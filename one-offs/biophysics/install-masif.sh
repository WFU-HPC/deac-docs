#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-masif
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs

mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS

module load compilers/gcc/12.3.0

################################################################################
# pixi environment
################################################################################

cat << EOF > ${ENVIRONMENT}/pixi.toml
[project]
authors = ["Sean Anderson <anderss@wfu.edu>"]
channels = ["nvidia", "conda-forge", "bioconda", "open3d-admin"]
description = "Pixi/conda environment for a recent masif stack using TF1"
name = "masif"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "3.7.*"
tensorflow = "1.14.*"
cuda-toolkit = { version = "12.1.*", channel = "nvidia" }
# cuda-toolkit = { channel = "nvidia" }
mkl-include = "*"
mpfr = "*"
libxcrypt = "*"
nose = "*"
pdb2pqr = "*"
biopython = "*"
ipython = "*"
rdkit = { channel = "conda-forge" }
openbabel = "*"
prody = "*"
scikit-learn = "*"
networkx = "*"
msms = { channel = "bioconda" }
open3d = { channel = "open3d-admin" }

[pypi-dependencies]
silence_tensorflow = "*"
EOF

cd $ENVIRONMENT
pixi install
# pixi init --import ${HOME}/albanese/conda-deacfold.yml ${ENVIRONMENT}

# pixi shell --manifest-path ${ENVIRONMENT}/pixi.toml
eval "$(pixi shell-hook --manifest-path ${ENVIRONMENT}/pixi.toml)"

################################################################################
# dependencies
################################################################################

# reduce
git clone https://github.com/rlabduke/reduce ${PROGS}/reduce
cd ${PROGS}/reduce
make

# abps
wget --no-check-certificate https://github.com/Electrostatics/apbs/releases/download/v3.4.1/APBS-3.4.1.Linux.zip -O /tmp/APBS-3.4.1.Linux.zip
unzip -q /tmp/APBS-3.4.1.Linux.zip -d ${PROGS}
rm /tmp/APBS-3.4.1.Linux.zip

# pymesh
export PYMESH_PATH=${PROGS}/PyMesh
git clone https://github.com/PyMesh/PyMesh.git ${PYMESH_PATH}

cd $PYMESH_PATH
git submodule update --init
sed -i -e '/#include <functional>/a #include <cstddef>' ${PYMESH_PATH}/third_party/draco/src/draco/core/hash_utils.h
sed -i -e '/#include <iterator>/a #include <limits>' ${PYMESH_PATH}/third_party/draco/src/draco/io/parser_utils.cc
sed -i -e 's|SET(CMAKE_C_FLAGS " -Wno-char-subscripts|SET(CMAKE_C_FLAGS " -fcommon -Wno-char-subscripts|g' ${PYMESH_PATH}/third_party/mmg/CMakeLists.txt # https://github.com/PyMesh/PyMesh/issues/255
cd ${PYMESH_PATH}/third_party
python3 ./build.py all

mkdir -p ${PYMESH_PATH}/build && cd ${PYMESH_PATH}/build
cmake -DTBB_INCLUDE_DIR="${PYMESH_PATH}/python/pymesh/third_party/include" -Dnlohmann_json_DIR="${PYMESH_PATH}/third_party/build/json" ..
make && make tests; make tests

cd ${PYMESH_PATH}
python3 ./setup.py install && python3 -c "import pymesh; pymesh.test()"

################################################################################
# masif masif-neosurf
################################################################################

git clone https://github.com/lpdi-epfl/masif         ${REPOS}/masif
git clone git@github.com:LPDI-EPFL/masif-neosurf.git ${REPOS}/masif-neosurf
git clone git@github.com:LPDI-EPFL/masif_seed.git    ${REPOS}/masif_seed

chmod +x ${REPOS}/masif-neosurf/preprocess_pdb.sh

sed -i -e 's|o3d.registration|o3d.pipelines.registration|g' ${REPOS}/masif/source/geometry/open3d_import.py
sed -i -e 's|ln -sf $MASIF_REPOSS_DIR/nn_models|ln -sf $MASIF_DATA/masif_site/nn_models|g' ${REPOS}/masif-neosurf/preprocess_pdb.sh
grep -rl ".todense()"   ${REPOS}/masif-neosurf | xargs sed -i 's/.todense()/.toarray()/g'
