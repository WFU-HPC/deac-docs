#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biology
export ENVIRONMENT=${SOFTWARE}/env-sequencing

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT

################################################################################
# pixi environment
################################################################################

cat << EOF > ${ENVIRONMENT}/pixi.toml
[workspace]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["conda-forge", "bioconda"]
name = "env-sequencing"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
matplotlib = ">=3.7.3,<4"
pandas = ">=2.0.3,<3"
biopython = ">=1.83,<2"
pixy = ">=2.0.0.beta2,<3"
dammit = ">=1.2,<2"
busco = ">=3.0.2,<4"
multiqc = ">=1.28,<2"
cutadapt = ">=4.9,<5"
flye = ">=2.9.5,<3"
quast = ">=5.2.0,<6"
salmon = ">=1.10.3,<2"
mmseqs2 = ">=16.747c6,<17"
jellyfish = ">=1.1.0,<2"
EOF

cd $ENVIRONMENT

# export PIXI_FROZEN=true
# export PIXI_LOCKED=true
pixi config set --local run-post-link-scripts insecure
pixi install

RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "FAILED PIXI"
  exit
fi

# pixi shell --manifest-path ${ENVIRONMENT}/pixi.toml

################################################################################
# module
################################################################################

export MODPATH="${SOFTWARE}/../../../modulefiles/rocky9-noarch/envs/biology"

mkdir -p $MODPATH

################################################################################
################################################################################

cat << EOF > ${MODPATH}/sequencing
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set environment     "env-sequencing"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/\${environment}/.pixi/envs/default/bin"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/\${environment}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "\${basedir}/\${environment}"
setenv  PIXI_PROJECT_NAME           "env-sequencing"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(env-sequencing) "
setenv  CONDA_DEFAULT_ENV           "env-sequencing"
setenv  CONDA_PREFIX                "\${basedir}/\${environment}/.pixi/envs/default"
setenv  HYDRA_FULL_ERROR            1

source-sh bash  "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/activate-r-base.sh"
source-sh bash  "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/augustus.sh"
source-sh bash  "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libarrow_activate.sh"
source-sh bash  "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libglib_activate.sh"
source-sh bash  "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
source-sh bash  "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/openjdk_activate.sh"
EOF
