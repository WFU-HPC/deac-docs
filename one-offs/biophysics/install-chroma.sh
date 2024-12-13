#!/bin/bash

export SOFTWARE=/home/anderss/hdeac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-chroma
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS

module load compilers/gcc/12.3.0 apps/python/3.11.8

################################################################################
## initial python env
################################################################################

python3 -m venv ${ENVIRONMENT}
. ${ENVIRONMENT}/bin/activate

python3 -m pip install generate-chroma==1.0.0 jupyter jupyterlab
