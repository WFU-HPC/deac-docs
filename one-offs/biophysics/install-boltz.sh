#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export MODPATH=/deac/opt/modulefiles/rocky9-noarch/envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-boltz
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS
mkdir -p $MODPATH

cd $ENVIRONMENT

################################################################################
# initialize environment
################################################################################

module load apps/python/3.11.8

python3 -m venv ${ENVIRONMENT}
. ${ENVIRONMENT}/bin/activate

################################################################################
# download repo and install
################################################################################

git clone git@github.com:yehlincho/BoltzDesign1.git ${REPOS}/BoltzDesign1
cd ${REPOS}/BoltzDesign1/boltz
python3 -m pip install -e .

################################################################################
# install rest of modules
################################################################################

python3 -m pip install ipykernel matplotlib seaborn prody tqdm PyYAML requests pypdb py3Dmol logmd==0.1.45
python3 -m pip install pyrosettacolabsetup pyrosetta-installer

################################################################################
# download pyrosetta, boltz weights, and ligandmpnn parameters
################################################################################

python3 -c 'import pyrosetta_installer; pyrosetta_installer.install_pyrosetta()'
python3 -c "from boltz.main import download; from pathlib import Path; cache = Path('${REPOS}/BoltzDesign1/cache').expanduser(); cache.mkdir(parents=True, exist_ok=True); download(cache)"

cd ${REPOS}/BoltzDesign1/LigandMPNN/
bash get_model_params.sh "./model_params"

chmod +x "${REPOS}/BoltzDesign1/boltzdesign/DAlphaBall.gcc"

################################################################################
################################################################################
################################################################################
################################################################################

cat << EOF > ${MODPATH}/boltzdesign
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-boltz"
set basedir         "$SOFTWARE"

################################################################################
################################################################################

prepend-path    PATH                ${ENVIRONMENT}/bin
prepend-path    PYTHONPATH          ${REPOS}/BoltzDesign1/boltzdesign

setenv  VIRTUAL_ENV                  "\${basedir}/env-boltz"
setenv  VIRTUAL_ENV_PROMPT           "(env-boltz)"
#setenv  PS1                         "(env-boltz) [\\u@\\h \\W]\\$"

setenv BOLTZROOT                    ${REPOS}/BoltzDesign1 
EOF
