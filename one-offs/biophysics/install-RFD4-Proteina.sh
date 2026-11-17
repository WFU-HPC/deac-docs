#!/bin/bash
module load apps/apptainer/1.5.2

git clone --depth 1 https://github.com/RosettaCommons/RFD4-Proteina.git /deac/chm/albaneseGrp/06_software/RFD4-Proteina
cd /deac/chm/albaneseGrp/06_software/RFD4-Proteina
make setup

cat << EOF > /deac/chm/albaneseGrp/06_software/RFD4-Proteina/module
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load apps/apptainer/1.5.2

set basedir         "/deac/chm/albaneseGrp/06_software/RFD4-Proteina"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/.venv/bin

setenv  VIRTUAL_ENV                     "\${basedir}/.venv"
setenv  VIRTUAL_ENV_PROMPT              "(RFD4-Proteina)"
#setenv  PS1                             "(RFD4-Proteina) [\\u@\\h \\W]\\$"

setenv  CCD_MIRROR_PATH                 "/deac/chm/albaneseGrp/06_software/rfd3_ccd_mirror"
EOF
