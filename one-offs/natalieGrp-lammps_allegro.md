#!/bin/bash

################################################################################
################################################################################
##### * build with newer versions of pair_allegro     # NOT WORKING FOR LATEST
##### * build with newer versions of LAMMPS           # doesn't compile with old version of pair_allegro
##### * unrestricted version of both                  # didn't work
##### * try new pytorch and see what happens          # didn't work
##### * give one last try with venv vs conda          # problem is python3.11 and pytorch 1.13
##### * seal the deal with previous versions          # let's seal the deal yo
#####
##### Basically, seems like we may just have to incrementally go up in
##### commits/versions until we find the latest working version. The model file format
##### leads to the scalar/floar error, which can be fixed with retraining. The at()
##### error can then be identified at whatever specific versions work. I think the
##### priority should be to upgrade pair_allegro first and possibly contact
##### developers.
#####
##### Exception: Argument passed to at() was not in the map."
################################################################################
################################################################################

# Target installation directory
export TARGET_ALLEGRO=/deac/opt/rocky9-noarch/deac-envs/natalieGrp/env-allegro

# mkdir -p $TARGET_ALLEGRO

################################################################################
# Conda environment
################################################################################

module load compilers/gcc/12.3.0 apps/anaconda3/2024.02
conda create --prefix=${TARGET_ALLEGRO} python=3.10 -y                              # UPDATE POINT: MOVE TO PY3.11
conda activate ${TARGET_ALLEGRO}

# conda install pytorch=1.11.0=py3.10_cuda11.5_cudnn8.3.2_0 -c pytorch -c nvidia -y
# conda install pytorch=1.12.1=py3.10_cuda11.6_cudnn8.3.2_0 -c pytorch -c nvidia -y
# conda install pytorch=2.3.1=py3.10_cuda11.8_cudnn8.7.0_0 -c pytorch -c nvidia -y
conda install pytorch=1.13.1=py3.10_cuda11.7_cudnn8.5.0_0 -c pytorch -c nvidia -y   # UPDATE POINT: MOVE TO TORCH 2+

################################################################################
# e3nn
################################################################################

pip3 install e3nn

################################################################################
# nequip
################################################################################

pip3 install nequip

################################################################################
# allegro
################################################################################

git clone https://github.com/mir-group/allegro.git /tmp/allegro
cd /tmp/allegro && python3 -m pip install . && cd - && rm -rf /tmp/allegro

################################################################################
# it's time for lammps bby
################################################################################

export ARCHDIR=cascadelake
export ARCHOPT=cascadelake
export TARGET_LAMMPS=/deac/opt/rocky9-${ARCHDIR}/lammps/17Feb2022-pair_allegro

################################################################################
# pair_allegro
################################################################################

git clone https://github.com/mir-group/pair_allegro.git /tmp/pair_allegro
cd /tmp/pair_allegro && git checkout 55f19d3bbdf90ef156bd6a8ac3336b1d5aa15da3 && cd -

################################################################################
# compile lammps on GPU node
################################################################################

module load mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0 libs/fftw/3.3.10 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 nvidia/cuda11/cuda/11.8.0 nvidia/cuda11/cudnn/8.7.0.84

git clone https://github.com/lammps/lammps.git /tmp/lammps
cd /tmp/lammps && git checkout 9b989b186026c6fe9da354c79cc9b4e152ab03af && cd -
# git clone --depth=1 https://github.com/lammps/lammps.git /tmp/lammps
cd /tmp/pair_allegro && ./patch_lammps.sh /tmp/lammps && cd - #&& rm -rf /tmp/pair_allegro

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
        -DCUDA_TOOLKIT_ROOT_DIR="$CUDA_HOME" \
        -DCUDNN_LIBRARY_PATH="${CUDNNDIR}/lib/libcudnn.so" \
        -DTORCH_CUDA_ARCH_LIST="7.0 8.0 9.0" \
        -DMKL_INCLUDE_DIR="${MKLROOT}/include" \
        -DLAMMPS_INSTALL_RPATH=on \
        ../cmake
make -j32
make install
mkdir -p /deac/opt/modulefiles/rocky9-${ARCHDIR}/apps/lammps
cat <<EOF > /deac/opt/modulefiles/rocky9-${ARCHDIR}/apps/lammps/pair_allegro
#%Module
## lammps
##

proc ModulesHelp { } {
    puts stderr "\tLAMMPS is a classical molecular dynamics (MD) code."
}

module-whatis   "LAMMPS is a classical molecular dynamics (MD) code"

# if { [module-info command load] } {
#     if {[getenv --return-value VIRTUAL_ENV] ne ""} {
#         puts stderr ""
#         puts stderr "########################################################################"
#         puts stderr "It seems like you may have another virtual environment activated!"
#         puts stderr "Please deactivate other environments before loading this module."
#         puts stderr "########################################################################"
#         exit
#     }
# }

# module load compilers/gcc/12.3.0 apps/python/3.11.8 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0 libs/fftw/3.3.10 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 nvidia/cuda11/cuda/11.8.0
module load compilers/gcc/12.3.0 apps/anaconda3/2024.02 mpi/openmpi/4.1.6

set version  "17Feb2022"
set lmpdir   "$TARGET_LAMMPS"
set envdir   "$TARGET_ALLEGRO"

# if { [module-info shelltype sh] && [module-info mode load] } {
#     puts stdout ". \$envdir/bin/activate ;"
# } elseif { [module-info shelltype csh] && [module-info mode load] } {
#     puts stdout "source \$envdir/bin/activate.csh ;"
# }

# if { [module-info mode load] } {
#     puts stderr ""
#     puts stderr "########################################################################"
#     puts stderr "This module activates the Python virtual environment located at:"
#     puts stderr "\$envdir"
#     puts stderr "WARNING: Your shell prompt will not change!"
#     puts stderr "WARNING: You need to deactivate any previously activated environments!"
#     puts stderr "########################################################################"
# }

# if { [module-info command unload] && [module-info command purge] } {
#     puts stdout "deactivate ;"
# }

################################################################################
################################################################################

prepend-path    PATH                \$lmpdir/bin
prepend-path    PATH                \$envdir/bin
prepend-path    MANPATH             \$lmpdir/share/man

setenv  OMP_NUM_THREADS             1
setenv  LAMMPSHOME                  \$lmpdir
setenv  LAMMPS_POTENTIALS           \$lmpdir/share/lammps/potentials
setenv  MSI2LMP_LIBRARY             \$lmpdir/share/lammps/frc_files

setenv  CONDA_DEFAULT_ENV           \$envdir
setenv  CONDA_PREFIX                \$envdir
setenv  CONDA_SHLVL                 1
setenv  CONDA_PROMPT_MODIFIER       (env-allegro)

# setenv  VIRTUAL_ENV                 \$envdir
# setenv  VIRTUAL_ENV_DISABLE_PROMPT  1
# setenv  VIRTUAL_ENV_PROMPT          "(env-allegro) "
EOF
cd $HOME && rm -rf /tmp/lammps /tmp/pair_allegro
