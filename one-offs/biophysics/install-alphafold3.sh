#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-alphafold3
export REPOS=${SOFTWARE}/repos
export PROGS=${SOFTWARE}/progs


mkdir -p $SOFTWARE
mkdir -p $ENVIRONMENT
mkdir -p $REPOS
mkdir -p $PROGS


module load compilers/gcc/12.3.0 apps/python/3.11.8

################################################################################
## initial python env
################################################################################

python3 -m venv ${ENVIRONMENT}
. ${ENVIRONMENT}/bin/activate

################################################################################
## hmmer
################################################################################

mkdir -p /tmp/hmmer_build ${PROGS}/hmmer
wget http://eddylab.org/software/hmmer/hmmer-3.4.tar.gz --directory-prefix /tmp/hmmer_build
tar -zxf /tmp/hmmer_build/hmmer-3.4.tar.gz -C /tmp/hmmer_build

cd /tmp/hmmer_build/hmmer-3.4
./configure --prefix ${PROGS}/hmmer
make -j8
make install

cd /tmp/hmmer_build/hmmer-3.4/easel
make install

cd $HOME
rm -rf /tmp/hmmer_build

################################################################################
## alphafold3
################################################################################

git clone git@github.com:google-deepmind/alphafold3.git ${REPOS}/alphafold3
cd ${REPOS}/alphafold3

pip3 install -r dev-requirements.txt
pip3 install --no-deps .

# Build chemical components database (this binary was installed by pip).
build_data
