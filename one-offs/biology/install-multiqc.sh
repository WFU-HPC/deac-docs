#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biology
export ENVIRONMENT=${SOFTWARE}/env-multiqc

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT

################################################################################
# python environment
################################################################################

module load compilers/gcc/12.3.0 apps/python/3.11.8

python3 -m venv $ENVIRONMENT

. ${ENVIRONMENT}/bin/activate
python3 -m pip install multiqc

################################################################################
# module
################################################################################
export MODPATH="${SOFTWARE}/../../../modulefiles/rocky9-noarch/envs/biology"

mkdir -p $MODPATH

################################################################################
################################################################################

cat << EOF > ${MODPATH}/multiqc
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-multiqc"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/\${environment}/bin

setenv  VIRTUAL_ENV                 "\${basedir}/env-multiqc"
setenv  VIRTUAL_ENV_PROMPT          "(env-multiqc)"
EOF
