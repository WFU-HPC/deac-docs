#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biology
export ENVIRONMENT=${SOFTWARE}/env-mvts

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT

cat << EOF > ${ENVIRONMENT}/pixi.toml
[workspace]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["pytorch", "conda-forge", "msys2"]
name = "mvts"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "3.8.*"
pip = "*"
tqdm = "*"
tensorflow = "*"
lightning = "*"
seaborn = "*"
openpyxl = "*"
tmux = "*"
jupyter = ">=1.1.1,<2"
ipykernel = "*"
pandas = "*"
pytorch = "*"
torchvision = "*"
scikit-learn = "*"
torchinfo = "*"
tornado = "*"
tensorboard = "*"
torchmetrics = "*"
sqlite = "*"
uvicorn = "*"
ipython = "*"
scipy = "*"
EOF

cd $ENVIRONMENT
pixi install

################################################################################
################################################################################

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/envs/biology/mvts)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biology/mvts
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set environment     "env-mvts"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/\${environment}/.pixi/envs/default/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/\${environment}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "\${basedir}/\${environment}"
setenv  PIXI_PROJECT_NAME           "env-mvts"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(env-mvts) "
setenv  CONDA_DEFAULT_ENV           "env-mvts"
setenv  CONDA_PREFIX                "\${basedir}/\${environment}/.pixi/envs/default"
setenv  CONDA_SHLVL                 1

source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
EOF
