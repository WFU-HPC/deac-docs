#!/bin/bash

env -i bash --noprofile --norc
. /usr/share/Modules/init/bash
. /deac/phy/natalieGrp/software/miniconda3/etc/profile.d/conda.sh

module load utils/cmake/3.23.1 utils/git/2.36.1

export TARGET="/deac/phy/natalieGrp/software/publiccode"
mkdir -p $TARGET

################################################################################
################################################################################

conda create -n lammps python=3.9.7
conda activate lammps
conda install pytorch==1.10.0 pytorch-cuda=11.8 -c pytorch -c nvidia

################################################################################
################################################################################

conda activate lammps
pip3 install e3nn==0.4.4

################################################################################
################################################################################

conda activate lammps
git clone https://github.com/mir-group/nequip.git ${TARGET}/nequip
cd ${TARGET}/nequip
git checkout eb6f9bca7b36162abf69ebb017049599b4ddb09c
pip3 install .

################################################################################
################################################################################

conda activate lammps
git clone https://github.com/mir-group/allegro.git ${TARGET}/allegro
cd ${TARGET}/allegro
git checkout a5128c2a86350762215dad6bd8bb42875ebb06cb
pip3 install .

################################################################################
################################################################################

srun -p gpu -w usb-gpu-04 --pty -n 16 --mem=16G --time=00-01:00:00 /bin/bash
module load utils/cmake/3.23.1 utils/git/2.36.1

export TARGET="/deac/phy/natalieGrp/software/publiccode"
export SCRATCH="/scratch/${SLURM_JOB_ID}"

conda activate lammps
git clone https://github.com/lammps/lammps.git ${SCRATCH}/lammps
cd ${SCRATCH}/lammps
git checkout 9b989b186026c6fe9da354c79cc9b4e152ab03af

################################################################################
################################################################################

conda activate lammps
git clone https://github.com/mir-group/pair_allegro.git ${TARGET}/pair_allegro
cd ${TARGET}/pair_allegro
git checkout 0161a8a8e2fe0849165de9eeae3fbb987b294079
./patch_lammps.sh ${SCRATCH}/lammps

################################################################################
################################################################################

conda activate lammps
module purge
module load compilers/gcc/10.2.0 \
            mpi/intel/2021.2 \
            libs/intel/tbb/2021.2 \
            libs/fftw/3.3.10/gcc/10.2.0_impi \
            cuda/11.8 \
            utils/ffmpeg/6.0.0 \
            utils/cmake/3.23.1 \
            utils/git/2.36.1

mkdir -p ${SCRATCH}/lammps/build
cd ${SCRATCH}/lammps/build
cp /deac/inf/adminGrp/anderss/repos/deac-examples/lammps/gcc.cmake ../cmake/presets/gcc.cmake
cmake   -C ../cmake/presets/gcc.cmake \
        -C ../cmake/presets/most.cmake \
        -DPKG_OPENMP=yes \
        -DBUILD_OMP=yes \
        -DFFTW3_LIBRARY:FILEPATH="/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0/lib/libfftw3.a" \
        -DFFTW3_OMP_LIBRARY:FILEPATH="/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0/lib/libfftw3_omp.a" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_PREFIX_PATH=`python -c 'import torch;print(torch.utils.cmake_prefix_path)'` \
        -DMKL_INCLUDE_DIR="${CONDA_PREFIX}/include" \
        -DCUDA_TOOLKIT_ROOT_DIR="/usr/local/cuda-11.8/lib64" \
        -DCMAKE_INSTALL_PREFIX="${TARGET}/lammps" \
        -DLAMMPS_INSTALL_RPATH=yes \
        ../cmake

make -j16
make install

################################################################################
################################################################################

# running
module purge && module load compilers/gcc/10.2.0 mpi/intel/2021.2
conda activate lammps
export LAMMPS_PATH="/deac/phy/natalieGrp/software/publiccode/lammps"
export PATH="${LAMMPS_PATH}/bin:$PATH"
export LAMMPS_POTENTIALS="${LAMMPS_PATH}/share/lammps/potentials"
export MSI2LMP_LIBRARY="${LAMMPS_PATH}/share/lammps/frc_files"
