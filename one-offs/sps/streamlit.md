```sh
module load apps/python/3.14.5

python3 -m venv /deac/opt/rocky9-noarch/deac-envs/sps/mfta-lab
. /deac/opt/rocky9-noarch/deac-envs/sps/mfta-lab/bin/activate

python3 -m pip install streamlit numpy pandas scipy plotly google-genai

mkdir -p /deac/opt/modulefiles/rocky9-noarch/envs/sps

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/sps/mfta-lab
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load apps/python/3.14.5

set environment     "mfta-lab"
set basedir         "/deac/opt/rocky9-noarch/deac-envs/sps"

################################################################################
################################################################################

prepend-path    PATH                    "\${basedir}/\${environment}/bin"

setenv  VIRTUAL_ENV                     "\${basedir}/\${environment}"
setenv  VIRTUAL_ENV_PROMPT              "(\${environment})"
EOF
```
