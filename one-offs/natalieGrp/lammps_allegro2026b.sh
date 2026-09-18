#!/bin/bash

# UPDATED on 2026/09/16 (HPC Center)

# Go ahead and do this whole thing on a GPU node:
# save yourself some time and headache.

################################################################################
################################################################################
# part 0: python environment
################################################################################
################################################################################

ssh gpu-a100-01.deac.wfu.edu

export SOFTWARE="/deac/opt/rocky9-noarch/deac-envs/natalieGrp"
export ENVIRONMENT="${SOFTWARE}/env-allegro2026b"

module load compilers/gcc/14.3.0 apps/python/3.14.5

python3 -m venv $ENVIRONMENT
. ${ENVIRONMENT}/bin/activate
python3 -m pip install torch torchvision torchaudio nequip wandb nequip-allegro
python3 -m pip install cuequivariance-torch cuequivariance-ops-torch-cu13


# argparse patching for python3.14. Maybe this can go away? Not so bad.
cat << 'EOF' > ${ENVIRONMENT}/lib/python3.14/site-packages/sitecustomize.py
import argparse

# Catch Python 3.14 strict argparse validation for custom Hydra objects
_orig_check_help = argparse.ArgumentParser._check_help
def _safe_check_help(self, action):
    try:
        _orig_check_help(self, action)
    except (TypeError, ValueError):
        pass

argparse.ArgumentParser._check_help = _safe_check_help
EOF

# ## Testing nequip on a GPU node
# module load compilers/gcc/14.3.0 apps/python/3.14.5
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
# part 0.5: nvhpc
################################################################################
################################################################################

ssh gpu-a100-01.deac.wfu.edu

export SOFTWARE="/deac/opt/rocky9-noarch/deac-envs/natalieGrp"
export ENVIRONMENT="${SOFTWARE}/env-allegro2026b"

mkdir -p ${SOFTWARE}/nvhpc
wget https://developer.download.nvidia.com/hpc-sdk/26.5/nvhpc_2026_265_Linux_x86_64_cuda_13.2.tar.gz -O /tmp/nvhpc_2026_265_Linux_x86_64_cuda_13.2.tar.gz
tar -xpzf /tmp/nvhpc_2026_265_Linux_x86_64_cuda_13.2.tar.gz -C /tmp
NVHPC_SILENT=true NVHPC_INSTALL_DIR="${SOFTWARE}/nvhpc" bash /tmp/nvhpc_2026_265_Linux_x86_64_cuda_13.2/install

cd ${SOFTWARE}/nvhpc/Linux_x86_64/2026/cuda/13.2/lib64/stubs
ln -s libcuda.so libcuda.so.1

rm -rf /tmp/nvhpc_2026_*

# exit the node to restart your environment!
exit

################################################################################
################################################################################
# part 1: lammps
################################################################################
################################################################################

ssh gpu-a100-01.deac.wfu.edu

export SOFTWARE="/deac/opt/rocky9-noarch/deac-envs/natalieGrp"
export ENVIRONMENT="${SOFTWARE}/env-allegro2026b"
export LAMMPSVER="patch_10Sep2025"

# module load compilers/gcc/12.3.0 mpi/openmpi/4.1.6 apps/python/3.11.8 nvidia/cuda12/cuda/12.8.1
module purge && module load compilers/gcc/14.3.0 apps/python/3.14.5 mpi/openmpi/5.0.10_cuda13

. ${ENVIRONMENT}/bin/activate

git clone git@github.com:mir-group/pair_nequip_allegro.git ${SOFTWARE}/pair_nequip_allegro # -b v0.7.0
# git clone -b release --depth=1 https://github.com/lammps/lammps /tmp/lammps
git clone --branch $LAMMPSVER https://github.com/lammps/lammps /tmp/lammps
cd ${SOFTWARE}/pair_nequip_allegro
./patch_lammps.sh /tmp/lammps
mkdir -p /tmp/lammps/build && cd /tmp/lammps/build

export NVHPC_CUDA_DIR="${SOFTWARE}/nvhpc/Linux_x86_64/2026/cuda/13.2"
export CUDA_HOME="${NVHPC_CUDA_DIR}"
export CUDAToolkit_ROOT="${NVHPC_CUDA_DIR}"
export PATH="${NVHPC_CUDA_DIR}/bin:${PATH}"
export LD_LIBRARY_PATH="${NVHPC_CUDA_DIR}/lib64:${LD_LIBRARY_PATH}"
export TORCH_CUDA_ARCH_LIST="7.0 8.0 9.0"
export CMAKE_CUDA_ARCHITECTURES="7.0 8.0 9.0"
export TORCH_LIB_DIR="$(python3 -c 'import torch, os; print(os.path.join(os.path.dirname(torch.__file__), "lib"))')"
export PY_CUDA_DIR="$(python3 -c 'import nvidia, os; print(os.path.join(os.path.dirname(nvidia.__file__), "cu13", "lib"))' 2>/dev/null || echo "${ENVIRONMENT}/lib/python3.14/site-packages/nvidia/cu13/lib")"

# Execute CMake configuration
cmake ../cmake \
    -C /tmp/lammps/cmake/presets/kokkos-cuda.cmake \
    -DCMAKE_BUILD_TYPE=Release \
    -DCMAKE_CXX_STANDARD=20 \
    -DCMAKE_INSTALL_PREFIX="${SOFTWARE}/lammps-${LAMMPSVER}" \
    -DCMAKE_PREFIX_PATH="$(python3 -c 'import torch;print(torch.utils.cmake_prefix_path)')" \
    -DCMAKE_CUDA_COMPILER="${NVHPC_CUDA_DIR}/bin/nvcc" \
    -DCUDAToolkit_ROOT="${NVHPC_CUDA_DIR}" \
    -DNVCC_WRAPPER_DEFAULT_COMPILER=g++ \
    -DLAMMPS_INSTALL_RPATH=OFF \
    -DCMAKE_INSTALL_RPATH="${NVHPC_CUDA_DIR}/lib64:${TORCH_LIB_DIR}:${PY_CUDA_DIR}" \
    -DCMAKE_BUILD_RPATH="${NVHPC_CUDA_DIR}/lib64:${TORCH_LIB_DIR}:${PY_CUDA_DIR}" \
    -DCMAKE_EXE_LINKER_FLAGS="-Wl,-rpath,${NVHPC_CUDA_DIR}/lib64:${TORCH_LIB_DIR}:${PY_CUDA_DIR}" \
    -DNEQUIP_AOT_COMPILE=ON \
    -DMKL_INCLUDE_DIR=/tmp \
    -DPKG_EXTRA-COMPUTE=ON

make -j32
make install

cd $HOME
rm -rf /tmp/lammps

exit

################################################################################
################################################################################
# part 2: module
################################################################################
################################################################################


export SOFTWARE="/deac/opt/rocky9-noarch/deac-envs/natalieGrp"
export ENVIRONMENT="${SOFTWARE}/env-allegro2026b"
export LAMMPSVER="patch_10Sep2025"

mkdir -p /deac/opt/modulefiles/rocky9-noarch/envs
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/allegro2026b
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

module load compilers/gcc/14.3.0 apps/python/3.14.5 mpi/openmpi/5.0.10_cuda13

set environment     "env-allegro2026b"
set basedir         "${SOFTWARE}"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/\${environment}/bin
prepend-path    PATH                \${basedir}/lammps-${LAMMPSVER}/bin
prepend-path    LD_LIBRARY_PATH     \${basedir}/nvhpc/Linux_x86_64/2026/cuda/13.2/lib64/stubs

setenv  VIRTUAL_ENV                 "$ENVIRONMENT"
setenv  VIRTUAL_ENV_PROMPT          "\$environment"
setenv  PYTHONWARNINGS              "ignore"
setenv  OMPI_MCA_mpi_cuda_support   1
setenv  LAMMPS_ROOT                 "\${basedir}/lammps-${LAMMPSVER}"
EOF

