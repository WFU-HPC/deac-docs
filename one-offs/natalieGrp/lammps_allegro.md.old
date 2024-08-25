#!/bin/bash

```sh
# Basic Modules
module load compilers/gcc/10.2.0 utils/cmake/3.23.1 utils/git/2.36.1

# Target installation directory
export TARGET="/deac/phy/natalieGrp/software/publiccode"
export MINICONDA=${TARGET}/../miniconda3
mkdir -p $TARGET

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

# ${MINICONDA}/bin/conda init
. ${MINICONDA}/etc/profile.d/conda.sh
conda create -n allegro python=3.10.13 -y
conda activate allegro

conda install pytorch=1.11.0=py3.10_cuda11.5_cudnn8.3.2_0 -c pytorch -c nvidia -y

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

pip3 install e3nn

# pip3 install e3nn==0.4.4                                              # from paper

################################################################################
# nequip
################################################################################

pip3 install nequip

# cd ${TARGET}/nequip                                                   # from paper
# git clone https://github.com/mir-group/nequip.git ${TARGET}/nequip    # from paper
# git checkout eb6f9bca7b36162abf69ebb017049599b4ddb09c                 # from paper
# pip3 install .                                                        # from paper
# conda install -c conda-forge nequip                                   # alternative to pip

################################################################################
# allegro
################################################################################

git clone https://github.com/mir-group/allegro.git ${TARGET}/allegro
cd ${TARGET}/allegro && pip3 install . && cd

# git checkout a5128c2a86350762215dad6bd8bb42875ebb06cb                 # from paper

################################################################################
# pair_allegro
################################################################################

git clone https://github.com/mir-group/pair_allegro.git ${TARGET}/pair_allegro

# git checkout 0161a8a8e2fe0849165de9eeae3fbb987b294079                 # from paper

################################################################################
# use slurm to compile lammps on GPU node
################################################################################

LAMMPS_BUILD=$(cat <<EOF
. ${MINICONDA}/etc/profile.d/conda.sh
conda activate allegro
module purge
module load compilers/gcc/10.2.0 \
            mpi/intel/2021.2 \
            libs/intel/mkl/2021.2 \
            libs/fftw/3.3.10/gcc/10.2.0_impi \
            cuda/11.8 \
            utils/ffmpeg/6.0.0 \
            utils/cmake/3.23.1 \
            utils/git/2.36.1

git clone https://github.com/lammps/lammps.git /scratch/\${SLURM_JOB_ID}/lammps
cd /scratch/\${SLURM_JOB_ID}/lammps && git checkout 9b989b186026c6fe9da354c79cc9b4e152ab03af
cd ${TARGET}/pair_allegro && ./patch_lammps.sh /scratch/\${SLURM_JOB_ID}/lammps

mkdir -p /scratch/\${SLURM_JOB_ID}/lammps/build && cd /scratch/\${SLURM_JOB_ID}/lammps/build
cat << EOD > /scratch/\${SLURM_JOB_ID}/lammps/cmake/presets/gcc.cmake
# preset that will explicitly request gcc/g++ compilers with support for MPI and OpenMP

set(CMAKE_CXX_COMPILER "g++" CACHE STRING "" FORCE)
set(CMAKE_C_COMPILER "gcc" CACHE STRING "" FORCE)
set(CMAKE_Fortran_COMPILER "gfortran" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_DEBUG "-Wall -Og -g" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_RELWITHDEBINFO "-g -O2 -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_CXX_FLAGS_RELEASE "-O3 -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_DEBUG "-Wall -Og -g" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELWITHDEBINFO "-g -O2 -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_C_FLAGS_RELEASE "-O3 -DNDEBUG" CACHE STRING "" FORCE)
set(CMAKE_Fortran_FLAGS_DEBUG "-Wall -Og -g -std=f2003" CACHE STRING "" FORCE)
set(CMAKE_Fortran_FLAGS_RELWITHDEBINFO "-g -O2 -DNDEBUG -std=f2003" CACHE STRING "" FORCE)
set(CMAKE_Fortran_FLAGS_RELEASE "-O3 -DNDEBUG -std=f2003" CACHE STRING "" FORCE)

set(MPI_CXX "g++" CACHE STRING "" FORCE)
set(MPI_CXX_COMPILER "mpicxx" CACHE STRING "" FORCE)
set(MPI_C "gcc" CACHE STRING "" FORCE)
set(MPI_C_COMPILER "mpicc" CACHE STRING "" FORCE)
set(MPI_Fortran "gfortran" CACHE STRING "" FORCE)
set(MPI_Fortran_COMPILER "mpifort" CACHE STRING "" FORCE)

unset(HAVE_OMP_H_INCLUDE CACHE)
set(OpenMP_C "gcc" CACHE STRING "" FORCE)
set(OpenMP_C_FLAGS "-fopenmp" CACHE STRING "" FORCE)
set(OpenMP_C_LIB_NAMES "gomp" CACHE STRING "" FORCE)
set(OpenMP_CXX "g++" CACHE STRING "" FORCE)
set(OpenMP_CXX_FLAGS "-fopenmp" CACHE STRING "" FORCE)
set(OpenMP_CXX_LIB_NAMES "gomp" CACHE STRING "" FORCE)
set(OpenMP_Fortran_FLAGS "-fopenmp" CACHE STRING "" FORCE)
set(OpenMP_gomp_LIBRARY "libgomp.so" CACHE PATH "" FORCE)
EOD
cmake   -C /scratch/\${SLURM_JOB_ID}/lammps/cmake/presets/gcc.cmake \
        -C /scratch/\${SLURM_JOB_ID}/lammps/cmake/presets/most.cmake \
        -DPKG_OPENMP=yes \
        -DBUILD_OMP=yes \
        -DFFTW3_LIBRARY:FILEPATH="/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0/lib/libfftw3.a" \
        -DFFTW3_OMP_LIBRARY:FILEPATH="/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0/lib/libfftw3_omp.a" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH=\$(python -c 'import torch;print(torch.utils.cmake_prefix_path)') \
        -DCUDA_NVCC_EXECUTABLE=\$(which nvcc) \
        -DCUDA_TOOLKIT_ROOT_DIR="/usr/local/cuda-11.8/lib64" \
        -DCMAKE_INSTALL_PREFIX="${TARGET}/lammps" \
        -DMKL_INCLUDE_DIR="\${MKLROOT}/include" \
        -DLAMMPS_INSTALL_RPATH=yes \
        ../cmake
make -j\$SLURM_NTASKS_PER_NODE && make install
EOF
)

sbatch --partition=gpu \
       --nodelist=usb-gpu-04 \
       --ntasks-per-node=32 \
       --output=${HOME}/lammps_build.out \
       --wrap="${LAMMPS_BUILD}"

# sed -i -e 's/  torch::jit::getBailoutDepth() = jit_bailout_depth;/  torch::jit::FusionStrategy strat = {{torch::jit::FusionBehavior::DYNAMIC, 1}};\n  torch::jit::setFusionStrategy(strat);/g' /scratch/\${SLURM_JOB_ID}/lammps/src/pair_allegro.cpp

################################################################################
################################################################################

## actually running the dang thing

# sbatch --partition=gpu \
#        --nodelist=usb-gpu-04 \
#        --ntasks-per-node=2 \
#        --cpus-per-task=2 \
#        --output=slurm \
#        --wrap ". ${MINICONDA}/etc/profile.d/conda.sh; conda activate allegro; module load compilers/gcc/10.2.0 mpi/intel/2021.2 libs/intel/mkl/2021.2; export OMP_NUM_THREADS=2; cd /deac/inf/adminGrp/anderss/scratch/allegro_testing/tutorial/lammps_run; mpirun ${RESEARCHPATH}/scratch/natalieGrp/lammps/bin/lmp -in si_rdf.in"

# module purge && module load compilers/gcc/10.2.0 mpi/intel/2021.2 cuda/11.8
# conda activate allegro
# export LAMMPS_PATH="/deac/phy/natalieGrp/software/publiccode/lammps"
# export PATH="${LAMMPS_PATH}/bin:$PATH"
# export LAMMPS_POTENTIALS="${LAMMPS_PATH}/share/lammps/potentials"
# export MSI2LMP_LIBRARY="${LAMMPS_PATH}/share/lammps/frc_files"

## If you need a vanilla environment (think: tcsh)

# env -i bash --noprofile --norc
# . /usr/share/Modules/init/bash
# . /deac/phy/natalieGrp/software/miniconda3/etc/profile.d/conda.sh
```
