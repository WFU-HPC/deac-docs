#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-deacfold
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
channels = ["nvidia", "pytorch", "predector", "conda-forge", "bioconda", "biocore", "dglteam/label/th23_cu121"]
description = "Pixi/conda environment for a recent ml+folding stack"
name = "deacfold"
platforms = ["linux-64"]
version = "0.1.0"

[tasks]

[dependencies]
python = "3.10.*"
pip = "*"
pytorch = { version = "2.3.0", channel = "pytorch" }
torchdata = { channel = "pytorch" }
torchvision = { channel = "pytorch" }
torchaudio = { channel = "pytorch" }
torchtext = { channel = "pytorch" }
torchtriton = { channel = "pytorch" }
pytorch-cuda = { version = "12.1.*", channel = "pytorch" }
cuda-toolkit = { version = "12.1.*", channel = "nvidia" }
cudnn = "*"
mkl-include = "2023.2.*"
signalp6 = { channel = "predector" }
pydantic = "*"
pyparsing = "3.1.1.*"
setuptools = "65.*"
numpy = "*"
dask = "*"
hydra-core = "*"
icecream = "*"
scipy = "*"
assertpy = "*"
openbabel = "*"
opt_einsum = "*"
e3nn = "*"
e3nn-jax = "*"
deepdiff = "*"
hhsuite = { channel = "bioconda" }
psipred = { channel = "biocore" }
csblast = { channel = "bioconda" }
huggingface_hub = "*"
dgl = { channel = "dglteam/label/th23_cu121" }
prody = "*"
ml-collections = "*"
dm-tree = "*"
einops = "*"
cloudpathlib = "*"
tokenizers = "*"
transformers = "*"
biotite = "*"
msgpack-numpy = "*"
scikit-learn = "*"
jedi = "*"
pyrsistent = "*"
cython = "*"
ipython = "*"

[pypi-dependencies]
# esm = "*"
EOF

cd $ENVIRONMENT
pixi install
# pixi init --import ${HOME}/albanese/conda-deacfold.yml ${ENVIRONMENT}

mkdir -p ${ENVIRONMENT}/.pixi/envs/default/lib/crypto_bak
mv ${ENVIRONMENT}/.pixi/envs/default/lib/libcrypto.so.* ${ENVIRONMENT}/.pixi/envs/default/lib/crypto_bak/.

# pixi shell --manifest-path ${ENVIRONMENT}/pixi.toml
eval "$(pixi shell-hook --manifest-path ${ENVIRONMENT}/pixi.toml)"

pip3 install esm

################################################################################
# rosettafold-all-atom
################################################################################

git clone https://github.com/baker-laboratory/RoseTTAFold-All-Atom ${REPOS}/RoseTTAFold-All-Atom
wget http://files.ipd.uw.edu/pub/RF-All-Atom/weights/RFAA_paper_weights.pt \
     -O ${REPOS}/RoseTTAFold-All-Atom/RFAA_paper_weights.pt

signalp6-register /deac/opt/tarballs/signalp/6.0h.fast/signalp-6.0h.fast.tar.gz
mv -i "${CONDA_PREFIX}/lib/python3.10/site-packages/signalp/model_weights/distilled_model_signalp6.pt" \
      "${CONDA_PREFIX}/lib/python3.10/site-packages/signalp/model_weights/ensemble_model_signalp6.pt"

chmod +x ${REPOS}/RoseTTAFold-All-Atom/input_prep/make_ss.sh
sed -i -e 's|  hhdb:.*|  hhdb: "/deac/data/alphafold_data/pdb100/pdb100_2021Mar03"|g'                                     ${REPOS}/RoseTTAFold-All-Atom/rf2aa/config/inference/base.yaml
sed -i -e 's|DB_UR30=.*|DB_UR30="/deac/data/alphafold_data/uniref30/UniRef30_2020_06"|g'                                  ${REPOS}/RoseTTAFold-All-Atom/make_msa.sh
sed -i -e 's|DB_BFD=.*|DB_BFD="/deac/data/alphafold_data/bfd/bfd_metaclust_clu_complete_id30_c90_final_seq.sorted_opt"|g' ${REPOS}/RoseTTAFold-All-Atom/make_msa.sh
sed -i -e 's|$PIPE_DIR/csblast-2.2.3|${CONDA_PREFIX}|g'                                                                   ${REPOS}/RoseTTAFold-All-Atom/input_prep/make_ss.sh
sed -i -e 's|$PIPE_DIR/blast-2.2.26|${CONDA_PREFIX}|g'                                                                    ${REPOS}/RoseTTAFold-All-Atom/input_prep/make_ss.sh
# sed -i -e 's|checkpoint_path:.*|checkpoint_path: /deac/data/models/RFAA/RFAA_paper_weights.pt|g'                          ${REPOS}/RoseTTAFold-All-Atom/rf2aa/config/inference/base.yaml

################################################################################
# ligandmpnn
################################################################################

git clone https://github.com/dauparas/LigandMPNN.git ${REPOS}/LigandMPNN
bash ${REPOS}/LigandMPNN/get_model_params.sh "${REPOS}/LigandMPNN/model_params"

sed -i -e 's|np.int)|int)|g' ${REPOS}/LigandMPNN/openfold/np/residue_constants.py

################################################################################
# esm
################################################################################

git clone git@github.com:evolutionaryscale/esm.git ${REPOS}/esm

################################################################################
# rfdiffusion
################################################################################

git clone https://github.com/RosettaCommons/RFdiffusion.git ${REPOS}/RFdiffusion
tar -xvf ${REPOS}/RFdiffusion/examples/ppi_scaffolds_subset.tar.gz -C ${REPOS}/RFdiffusion/examples/
# sed -i -e 's|  - pytorch=.*|  - pytorch=1.9.1=cuda111py39hb4a4491_3|g' ${REPOS}/RFdiffusion/env/SE3nv.yml

mkdir -p ${REPOS}/RFdiffusion/models
wget http://files.ipd.uw.edu/pub/RFdiffusion/6f5902ac237024bdd0c176cb93063dc4/Base_ckpt.pt                       -O ${REPOS}/RFdiffusion/models/Base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/e29311f6f1bf1af907f9ef9f44b8328b/Complex_base_ckpt.pt               -O ${REPOS}/RFdiffusion/models/Complex_base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/60f09a193fb5e5ccdc4980417708dbab/Complex_Fold_base_ckpt.pt          -O ${REPOS}/RFdiffusion/models/Complex_Fold_base_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/74f51cfb8b440f50d70878e05361d8f0/InpaintSeq_ckpt.pt                 -O ${REPOS}/RFdiffusion/models/InpaintSeq_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/76d00716416567174cdb7ca96e208296/InpaintSeq_Fold_ckpt.pt            -O ${REPOS}/RFdiffusion/models/InpaintSeq_Fold_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/5532d2e1f3a4738decd58b19d633b3c3/ActiveSite_ckpt.pt                 -O ${REPOS}/RFdiffusion/models/ActiveSite_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/12fc204edeae5b57713c5ad7dcb97d39/Base_epoch8_ckpt.pt                -O ${REPOS}/RFdiffusion/models/Base_epoch8_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/f572d396fae9206628714fb2ce00f72e/Complex_beta_ckpt.pt               -O ${REPOS}/RFdiffusion/models/Complex_beta_ckpt.pt
wget http://files.ipd.uw.edu/pub/RFdiffusion/1befcb9b28e2f778f53d47f18b7597fa/RF_structure_prediction_weights.pt -O ${REPOS}/RFdiffusion/models/RF_structure_prediction_weights.pt

cd ${REPOS}/RFdiffusion/env/SE3Transformer
python3 setup.py install

cd ${REPOS}/RFdiffusion
python3 -m pip install -e .

################################################################################
# openmm
################################################################################

wget https://github.com/openmm/openmm/archive/refs/tags/8.1.2.tar.gz -O /tmp/openmm-8.1.2.tar.gz
tar -xf /tmp/openmm-8.1.2.tar.gz -C /tmp
mkdir -p /tmp/openmm-8.1.2/build && cd /tmp/openmm-8.1.2/build

cmake -DCMAKE_INSTALL_PREFIX=${PROGS}/openmm-8.1.2 .. #-DOPENMM_BUILD_CUDA_LIB

make -j4
make test
make install
make PythonInstall
python3 -m openmm.testInstallation
# make && make install && make PythonInstall

rm -rf /tmp/openmm-8.1.2.tar.gz
rm -rf /tmp/openmm-8.1.2
