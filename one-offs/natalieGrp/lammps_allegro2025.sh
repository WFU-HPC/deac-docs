#!/bin/bash

# Go ahead and do this whole thing on a GPU node:
# save yourself some time and headache.

################################################################################
################################################################################
# part 0: python environment
################################################################################
################################################################################

ssh gpu-a100-02.deac.wfu.edu

# mkdir -p /scratch/anderss
export SOFTWARE="/deac/opt/rocky9-noarch/deac-envs/natalieGrp"
export ENVIRONMENT="${SOFTWARE}/env-allegro2025a"

module load compilers/gcc/12.3.0 apps/python/3.11.8

python3 -m venv $ENVIRONMENT
. ${ENVIRONMENT}/bin/activate
python3 -m pip install torch torchvision torchaudio nequip wandb nequip-allegro
python3 -m pip install cuequivariance-torch cuequivariance-ops-torch-cu12


## Testing nequip on a GPU node
# module load compilers/gcc/12.3.0 apps/python/3.11.8
# . ${ENVIRONMENT}/bin/activate
# git clone https://github.com/mir-group/nequip.git /tmp/nequip
# cd /tmp/nequip/configs
# python3 get_tutorial_data.py
# nequip-train -cn tutorial.yaml
# cd $HOME && rm -rf /tmp/nequip

# exit the node to restart your environment!
exit

################################################################################
################################################################################
# part 1: lammps
################################################################################
################################################################################

ssh gpu-a100-02.deac.wfu.edu

export SOFTWARE="/deac/opt/rocky9-noarch/deac-envs/natalieGrp"
export ENVIRONMENT="${SOFTWARE}/env-allegro2025a"

module load compilers/gcc/12.3.0 nvidia/cuda12/cuda/12.4.1 mpi/openmpi/4.1.6 apps/python/3.11.8

. ${ENVIRONMENT}/bin/activate

git clone git@github.com:mir-group/pair_nequip_allegro.git ${SOFTWARE}/pair_nequip_allegro -b v0.7.0
git clone -b release --depth=1 https://github.com/lammps/lammps /tmp/lammps
cd ${SOFTWARE}/pair_nequip_allegro
./patch_lammps.sh /tmp/lammps
mkdir -p /tmp/lammps/build && cd /tmp/lammps/build

cmake   ../cmake \
        -C /tmp/lammps/cmake/presets/kokkos-cuda.cmake \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX="${SOFTWARE}/lammps-22Jul2025" \
        -DCMAKE_PREFIX_PATH="$(python3 -c 'import torch;print(torch.utils.cmake_prefix_path)')" \
        -DLAMMPS_INSTALL_RPATH=ON \
        -DNEQUIP_AOT_COMPILE=ON \
        -DMKL_INCLUDE_DIR=/tmp \
        -DNVCC_WRAPPER_DEFAULT_COMPILER=g++ \
        -DPKG_EXTRA-COMPUTE=ON

make -j32
make install

cd $HOME
rm -rf /tmp/lammps

## UGHGGGGGGHGGGGGHHHHHHHHHHHHHHHHHHHHHHHHHH
scp gpu-a100-01.deac.wfu.edu:/usr/lib64/libcuda.so.1 ${SOFTWARE}/lammps-22Jul2025/.

################################################################################
################################################################################
# part 2: module
################################################################################
################################################################################

mkdir -p /deac/opt/modulefiles/rocky9-noarch/envs
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/allegro2025a
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

module load compilers/gcc/12.3.0 nvidia/cuda12/cuda/12.4.1 mpi/openmpi/4.1.6 apps/python/3.11.8

set environment     "env-allegro2025a"
set basedir         "${SOFTWARE}"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/\${environment}/bin
prepend-path    PATH                \${basedir}/lammps-22Jul2025/bin
append-path     LD_LIBRARY_PATH     \${basedir}/lammps-22Jul2025

setenv  VIRTUAL_ENV                 "$ENVIRONMENT"
setenv  VIRTUAL_ENV_PROMPT          "\$environment"
setenv  PYTHONWARNINGS              "ignore"
setenv  OMPI_MCA_mpi_cuda_support   1
setenv  LAMMPS_ROOT                 "\${basedir}/lammps-22Jul2025"
EOF

