#!/bin/bash

export TARGET="/deac/phy/natalieGrp/software/publiccode/mlip3_lammps"

module purge
module load compilers/gcc/10.2.0 \
            mpi/openmpi/4.1.1/gcc/10.2.0 \
            libs/intel/mkl/2021.2 \
            libs/intel/tbb/2021.2 \
            utils/cmake/3.23.1 \
            utils/git/2.36.1 

mkdir -p $TARGET

################################################################################
################################################################################

## Mlip-3 (https://gitlab.com/ashapeev/mlip-3)

git clone https://gitlab.com/ashapeev/mlip-3.git ${TARGET}/mlip-3

mkdir -p ${TARGET}/mlip-3/obj
cd ${TARGET}/mlip-3
./configure --blas=mkl && make mlp && make libinterface

################################################################################
################################################################################

## LAMMPS-MLIP-3 interface (https://gitlab.com/ivannovikov/interface-lammps-mlip-3)

git clone -b stable https://github.com/lammps/lammps.git "${TARGET}/lammps"
git clone https://gitlab.com/ivannovikov/interface-lammps-mlip-3.git ${TARGET}/interface-lammps-mlip-3

mkdir -p ${TARGET}/lammps/lib/mlip
cp    ${TARGET}/mlip-3/lib/lib_mlip_interface.a                         ${TARGET}/lammps/lib/mlip
cp    ${TARGET}/interface-lammps-mlip-3/LAMMPS/Makefile.lammps.template ${TARGET}/lammps/lib/mlip/Makefile.lammps
cp -r ${TARGET}/interface-lammps-mlip-3/LAMMPS/USER-MLIP/               ${TARGET}/lammps/src/
cp    ${TARGET}/interface-lammps-mlip-3/LAMMPS/Install.sh               ${TARGET}/lammps/src/USER-MLIP/
cp    ${TARGET}/interface-lammps-mlip-3/LAMMPS/README                   ${TARGET}/lammps/src/USER-MLIP/

cd ${TARGET}/lammps/src
make no-user-mlip
make yes-user-mlip
make mpi-stubs

cat <<EOF > MAKE/MINE/Makefile.deac
# deac = The DEAC Cluster Configuration

SHELL = /bin/sh

# ---------------------------------------------------------------------
# compiler/linker settings
# specify flags and libraries needed for your compiler

export OMPI_CXX = g++
CC =        mpicxx -std=c++11
OPTFLAGS =      -O3 -march=cascadelake -mtune=cascadelake

CCFLAGS =   -g -fopenmp -DLMP_USE_MKL_RNG \$(OPTFLAGS) -I\$(MKLROOT)/include


SHFLAGS =   -fPIC
FMTFLAGS =  -std=c++11
DEPFLAGS =  -M

LINK =      mpicxx -std=c++11
LINKFLAGS = -g -fopenmp \$(OPTFLAGS) -L\$(MKLROOT)/lib/intel64/
LIB =       -ltbbmalloc -lmkl_gf_lp64 -lmkl_sequential -lmkl_core
SIZE =      size

ARCHIVE =   ar
ARFLAGS =   -rc
SHLIBFLAGS =    -shared

# ---------------------------------------------------------------------
# LAMMPS-specific settings, all OPTIONAL
# specify settings for LAMMPS features you will use
# if you change any -D setting, do full re-compile after "make clean"

# LAMMPS ifdef settings
# see possible settings in Section 3.5 of the manual

LMP_INC =   -DLAMMPS_GZIP

# MPI library
# see discussion in Section 3.4 of the manual
# MPI wrapper compiler/linker can provide this info
# can point to dummy MPI library in src/STUBS as in Makefile.serial
# use -D MPICH and OMPI settings in INC to avoid C++ lib conflicts
# INC = path for mpi.h, MPI compiler settings
# PATH = path for MPI library
# LIB = name of MPI library

MPI_INC =       -DMPICH_SKIP_MPICXX -DOMPI_SKIP_MPICXX=1
MPI_PATH =
MPI_LIB =

# FFT library
# see discussion in Section 3.5.2 of manual
# can be left blank to use provided KISS FFT library
# INC = -DFFT setting, e.g. -DFFT_FFTW, FFT compiler settings
# PATH = path for FFT library
# LIB = name of FFT library

FFT_INC =      -DFFT_MKL -DFFT_SINGLE
FFT_PATH =
FFT_LIB =

# JPEG and/or PNG library
# see discussion in Section 3.5.4 of manual
# only needed if -DLAMMPS_JPEG or -DLAMMPS_PNG listed with LMP_INC
# INC = path(s) for jpeglib.h and/or png.h
# PATH = path(s) for JPEG library and/or PNG library
# LIB = name(s) of JPEG library and/or PNG library

JPG_INC =
JPG_PATH =
JPG_LIB =

#  library for loading shared objects (defaults to -ldl, should be empty on Windows)
# uncomment to change the default

# override DYN_LIB =

# ---------------------------------------------------------------------
# build rules and dependencies
# do not edit this section

include Makefile.package.settings
include Makefile.package

EXTRA_INC = \$(LMP_INC) \$(PKG_INC) \$(MPI_INC) \$(FFT_INC) \$(JPG_INC) \$(PKG_SYSINC)
EXTRA_PATH = \$(PKG_PATH) \$(MPI_PATH) \$(FFT_PATH) \$(JPG_PATH) \$(PKG_SYSPATH)
EXTRA_LIB = \$(PKG_LIB) \$(MPI_LIB) \$(FFT_LIB) \$(JPG_LIB) \$(PKG_SYSLIB) \$(DYN_LIB)
EXTRA_CPP_DEPENDS = \$(PKG_CPP_DEPENDS)
EXTRA_LINK_DEPENDS = \$(PKG_LINK_DEPENDS)

# Path to src files

vpath %.cpp ..
vpath %.h ..

# Link target

\$(EXE): main.o \$(LMPLIB) \$(EXTRA_LINK_DEPENDS)
	\$(LINK) \$(LINKFLAGS) main.o \$(EXTRA_PATH) \$(LMPLINK) \$(EXTRA_LIB) \$(LIB) -o \$@
	\$(SIZE) \$@

# Library targets

\$(ARLIB): \$(OBJ) \$(EXTRA_LINK_DEPENDS)
	@rm -f ../\$(ARLIB)
	\$(ARCHIVE) \$(ARFLAGS) ../\$(ARLIB) \$(OBJ)
	@rm -f \$(ARLIB)
	@ln -s ../\$(ARLIB) \$(ARLIB)

\$(SHLIB): \$(OBJ) \$(EXTRA_LINK_DEPENDS)
	\$(CC) \$(CCFLAGS) \$(SHFLAGS) \$(SHLIBFLAGS) \$(EXTRA_PATH) -o ../\$(SHLIB) \
		\$(OBJ) \$(EXTRA_LIB) \$(LIB)
	@rm -f \$(SHLIB)
	@ln -s ../\$(SHLIB) \$(SHLIB)

# Compilation rules

%.o:%.cpp
	\$(CC) \$(CCFLAGS) \$(SHFLAGS) \$(EXTRA_INC) -c \$<

variable.o : ../variable.cpp
	\$(CC) \$(CCFLAGS) \$(SHFLAGS) \$(EXTRA_INC) \$(FMTFLAGS) -c \$<

utils.o : ../utils.cpp
	\$(CC) \$(CCFLAGS) \$(SHFLAGS) \$(EXTRA_INC) \$(FMTFLAGS) -c \$<

fmtlib_format.o : ../fmtlib_format.cpp
	\$(CC) \$(CCFLAGS) \$(SHFLAGS) \$(EXTRA_INC) \$(FMTFLAGS) -c \$<

fmtlib_os.o : ../fmtlib_os.cpp
	\$(CC) \$(CCFLAGS) \$(SHFLAGS) \$(EXTRA_INC) \$(FMTFLAGS) -c \$<

# Individual dependencies

depend : fastdep.exe \$(SRC)
	@./fastdep.exe \$(EXTRA_INC) -- \$^ > .depend || exit 1

fastdep.exe: ../DEPEND/fastdep.c
	cc -O -o \$@ \$<

sinclude .depend
EOF

make -j4 deac

cp ${TARGET}/lammps/src/lmp_deac ${TARGET}/interface-lammps-mlip-3/.
