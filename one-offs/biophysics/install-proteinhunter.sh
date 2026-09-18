#!/bin/bash

module load apps/python/3.11.8

python3 -m venv /deac/opt/rocky9-noarch/deac-envs/biophysics/env-protein_hunter
. /deac/opt/rocky9-noarch/deac-envs/biophysics/env-protein_hunter/bin/activate

git clone https://github.com/yehlincho/Protein-Hunter.git /deac/chm/albaneseGrp/06_software/Protein-Hunter

cd /deac/chm/albaneseGrp/06_software/Protein-Hunter

################################################################################
# boltz_ph

cd /deac/chm/albaneseGrp/06_software/Protein-Hunter/boltz_ph/
python3 -m pip install -e .
python3 -m pip install ipykernel jupyter jupyterlab matplotlib seaborn prody tqdm PyYAML requests pypdb py3Dmol py2Dmol logmd==0.1.45 ml_collections pyrosettacolabsetup pyrosetta-installer
python3 -c 'import pyrosetta_installer; pyrosetta_installer.install_pyrosetta()'

python3 -m pip install --upgrade "numpy>=1.24,<1.27" numba
python3 << 'PYCODE'
import sys
import os
# Ensure boltz is importable
sys.path.insert(0, os.path.join(os.getcwd(), 'boltz_ph'))
try:
    from boltz.main import download_boltz2
    from pathlib import Path
    cache = Path('/deac/chm/albaneseGrp/06_software/Protein-Hunter/boltz_weights').expanduser()
    cache.mkdir(parents=True, exist_ok=True)
    download_boltz2(cache)
    print("✅ Boltz weights downloaded successfully!")
except Exception as e:
    print(f"❌ Error downloading Boltz weights: {e}")
    sys.exit(1)
PYCODE

################################################################################
# LigandMPNN

cd /deac/chm/albaneseGrp/06_software/Protein-Hunter/LigandMPNN/
bash get_model_params.sh ./model_params
chmod +x /deac/chm/albaneseGrp/06_software/Protein-Hunter/utils/DAlphaBall.gcc

################################################################################
# chai-lab

python3 -m pip install --no-deps git+https://github.com/sokrypton/chai-lab.git 'gemmi~=0.6.3' 'jaxtyping>=0.2.25' 'pandera>=0.24' 'antipickle==0.2.0' 'rdkit~=2024.9.5' 'modelcif>=1.0' 'biopython>=1.83' typing_inspect beartype typeguard ihm mypy_extensions equinox wadler_lindig py3Dmol

################################################################################
# kernel nonsense

#python -m ipykernel install --user --name=proteinhunter --display-name="Protein Hunter"

################################################################################
# module

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biophysics/protein-hunter
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-protein_hunter"
set basedir         "/deac/opt/rocky9-noarch/deac-envs/biophysics"

################################################################################
################################################################################

prepend-path    PATH                    "\${basedir}/\${environment}/bin"

setenv  VIRTUAL_ENV                     "\${basedir}/\${environment}"
setenv  VIRTUAL_ENV_PROMPT              "(\${environment})"

setenv  ALPHAFOLD3_ROOT                 "\${basedir}/repos/alphafold3"
EOF
