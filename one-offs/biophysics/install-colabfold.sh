#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-colabfold
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS

cd $ENVIRONMENT

################################################################################
## initial python env
################################################################################

pixi init
pixi project channel add bioconda
pixi add python==3.11 pip pdbfixer mmseqs2==15.6f452 kalign2==2.04 hhsuite==3.3.0

################################################################################
## pip install ugh
################################################################################

eval "$(pixi shell-hook --manifest-path ${ENVIRONMENT}/pixi.toml)"
python3 -m pip install openmm "jax[cuda12]"==0.4.35 "colabfold[alphafold-minus-jax] @ git+https://github.com/sokrypton/ColabFold" "colabfold[alphafold]" "tensorflow[and-cuda]" silence_tensorflow

# Use 'Agg' for non-GUI backend
sed -i -e "s#from matplotlib import pyplot as plt#import matplotlib\nmatplotlib.use('Agg')\nimport matplotlib.pyplot as plt#g" ${ENVIRONMENT}/.pixi/envs/default/lib/python3.11/site-packages/colabfold/plot.py
# modify the default params directory
#sed -i -e "s#appdirs.user_cache_dir(__package__ or \"colabfold\")#\"${COLABFOLDDIR}/colabfold\"#g" ${ENVIRONMENT}/.pixi/envs/default/lib/python3.11/site-packages/colabfold/download.py
# suppress warnings related to tensorflow
sed -i -e "s#from io import StringIO#from io import StringIO\nfrom silence_tensorflow import silence_tensorflow\nsilence_tensorflow()#g" ${ENVIRONMENT}/.pixi/envs/default/lib/python3.11/site-packages/colabfold/batch.py
# remove cache directory
rm -rf ${ENVIRONMENT}/.pixi/envs/default/lib/python3.11/site-packages/colabfold/__pycache__
