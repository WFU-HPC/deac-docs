#!/bin/bash

# Directory
mkdir -p /deac/opt/rhel7-noarch/alphafold

# Install system-wide Miniconda. Not great, but probably OK if used JUST FOR THIS
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O /tmp/Miniconda3-latest-Linux-x86_64.sh
bash /tmp/Miniconda3-latest-Linux-x86_64.sh -b -p /deac/opt/rhel7-noarch/alphafold/miniconda3
rm -f /tmp/Miniconda3-latest-Linux-x86_64.sh

# Source newly installed Miniconda
. /deac/opt/rhel7-noarch/alphafold/miniconda3/etc/profile.d/conda.sh

# Create and activate environment
conda create --name alphafold python==3.9.18 -y
conda activate alphafold

# Install packages
conda install -y -c conda-forge openmm==7.5.1 cudatoolkit==11.2.2 pdbfixer
conda install -y -c bioconda hmmer hhsuite==3.3.0 kalign2
python3 -m pip install --upgrade pip
python3 -m pip install absl-py==1.0.0 biopython==1.79 chex==0.0.7 dm-haiku==0.0.9 dm-tree==0.1.6 immutabledict==2.0.0 jax==0.3.25 ml-collections==0.1.0 pandas==1.3.4 protobuf==3.20.1 scipy==1.7.0 tensorflow-cpu==2.9.0
python3 -m pip install --upgrade --no-cache-dir jax==0.3.25 jaxlib==0.3.25+cuda11.cudnn805 -f https://storage.googleapis.com/jax-releases/jax_cuda_releases.html

# Download and prepare alphafold
wget -P /tmp https://github.com/deepmind/alphafold/archive/refs/tags/v2.3.2.tar.gz
tar -xzf /tmp/v2.3.2.tar.gz -C /deac/opt/rhel7-noarch/alphafold

# Useful alphafold path
export ALPHAFOLD_PATH="/deac/opt/rhel7-noarch/alphafold/alphafold-2.3.2"

# whatever this thing is
wget --no-check-certificate -P ${ALPHAFOLD_PATH}/alphafold/common/ https://git.scicore.unibas.ch/schwede/openstructure/-/raw/7102c63615b64735c4941278d92b554ec94415f8/modules/mol/alg/src/stereo_chemical_props.txt

# Patch openmm for docker stuff, even though we're not using docker
cd ${CONDA_PREFIX}/lib/python3.*/site-packages
patch -p0 < ${ALPHAFOLD_PATH}/docker/openmm.patch
