#!/bin/bash

################################################################################
# python env
################################################################################

export TARGET="/deac/opt/rocky9-noarch/deac-envs/biology/env-esstmanGrp"

module load apps/python/3.11.8
python3 -m venv $TARGET
. ${TARGET}/bin/activate
python3 -m pip install numpy==1.26.4 pandas biopython scikit-learn tensorflow
python3 -m pip install torch torchdata torchvision torchaudio torchtext
python3 -m pip install 2to3 biopython Flask forgi

git clone git@github.com:ViennaRNA/forna.git ${TARGET}/forna
2to3 -w ${TARGET}/forna/forna_db.py
2to3 -w ${TARGET}/forna/forna.py
2to3 -w ${TARGET}/forna/forna_server.py

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/envs/biology/esstmanGrp)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biology/esstmanGrp
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8 apps/viennarna/2.7.0

set environment     "env-esstmanGrp"
set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                    \${basedir}/bin

setenv  VIRTUAL_ENV                     "\${basedir}"
setenv  VIRTUAL_ENV_PROMPT              "(\${environment})"
#setenv  PS1                             "(\${environment}) [\\u@\\h \\W]\\$"
setenv  FORNA                           ${TARGET}/forna
EOF

################################################################################
# varna
################################################################################

wget https://varna.lisn.upsaclay.fr/bin/VARNAv3-93.jar -O /deac/opt/rocky9-noarch/varna/VARNAv3-93.jar

mkdir -p $(dirname /deac/opt/modulefiles/rocky9-noarch/apps/varna/3-93)
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/varna/3-93
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a Varna software."
}

module-whatis   "Sets up a Varna software"

set basedir         "/deac/opt/rocky9-noarch/varna/"

################################################################################
################################################################################

setenv  VARNAJAR              "/deac/opt/rocky9-noarch/varna/VARNAv3-93.jar"
EOF
