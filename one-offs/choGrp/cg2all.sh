#!/bin/bash

export PIXI_CACHE_DIR=${SCRATCH}/pixi-cache-anderss
export TARGET=/deac/opt/rocky9-noarch/deac-envs/choGrp/cg2all

pixi init ${TARGET} -c dglteam/label/cu113 -c conda-forge
cd ${TARGET}
pixi add pip python=3.9 numpy=1.22 pandas pydantic
pixi add --pypi dgl==1.0.0 e3nn==0.5.1 "cg2all @ git+https://github.com/huhlim/cg2all.git" mrcfile

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/physics/cg2all
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "${TARGET}/.pixi/envs/default/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "${TARGET}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "${TARGET}"
setenv  PIXI_PROJECT_NAME           "cg2all"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(cg2all) "
setenv  CONDA_DEFAULT_ENV           "cg2all"
setenv  CONDA_PREFIX                "${TARGET}/.pixi/envs/default"
setenv  PYTHONNOUSERSITE            "1"
EOF
