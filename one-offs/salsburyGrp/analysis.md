```sh
#!/bin/bash
export TARGET=/deac/opt/rocky9-noarch/deac-envs/salsburyGrp/analysis

mkdir -p $TARGET
sudo cp /deac/phy/salsburyGrp/software/miniconda3/envs/analysis.yml $TARGET

cd $TARGET
pixi init --import analysis.yml
pixi config set --local run-post-link-scripts insecure
pixi install
pixi add pip

################################################################################
################################################################################

chmod -R g+rw /deac/opt/rocky9-noarch/deac-envs/salsburyGrp
sudo chown -R anderss:salsburyGrp /deac/opt/rocky9-noarch/deac-envs/salsburyGrp

################################################################################
################################################################################

cat << EOF > /deac/opt/modulefiles/rocky9-noarch/envs/biophysics/.salsburygrp_analysis
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

set environment     "analysis"
set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/.pixi/envs/default/bin"

setenv  CONDA_SHLVL                 1
setenv  CONDA_PREFIX                \${basedir}/.pixi/envs/default
setenv  CONDA_DEFAULT_ENV           analysis
setenv  PIXI_IN_SHELL               1
setenv  PIXI_PROJECT_NAME           analysis
setenv  PIXI_EXE                    /deac/opt/rocky9-noarch/pixi/bin/pixi
setenv  PIXI_PROJECT_ROOT           "\${basedir}"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/pixi.toml"
setenv  PIXI_PROJECT_VERSION        0.1.0
setenv  PIXI_ENVIRONMENT_NAME       default
setenv  PIXI_ENVIRONMENT_PLATFORMS  linux-64
#setenv  PIXI_PROMPT                 '(analysis) '

source-sh bash "\${basedir}/.pixi/envs/default/etc/conda/activate.d/libglib_activate.sh"
source-sh bash "\${basedir}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
EOF

################################################################################
################################################################################

#pixi shell-hook --manifest-path $TARGET

# create a new kernel to be shared
#python3 -m ipykernel install --user --name analysis2 --display-name "Python (analysis2)"
```
