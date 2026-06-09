```sh
#!/bin/bash

module load apps/python/3.11.8

python3 -m venv /deac/opt/rocky9-noarch/orange3/3.40.0 --prompt orange3
. /deac/opt/rocky9-noarch/orange3/3.40.0/bin/activate
python3 -m pip install PyQt6 PyQt6-WebEngine orange3
```

```sh
cat << EOF > /deac/opt/modulefiles/rocky9-noarch/apps/orange3/3.40.0
#%Module
##
## python evironment using venv

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using venv."
}

module-whatis   "Sets up a python environment using venv"

module load compilers/gcc/12.3.0 apps/python/3.11.8

set basedir         "/deac/opt/rocky9-noarch/orange3/3.40.0"

################################################################################
################################################################################

prepend-path    PATH                \${basedir}/bin

setenv  VIRTUAL_ENV                 "\${basedir}"
setenv  VIRTUAL_ENV_PROMPT          "orange3"
setenv  PYTHONWARNINGS              "ignore"
EOF
```
