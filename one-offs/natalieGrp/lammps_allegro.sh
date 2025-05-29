#!/bin/bash

## init
export ROOT=/deac/opt
export TARGET_ALLEGRO=${ROOT}/rocky9-noarch/deac-envs/natalieGrp/env-allegro

## env #########################################################################
## env #########################################################################
## env #########################################################################
## env #########################################################################

mkdir -p $TARGET_ALLEGRO

cat << EOF > ${TARGET_ALLEGRO}/pixi.toml
[project]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["nvidia", "pytorch", "conda-forge"]
description = "Add a short description here"
name = "allegro"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "3.10.*"
pip = "*"
numpy = "1.*"
mkl = "2023.2.0"
mkl-include = "2023.2.0"
# pytorch = "1.11.*"
pytorch-cuda  = { version = "11.8.*", channel = "pytorch" }
#cuda-version  = { version = "11.8.*", channel = "nvidia" }
#cuda-toolkit  = { version = "11.8.*", channel = "nvidia" }
#cuda-nvcc     = { version = "11.8.*", channel = "nvidia" }
e3nn = "*"
nequip = "*"
EOF

cd $TARGET_ALLEGRO
pixi install
#pixi shell --manifest-path ${TARGET_ALLEGRO}/pixi.toml
eval "$(pixi shell-hook --manifest-path ${TARGET_ALLEGRO}/pixi.toml)"

## allegro #####################################################################
## allegro #####################################################################
## allegro #####################################################################
## allegro #####################################################################

git clone https://github.com/mir-group/allegro.git /tmp/allegro
cd /tmp/allegro
python3 -m pip install .
cd $TARGET_ALLEGRO
rm -rf /tmp/allegro

## pair_allegro ################################################################
## pair_allegro ################################################################
## pair_allegro ################################################################
## pair_allegro ################################################################

git clone https://github.com/mir-group/pair_allegro.git ${TARGET_ALLEGRO}/pair_allegro
cd ${TARGET_ALLEGRO}/pair_allegro
git checkout 55f19d3bbdf90ef156bd6a8ac3336b1d5aa15da3
cd ${TARGET_ALLEGRO}

## lammps ######################################################################
## lammps ######################################################################
## lammps ######################################################################
## lammps ######################################################################

git clone https://github.com/lammps/lammps.git /tmp/lammps
# git clone --depth=1 https://github.com/lammps/lammps.git /tmp/lammps
cd /tmp/lammps
git checkout 9b989b186026c6fe9da354c79cc9b4e152ab03af
cd ${TARGET_ALLEGRO}/pair_allegro
./patch_lammps.sh /tmp/lammps
cd $TARGET_ALLEGRO #&& rm -rf ${TARGET_ALLEGRO}/pair_allegro

export ARCHDIR=cascadelake
export ARCHOPT=cascadelake
export TARGET_LAMMPS=${ROOT}/rocky9-${ARCHDIR}/lammps/17Feb2022-pair_allegro

module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/fftw/3.3.10 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 nvidia/cuda11/cuda/11.8.0

cat << EOD > /tmp/lammps/cmake/presets/DEAC.cmake
# preset that will explicitly request gcc/g++ compilers with support for MPI and OpenMP

set(CMAKE_C_COMPILER            "$BASECC"   CACHE STRING "" FORCE)
set(CMAKE_CXX_COMPILER          "$BASECXX"  CACHE STRING "" FORCE)
set(CMAKE_Fortran_COMPILER      "$BASEFC"   CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE     "-O3 -march=$ARCHOPT -mtune=$ARCHOPT            -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELEASE       "-O3 -march=$ARCHOPT -mtune=$ARCHOPT            -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -march=$ARCHOPT -mtune=$ARCHOPT -std=f2003 -DNDEBUG" CACHE STRING "" FORCE)

set(MPI_C                       "$BASECC"       CACHE STRING "" FORCE)
set(MPI_CXX                     "$BASECXX"      CACHE STRING "" FORCE)
set(MPI_Fortran                 "$BASEFC"       CACHE STRING "" FORCE)
set(MPI_C_COMPILER              "$MPICC"    CACHE STRING "" FORCE)
set(MPI_CXX_COMPILER            "$MPICXX"   CACHE STRING "" FORCE)
set(MPI_Fortran_COMPILER        "$MPIFC"    CACHE STRING "" FORCE)

unset(HAVE_OMP_H_INCLUDE CACHE)
set(OpenMP_C                    "$BASECC"       CACHE STRING "" FORCE)
set(OpenMP_CXX                  "$BASECXX"      CACHE STRING "" FORCE)
set(OpenMP_Fortran              "$BASEFC"       CACHE STRING "" FORCE)
set(OpenMP_C_FLAGS              "$FLAGOMP"  CACHE STRING "" FORCE)
set(OpenMP_CXX_FLAGS            "$FLAGOMP"  CACHE STRING "" FORCE)
set(OpenMP_Fortran_FLAGS        "$FLAGOMP"  CACHE STRING "" FORCE)
# set(OpenMP_C_LIB_NAMES          "gomp"      CACHE STRING "" FORCE)
# set(OpenMP_CXX_LIB_NAMES        "gomp"      CACHE STRING "" FORCE)
# set(OpenMP_gomp_LIBRARY         "libgomp.so" CACHE PATH "" FORCE)

set(FFTW3_LIBRARY               "${FFTWROOT}/lib/libfftw3.a"       CACHE PATH "" FORCE)
set(FFTW3_OMP_LIBRARY           "${FFTWROOT}/lib/libfftw3_omp.a"   CACHE PATH "" FORCE)
set(HDF5_C_COMPILER_EXECUTABLE  "${HDF5_PATH}/bin/h5pcc"           CACHE PATH "" FORCE)
set(NETCDF_LIBRARY              "${NETCDF_C_PATH}/lib/libnetcdf.a" CACHE PATH "" FORCE)
EOD

export NVCC_APPEND_FLAGS='-allow-unsupported-compiler'
mkdir -p /tmp/lammps/build && cd /tmp/lammps/build

cmake   -C /tmp/lammps/cmake/presets/DEAC.cmake \
        -C /tmp/lammps/cmake/presets/most.cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="$TARGET_LAMMPS" \
        -DPKG_OPENMP=on \
        -DBUILD_OMP=on \
        -DCMAKE_PREFIX_PATH="$(python3 -c 'import torch;print(torch.utils.cmake_prefix_path)')" \
        -DCUDA_NVCC_EXECUTABLE="$(which nvcc)" \
        -DTORCH_CUDA_ARCH_LIST="7.0 8.0 9.0" \
        -DMKL_INCLUDE_DIR="${CONDA_PREFIX}/include" \
        -DLAMMPS_INSTALL_RPATH=on \
        ../cmake
#        -DCUDA_TOOLKIT_ROOT_DIR="$CONDA_PREFIX" \
#        -DCUDNN_LIBRARY_PATH="${CUDNNDIR}/lib/libcudnn.so" \

make -j16
make install

cd $HOME
rm -rf /tmp/lammps

## module ######################################################################
## module ######################################################################
## module ######################################################################
## module ######################################################################

mkdir -p ${ROOT}/modulefiles/rocky9-${ARCHDIR}/envs
cat << EOF > ${ROOT}/modulefiles/rocky9-${ARCHDIR}/envs/allegro
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6

set environment     "env-allegro"
set basedir         "$TARGET_ALLEGRO/../"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/\${environment}/.pixi/envs/default/bin"
prepend-path    PATH                "${TARGET_LAMMPS}/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/\${environment}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "\${basedir}/\${environment}"
setenv  PIXI_PROJECT_NAME           "allegro"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(allegro) "
setenv  CONDA_DEFAULT_ENV           "allegro"
setenv  CONDA_PREFIX                "\${basedir}/\${environment}/.pixi/envs/default"
setenv  PYTHONWARNINGS              "ignore"

setenv  LAMMPS_ROOT                 "${TARGET_LAMMPS}"

source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libblas_mkl_activate.sh"
source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
EOF

