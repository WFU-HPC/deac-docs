```sh
#!/bin/bash

## global environment variables
export LANG="en_US.UTF-8"

# parallelization
export CORES=8

# arch parameters
export ARCHDIR=zen4
export ARCHOPT=znver4

function moduletron {
    export MODULEPATH="/usr/share/Modules/modulefiles:/etc/modulefiles:/usr/share/modulefiles:/opt/scyld/modulefiles"
    module use $1
    module purge && module load $2
    echo $MODULEPATH
    echo $LOADEDMODULES
}

function _DSS_quantumespresso {
    local version="$1"
    local target="$2"
    local dependencies="$3"
    local module_path="$4"
    local flagsc="$5"
    local flagsfc="$6"

    # download files
    wget --no-check-certificate https://www.quantum-espresso.org/download/software/qe-${version}-ReleasePack.tar.gz -O /tmp/qe-${version}-ReleasePack.tar.gz
    mkdir -p $target

    # untar
    tar -xf /tmp/qe-${version}-ReleasePack.tar.gz -C $target

    # change into directory
    cd ${target}/qe-${version}

    # module load
    moduletron "$module_path" "$dependencies"

    # double ugh
    unset CPP

    # I hate this -- if you are reading this, QE developers: why?
cat << EOF > ${target}/qe-${version}/.gitmodules
[submodule "external/lapack"]
    path = external/lapack
    url = https://github.com/Reference-LAPACK/lapack.git
[submodule "external/fox"]
    path = external/fox
    url = https://github.com/pietrodelugas/fox.git
[submodule "external/wannier90"]
    path = external/wannier90
    url = https://github.com/wannier-developers/wannier90.git
[submodule "external/mbd"]
    path = external/mbd
    url = https://github.com/libmbd/libmbd.git
[submodule "external/devxlib"]
    path = external/devxlib
    url = https://gitlab.com/max-centre/components/devicexlib.git
[submodule "external/d3q"]
    path = external/d3q
    url = https://github.com/anharmonic/d3q.git
[submodule "external/pw2qmcpack"]
    path = external/pw2qmcpack
    url = https://github.com/QMCPACK/pw2qmcpack.git
[submodule "external/qe-gipaw"]
    path = external/qe-gipaw
    url = https://github.com/dceresoli/qe-gipaw
EOF

    rm -rf         ${target}/qe-${version}/external/wannier90/.*.y*
    sed -i 's|qe_git_submodule_update(external/devxlib)||g' ${target}/qe-${version}/external/devxlib.cmake

    ./configure \
        CFLAGS="$flagsc" \
        FFLAGS="$flagsfc" \
        --prefix="$target" \
        --enable-parallel \
        --enable-openmp \
        --enable-shared \
        --with-hdf5="$HDF5_PATH" \
        --with-libxc \
        --with-libxc-prefix="$LIBXCHOME"

    make -j$CORES all

    tar -xf /deac/opt/tarballs/perturbo/perturbo-3.0.0.tar.gz -C ${target}/qe-${version}

cat << EOF > ${target}/qe-${version}/perturbo-3.0.0/make.sys
# IMPORTANT: Perturbo must be compiled on top of QE7.3

# include make.inc of QE
include ../../make.inc

# for gfortran compiler
FFLAGS += -fopenmp -x f95-cpp-input -O3 -ffree-line-length-0
LDFLAGS += -fopenmp

# path to HDF5 library
IFLAGS += -I${HDF5_PATH}/include
HDF5_LIBS = -L${HDF5_PATH}/lib -lhdf5 -lhdf5_fortran -lgfortran
# in case of ARM64 flag -L/usr/lib/aarch64-linux-gnu also can be useful

MODFLAGS= \$(BASEMOD_FLAGS) \
          \$(MOD_FLAG)../../PW/src \
          \$(MOD_FLAG)../../dft-d3 \
          \$(MOD_FLAG)../../LR_Modules\
             \$(MOD_FLAG)../../PHonon/PH


PHMODS = ../../PHonon/PH/libph.a
LRMODS = ../../LR_Modules/liblrmod.a
PWOBJS = ../../PW/src/libpw.a
QEMODS = ../../Modules/libqemod.a ../../KS_Solvers/libks_solvers.a \
         ../../FFTXlib/src/libqefft.a ../../LAXlib/libqela.a \
            ../../UtilXlib/libutil.a ../../dft-d3/libdftd3qe.a \
         ../../upflib/libupf.a ../../XClib/xc_lib.a \
         ../../MBD/libmbd.a

F90FLAGS = \$(FFLAGS) \$(FDFLAGS) \$(MODFLAGS) \$(IFLAGS)
LDFLAGS += \$(HDF5_LIB)
EOF

    cd ${target}/qe-${version}/perturbo-3.0.0
    make

    # go back to HOME just in case
    cd $HOME

    # remove spurious leftovers
    rm -rf /tmp/qe-${version}-ReleasePack.tar.gz
}

function _DSS_quantumespresso_mod {
    local version="$1"
    local target="$2"
    local dependencies="$3"
    local module_path="$4"

    # prepare for modules
    mkdir -p $(dirname ${module_path})

# generate module using awesome naming scheme
cat <<EOF > ${module_path}
#%Module1.0
##
## quantum-espresso
##
##

proc ModulesHelp { } {
    puts stderr "Quantum ESPRESSO is an integrated suite of Open-Source computer codes"
    puts stderr "for electronic-structure calculations and materials modeling at the"
    puts stderr "nanoscale. It is based on density-functional theory, plane waves, and"
    puts stderr "pseudopotentials."
}

module-whatis "Quantum ESPRESSO is an integrated suite of computer codes for electronic-structure calculations."

module load $dependencies

set version  "$version"
set basedir  "$target"

################################################################################
################################################################################

prepend-path    PATH                \$basedir/qe-7.3/bin
prepend-path    PATH                \$basedir/qe-7.3/perturbo-3.0.0/bin

setenv  NO_STOP_MESSAGE     yes
setenv  QEROOT     \$basedir/qe-7.3
setenv  QEHOME     \$basedir/qe-7.3
EOF
}

################################################################################
################################################################################
## quantum-espresso qe
_DSS_quantumespresso     "7.3" \
                         "/deac/opt/rocky9-${ARCHDIR}/quantum-espresso/7.3-perturbo" \
                         "compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0 libs/hdf5/1.14.3-serial libs/libxc/.7.0.0_static" \
                         "/deac/opt/modulefiles/rocky9-noarch /deac/opt/modulefiles/rocky9-${ARCHDIR}" \
                         "-O2 -DNDEBUG -march=${ARCHOPT} -mtune=${ARCHOPT} " \
                         "-O2 -DNDEBUG -fallow-argument-mismatch -march=${ARCHOPT} -mtune=${ARCHOPT}"

_DSS_quantumespresso_mod "7.3" \
                         "/deac/opt/rocky9-${ARCHDIR}/quantum-espresso/7.3-perturbo" \
                         "compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0 libs/hdf5/1.14.3 libs/libxc/6.2.2" \
                         "/deac/opt/rocky9-${ARCHDIR}/quantum-espresso/7.3-perturbo/modules/perturbo"
```
