#!/bin/bash
# this is it man
export TARGET="/deac/opt/rocky9-noarch/deac-envs/biophysics/env-RFdiffusion3"

# getting started
mkdir -p $TARGET

## hbplus
unzip -q /deac/opt/tarballs/hbplus/hbplus.zip -d $TARGET
cd ${TARGET}/hbplus
make

# pixi ftw yo
cd $TARGET
cat <<EOF > ${TARGET}/pixi.toml
[workspace]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["conda-forge"]
name = "RFdiffusion3"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "==3.12"
pip = ">=26.0.1,<27"

[pypi-dependencies]
rc-foundry = { extras = ["all"] }
EOF

# install bby
pixi install

# do it
eval "$(pixi shell-hook --manifest-path ${TARGET}/pixi.toml)"

# download them models
foundry install all --checkpoint-dir ${TARGET}/checkpoints
# foundry list-available
# foundry list-installed

################################################################################
################################################################################
################################################################################
################################################################################

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/envs/biophysics/RFdiffusion3)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biophysics/RFdiffusion3
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set environment     "env-RFdiffusion3"
set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "${TARGET}/.pixi/envs/default/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "${TARGET}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "${TARGET}"
setenv  PIXI_PROJECT_NAME           "RFdiffusion3"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(RFdiffusion3) "
setenv  CONDA_DEFAULT_ENV           "RFdiffusion3"
setenv  CONDA_PREFIX                "${TARGET}/.pixi/envs/default"

setenv  HBPLUS_PATH                 "${TARGET}/hbplus/hbplus"
setenv  FOUNDRY_CHECKPOINT_DIRS     "${TARGET}/checkpoints"
EOF



