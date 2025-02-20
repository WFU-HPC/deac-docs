#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-esmfold
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS

# module load compilers/gcc/12.3.0

mkdir -p $ENVIRONMENT

cat << EOF > ${ENVIRONMENT}/pixi.toml
[project]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["nvidia", "pytorch", "conda-forge", "bioconda"]
name = "env-esmfold"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "3.9.*"
libgcc = "7.2.*"
setuptools = "59.5.0.*"
pip = "*"
numpy = "1.22.*"
cuda-toolkit = { version = "11.6.*", channel = "nvidia" }
cuda-nvcc = { version = "11.6.*", channel = "nvidia" }
cuda-compiler = { version = "11.6.*", channel = "nvidia" }
cuda-command-line-tools = { version = "11.6.*", channel = "nvidia" }
cuda-libraries-dev = { version = "11.6.*", channel = "nvidia" }
cuda-cccl = { version = "11.6.*", channel = "nvidia" }
cuda-cudart = { version = "11.6.*", channel = "nvidia" }
cuda-cudart-dev = { version = "11.6.*", channel = "nvidia" }
cuda-cuobjdump = { version = "11.6.*", channel = "nvidia" }
cuda-cupti = { version = "11.6.*", channel = "nvidia" }
cuda-cuxxfilt = { version = "11.6.*", channel = "nvidia" }
cuda-driver-dev = { version = "11.6.*", channel = "nvidia" }
cuda-gdb = { version = "11.6.*", channel = "nvidia" }
cuda-libraries = { version = "11.6.*", channel = "nvidia" }
cuda-nsight = { version = "11.6.*", channel = "nvidia" }
cuda-nsight-compute = { version = "11.6.*", channel = "nvidia" }
cuda-nvdisasm = { version = "11.6.*", channel = "nvidia" }
cuda-nvml-dev = { version = "11.6.*", channel = "nvidia" }
cuda-nvprof = { version = "11.6.*", channel = "nvidia" }
cuda-nvprune = { version = "11.6.*", channel = "nvidia" }
cuda-nvrtc = { version = "11.6.*", channel = "nvidia" }
cuda-nvrtc-dev = { version = "11.6.*", channel = "nvidia" }
cuda-nvtx = { version = "11.6.*", channel = "nvidia" }
cuda-nvvp = { version = "11.6.*", channel = "nvidia" }
cuda-sanitizer-api = { version = "11.6.*", channel = "nvidia" }
openmm = "7.7.*"
pdbfixer = "*"
pytorch-lightning = "*"
biopython = "*"
pandas = "*"
pyyaml = "==5.4.1"
requests = "*"
scipy = "==1.7"
tqdm = "==4.62.2"
typing-extensions = "==4.0"
wandb = "*"
modelcif = "==0.7"
#awscli = "*"
ml-collections = "*"
aria2 = "*"
mkl = "2024.0.*"
git = "*"
hmmer = { version = "==3.3.2", channel = "bioconda" }
hhsuite = { version = "==3.3.0", channel = "bioconda" }
kalign2 = { version = "==2.4", channel = "bioconda" }
mmseqs2 = { channel = "bioconda" }
pytorch = { version = "1.12.*", channel = "pytorch" }
biotite = "*"

[pypi-dependencies]
deepspeed = ""
dm-tree = "==0.1.6"
dllogger = { git = "git+https://github.com/NVIDIA/dllogger.git" }
fair-esm = { version = "==2.0.0", extras = ["esmfold"] }
EOF

cd $ENVIRONMENT

# export PIXI_FROZEN=true
# export PIXI_LOCKED=true
pixi install

RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "FAILED PIXI"
  exit
fi

eval "$(pixi shell-hook --manifest-path ${ENVIRONMENT}/pixi.toml)"

################################################################################
# openfold
################################################################################

wget https://github.com/aqlaboratory/openfold/archive/refs/tags/v1.0.1.tar.gz \
     -O /tmp/openfold-1.0.1.tar.gz
tar -xvf /tmp/openfold-1.0.1.tar.gz -C $REPOS
cd ${REPOS}/openfold-1.0.1

export NVCC_APPEND_FLAGS='-allow-unsupported-compiler'
python3 setup.py install

################################################################################
# example
################################################################################

cat << EOF > /tmp/esmfold.py
#!/usr/bin/env python3

import torch
import esm

model = esm.pretrained.esmfold_v1()
model = model.eval().cuda()

# Optionally, uncomment to set a chunk size for axial attention. This can help reduce memory.
# Lower sizes will have lower memory requirements at the cost of increased speed.
# model.set_chunk_size(128)

sequence = "MKTVRQERLKSIVRILERSKEPVSGAQLAEELSVSRQVIVQDIAYLRSLGYNIVATPRGYVLAGG"
# Multimer prediction can be done with chains separated by ':'

with torch.no_grad():
    output = model.infer_pdb(sequence)

with open("result.pdb", "w") as f:
    f.write(output)

import biotite.structure.io as bsio
struct = bsio.load_structure("result.pdb", extra_fields=["b_factor"])
print(struct.b_factor.mean())  # this will be the pLDDT
# 88.3
EOF

python3 /tmp/esmfold.py

################################################################################
# cleanup
################################################################################

rm -f /tmp/esmfold.py
rm -f /tmp/openfold-1.0.1.tar.gz
