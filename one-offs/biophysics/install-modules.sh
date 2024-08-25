#!/bin/bash

MODPATH=/deac/opt/modulefiles/rocky9-noarch/envs/biophysics
TARGET=/deac/opt/rocky9-noarch/deac-envs/biophysics

mkdir -p $MODPATH

cat << EOF > ${MODPATH}/deacfold
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

module load compilers/gcc/12.3.0

set environment     "env-deacfold"
set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/\${environment}/.pixi/envs/default/bin"
prepend-path    PATH                "\${basedir}/progs/openmm-8.1.2/bin"

prepend-path    LD_LIBRARY_PATH     "\${basedir}/progs/openmm-8.1.2/lib"
prepend-path    LIBRARY_PATH        "\${basedir}/progs/openmm-8.1.2/lib"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/\${environment}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "\${basedir}/\${environment}"
setenv  PIXI_PROJECT_NAME           "deacfold"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(deacfold) "
setenv  CONDA_DEFAULT_ENV           "deacfold"
setenv  CONDA_PREFIX                "\${basedir}/\${environment}/.pixi/envs/default"
setenv  HYDRA_FULL_ERROR            1

setenv ROSETTAFOLDAA_ROOT           "\${basedir}/repos/RoseTTAFold-All-Atom"
setenv LIGANDMPNN_ROOT              "\${basedir}/repos/LigandMPNN"
setenv RFDIFFUSION_ROOT             "\${basedir}/repos/RFdiffusion"
setenv ESM_ROOT                     "\${basedir}/repos/esm"
setenv OPENMM_ROOT                  "\${basedir}/progs/openmm-8.1.2"

source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libglib_activate.sh"
source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
EOF

cat << EOF > ${MODPATH}/masif
#%Module
##
## python evironment using pixi

proc ModulesHelp { } {
    puts stderr "\tSets up a python environment using Pixi."
}

module-whatis   "Sets up a python environment using Pixi"

module load compilers/gcc/12.3.0

set environment     "env-masif"
set basedir         "$TARGET"

################################################################################
################################################################################

prepend-path    PATH                "/deac/opt/rocky9-noarch/pixi/bin"
prepend-path    PATH                "\${basedir}/\${environment}/.pixi/envs/default/bin"
prepend-path    PATH                "\${basedir}/progs/reduce/reduce_src"

setenv  PIXI_EXE                    "/deac/opt/rocky9-noarch/pixi/bin/pixi"
setenv  PIXI_PROJECT_MANIFEST       "\${basedir}/\${environment}/pixi.toml"
setenv  PIXI_PROJECT_ROOT           "\${basedir}/\${environment}"
setenv  PIXI_PROJECT_NAME           "masif"
setenv  PIXI_IN_SHELL               "1"
setenv  PIXI_PROJECT_VERSION        "0.1.0"
setenv  PIXI_ENVIRONMENT_NAME       "default"
setenv  PIXI_ENVIRONMENT_PLATFORMS  "linux-64"
setenv  PIXI_PROMPT                 "(masif) "
setenv  CONDA_DEFAULT_ENV           "masif"
setenv  CONDA_PREFIX                "\${basedir}/\${environment}/.pixi/envs/default"

setenv  REDUCE_HET_DICT             \${basedir}/progs/reduce/reduce_wwPDB_het_dict.txt
setenv  MULTIVALUE_BIN              \${basedir}/progs/APBS-3.4.1.Linux/share/apbs/tools/bin/multivalue
setenv  APBS_BIN                    \${basedir}/progs/APBS-3.4.1.Linux/bin/apbs
setenv  PYMESH_PATH                 \${basedir}/progs/PyMesh
setenv  PDB2PQR_BIN                 \${basedir}/\${environment}/.pixi/envs/default/bin/pdb2pqr30
setenv  PDB2XYZRN                   \${basedir}/\${environment}/.pixi/envs/default/bin/pdb_to_xyzrn
setenv  MSMS_BIN                    \${basedir}/\${environment}/.pixi/envs/default/bin/msms

setenv MASIF_ROOT                   "\${basedir}/repos/masif"
setenv MASIFNEOSURF_ROOT            "\${basedir}/repos/masif-neosurf"
setenv MASIFSEED_ROOT               "\${basedir}/repos/masif_seed"

#source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/activate-binutils_linux-64.sh"
#source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/activate-gcc_linux-64.sh"
#source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/activate-gxx_linux-64.sh"
source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libglib_activate.sh"
source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/libxml2_activate.sh"
source-sh bash "\${basedir}/\${environment}/.pixi/envs/default/etc/conda/activate.d/~cuda-nvcc_activate.sh"
EOF
