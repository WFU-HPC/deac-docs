#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-AF2chi
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs
export MODPATH=/deac/opt/modulefiles/rocky9-noarch/envs/biophysics

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS
mkdir -p $MODPATH

cd $ENVIRONMENT

################################################################################
## this makes me sad
################################################################################

git clone https://github.com/matteo-cagiada/AF2chi_localcolabfold.git ${ENVIRONMENT}/AF2chi_localcolabfold
cd ${ENVIRONMENT}/AF2chi_localcolabfold
${ENVIRONMENT}/AF2chi_localcolabfold/install_colabbatch_linux.sh
${ENVIRONMENT}/AF2chi_localcolabfold/patcher_colabfold_linux.sh

################################################################################
################################################################################

cat << EOF > ${MODPATH}/AF2chi
#%Module
##
## python evironment

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment."
}

module-whatis   "Sets up a python environment"

set environment     "env-AF2chi"
set basedir         "${ENVIRONMENT}"

################################################################################
################################################################################

prepend-path    PATH                "\${basedir}/AF2chi_localcolabfold/localcolabfold/colabfold-conda/bin"
EOF
