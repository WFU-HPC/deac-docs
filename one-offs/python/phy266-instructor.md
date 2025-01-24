# PHY266 Documentation for Instructor

## Initial Python Environment

I will assume that the Python environment will be installed in,

```sh
/deac/phy/classes/phy266/python
```

You can then do the following steps to install everything to that location,

```sh
module load apps/python/3.11.8

python3 -m venv /deac/opt/rocky9-noarch/deac-envs/classes/env-phy266

. /deac/opt/rocky9-noarch/deac-envs/classes/env-phy266/bin/activate # if you use bash, or
# source /deac/opt/rocky9-noarch/deac-envs/classes/env-phy266/bin/activate.csh # if you use tcsh or csh
python3 -m pip install numpy matplotlib seaborn pandas scipy ipywidgets jupyter statsmodels keras scikit-learn google hdbscan jupyterlab
```

```sh
mkdir -p /deac/opt/modulefiles/rocky9-noarch/envs/classes
cat <<EOF > /deac/opt/modulefiles/rocky9-noarch/envs/classes/phy266
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

conflict envs

module load compilers/gcc/12.3.0 apps/python/3.11.8

set environment     "env-phy266"
set basedir         "/deac/opt/rocky9-noarch/deac-envs/classes"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/\${environment}/bin

setenv  VIRTUAL_ENV                     "\${basedir}/\${environment}"
setenv  VIRTUAL_ENV_PROMPT              "(\${environment})"
#setenv  PS1                             "(\${environment}) [\u@\h \W]\$"
EOF
```








We will use Visual Studio Code to handle the Jupyter notebooks directly, so refer to the student documentation about setting that up.


## Installing new Python modules

If you want to add more Python modules to the environment, just follow the last two steps from above,

```sh
source /deac/phy/classes/phy266/python/bin/activate # if you use bash, or
# source /deac/phy/classes/phy266/python/bin/activate.csh # if you use tcsh or csh
python3 -m pip install new_package1 new_package2
```
