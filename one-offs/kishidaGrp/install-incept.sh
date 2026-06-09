#!/bin/bash

################################################################################
################################################################################

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biology
export ENVIRONMENT=${SOFTWARE}/env-incept
export MODULEFILE="/deac/opt/modulefiles/rocky9-noarch/envs/biology/incept"

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT

################################################################################
################################################################################

cat << EOF > ${ENVIRONMENT}/pixi.toml
[workspace]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["conda-forge", "msys2"]
name = "env-incept"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = { version = "3.12.*" }
alabaster = { version = "*" }
aom = { version = "*" }
arrow = { version = "*" }
astroid = { version = "*" }
black = { version = "*" }
bleach = { version = "*" }
dill = { version = "*" }
expat = { version = "*" }
ffmpeg = { version = "*" }
graphite2 = { version = "*" }
hdf5 = { version = "*" }
inflection = { version = "*" }
ipykernel = { version = "*" }
jedi = { version = "*" }
jellyfish = { version = "*" }
pyuca = { version = "*" }
rich = { version = "*" }
rope = { version = "*" }
setuptools = { version = "*" }
sip = { version = "*" }
snappy = { version = "*" }
snowballstemmer = { version = "*" }
sortedcontainers = { version = "*" }
soupsieve = { version = "*" }
spyder = { version = "*" }
spyder-kernels = { version = "*" }
sqlite = { version = "*" }
watchdog = { version = "*" }
tensorflow = { version = "*" }
tensorflow-estimator = { version = "*" }

[pypi-dependencies]
cycler = "*"
gast = "*"
google-pasta = "*"
ipympl = "*"
ipython = "*"
ipython-genutils = "*"
ipywidgets = "*"
joblib = "*"
jupyter = "*"
jupyterlab = "*"
jupyterlab-widgets = "*"
kaleido = "*"
keras = "*"
keras-preprocessing = "*"
kiwisolver = "*"
markdown = "*"
markupsafe = "*"
matplotlib = "*"
opt-einsum = "*"
pandas = "*"
plotly = "*"
protobuf = "*"
psutil = "*"
requests-oauthlib = "*"
rsa = "*"
scikit-learn = "*"
scipy = "*"
six = "*"
stack-data = "*"
tenacity = "*"
tensorboard = "*"
tensorboard-data-server = "*"
tensorboard-plugin-wit = "*"
werkzeug = "*"
widgetsnbextension = "*"
wrapt = "*"
EOF

cd $ENVIRONMENT
pixi install

################################################################################
################################################################################

mkdir -p $(dirname $MODULEFILE)

cat << EOF > $MODULEFILE
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set environment     "env-incept"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/\${environment}/.pixi/envs/default/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/\${environment}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "\${basedir}/\${environment}"
setenv  PIXI_PROJECT_NAME           "env-incept"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(env-incept) "
setenv  CONDA_DEFAULT_ENV           "env-incept"
setenv  CONDA_PREFIX                "\${basedir}/\${environment}/.pixi/envs/default"
setenv  CONDA_SHLVL                 1
EOF
