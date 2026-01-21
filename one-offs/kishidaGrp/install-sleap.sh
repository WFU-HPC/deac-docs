#!/bin/bash

################################################################################
################################################################################

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biology
export ENVIRONMENT=${SOFTWARE}/env-sleap

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT

################################################################################
################################################################################

module load apps/python/3.11.8

################################################################################
################################################################################

python3 -m venv $ENVIRONMENT

. ${ENVIRONMENT}/bin/activate

python3 -m pip install "sleap[nn]" --extra-index-url https://download.pytorch.org/whl/cu128 --index-url https://pypi.org/simple

################################################################################
################################################################################

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/envs/biology/sleap)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biology/sleap
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-sleap"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                    \${basedir}/\${environment}/bin

setenv  VIRTUAL_ENV                     "\${basedir}/\${environment}"
setenv  VIRTUAL_ENV_PROMPT              "(\${environment})"
#setenv  PS1                            "(\${environment}) [\u@\h \W]$"
EOF
