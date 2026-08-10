#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export MODPATH=/deac/opt/modulefiles/rocky9-noarch/envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-boltzgen

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $MODPATH

module load compilers/gcc/12.3.0 apps/python/3.11.8

################################################################################
# initialize environment
################################################################################

python3 -m venv ${ENVIRONMENT}
. ${ENVIRONMENT}/bin/activate

python3 -m pip install boltzgen jupyter jupyterlab

################################################################################
################################################################################
################################################################################
################################################################################

cat << EOF > ${MODPATH}/boltzgen
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-boltzgen"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                    "\${basedir}/env-boltzgen/bin"

setenv  VIRTUAL_ENV                     "\${basedir}/env-boltzgen"
setenv  VIRTUAL_ENV_PROMPT              "(env-boltzgen)"
#setenv  PS1                             "(env-boltzgen) [\u@\h \W]\$"
EOF
