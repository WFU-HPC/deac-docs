#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export MODPATH=/deac/opt/modulefiles/rocky9-noarch/envs/biophysics
export ENV_NAME=proteinmpnn
export ENVIRONMENT="${SOFTWARE}/env-${ENV_NAME}"
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS
mkdir -p $MODPATH

################################################################################
# pixi environment
################################################################################

cat << EOF > ${ENVIRONMENT}/pixi.toml
[workspace]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["pytorch", "conda-forge", "huggingface", "bioconda"]
name = "${ENV_NAME}"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "3.8.*"
pip = "*"
numpy = { version = "1.22.3.*", channel = "conda-forge" }
pandas = { version = "~=1.1.5", channel = "conda-forge" }
pytorch = { version = "1.12.*", channel = "pytorch" }
transformers = { version = "4.11.3.*", channel = "huggingface" }
pytorch-lightning = { version = "1.6.4.*", channel = "conda-forge" }
huggingface_hub = { channel = "conda-forge" }
seaborn = { channel = "conda-forge" }
mpl-scatter-density = { channel = "conda-forge" }
astropy = { version = "5.1.*", channel = "conda-forge" }
gitpython = { channel = "conda-forge" }
biotite = { version = "0.34.*", channel = "conda-forge" }
scikit-learn = { version = "1.2.1.*", channel = "conda-forge" }
tmalign = { channel = "bioconda" }
requests = { channel = "conda-forge" }
mkl = "2023.2.*"
torchvision = { version = "*", channel = "pytorch" }
torchaudio = { version = "*", channel = "pytorch" }
EOF

cd $ENVIRONMENT

export PIXI_FROZEN=false
# export PIXI_LOCKED=true
pixi install

RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "FAILED PIXI"
  exit
fi

# pixi shell --manifest-path ${ENVIRONMENT}/pixi.toml
eval "$(pixi shell-hook --manifest-path ${ENVIRONMENT}/pixi.toml)"

################################################################################
# software
################################################################################

git clone git@github.com:microsoft/foldingdiff.git ${REPOS}/foldingdiff
git clone git@github.com:dauparas/ProteinMPNN.git  ${REPOS}/ProteinMPNN

cd ${REPOS}/foldingdiff
python3 -m pip install -e ./

cd ${REPOS}/foldingdiff/data
./download_cath.sh

## test
#cd ${REPOS}/foldingdiff
#python3 bin/train.py config_jsons/cath_full_angles_cosine.json --dryrun

################################################################################
# modules
################################################################################

cat << EOF > "${MODPATH}/${ENV_NAME}"
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set environment     "$ENV_NAME"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "${ENVIRONMENT}/.pixi/envs/default/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "${ENVIRONMENT}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "${ENVIRONMENT}"
setenv  PIXI_PROJECT_NAME           "$ENV_NAME"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "($ENV_NAME) "
setenv  CONDA_DEFAULT_ENV           "$ENV_NAME"
setenv  CONDA_PREFIX                "${ENVIRONMENT}/.pixi/envs/default"

setenv FOLDINGDIFF_ROOT             "${REPOS}/foldingdiff"
setenv PROTEINMPNN_ROOT             "${REPOS}/ProteinMPNN"

source-sh bash "${ENVIRONMENT}/.pixi/envs/default/etc/conda/activate.d/libblas_mkl_activate.sh"
source-sh bash "${ENVIRONMENT}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
EOF
