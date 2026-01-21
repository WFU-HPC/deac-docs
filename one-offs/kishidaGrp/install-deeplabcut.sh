#!/bin/bash

################################################################################
################################################################################

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biology
export ENVIRONMENT=${SOFTWARE}/env-deeplabcut

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT

################################################################################
################################################################################

module load apps/python/3.11.8

################################################################################
################################################################################

python3 -m venv $ENVIRONMENT

. ${ENVIRONMENT}/bin/activate

python3 -m pip install pandas==2.0.3
python3 -m pip install jupyter
python3 -m pip install --pre 'deeplabcut[gui,modelzoo]'

################################################################################
################################################################################

# dnf install xcb-util-cursor-devel

################################################################################
################################################################################

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biology/deeplabcut
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-deeplabcut"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                    \${basedir}/\${environment}/bin

setenv  VIRTUAL_ENV                     "\${basedir}/\${environment}"
setenv  VIRTUAL_ENV_PROMPT              "(\${environment})"
#setenv  PS1                            "(\${environment}) [\u@\h \W]$"
EOF
