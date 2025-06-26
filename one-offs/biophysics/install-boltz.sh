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

module load compilers/gcc/12.3.0 apps/python/3.11.8

################################################################################
# initialize environment
################################################################################

python3 -m venv ${ENVIRONMENT}
. ${ENVIRONMENT}/bin/activate

################################################################################
## alphafold3
################################################################################

cd ${REPOS}/alphafold3

python3 -m pip install -r dev-requirements.txt
python3 -m pip install --no-deps .

# Build chemical components database (this binary was installed by pip).
build_data

################################################################################
# download boltz repo and install
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

prepend-path    PATH                    "\${basedir}/\${environment}/bin"
prepend-path    PATH                    "\${basedir}/progs/hmmer/bin"
prepend-path    PYTHONPATH              "\${basedir}/repos/BoltzDesign1/boltzdesign"

setenv  VIRTUAL_ENV                     "\${basedir}/env-boltz"
setenv  VIRTUAL_ENV_PROMPT              "(env-boltz)"
setenv  XLA_CLIENT_MEM_FRACTION         0.95
setenv  XLA_PYTHON_CLIENT_PREALLOCATE   true
setenv  XLA_FLAGS                       "--xla_gpu_enable_triton_gemm=false"

setenv  BOLTZROOT                       "\${basedir}/repos/BoltzDesign1"
setenv  ALPHAFOLD3_ROOT                 "\${basedir}/repos/alphafold3"
EOF
