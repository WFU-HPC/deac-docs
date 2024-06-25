# LAMMPS + ALLEGRO (updated for 2024)

```sh
export TARGET_ALLEGRO=/deac/opt/rocky9-noarch/deac-envs/natalieGrp/env-allegro
mkdir -p ${TARGET_ALLEGRO}
module purge && module load compilers/gcc/12.3.0 apps/python/3.11.8 nvidia/cuda12/cuda/12.4.1
python3 -m venv $TARGET_ALLEGRO
. ${TARGET_ALLEGRO}/bin/activate
python3 -m pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/cu121
python3 -m pip install e3nn nequip
git clone https://github.com/mir-group/allegro.git /tmp/allegro
cd /tmp/allegro && python3 -m pip install . && cd $HOME && rm -rf /tmp/allegro
deactivate

################################################################################
################################################################################

export ARCHDIR=cascadelake
export ARCHOPT=cascadelake
export TARGET_LAMMPS=/deac/opt/rocky9-${ARCHDIR}/lammps/develop-allegro
module purge && module load compilers/gcc/12.3.0 apps/python/3.11.8 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0 libs/fftw/3.3.10 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 nvidia/cuda12/cuda/12.4.1
. ${TARGET_ALLEGRO}/bin/activate
git clone https://github.com/mir-group/pair_allegro.git /tmp/pair_allegro
git clone --depth=1 https://github.com/lammps/lammps.git /tmp/lammps
cd /tmp/pair_allegro && ./patch_lammps.sh /tmp/lammps && cd $HOME && rm -rf /tmp/pair_allegro
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
mkdir -p /tmp/lammps/build && cd /tmp/lammps/build
cmake   -C /tmp/lammps/cmake/presets/DEAC.cmake \
        -C /tmp/lammps/cmake/presets/most.cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${TARGET_LAMMPS}" \
        -DPKG_OPENMP=on \
        -DBUILD_OMP=on \
        -DCMAKE_PREFIX_PATH=$(python3 -c 'import torch;print(torch.utils.cmake_prefix_path)') \
        -DCUDA_NVCC_EXECUTABLE=$(which nvcc) \
        -DCUDA_TOOLKIT_ROOT_DIR="$CUDA_HOME" \
        -DTORCH_CUDA_ARCH_LIST="7.0 8.0 9.0" \
        -DMKL_INCLUDE_DIR="${MKLROOT}/include" \
        -DLAMMPS_INSTALL_RPATH=on \
        ../cmake
make -j8
make install
cat <<EOF > /deac/opt/modulefiles/rocky9-${ARCHDIR}/apps/lammps/pair_allegro
#%Module
## lammps
##

proc ModulesHelp { } {
    puts stderr "\tLAMMPS is a classical molecular dynamics (MD) code."
}

module-whatis   "LAMMPS is a classical molecular dynamics (MD) code"

if { [module-info command load] } {
    if {[getenv --return-value VIRTUAL_ENV] ne ""} {
        puts stderr ""
        puts stderr "########################################################################"
        puts stderr "It seems like you may have another virtual environment activated!"
        puts stderr "Please deactivate other environments before loading this module."
        puts stderr "########################################################################"
        exit
    }
}

module load compilers/gcc/12.3.0 apps/python/3.11.8 mpi/openmpi/4.1.6 libs/intel/mkl/2023.2.0 libs/fftw/3.3.10 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 nvidia/cuda12/cuda/12.4.1

set version  "develop"
set basedir  "$TARGET_LAMMPS"
set envdir   "$TARGET_ALLEGRO"

if { [module-info shelltype sh] && [module-info mode load] } {
    puts stdout ". \$envdir/bin/activate ;"
} elseif { [module-info shelltype csh] && [module-info mode load] } {
    puts stdout "source \$envdir/bin/activate.csh ;"
}

if { [module-info mode load] } {
    puts stderr ""
    puts stderr "########################################################################"
    puts stderr "This module activates the Python virtual environment located at:"
    puts stderr "\$envdir"
    puts stderr "WARNING: Your shell prompt will not change!"
    puts stderr "WARNING: You need to deactivate any previously activated environments!"
    puts stderr "########################################################################"
}

if { [module-info command unload] && [module-info command purge] } {
    puts stdout "deactivate ;"
}

################################################################################
################################################################################

prepend-path    PATH                \$basedir/bin
prepend-path    PATH                \$envdir/bin
prepend-path    MANPATH             \$basedir/share/man

setenv  OMP_NUM_THREADS             \$basedir
setenv  LAMMPSHOME                  \$basedir
setenv  LAMMPS_POTENTIALS           \$basedir/share/lammps/potentials
setenv  MSI2LMP_LIBRARY             \$basedir/share/lammps/frc_files
setenv  VIRTUAL_ENV                 \$envdir
setenv  VIRTUAL_ENV_DISABLE_PROMPT  1
# setenv  VIRTUAL_ENV_PROMPT          "(env-allegro) "
EOF
cd $HOME && rm -rf /tmp/lammps

################################################################################
################################################################################
```


## OLD OLD OLD

```sh
# export MINICONDA=${TARGET}/../miniconda3

################################################################################
# Miniconda from scratch
################################################################################

# wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh \
#         -O /tmp/Miniconda3-latest-Linux-x86_64.sh
# bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p ${MINICONDA}
# rm -rf /tmp/Miniconda3-latest-Linux-x86_64.sh


################################################################################
# Conda environment
################################################################################

# # ${MINICONDA}/bin/conda init
# . ${MINICONDA}/etc/profile.d/conda.sh
# conda create -n allegro python=3.10.13 -y
# conda activate allegro

# conda install pytorch=1.11.0=py3.10_cuda11.5_cudnn8.3.2_0 -c pytorch -c nvidia -y

# Read this https://github.com/mir-group/pair_allegro#cuda
# conda install cudatoolkit-dev=11.5.0=h72bdee0_5 -c conda-forge -y     # viable? system better
# conda create -n lammps python=3.9.7                                   # from paper
# conda install pytorch==1.10.0 pytorch-cuda=11.8 -c pytorch -c nvidia  # from paper
# conda install cuda -c "nvidia/label/cuda-11.5.2"                      # not useful
# conda install cuda-toolkit -c "nvidia/label/cuda-11.5.2"              # not useful
# conda install cudnn==8.3.2.44 -c conda-forge -y                       # nvrtc errors w/lammps
# conda activate allegro && conda env config vars set MKLROOT="$CONDA_PREFIX" && conda deactivate

################################################################################
# e3nn
################################################################################

# pip3 install e3nn==0.4.4                                              # from paper

################################################################################
# nequip
################################################################################

# cd ${TARGET}/nequip                                                   # from paper
# git clone https://github.com/mir-group/nequip.git ${TARGET}/nequip    # from paper
# git checkout eb6f9bca7b36162abf69ebb017049599b4ddb09c                 # from paper
# pip3 install .                                                        # from paper
# conda install -c conda-forge nequip                                   # alternative to pip

################################################################################
# allegro
################################################################################

# git clone https://github.com/mir-group/allegro.git /tmp/allegro && cd /tmp/allegro
# git checkout a5128c2a86350762215dad6bd8bb42875ebb06cb                 # from paper

################################################################################
# pair_allegro
################################################################################

# git clone https://github.com/mir-group/pair_allegro.git /tmp/pair_allegro
# git checkout 0161a8a8e2fe0849165de9eeae3fbb987b294079                 # from paper

################################################################################
# lammps
################################################################################

# cd /tmp/lammps && git checkout 9b989b186026c6fe9da354c79cc9b4e152ab03af
# sed -i -e 's/  torch::jit::getBailoutDepth() = jit_bailout_depth;/  torch::jit::FusionStrategy strat = {{torch::jit::FusionBehavior::DYNAMIC, 1}};\n  torch::jit::setFusionStrategy(strat);/g' /tmp/lammps/src/pair_allegro.cpp

################################################################################
# actually running the dang thing
################################################################################

# sbatch --partition=gpu \
#        --nodelist=usb-gpu-04 \
#        --ntasks-per-node=2 \
#        --cpus-per-task=2 \
#        --output=slurm \
#        --wrap ". ${MINICONDA}/etc/profile.d/conda.sh; conda activate allegro; module load compilers/gcc/10.2.0 mpi/intel/2021.2 libs/intel/mkl/2021.2; export OMP_NUM_THREADS=2; cd /deac/inf/adminGrp/anderss/scratch/allegro_testing/tutorial/lammps_run; mpirun ${RESEARCHPATH}/scratch/natalieGrp/lammps/bin/lmp -in si_rdf.in"

# module purge && module load compilers/gcc/10.2.0 mpi/intel/2021.2 cuda/11.8
# conda activate allegro

## If you need a vanilla environment (think: tcsh)

# env -i bash --noprofile --norc
# . /usr/share/Modules/init/bash
# . /deac/phy/natalieGrp/software/miniconda3/etc/profile.d/conda.sh
```
