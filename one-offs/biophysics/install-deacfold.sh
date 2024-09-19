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
jupyter = ">=1.1.1,<2"
jupyterlab = ">=4.2.5,<5"
matplotlib = ">=3.9.1,<4"
fire = "*"

[pypi-dependencies]
# esm = "*"
EOF

cat << EOF > ${ENVIRONMENT}/pixi.lock
version: 5
environments:
  default:
    channels:
    - url: https://conda.anaconda.org/nvidia/
    - url: https://conda.anaconda.org/pytorch/
    - url: https://conda.anaconda.org/predector/
    - url: https://conda.anaconda.org/conda-forge/
    - url: https://conda.anaconda.org/bioconda/
    - url: https://conda.anaconda.org/biocore/
    - url: https://conda.anaconda.org/dglteam/label/th23_cu121/
    packages:
      linux-64:
      - conda: https://conda.anaconda.org/conda-forge/linux-64/_libgcc_mutex-0.1-conda_forge.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/_openmp_mutex-4.5-2_kmp_llvm.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/absl-py-2.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/alsa-lib-1.2.8-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/antlr-python-runtime-4.9.3-pyhd8ed1ab_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/anyio-4.4.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/argon2-cffi-23.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/argon2-cffi-bindings-21.2.0-py310ha75aee5_5.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/arrow-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/assertpy-1.1-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/asttokens-2.4.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/async-lru-2.0.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/attr-2.5.1-h166bdaf_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/attrs-24.2.0-pyh71513ae_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/babel-2.14.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/beautifulsoup4-4.12.3-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/biopython-1.84-py310hc51659f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/biotite-0.41.0-py310h76e45a6_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/blas-1.0-mkl.tar.bz2
      - conda: https://conda.anaconda.org/bioconda/linux-64/blast-legacy-2.2.26-h9ee0642_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/bleach-6.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/bokeh-2.4.3-pyhd8ed1ab_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/brotli-1.1.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/brotli-bin-1.1.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/brotli-python-1.1.0-py310hc6cd4ac_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/bzip2-1.0.8-h4bc722e_7.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ca-certificates-2024.7.4-hbcca054_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cached-property-1.5.2-hd8ed1ab_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/cached_property-1.5.2-pyha770c72_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cairo-1.16.0-ha61ee94_1014.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/certifi-2024.7.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cffi-1.17.0-py310h2fdcea3_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/charset-normalizer-3.3.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/click-8.1.7-unix_pyh707e725_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cloudpathlib-0.18.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cloudpickle-3.0.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/colorama-0.4.6-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/comm-0.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/contextlib2-21.6.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/contourpy-1.2.1-py310hd41b1e2_0.conda
      - conda: https://conda.anaconda.org/bioconda/linux-64/csblast-2.2.3-h4ac6f70_3.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cccl-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-command-line-tools-12.1.1-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-compiler-12.6.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cudart-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cudart-dev-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cudart-static-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cuobjdump-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cupti-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cupti-static-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-cuxxfilt-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-documentation-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-driver-dev-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-gdb-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-libraries-12.1.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-libraries-dev-12.6.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-libraries-static-12.1.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nsight-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvcc-12.4.131-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvdisasm-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvml-dev-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvprof-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvprune-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvrtc-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvrtc-dev-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvrtc-static-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvtx-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvvp-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-opencl-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-opencl-dev-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-profiler-api-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-runtime-12.1.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-sanitizer-api-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-toolkit-12.1.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-tools-12.1.1-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-visual-tools-12.6.0-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cudatoolkit-11.1.74-h6bb024c_0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/cudnn-8.0.4-cuda11.1_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/cycler-0.12.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cython-3.0.11-py310hea249c9_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cytoolz-0.12.3-py310h2372a71_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/dask-2023.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/dask-core-2023.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/dataclasses-0.8-pyhc8e2a94_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/dbus-1.13.6-h5008d03_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/debugpy-1.8.5-py310hf71b8c6_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/decorator-5.1.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/deepdiff-7.0.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/defusedxml-0.7.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/dglteam/label/th23_cu121/linux-64/dgl-2.3.0.th23.cu121-py310_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/distributed-2023.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/dm-tree-0.1.8-py310ha8c1f0e_4.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/e3nn-0.5.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/e3nn-jax-0.20.7-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/einops-0.8.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/entrypoints-0.4-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/exceptiongroup-1.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/executing-2.0.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/expat-2.6.2-h59595ed_0.conda
      - conda: https://conda.anaconda.org/pytorch/linux-64/ffmpeg-4.3-hf484d3e_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/fftw-3.3.10-nompi_hf1063bd_110.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/filelock-3.15.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fire-0.6.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-dejavu-sans-mono-2.37-hab24e00_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-inconsolata-3.000-h77eed37_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-source-code-pro-2.038-h77eed37_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-ubuntu-0.83-h77eed37_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/fontconfig-2.14.2-h14ed4e7_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fonts-conda-ecosystem-1-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/fonts-conda-forge-1-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/fonttools-4.53.1-py310h5b4e0ec_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fqdn-1.5.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/freetype-2.12.1-h267a509_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fsspec-2024.6.1-pyhff2d567_0.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/gds-tools-1.9.1.3-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gettext-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gettext-tools-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/glib-2.80.2-hf974151_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/glib-tools-2.80.2-hb6ce0ca_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gmp-6.3.0-hac33072_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gmpy2-2.1.5-py310hc7909c9_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gnutls-3.6.13-h85f3911_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/graphite2-1.3.13-h59595ed_1003.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gst-plugins-base-1.22.0-h4243ec0_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gstreamer-1.22.0-h25f0c4b_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gstreamer-orc-0.4.39-h4bc722e_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gzip-1.13-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/h11-0.14.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/h2-4.1.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/harfbuzz-6.0.0-h8e241bc_0.conda
      - conda: https://conda.anaconda.org/bioconda/linux-64/hhsuite-3.3.0-py310pl5321hc31ed2c_12.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/hpack-4.0.0-pyh9f0ad1d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/httpcore-1.0.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/httpx-0.27.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/huggingface_hub-0.17.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/hydra-core-1.3.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/hyperframe-6.0.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/icecream-2.1.3-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/icu-70.1-h27087fc_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/idna-3.8-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/importlib-metadata-8.4.0-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/importlib_metadata-8.4.0-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/importlib_resources-6.4.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ipykernel-6.29.5-pyh3099207_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ipython-8.26.0-pyh707e725_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ipywidgets-8.1.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/isoduration-20.11.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jack-1.9.22-h11f4161_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jax-0.3.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jaxlib-0.1.75-py310hb5077e9_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/jedi-0.19.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jinja2-3.1.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/joblib-1.4.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jpeg-9e-h166bdaf_2.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/json5-0.9.25-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jsonpointer-3.0.0-py310hff52083_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jsonschema-4.23.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jsonschema-specifications-2023.12.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jsonschema-with-format-nongpl-4.23.0-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter-1.1.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter-lsp-2.2.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_client-8.6.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_console-6.6.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jupyter_core-5.7.2-py310hff52083_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_events-0.10.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_server-2.14.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_server_terminals-0.5.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab-4.2.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_pygments-0.3.0-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_server-2.27.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_widgets-3.0.13-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/keyutils-1.6.1-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/kiwisolver-1.4.5-py310hd41b1e2_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/krb5-1.20.1-h81ceb04_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lame-3.100-h166bdaf_1003.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lcms2-2.15-hfd0df8a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ld_impl_linux-64-2.40-hf3520f5_7.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lerc-4.0.0-h27087fc_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libabseil-20240116.2-cxx17_he02047a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libasprintf-0.22.5-he8f35ee_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libasprintf-devel-0.22.5-he8f35ee_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libblas-3.9.0-1_h86c2bf4_netlib.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libbrotlicommon-1.1.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libbrotlidec-1.1.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libbrotlienc-1.1.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcap-2.67-he9d0100_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcblas-3.9.0-6_ha36c22a_netlib.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libclang-15.0.7-default_h127d8a8_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libclang13-15.0.7-default_h5d6823c_5.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcublas-12.1.0.26-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcublas-dev-12.1.0.26-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcublas-static-12.1.0.26-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcufft-11.0.2.4-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcufft-dev-11.0.2.4-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcufft-static-11.0.2.4-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcufile-1.9.1.3-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcufile-dev-1.9.1.3-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcufile-static-1.9.1.3-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcups-2.3.3-h36d4200_3.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcurand-10.3.5.147-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcurand-dev-10.3.5.147-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcurand-static-10.3.5.147-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcusolver-11.4.4.55-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcusolver-dev-11.4.4.55-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcusolver-static-11.4.4.55-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcusparse-12.0.2.55-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcusparse-dev-12.0.2.55-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libcusparse-static-12.0.2.55-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libdb-6.2.32-h9c3ff4c_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libdeflate-1.17-h0b41bf4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libedit-3.1.20191231-he28a2e2_2.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libevent-2.1.10-h28343ad_4.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libexpat-2.6.2-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libffi-3.4.2-h7f98852_5.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libflac-1.4.3-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgcc-14.1.0-h77fa898_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgcc-ng-14.1.0-h69a702a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgcrypt-1.11.0-h4ab18f5_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgettextpo-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgettextpo-devel-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgfortran-ng-14.1.0-h69a702a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgfortran5-14.1.0-hc5f4f2c_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libglib-2.80.2-hf974151_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgpg-error-1.50-h4f305b6_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libhwloc-2.9.1-hd6dc26d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libiconv-1.17-hd590300_2.conda
      - conda: https://conda.anaconda.org/pytorch/linux-64/libjpeg-turbo-2.0.0-h9bf148f_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/liblapack-3.9.0-6_ha36c22a_netlib.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libllvm15-15.0.7-hadd5161_1.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnpp-12.0.2.50-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnpp-dev-12.0.2.50-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnpp-static-12.0.2.50-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libnsl-2.0.1-hd590300_0.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvfatbin-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvfatbin-dev-12.4.127-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvjitlink-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvjitlink-dev-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvjpeg-12.1.1.14-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvjpeg-dev-12.1.1.14-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvjpeg-static-12.1.1.14-0.tar.bz2
      - conda: https://conda.anaconda.org/nvidia/linux-64/libnvvm-samples-12.1.105-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libogg-1.3.5-h4ab18f5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libopus-1.3.1-h7f98852_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libpng-1.6.43-h2797004_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libpq-15.3-hbcd7760_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsndfile-1.2.2-hc60ed4a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsodium-1.0.18-h36c2ea0_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsqlite-3.46.0-hde9e2c9_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-14.1.0-hc0a3c3a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-ng-14.1.0-h4852527_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsystemd0-253-h8c4010b_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libtiff-4.5.0-h6adf6a1_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libtool-2.4.7-h27087fc_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libudev1-253-h0b41bf4_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libuuid-2.38.1-h0b41bf4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libvorbis-1.3.7-h9c3ff4c_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libwebp-base-1.4.0-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxcb-1.13-h7f98852_1004.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxcrypt-4.4.36-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxkbcommon-1.5.0-h79f4944_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxml2-2.10.3-hca2bb57_4.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libzlib-1.2.13-h4ab18f5_6.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/llvm-openmp-15.0.7-h0cdce71_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/locket-1.0.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lz4-4.3.3-py310h350c4a5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lz4-c-1.9.4-hcb278e6_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/markupsafe-2.1.5-py310h2372a71_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-3.9.1-py310hff52083_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-base-3.9.1-py310hf02ac8c_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/matplotlib-inline-0.1.7-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/mistune-3.0.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mkl-2023.0.0-h84fe81f_26648.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mkl-include-2023.2.0-h84fe81f_50496.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ml-collections-0.1.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mpc-1.3.1-hfe3b2da_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mpfr-4.2.1-h38ae2d0_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mpg123-1.32.6-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/mpmath-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/msgpack-numpy-0.4.8-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/msgpack-python-1.0.8-py310h25c7140_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/munkres-1.1.4-pyh9f0ad1d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mysql-common-8.0.33-hf1915f5_6.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mysql-libs-8.0.33-hca2cd23_6.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nbclient-0.10.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nbconvert-core-7.16.4-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nbformat-5.10.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ncurses-6.5-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nest-asyncio-1.6.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/nettle-3.6-he412f7d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/networkx-3.3-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/notebook-7.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/notebook-shim-0.2.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/nsight-compute-2024.1.1.4-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/nspr-4.35-h27087fc_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/nss-3.100-hca3bf56_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/numpy-1.26.4-py310hb13e2d6_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/omegaconf-2.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openbabel-3.1.1-py310heaf86c6_5.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openh264-2.1.1-h780b84a_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openjpeg-2.5.0-hfec8fc6_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openssl-3.1.6-h4ab18f5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/opt-einsum-3.3.0-hd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/opt_einsum-3.3.0-pyhc1e730c_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/opt_einsum_fx-0.1.4-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/ordered-set-4.1.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/orjson-3.10.7-py310h42e942d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/overrides-7.7.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/packaging-24.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pandas-2.2.2-py310hf9f9076_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pandocfilters-1.5.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/parso-0.8.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/partd-1.4.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pcre2-10.43-hcad00b1_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/perl-5.32.1-7_hd590300_perl5.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pexpect-4.9.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pickleshare-0.7.5-py_1003.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pillow-9.4.0-py310h023d228_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pip-24.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pixman-0.43.2-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pkgutil-resolve-name-1.3.10-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/platformdirs-4.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ply-3.11-pyhd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/prody-2.4.0-py310heca2aa9_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/prometheus_client-0.20.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/prompt-toolkit-3.0.47-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/prompt_toolkit-3.0.47-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/biocore/linux-64/psipred-4.01-1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/psutil-6.0.0-py310hc51659f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pthread-stubs-0.4-h36c2ea0_1001.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/ptyprocess-0.7.0-pyhd3deb0d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-16.1-hcb278e6_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-client-16.1-h5195f5e_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-daemon-16.1-ha8d29e2_3.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pure_eval-0.2.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pycparser-2.22-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pydantic-1.10.17-py310h5b4e0ec_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pygments-2.18.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pyparsing-3.1.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyqt-5.15.9-py310h04931ad_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyqt5-sip-12.12.2-py310hc6cd4ac_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyrsistent-0.20.0-py310h2372a71_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pysocks-1.7.1-pyha2e5f31_6.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/python-3.10.13-hd12c33a_0_cpython.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-dateutil-2.9.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-fastjsonschema-2.20.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-flatbuffers-24.3.25-pyh59ac667_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-json-logger-2.0.7-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-tzdata-2024.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/python_abi-3.10-5_cp310.conda
      - conda: https://conda.anaconda.org/pytorch/linux-64/pytorch-2.3.0-py3.10_cuda12.1_cudnn8.9.2_0.tar.bz2
      - conda: https://conda.anaconda.org/pytorch/linux-64/pytorch-cuda-12.1-ha16c6d3_5.tar.bz2
      - conda: https://conda.anaconda.org/pytorch/noarch/pytorch-mutex-1.0-cuda.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/pytz-2024.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyyaml-6.0.2-py310h5b4e0ec_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyzmq-26.2.0-py310h71f11fc_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/qhull-2020.2-h434a139_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/qt-main-5.15.8-h5d23da1_6.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/readline-8.2-h8228510_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/referencing-0.35.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/regex-2024.7.24-py310h5b4e0ec_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/requests-2.32.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/rfc3339-validator-0.1.4-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/rfc3986-validator-0.1.1-pyh9f0ad1d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/rpds-py-0.20.0-py310h505e2c1_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/sacremoses-0.0.53-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/scikit-learn-1.5.1-py310h146d792_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/scipy-1.14.1-py310ha3fb0e1_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/send2trash-1.8.3-pyh0d859eb_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/setuptools-65.6.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/predector/noarch/signalp6-6.0g-1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/sip-6.7.12-py310hc6cd4ac_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/six-1.16.0-pyh6c4a22f_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/sniffio-1.3.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/sortedcontainers-2.4.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/soupsieve-2.5-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/stack_data-0.6.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/sympy-1.13.2-pypyh2585a3b_103.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tbb-2021.9.0-hf52228f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/tblib-3.0.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/termcolor-2.4.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/terminado-0.18.1-pyh0d859eb_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/threadpoolctl-3.5.0-pyhc1e730c_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/tinycss2-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tk-8.6.13-noxft_h4845f30_101.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tokenizers-0.15.0-py310h320607d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/toml-0.10.2-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/tomli-2.0.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/toolz-0.12.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/pytorch/linux-64/torchaudio-2.3.0-py310_cu121.tar.bz2
      - conda: https://conda.anaconda.org/pytorch/linux-64/torchdata-0.8.0-py310.tar.bz2
      - conda: https://conda.anaconda.org/pytorch/linux-64/torchtext-0.18.0-py310.tar.bz2
      - conda: https://conda.anaconda.org/pytorch/linux-64/torchtriton-2.3.0-py310.tar.bz2
      - conda: https://conda.anaconda.org/pytorch/linux-64/torchvision-0.18.0-py310_cu121.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tornado-6.4.1-py310hc51659f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/tqdm-4.66.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/traitlets-5.14.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/transformers-4.17.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/types-python-dateutil-2.9.0.20240821-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/typing-extensions-4.12.2-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/typing_extensions-4.12.2-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/typing_utils-0.1.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/tzdata-2024a-h0c530f3_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/unicodedata2-15.1.0-py310h2372a71_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/unzip-6.0-h7f98852_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/uri-template-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/urllib3-2.2.2-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/wcwidth-0.2.13-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/webcolors-24.8.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/webencodings-0.5.1-pyhd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/websocket-client-1.8.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/wheel-0.44.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/widgetsnbextension-4.0.13-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-0.4.0-h516909a_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-image-0.4.0-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-keysyms-0.4.0-h516909a_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-renderutil-0.3.9-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-wm-0.4.1-h516909a_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xkeyboard-config-2.38-h0b41bf4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-kbproto-1.0.7-h7f98852_1002.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libice-1.1.1-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libsm-1.2.4-h7391055_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libx11-1.8.4-h0b41bf4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxau-1.0.11-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxdmcp-1.1.3-h7f98852_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxext-1.3.4-h0b41bf4_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxrender-0.9.10-h7f98852_1003.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-renderproto-0.11.1-h7f98852_1002.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-xextproto-7.3.0-h0b41bf4_1003.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-xproto-7.0.31-h7f98852_1007.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xz-5.2.6-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/yaml-0.2.5-h7f98852_2.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zeromq-4.3.5-h59595ed_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/zict-3.0.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zip-3.0-hd590300_3.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/zipp-3.20.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zlib-1.2.13-h4ab18f5_6.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zstandard-0.23.0-py310h64cae3c_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zstd-1.5.6-ha6fb4c9_0.conda
packages:
- kind: conda
  name: _libgcc_mutex
  version: '0.1'
  build: conda_forge
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/_libgcc_mutex-0.1-conda_forge.tar.bz2
  sha256: fe51de6107f9edc7aa4f786a70f4a883943bc9d39b3bb7307c04c41410990726
  md5: d7c89558ba9fa0495403155b64376d81
  license: None
  size: 2562
  timestamp: 1578324546067
- kind: conda
  name: _openmp_mutex
  version: '4.5'
  build: 2_kmp_llvm
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/_openmp_mutex-4.5-2_kmp_llvm.tar.bz2
  sha256: 84a66275da3a66e3f3e70e9d8f10496d807d01a9e4ec16cd2274cc5e28c478fc
  md5: 562b26ba2e19059551a811e72ab7f793
  depends:
  - _libgcc_mutex 0.1 conda_forge
  - llvm-openmp >=9.0.1
  license: BSD-3-Clause
  license_family: BSD
  size: 5744
  timestamp: 1650742457817
- kind: conda
  name: absl-py
  version: 2.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/absl-py-2.1.0-pyhd8ed1ab_0.conda
  sha256: 6c84575fe0c3a860c7b6a52cb36dc548c838503c8da0f950a63a64c29b443937
  md5: 035d1d58677c13ec93122d9eb6b8803b
  depends:
  - python >=3.7
  license: Apache-2.0
  license_family: Apache
  size: 107266
  timestamp: 1705494755555
- kind: conda
  name: alsa-lib
  version: 1.2.8
  build: h166bdaf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/alsa-lib-1.2.8-h166bdaf_0.tar.bz2
  sha256: 2c0a618d0fa695e4e01a30e7ff31094be540c52e9085cbd724edb132c65cf9cd
  md5: be733e69048951df1e4b4b7bb8c7666f
  depends:
  - libgcc-ng >=12
  license: LGPL-2.1-or-later
  license_family: GPL
  size: 592320
  timestamp: 1666699031168
- kind: conda
  name: antlr-python-runtime
  version: 4.9.3
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/antlr-python-runtime-4.9.3-pyhd8ed1ab_1.tar.bz2
  sha256: b91f8ab4ac2b48972fbee1fc8e092cc452fdf59156e4ff2322c94bbf73650f94
  md5: c88eaec8de9ae1fa161205aa18e7a5b1
  depends:
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 101065
  timestamp: 1638309284042
- kind: conda
  name: anyio
  version: 4.4.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/anyio-4.4.0-pyhd8ed1ab_0.conda
  sha256: 84ac9429812495f12939ab4994f2634f7cacd254f6234a0c2c0243daed15a7ee
  md5: 1fa97c6e8db1f82c64ff17a5efc4ae8e
  depends:
  - exceptiongroup >=1.0.2
  - idna >=2.8
  - python >=3.8
  - sniffio >=1.1
  - typing_extensions >=4.1
  constrains:
  - uvloop >=0.17
  - trio >=0.23
  license: MIT
  license_family: MIT
  size: 104255
  timestamp: 1717693144467
- kind: conda
  name: argon2-cffi
  version: 23.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/argon2-cffi-23.1.0-pyhd8ed1ab_0.conda
  sha256: 130766446f5507bd44df957b6b5c898a8bd98f024bb426ed6cb9ff1ad67fc677
  md5: 3afef1f55a1366b4d3b6a0d92e2235e4
  depends:
  - argon2-cffi-bindings
  - python >=3.7
  - typing-extensions
  constrains:
  - argon2_cffi ==999
  license: MIT
  license_family: MIT
  size: 18602
  timestamp: 1692818472638
- kind: conda
  name: argon2-cffi-bindings
  version: 21.2.0
  build: py310ha75aee5_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/argon2-cffi-bindings-21.2.0-py310ha75aee5_5.conda
  sha256: 1050f55294476b4d9b36ca3cf22b47f2f23d6e143ad6a177025bc5e5984d5409
  md5: a2da54f3a705d518c95a5b6de8ad8af6
  depends:
  - __glibc >=2.17,<3.0.a0
  - cffi >=1.0.1
  - libgcc >=13
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: MIT
  license_family: MIT
  size: 34425
  timestamp: 1725356664523
- kind: conda
  name: arrow
  version: 1.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/arrow-1.3.0-pyhd8ed1ab_0.conda
  sha256: ff49825c7f9e29e09afa6284300810e7a8640d621740efb47c4541f4dc4969db
  md5: b77d8c2313158e6e461ca0efb1c2c508
  depends:
  - python >=3.8
  - python-dateutil >=2.7.0
  - types-python-dateutil >=2.8.10
  license: Apache-2.0
  license_family: Apache
  size: 100096
  timestamp: 1696129131844
- kind: conda
  name: assertpy
  version: '1.1'
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/assertpy-1.1-pyhd8ed1ab_1.conda
  sha256: a9cd24b54dd7faf27415ee968f2da09175ce0ed2e9f7398b722c323c80a65321
  md5: 50ac43bcda73efd031f9fd3f38c620b6
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 30128
  timestamp: 1694384897968
- kind: conda
  name: asttokens
  version: 2.4.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/asttokens-2.4.1-pyhd8ed1ab_0.conda
  sha256: 708168f026df19a0344983754d27d1f7b28bb21afc7b97a82f02c4798a3d2111
  md5: 5f25798dcefd8252ce5f9dc494d5f571
  depends:
  - python >=3.5
  - six >=1.12.0
  license: Apache-2.0
  license_family: Apache
  size: 28922
  timestamp: 1698341257884
- kind: conda
  name: async-lru
  version: 2.0.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/async-lru-2.0.4-pyhd8ed1ab_0.conda
  sha256: 7ed83731979fe5b046c157730e50af0e24454468bbba1ed8fc1a3107db5d7518
  md5: 3d081de3a6ea9f894bbb585e8e3a4dcb
  depends:
  - python >=3.8
  - typing_extensions >=4.0.0
  license: MIT
  license_family: MIT
  size: 15342
  timestamp: 1690563152778
- kind: conda
  name: attr
  version: 2.5.1
  build: h166bdaf_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/attr-2.5.1-h166bdaf_1.tar.bz2
  sha256: 82c13b1772c21fc4a17441734de471d3aabf82b61db9b11f4a1bd04a9c4ac324
  md5: d9c69a24ad678ffce24c6543a0176b00
  depends:
  - libgcc-ng >=12
  license: GPL-2.0-or-later
  license_family: GPL
  size: 71042
  timestamp: 1660065501192
- kind: conda
  name: attrs
  version: 24.2.0
  build: pyh71513ae_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/attrs-24.2.0-pyh71513ae_0.conda
  sha256: 28dba85a7e0f7fb57d7315e13f603d1e41b83c5b88aa2a602596b52c833a2ff8
  md5: 6732fa52eb8e66e5afeb32db8701a791
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 56048
  timestamp: 1722977241383
- kind: conda
  name: babel
  version: 2.14.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/babel-2.14.0-pyhd8ed1ab_0.conda
  sha256: 8584e3da58e92b72641c89ff9b98c51f0d5dbe76e527867804cbdf03ac91d8e6
  md5: 9669586875baeced8fc30c0826c3270e
  depends:
  - python >=3.7
  - pytz
  - setuptools
  license: BSD-3-Clause
  license_family: BSD
  size: 7609750
  timestamp: 1702422720584
- kind: conda
  name: beautifulsoup4
  version: 4.12.3
  build: pyha770c72_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/beautifulsoup4-4.12.3-pyha770c72_0.conda
  sha256: 7b05b2d0669029326c623b9df7a29fa49d1982a9e7e31b2fea34b4c9a4a72317
  md5: 332493000404d8411859539a5a630865
  depends:
  - python >=3.6
  - soupsieve >=1.2
  license: MIT
  license_family: MIT
  size: 118200
  timestamp: 1705564819537
- kind: conda
  name: biopython
  version: '1.84'
  build: py310hc51659f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/biopython-1.84-py310hc51659f_0.conda
  sha256: cc686ead6074272cc5f1f137eee1fd746b60cc4fbcef070a4a4f2efa0935040b
  md5: 3808f3a366af4c309400beae4525aae9
  depends:
  - libgcc-ng >=12
  - numpy
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: LicenseRef-Biopython
  size: 2861234
  timestamp: 1720015008216
- kind: conda
  name: biotite
  version: 0.41.0
  build: py310h76e45a6_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/biotite-0.41.0-py310h76e45a6_0.conda
  sha256: 34794d26a7adc99967557158bc1898b1130c0767a1fa780b2af2e395f4f9d15c
  md5: 9504d8a9e74f1dbab5867a4d44419195
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - msgpack-python
  - networkx >=2.0
  - numpy >=1.26.4,<2.0a0
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - requests >=2.12
  license: BSD-3-Clause
  license_family: BSD
  size: 33332326
  timestamp: 1718030112859
- kind: conda
  name: blas
  version: '1.0'
  build: mkl
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/blas-1.0-mkl.tar.bz2
  sha256: a9a9125029a66905fc9e932dfd4f595be3a59a30db37fd7bf4a675a5c6151d62
  md5: 349aef876b1d8c9dccae01de20d5b385
  depends:
  - mkl
  track_features:
  - blas_mkl
  license: BSD 3-clause
  size: 1381
- kind: conda
  name: blast-legacy
  version: 2.2.26
  build: h9ee0642_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/bioconda/linux-64/blast-legacy-2.2.26-h9ee0642_3.tar.bz2
  sha256: 64c7302072994df20f1a78e00c4baa7ca7c141f2b4935b79fb6a77758bbaf5bc
  md5: b7fe67ef984501e8089a142f1f58ab2f
  license: Public Domain
  size: 37174851
  timestamp: 1622056672809
- kind: conda
  name: bleach
  version: 6.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/bleach-6.1.0-pyhd8ed1ab_0.conda
  sha256: 845e77ef495376c5c3c328ccfd746ca0ef1978150cae8eae61a300fe7755fb08
  md5: 0ed9d7c0e9afa7c025807a9a8136ea3e
  depends:
  - packaging
  - python >=3.6
  - setuptools
  - six >=1.9.0
  - webencodings
  license: Apache-2.0
  license_family: Apache
  size: 131220
  timestamp: 1696630354218
- kind: conda
  name: bokeh
  version: 2.4.3
  build: pyhd8ed1ab_3
  build_number: 3
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/bokeh-2.4.3-pyhd8ed1ab_3.tar.bz2
  sha256: f37e33fb11ae76ff07ce726a3dbdf4cd26ffff1b52c126d2d2d136669d6b919f
  md5: e4c6e6d99add99cede5328d811cacb21
  depends:
  - jinja2 >=2.9
  - numpy >=1.11.3
  - packaging >=16.8
  - pillow >=7.1.0
  - python >=3.7
  - pyyaml >=3.10
  - tornado >=5.1
  - typing_extensions >=3.10.0
  license: BSD-3-Clause
  license_family: BSD
  size: 13940985
  timestamp: 1660586705876
- kind: conda
  name: brotli
  version: 1.1.0
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/brotli-1.1.0-hd590300_1.conda
  sha256: f2d918d351edd06c55a6c2d84b488fe392f85ea018ff227daac07db22b408f6b
  md5: f27a24d46e3ea7b70a1f98e50c62508f
  depends:
  - brotli-bin 1.1.0 hd590300_1
  - libbrotlidec 1.1.0 hd590300_1
  - libbrotlienc 1.1.0 hd590300_1
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 19383
  timestamp: 1695990069230
- kind: conda
  name: brotli-bin
  version: 1.1.0
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/brotli-bin-1.1.0-hd590300_1.conda
  sha256: a641abfbaec54f454c8434061fffa7fdaa9c695e8a5a400ed96b4f07c0c00677
  md5: 39f910d205726805a958da408ca194ba
  depends:
  - libbrotlidec 1.1.0 hd590300_1
  - libbrotlienc 1.1.0 hd590300_1
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 18980
  timestamp: 1695990054140
- kind: conda
  name: brotli-python
  version: 1.1.0
  build: py310hc6cd4ac_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/brotli-python-1.1.0-py310hc6cd4ac_1.conda
  sha256: e22268d81905338570786921b3def88e55f9ed6d0ccdd17d9fbae31a02fbef69
  md5: 1f95722c94f00b69af69a066c7433714
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  constrains:
  - libbrotlicommon 1.1.0 hd590300_1
  license: MIT
  license_family: MIT
  size: 349397
  timestamp: 1695990295884
- kind: conda
  name: bzip2
  version: 1.0.8
  build: h4bc722e_7
  build_number: 7
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/bzip2-1.0.8-h4bc722e_7.conda
  sha256: 5ced96500d945fb286c9c838e54fa759aa04a7129c59800f0846b4335cee770d
  md5: 62ee74e96c5ebb0af99386de58cf9553
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  license: bzip2-1.0.6
  license_family: BSD
  size: 252783
  timestamp: 1720974456583
- kind: conda
  name: ca-certificates
  version: 2024.7.4
  build: hbcca054_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ca-certificates-2024.7.4-hbcca054_0.conda
  sha256: c1548a3235376f464f9931850b64b02492f379b2f2bb98bc786055329b080446
  md5: 23ab7665c5f63cfb9f1f6195256daac6
  license: ISC
  size: 154853
  timestamp: 1720077432978
- kind: conda
  name: cached-property
  version: 1.5.2
  build: hd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/cached-property-1.5.2-hd8ed1ab_1.tar.bz2
  sha256: 561e6660f26c35d137ee150187d89767c988413c978e1b712d53f27ddf70ea17
  md5: 9b347a7ec10940d3f7941ff6c460b551
  depends:
  - cached_property >=1.5.2,<1.5.3.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 4134
  timestamp: 1615209571450
- kind: conda
  name: cached_property
  version: 1.5.2
  build: pyha770c72_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/cached_property-1.5.2-pyha770c72_1.tar.bz2
  sha256: 6dbf7a5070cc43d90a1e4c2ec0c541c69d8e30a0e25f50ce9f6e4a432e42c5d7
  md5: 576d629e47797577ab0f1b351297ef4a
  depends:
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 11065
  timestamp: 1615209567874
- kind: conda
  name: cairo
  version: 1.16.0
  build: ha61ee94_1014
  build_number: 1014
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cairo-1.16.0-ha61ee94_1014.tar.bz2
  sha256: f062cf56e6e50d3ad4b425ebb3765ca9138c6ebc52e6a42d1377de8bc8d954f6
  md5: d1a88f3ed5b52e1024b80d4bcd26a7a0
  depends:
  - fontconfig >=2.13.96,<3.0a0
  - fonts-conda-ecosystem
  - freetype >=2.12.1,<3.0a0
  - icu >=70.1,<71.0a0
  - libgcc-ng >=12
  - libglib >=2.72.1,<3.0a0
  - libpng >=1.6.38,<1.7.0a0
  - libxcb >=1.13,<1.14.0a0
  - libzlib >=1.2.12,<2.0.0a0
  - pixman >=0.40.0,<1.0a0
  - xorg-libice
  - xorg-libsm
  - xorg-libx11
  - xorg-libxext
  - xorg-libxrender
  - zlib >=1.2.12,<1.3.0a0
  license: LGPL-2.1-only or MPL-1.1
  size: 1576122
  timestamp: 1663568213559
- kind: conda
  name: certifi
  version: 2024.7.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/certifi-2024.7.4-pyhd8ed1ab_0.conda
  sha256: dd3577bb5275062c388c46b075dcb795f47f8dac561da7dd35fe504b936934e5
  md5: 24e7fd6ca65997938fff9e5ab6f653e4
  depends:
  - python >=3.7
  license: ISC
  size: 159308
  timestamp: 1720458053074
- kind: conda
  name: cffi
  version: 1.17.0
  build: py310h2fdcea3_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cffi-1.17.0-py310h2fdcea3_0.conda
  sha256: 082a0c2aee928cdc4fc41320a61a530d10b4c13c886f0de8f6d57e7daacfc1b1
  md5: 6ac912f6208a15d35955ab73a4e5efda
  depends:
  - __glibc >=2.17,<3.0.a0
  - libffi >=3.4,<4.0a0
  - libgcc-ng >=12
  - pycparser
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: MIT
  license_family: MIT
  size: 242409
  timestamp: 1723018481932
- kind: conda
  name: charset-normalizer
  version: 3.3.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/charset-normalizer-3.3.2-pyhd8ed1ab_0.conda
  sha256: 20cae47d31fdd58d99c4d2e65fbdcefa0b0de0c84e455ba9d6356a4bdbc4b5b9
  md5: 7f4a9e3fcff3f6356ae99244a014da6a
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 46597
  timestamp: 1698833765762
- kind: conda
  name: click
  version: 8.1.7
  build: unix_pyh707e725_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/click-8.1.7-unix_pyh707e725_0.conda
  sha256: f0016cbab6ac4138a429e28dbcb904a90305b34b3fe41a9b89d697c90401caec
  md5: f3ad426304898027fc619827ff428eca
  depends:
  - __unix
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 84437
  timestamp: 1692311973840
- kind: conda
  name: cloudpathlib
  version: 0.18.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/cloudpathlib-0.18.1-pyhd8ed1ab_0.conda
  sha256: 503cc08660ee3b6f56d43ef003ffedf2c8b93d0dcce5eb8fd1127698153c0ac7
  md5: d6b3ce6270608b5b4df8d4a8ebb0085a
  depends:
  - importlib-metadata
  - python >=3.7
  - typing_extensions
  license: MIT
  license_family: MIT
  size: 39095
  timestamp: 1708996002170
- kind: conda
  name: cloudpickle
  version: 3.0.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/cloudpickle-3.0.0-pyhd8ed1ab_0.conda
  sha256: 0dfbc1ffa72e7a0882f486c9b1e4e9cccb68cf5c576fe53a89d076c9f1d43754
  md5: 753d29fe41bb881e4b9c004f0abf973f
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 24746
  timestamp: 1697464875382
- kind: conda
  name: colorama
  version: 0.4.6
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/colorama-0.4.6-pyhd8ed1ab_0.tar.bz2
  sha256: 2c1b2e9755ce3102bca8d69e8f26e4f087ece73f50418186aee7c74bef8e1698
  md5: 3faab06a954c2a04039983f2c4a50d99
  depends:
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 25170
  timestamp: 1666700778190
- kind: conda
  name: comm
  version: 0.2.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/comm-0.2.2-pyhd8ed1ab_0.conda
  sha256: e923acf02708a8a0b591f3bce4bdc11c8e63b73198b99b35fe6cd96bfb6a0dbe
  md5: 948d84721b578d426294e17a02e24cbb
  depends:
  - python >=3.6
  - traitlets >=5.3
  license: BSD-3-Clause
  license_family: BSD
  size: 12134
  timestamp: 1710320435158
- kind: conda
  name: contextlib2
  version: 21.6.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/contextlib2-21.6.0-pyhd8ed1ab_0.tar.bz2
  sha256: 7762dc5b54c4e3e66f3c1d425ac2c6d1cff651e8fd4ab8d4d5ddfa883028ffaa
  md5: 5b26a831440be04c39531a8ce20f5d71
  depends:
  - python >=3.6
  license: PSF-2.0
  license_family: PSF
  size: 16367
  timestamp: 1624848715744
- kind: conda
  name: contourpy
  version: 1.2.1
  build: py310hd41b1e2_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/contourpy-1.2.1-py310hd41b1e2_0.conda
  sha256: b9283a52ec79bf71325cde80b8845e86bdf9ac80d8b38f95ad47cbaab32447fe
  md5: 60ee50b1968f802f2a487ba36d4cce0d
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - numpy >=1.20
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: BSD-3-Clause
  license_family: BSD
  size: 241947
  timestamp: 1712430089559
- kind: conda
  name: csblast
  version: 2.2.3
  build: h4ac6f70_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/bioconda/linux-64/csblast-2.2.3-h4ac6f70_3.tar.bz2
  sha256: b7102568d987e324e6413c664f76873ea7e1d22081e7379befa89a94f6794a5d
  md5: 5a5b59bcb286e05dace99051df3404d9
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: GPL3
  size: 4166502
  timestamp: 1684195093896
- kind: conda
  name: cuda-cccl
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cccl-12.4.127-0.tar.bz2
  sha256: 0818bede93df28b2ab7993b591f73f6e00a680145011a4a4ad8c3fb10f0c9df2
  md5: 90bcbf580038ee64d11555ed97d0eab0
  size: 1460617
  timestamp: 1710541403303
- kind: conda
  name: cuda-command-line-tools
  version: 12.1.1
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-command-line-tools-12.1.1-0.tar.bz2
  sha256: 3d070cf01cc89bb193bbc0b97770f1e2d3513f9b2f2d548f3ac9ab7f1c7fc12f
  md5: 638ae22f7ab22136e8a7544121467979
  depends:
  - cuda-cupti >=12.1.105
  - cuda-gdb >=12.1.105
  - cuda-nvdisasm >=12.1.105
  - cuda-nvprof >=12.1.105
  - cuda-nvtx >=12.1.105
  - cuda-sanitizer-api >=12.1.105
  size: 1475
  timestamp: 1681743539057
- kind: conda
  name: cuda-compiler
  version: 12.6.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-compiler-12.6.0-0.tar.bz2
  sha256: 0ea8489bac624701569e88db40e09f4a5f003114595bfb37970faaa3ada06666
  md5: 1c75343d08e72c72721ebf7b3f0f6999
  depends:
  - __linux
  - cuda-cuobjdump
  - cuda-cuxxfilt
  - cuda-nvcc
  - cuda-nvprune
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 16701
  timestamp: 1722030194998
- kind: conda
  name: cuda-cudart
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cudart-12.1.105-0.tar.bz2
  sha256: 8ce27449a0a1d98630b8b13669590a34b04bccf11bf9a98151a40541f7edf7ba
  md5: 001823a01c0d49300fd9622c4578eb40
  size: 193370
  timestamp: 1680585606879
- kind: conda
  name: cuda-cudart-dev
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cudart-dev-12.1.105-0.tar.bz2
  sha256: eaf9ea2d6a606eb2883a356a24afe04c0075d802054524d9c4c6c10bbeef40de
  md5: accec90e42a0c11db1dd946031f3842f
  depends:
  - cuda-cccl
  - cuda-cudart >=12.1.105
  size: 380810
  timestamp: 1680585608812
- kind: conda
  name: cuda-cudart-static
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cudart-static-12.1.105-0.tar.bz2
  sha256: 401e8db46ceb02199cd0373fe46af76fc1f8340e6370473b4b4607ba858b104e
  md5: f05e2f83beeb8425a7e25ee2fefeb6c7
  depends:
  - cuda-cudart-dev >=12.1.105
  size: 948195
  timestamp: 1680585610338
- kind: conda
  name: cuda-cuobjdump
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cuobjdump-12.4.127-0.tar.bz2
  sha256: e510fe72282223c4c289af825c65bac7fb0e00419707edd66931776a575e5b5f
  md5: 001245d79965267fe26f742134bcbefd
  size: 308750
  timestamp: 1710542943296
- kind: conda
  name: cuda-cupti
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cupti-12.1.105-0.tar.bz2
  sha256: b7d23bb1cf1f8e47c097ecbdb7fae8edc845a6b0d26a222ca1559bdae41ce8ad
  md5: c0bfa9a714fd8099e085c70ab2ebe6ec
  size: 16124565
  timestamp: 1680572515893
- kind: conda
  name: cuda-cupti-static
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cupti-static-12.1.105-0.tar.bz2
  sha256: cac2330e176ad1654da30a792dc0d8ab526196d364cdd0d75ffae5d6083aad42
  md5: dc7e268daa45bac51b318fcc209a5e8f
  depends:
  - cuda-cupti >=12.1.105
  size: 12144368
  timestamp: 1680572526891
- kind: conda
  name: cuda-cuxxfilt
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-cuxxfilt-12.4.127-0.tar.bz2
  sha256: e1a0d0e114f9dcc6591a5bce395e1162c528d17af012d7ca662fa7beb2038832
  md5: 657cd4f3f23b5f3e09ce78737692dfea
  size: 302608
  timestamp: 1710544312462
- kind: conda
  name: cuda-documentation
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-documentation-12.4.127-0.tar.bz2
  sha256: 57887b72711c637f7dd34853cdd1caccb0d1db757a5a1872155c16182b95baa0
  md5: 1410656e3b0350b35549c922c5dfdb53
  size: 91629
  timestamp: 1710540364040
- kind: conda
  name: cuda-driver-dev
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-driver-dev-12.4.127-0.tar.bz2
  sha256: 4cca33c1d25c32e14d9af3a600f6876939f31f0322ebe3011008cd3f814fd8f6
  md5: 309fe813e7d4be5b6e317e8adc5ed4f4
  size: 18557
  timestamp: 1710544195085
- kind: conda
  name: cuda-gdb
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-gdb-12.4.127-0.tar.bz2
  sha256: b66f62901a846328bf999be246098ff9dc07fb098b089fe995cc7a6b7b0eb664
  md5: f36a1e5fef08c9980991e3ed27fcd644
  size: 6056326
  timestamp: 1710546537965
- kind: conda
  name: cuda-libraries
  version: 12.1.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-libraries-12.1.0-0.tar.bz2
  sha256: f282fdaf5ce1bbcb998126bcf4e551468cb2dfa8ed31a959aa6d6861e3c044ee
  md5: 8c08238819848e471a6213db526dbf15
  depends:
  - cuda-cudart >=12.1.55
  - cuda-nvrtc >=12.1.55
  - cuda-opencl >=12.1.56
  - libcublas >=12.1.0.26
  - libcufft >=11.0.2.4
  - libcufile >=1.6.0.25
  - libcurand >=10.3.2.56
  - libcusolver >=11.4.4.55
  - libcusparse >=12.0.2.55
  - libnpp >=12.0.2.50
  - libnvjitlink >=12.1.55
  - libnvjpeg >=12.1.0.39
  size: 1551
  timestamp: 1677130423817
- kind: conda
  name: cuda-libraries-dev
  version: 12.6.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-libraries-dev-12.6.0-0.tar.bz2
  sha256: d5420bc519427e43fd44883ee409de213d134a5053228e2cd28dd97c1396a32e
  md5: b63124277b94bff050cdc9278b89fe14
  depends:
  - cuda-cccl
  - cuda-cudart-dev
  - cuda-driver-dev
  - cuda-nvrtc-dev
  - cuda-opencl-dev
  - cuda-profiler-api
  - libcublas-dev
  - libcufft-dev
  - libcufile-dev
  - libcurand-dev
  - libcusolver-dev
  - libcusparse-dev
  - libnpp-dev
  - libnvfatbin-dev
  - libnvjitlink-dev
  - libnvjpeg-dev
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 16707
  timestamp: 1722030231047
- kind: conda
  name: cuda-libraries-static
  version: 12.1.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-libraries-static-12.1.0-0.tar.bz2
  sha256: 1b70660e87c7afbd38a7911df83a809749d4249ff35ade69daffb4a868825e00
  md5: 7cbabea1d56ac1745fb483024cbb7538
  depends:
  - cuda-cudart-static >=12.1.55
  - cuda-cupti-static >=12.1.62
  - cuda-nvrtc-static >=12.1.55
  - libcublas-static >=12.1.0.26
  - libcufft-static >=11.0.2.4
  - libcufile-static >=1.6.0.25
  - libcurand-static >=10.3.2.56
  - libcusolver-static >=11.4.4.55
  - libcusparse-static >=12.0.2.55
  - libnpp-static >=12.0.2.50
  - libnvjpeg-static >=12.1.0.39
  size: 1553
  timestamp: 1677130451989
- kind: conda
  name: cuda-nsight
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nsight-12.4.127-0.tar.bz2
  sha256: 809499163a96812af3a2a4058cdf7affc1c638eabf255e6f39efdcd75a67f3eb
  md5: 031e25cc0010cecfa62249acc3939ee6
  size: 119222580
  timestamp: 1710541146699
- kind: conda
  name: cuda-nvcc
  version: 12.4.131
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvcc-12.4.131-0.tar.bz2
  sha256: 8342cc8ca1d82923bf46ee42f6f61e53b7b0f16cc5189573259ab9a655b78997
  md5: 3fbe761aaf3b7602f107f75008c3a4de
  size: 65674958
  timestamp: 1711621862142
- kind: conda
  name: cuda-nvdisasm
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvdisasm-12.4.127-0.tar.bz2
  sha256: 2635c44a557ab45c46265e9af7694d00956f6bd8c031d5a10da83e6472d26aae
  md5: 2011077477fc67866170f04bcac0dcd0
  size: 50215513
  timestamp: 1710544140559
- kind: conda
  name: cuda-nvml-dev
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvml-dev-12.4.127-0.tar.bz2
  sha256: 81897bec35368e956b21c91d1e8fb78b87b344d8ecd0ee0d8f9d2cd1e41d53ac
  md5: 946441b19210bfb6cfa4c403148d0a5d
  size: 181774
  timestamp: 1710541139047
- kind: conda
  name: cuda-nvprof
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvprof-12.4.127-0.tar.bz2
  sha256: 75597b69222f52c0de92e72f0431b133a2ac6945dc3456f3a4c2c9da4681f0f3
  md5: bfdbdb5a65e35ef10ca14723de7fd9b5
  size: 4960988
  timestamp: 1710549514085
- kind: conda
  name: cuda-nvprune
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvprune-12.4.127-0.tar.bz2
  sha256: 9d4bc4d917220a88c21e50fef757988b763ffa92ceb3e88d39460db6777f2821
  md5: b50c01959e8cadfd2c6e85de154f39b2
  size: 67338
  timestamp: 1710544016364
- kind: conda
  name: cuda-nvrtc
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvrtc-12.1.105-0.tar.bz2
  sha256: 33866252ee8515a30211ac8792fec628de1e9ead7f8e54deac5fe330b2e9a44c
  md5: 12c15423c4eeb41fee6df3a2e5ab53ab
  size: 20683159
  timestamp: 1680582964872
- kind: conda
  name: cuda-nvrtc-dev
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvrtc-dev-12.1.105-0.tar.bz2
  sha256: bebe8dfdb8baebd00e6508095c81f2477e5581bc9b84601bc1738780061db66f
  md5: efd34c7e894b08088f367853741d7716
  depends:
  - cuda-nvrtc >=12.1.105
  size: 11788
  timestamp: 1680582975092
- kind: conda
  name: cuda-nvrtc-static
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvrtc-static-12.1.105-0.tar.bz2
  sha256: 9b910cf09a17f246e7788029248feb46ceb276b59d77e0998e4930edf43d3e66
  md5: 02888028f633b77901842f685a651399
  depends:
  - cuda-nvrtc-dev >=12.1.105
  size: 18356000
  timestamp: 1680582975636
- kind: conda
  name: cuda-nvtx
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvtx-12.1.105-0.tar.bz2
  sha256: ea28adfbbaaeb4e35a8af9f312ff37d7da6480b35134843f8c69704905ec4c81
  md5: 813ed3c0b687b8bb5daebf43889d8317
  size: 58422
  timestamp: 1680583941909
- kind: conda
  name: cuda-nvvp
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvvp-12.4.127-0.tar.bz2
  sha256: dad5b6a981d34ea7886928e62ee860d82274d996c824ac9ce0e0682bfc138da0
  md5: fe0f1f926bd04b7468df9d6c991d7b77
  depends:
  - cuda-nvdisasm
  - cuda-nvprof
  size: 120069229
  timestamp: 1710550059475
- kind: conda
  name: cuda-opencl
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-opencl-12.4.127-0.tar.bz2
  sha256: 94f15dcc7bb763d7afab2042579023188aeeee2e7d563bf2c67d5795526a2376
  md5: 3de25496d2b46d83abb8c910ea9842cb
  size: 11830
  timestamp: 1710543602704
- kind: conda
  name: cuda-opencl-dev
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-opencl-dev-12.4.127-0.tar.bz2
  sha256: 8ab66ebd2271bc2c647d1eaf759477e4b23cf266eaef2da1811d09a3cd2b92d3
  md5: 6c7eb107051c5193974b6902b6fb46e1
  depends:
  - cuda-opencl >=12.4.127
  size: 73406
  timestamp: 1710543602908
- kind: conda
  name: cuda-profiler-api
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-profiler-api-12.4.127-0.tar.bz2
  sha256: 18bca2d9f35b3f1e9b1924bdcf1424077346487f553c25ed5cade7598a9129b3
  md5: 5a12f7616c05770a6df75dd585b9b608
  size: 19274
  timestamp: 1710544073179
- kind: conda
  name: cuda-runtime
  version: 12.1.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-runtime-12.1.0-0.tar.bz2
  sha256: ddcef7597007188a71bddba2eeacb603ff89328bdcae311210abd083ade57a30
  md5: 95e8c2f09ec28cce7cdecd6200b5d26e
  depends:
  - cuda-libraries >=12.1.0
  size: 1434
  timestamp: 1677130501720
- kind: conda
  name: cuda-sanitizer-api
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-sanitizer-api-12.4.127-0.tar.bz2
  sha256: 479ef4c2877f59d11b4125b7e4147d1aa226906975544904022076491bf20b9f
  md5: 3d8b2d25db78ccdbe63cae75f8056a8d
  size: 17962299
  timestamp: 1710553494409
- kind: conda
  name: cuda-toolkit
  version: 12.1.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-toolkit-12.1.0-0.tar.bz2
  sha256: 2a8c9ee82de6f5cc2960ef5497b3115f6c6cfeed4ec525cf2a60bac67040bc31
  md5: bb876165ea7f246620641bbbcbcd78a0
  depends:
  - cuda-compiler >=12.1.0
  - cuda-documentation >=12.1.55
  - cuda-libraries >=12.1.0
  - cuda-libraries-dev >=12.1.0
  - cuda-libraries-static >=12.1.0
  - cuda-nvml-dev >=12.1.55
  - cuda-tools >=12.1.0
  - libnvvm-samples >=12.1.55
  size: 1503
  timestamp: 1677130540965
- kind: conda
  name: cuda-tools
  version: 12.1.1
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-tools-12.1.1-0.tar.bz2
  sha256: be68ddd163e7651dcf978bd42aac6d9800ec53cf61bba7d91a8aa8804e51bd9a
  md5: 1296be3d3ef63e9c60574ee244942282
  depends:
  - cuda-command-line-tools >=12.1.1
  - cuda-visual-tools >=12.1.1
  - gds-tools >=1.6.1.9
  size: 1453
  timestamp: 1681743640921
- kind: conda
  name: cuda-visual-tools
  version: 12.6.0
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-visual-tools-12.6.0-0.tar.bz2
  sha256: 98ae1573e6b07e7006c933b791b29289a7919e94affb9af9ef73b852f5c00ef6
  md5: 64a50f5638e18567fcddb55bfa90fd8e
  depends:
  - cuda-libraries-dev 12.6.0.*
  - cuda-nsight
  - cuda-nvml-dev
  - cuda-nvvp
  - nsight-compute
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 16699
  timestamp: 1722030253845
- kind: conda
  name: cudatoolkit
  version: 11.1.74
  build: h6bb024c_0
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cudatoolkit-11.1.74-h6bb024c_0.tar.bz2
  sha256: 491dcbecfc838b721070d5819a42a5d62a3ba42d82700af11d276dd2228cac63
  md5: 7ef870174e8baed24f96824c49c24eb7
  depends:
  - libgcc-ng >=7.3.0
  - libstdcxx-ng >=7.3.0
  license: NVIDIA End User License Agreement
  size: 1274140908
  timestamp: 1602682302206
- kind: conda
  name: cudnn
  version: 8.0.4
  build: cuda11.1_0
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cudnn-8.0.4-cuda11.1_0.tar.bz2
  sha256: 7db90852b217a894456981b8a34954afbdfb236c9a8d91616867998fdbcd858b
  md5: 6989f4133a36c3adc6c7be38903bc5aa
  depends:
  - cudatoolkit >=11.1,<11.2
  license: NVIDIA cuDNN Software License Agreement
  size: 748243477
  timestamp: 1603470127215
- kind: conda
  name: cycler
  version: 0.12.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/cycler-0.12.1-pyhd8ed1ab_0.conda
  sha256: f221233f21b1d06971792d491445fd548224641af9443739b4b7b6d5d72954a8
  md5: 5cd86562580f274031ede6aa6aa24441
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 13458
  timestamp: 1696677888423
- kind: conda
  name: cython
  version: 3.0.11
  build: py310hea249c9_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cython-3.0.11-py310hea249c9_0.conda
  sha256: 49b4ce9d6e59811ba0c7fea775992898ae7afdaf107fab7ab1f8dc5b64a7578c
  md5: f67268cb88129183c3368663f45932eb
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Apache-2.0
  license_family: APACHE
  size: 3229414
  timestamp: 1722872657472
- kind: conda
  name: cytoolz
  version: 0.12.3
  build: py310h2372a71_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cytoolz-0.12.3-py310h2372a71_0.conda
  sha256: a75c195a71b8a1676f057a785515d1f78515d4f59389d5ac6d3cd9a08880566a
  md5: 21362970a6fea90ca507c253c20465f2
  depends:
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - toolz >=0.10.0
  license: BSD-3-Clause
  license_family: BSD
  size: 368467
  timestamp: 1706897294269
- kind: conda
  name: dask
  version: 2023.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/dask-2023.3.0-pyhd8ed1ab_0.conda
  sha256: 7e95d34946ac4d156d3f0b72d7165c19185e0c23c053084665802ae1a18dc218
  md5: aab5cea04004860e804de5bb3337f183
  depends:
  - bokeh >=2.4.2,<3
  - cytoolz >=0.8.2
  - dask-core >=2023.3.0,<2023.3.1.0a0
  - distributed >=2023.3.0,<2023.3.1.0a0
  - jinja2 >=2.10.3
  - lz4
  - numpy >=1.21
  - pandas >=1.3
  - python >=3.8
  constrains:
  - openssl !=1.1.1e
  license: BSD-3-Clause
  license_family: BSD
  size: 7063
  timestamp: 1677718268307
- kind: conda
  name: dask-core
  version: 2023.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/dask-core-2023.3.0-pyhd8ed1ab_0.conda
  sha256: 3e9f7d7180f0ffbf2e3014bb7b7aa010f65a90f701a1e43471487fbf03ceeca7
  md5: 34437340f37faafad7a6287d3b624f60
  depends:
  - click >=7.0
  - cloudpickle >=1.1.1
  - fsspec >=0.6.0
  - packaging >=20.0
  - partd >=1.2.0
  - python >=3.8
  - pyyaml >=5.3.1
  - toolz >=0.8.2
  license: BSD-3-Clause
  license_family: BSD
  size: 836744
  timestamp: 1677707157572
- kind: conda
  name: dataclasses
  version: '0.8'
  build: pyhc8e2a94_3
  build_number: 3
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/dataclasses-0.8-pyhc8e2a94_3.tar.bz2
  sha256: 63a83e62e0939bc1ab32de4ec736f6403084198c4639638b354a352113809c92
  md5: a362b2124b06aad102e2ee4581acee7d
  depends:
  - python >=3.7
  license: Apache-2.0
  license_family: APACHE
  size: 9870
  timestamp: 1628958582931
- kind: conda
  name: dbus
  version: 1.13.6
  build: h5008d03_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/dbus-1.13.6-h5008d03_3.tar.bz2
  sha256: 8f5f995699a2d9dbdd62c61385bfeeb57c82a681a7c8c5313c395aa0ccab68a5
  md5: ecfff944ba3960ecb334b9a2663d708d
  depends:
  - expat >=2.4.2,<3.0a0
  - libgcc-ng >=9.4.0
  - libglib >=2.70.2,<3.0a0
  license: GPL-2.0-or-later
  license_family: GPL
  size: 618596
  timestamp: 1640112124844
- kind: conda
  name: debugpy
  version: 1.8.5
  build: py310hf71b8c6_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/debugpy-1.8.5-py310hf71b8c6_1.conda
  sha256: 707edcafef00b9c37972ad85950445fd4ce5210b59b1974aa0cb0500bd2787e2
  md5: 800ecd5457373be6e6ff565d61646d8b
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: MIT
  license_family: MIT
  size: 1931749
  timestamp: 1725269349626
- kind: conda
  name: decorator
  version: 5.1.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/decorator-5.1.1-pyhd8ed1ab_0.tar.bz2
  sha256: 328a6a379f9bdfd0230e51de291ce858e6479411ea4b0545fb377c71662ef3e2
  md5: 43afe5ab04e35e17ba28649471dd7364
  depends:
  - python >=3.5
  license: BSD-2-Clause
  license_family: BSD
  size: 12072
  timestamp: 1641555714315
- kind: conda
  name: deepdiff
  version: 7.0.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/deepdiff-7.0.1-pyhd8ed1ab_0.conda
  sha256: 90b377f43227dae2024b6c4481f18254cd06241d929bec278a55af3d91978cc4
  md5: 3135304fe21f0244ed79f4094387f80d
  depends:
  - ordered-set >=4.1.0,<4.2.0
  - orjson
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 71217
  timestamp: 1712671931763
- kind: conda
  name: defusedxml
  version: 0.7.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/defusedxml-0.7.1-pyhd8ed1ab_0.tar.bz2
  sha256: 9717a059677553562a8f38ff07f3b9f61727bd614f505658b0a5ecbcf8df89be
  md5: 961b3a227b437d82ad7054484cfa71b2
  depends:
  - python >=3.6
  license: PSF-2.0
  license_family: PSF
  size: 24062
  timestamp: 1615232388757
- kind: conda
  name: dgl
  version: 2.3.0.th23.cu121
  build: py310_0
  subdir: linux-64
  url: https://conda.anaconda.org/dglteam/label/th23_cu121/linux-64/dgl-2.3.0.th23.cu121-py310_0.tar.bz2
  md5: f78c2f9353c36a7aa529630726ef46e5
  depends:
  - networkx
  - numpy
  - psutil
  - python >=3.10,<3.11.0a0
  - requests
  - scipy
  - tqdm
  arch: x86_64
  platform: linux
  license: Apache
  size: 255164376
  timestamp: 1719521407051
- kind: conda
  name: distributed
  version: 2023.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/distributed-2023.3.0-pyhd8ed1ab_0.conda
  sha256: 5d4b493172026813cd0774f94efdc54651a2708fb52cfc55574fa9504b50c50c
  md5: 6ca8ed418961a91d76965268b6f4aa5b
  depends:
  - click >=7.0
  - cloudpickle >=1.5.0
  - cytoolz >=0.10.1
  - dask-core >=2023.3.0,<2023.3.1.0a0
  - jinja2 >=2.10.3
  - locket >=1.0.0
  - msgpack-python >=1.0.0
  - packaging >=20.0
  - psutil >=5.7.0
  - python >=3.8
  - pyyaml >=5.3.1
  - sortedcontainers >=2.0.5
  - tblib >=1.6.0
  - toolz >=0.10.0
  - tornado >=6.0.3
  - urllib3 >=1.24.3
  - zict >=2.1.0
  constrains:
  - openssl !=1.1.1e
  license: BSD-3-Clause
  license_family: BSD
  size: 749994
  timestamp: 1677711209126
- kind: conda
  name: dm-tree
  version: 0.1.8
  build: py310ha8c1f0e_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/dm-tree-0.1.8-py310ha8c1f0e_4.conda
  sha256: a7e4f5565856370a75247100f87f9b4afefdb7f0eeced4709ad31f9676af65ac
  md5: d099355e8706f6c981147baec066269a
  depends:
  - libabseil * cxx17*
  - libabseil >=20240116.1,<20240117.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Apache-2.0
  license_family: Apache
  size: 106907
  timestamp: 1709886929256
- kind: conda
  name: e3nn
  version: 0.5.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/e3nn-0.5.1-pyhd8ed1ab_0.conda
  sha256: 666888e0f209dceb30fe171d32bb98c4872c0d3b2ece408a6550731d127a0a25
  md5: fb4e206f13941e3eb355e5c303023953
  depends:
  - opt_einsum_fx >=0.1.4
  - python >=3.7
  - pytorch >=1.8.0
  - scipy
  - sympy
  license: MIT
  license_family: MIT
  size: 86090
  timestamp: 1670911139434
- kind: conda
  name: e3nn-jax
  version: 0.20.7
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/e3nn-jax-0.20.7-pyhd8ed1ab_0.conda
  sha256: 1c21bed9badc110a9f8c5895e15b83a38a0739a046b5e819cf6535d075b6409d
  md5: 96d98f10514672864cfb049ea9dd0861
  depends:
  - attrs
  - jax
  - jaxlib
  - numpy
  - python >=3.9
  - sympy
  license: Apache-2.0
  license_family: APACHE
  size: 123043
  timestamp: 1723631455414
- kind: conda
  name: einops
  version: 0.8.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/einops-0.8.0-pyhd8ed1ab_0.conda
  sha256: 8f706a97a658e5c3c037cc8456819f22e6b87efef85394a0c24574424e890cdc
  md5: 6f8dfe6d33eeda92e9ecc2b8bda06c94
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 40293
  timestamp: 1714285282316
- kind: conda
  name: entrypoints
  version: '0.4'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/entrypoints-0.4-pyhd8ed1ab_0.tar.bz2
  sha256: 2ec4a0900a4a9f42615fc04d0fb3286b796abe56590e8e042f6ec25e102dd5af
  md5: 3cf04868fee0a029769bd41f4b2fbf2d
  depends:
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 9199
  timestamp: 1643888357950
- kind: conda
  name: exceptiongroup
  version: 1.2.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/exceptiongroup-1.2.2-pyhd8ed1ab_0.conda
  sha256: e0edd30c4b7144406bb4da975e6bb97d6bc9c0e999aa4efe66ae108cada5d5b5
  md5: d02ae936e42063ca46af6cdad2dbd1e0
  depends:
  - python >=3.7
  license: MIT and PSF-2.0
  size: 20418
  timestamp: 1720869435725
- kind: conda
  name: executing
  version: 2.0.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/executing-2.0.1-pyhd8ed1ab_0.conda
  sha256: c738804ab1e6376f8ea63372229a04c8d658dc90fd5a218c6273a2eaf02f4057
  md5: e16be50e378d8a4533b989035b196ab8
  depends:
  - python >=2.7
  license: MIT
  license_family: MIT
  size: 27689
  timestamp: 1698580072627
- kind: conda
  name: expat
  version: 2.6.2
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/expat-2.6.2-h59595ed_0.conda
  sha256: 89916c536ae5b85bb8bf0cfa27d751e274ea0911f04e4a928744735c14ef5155
  md5: 53fb86322bdb89496d7579fe3f02fd61
  depends:
  - libexpat 2.6.2 h59595ed_0
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 137627
  timestamp: 1710362144873
- kind: conda
  name: ffmpeg
  version: '4.3'
  build: hf484d3e_0
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/ffmpeg-4.3-hf484d3e_0.tar.bz2
  sha256: 60b3e36cb36b706f5850f155bd9d3f33194a522b5ef20be46cb37dbc987a6741
  md5: 0b0bf7c3d7e146ef91de5310bbf7a230
  depends:
  - bzip2 >=1.0.8,<2.0a0
  - freetype >=2.10.2,<3.0a0
  - gmp >=6.1.2
  - gnutls >=3.6.5,<3.7.0a0
  - lame >=3.100,<3.101.0a0
  - libgcc-ng >=7.3.0
  - libiconv
  - libstdcxx-ng >=7.3.0
  - openh264 >=2.1.0,<2.2.0a0
  - zlib >=1.2.11,<1.3.0a0
  license: LGPL
  size: 10426878
  timestamp: 1596130242227
- kind: conda
  name: fftw
  version: 3.3.10
  build: nompi_hf1063bd_110
  build_number: 110
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/fftw-3.3.10-nompi_hf1063bd_110.conda
  sha256: 3cc58c9d9a8cc0089e3839ae5ff7ba4ddfc6df99d5f6a147fe90ea963bc6fe45
  md5: ee3e687b78b778db7b304e5b00a4dca6
  depends:
  - libgcc-ng >=12
  - libgfortran-ng
  - libgfortran5 >=12.3.0
  - libstdcxx-ng >=12
  license: GPL-2.0-or-later
  license_family: GPL
  size: 2075171
  timestamp: 1717757963922
- kind: conda
  name: filelock
  version: 3.15.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/filelock-3.15.4-pyhd8ed1ab_0.conda
  sha256: f78d9c0be189a77cb0c67d02f33005f71b89037a85531996583fb79ff3fe1a0a
  md5: 0e7e4388e9d5283e22b35a9443bdbcc9
  depends:
  - python >=3.7
  license: Unlicense
  size: 17592
  timestamp: 1719088395353
- kind: conda
  name: fire
  version: 0.6.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/fire-0.6.0-pyhd8ed1ab_0.conda
  sha256: bfc87eb02451144794e441bc58f616bef0a7eb7d0179852ad590a60e1b704371
  md5: e9ed10aa8fa1dd6782940b95c942a6ae
  depends:
  - python >=3.7
  - six
  - termcolor
  license: Apache-2.0
  license_family: Apache
  size: 85151
  timestamp: 1710221690085
- kind: conda
  name: font-ttf-dejavu-sans-mono
  version: '2.37'
  build: hab24e00_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/font-ttf-dejavu-sans-mono-2.37-hab24e00_0.tar.bz2
  sha256: 58d7f40d2940dd0a8aa28651239adbf5613254df0f75789919c4e6762054403b
  md5: 0c96522c6bdaed4b1566d11387caaf45
  license: BSD-3-Clause
  license_family: BSD
  size: 397370
  timestamp: 1566932522327
- kind: conda
  name: font-ttf-inconsolata
  version: '3.000'
  build: h77eed37_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/font-ttf-inconsolata-3.000-h77eed37_0.tar.bz2
  sha256: c52a29fdac682c20d252facc50f01e7c2e7ceac52aa9817aaf0bb83f7559ec5c
  md5: 34893075a5c9e55cdafac56607368fc6
  license: OFL-1.1
  license_family: Other
  size: 96530
  timestamp: 1620479909603
- kind: conda
  name: font-ttf-source-code-pro
  version: '2.038'
  build: h77eed37_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/font-ttf-source-code-pro-2.038-h77eed37_0.tar.bz2
  sha256: 00925c8c055a2275614b4d983e1df637245e19058d79fc7dd1a93b8d9fb4b139
  md5: 4d59c254e01d9cde7957100457e2d5fb
  license: OFL-1.1
  license_family: Other
  size: 700814
  timestamp: 1620479612257
- kind: conda
  name: font-ttf-ubuntu
  version: '0.83'
  build: h77eed37_2
  build_number: 2
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/font-ttf-ubuntu-0.83-h77eed37_2.conda
  sha256: c940f6e969143e13a3a9660abb3c7e7e23b8319efb29dbdd5dee0b9939236e13
  md5: cbbe59391138ea5ad3658c76912e147f
  license: LicenseRef-Ubuntu-Font-Licence-Version-1.0
  license_family: Other
  size: 1622566
  timestamp: 1714483134319
- kind: conda
  name: fontconfig
  version: 2.14.2
  build: h14ed4e7_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/fontconfig-2.14.2-h14ed4e7_0.conda
  sha256: 155d534c9037347ea7439a2c6da7c24ffec8e5dd278889b4c57274a1d91e0a83
  md5: 0f69b688f52ff6da70bccb7ff7001d1d
  depends:
  - expat >=2.5.0,<3.0a0
  - freetype >=2.12.1,<3.0a0
  - libgcc-ng >=12
  - libuuid >=2.32.1,<3.0a0
  - libzlib >=1.2.13,<2.0.0a0
  license: MIT
  license_family: MIT
  size: 272010
  timestamp: 1674828850194
- kind: conda
  name: fonts-conda-ecosystem
  version: '1'
  build: '0'
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/fonts-conda-ecosystem-1-0.tar.bz2
  sha256: a997f2f1921bb9c9d76e6fa2f6b408b7fa549edd349a77639c9fe7a23ea93e61
  md5: fee5683a3f04bd15cbd8318b096a27ab
  depends:
  - fonts-conda-forge
  license: BSD-3-Clause
  license_family: BSD
  size: 3667
  timestamp: 1566974674465
- kind: conda
  name: fonts-conda-forge
  version: '1'
  build: '0'
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/fonts-conda-forge-1-0.tar.bz2
  sha256: 53f23a3319466053818540bcdf2091f253cbdbab1e0e9ae7b9e509dcaa2a5e38
  md5: f766549260d6815b0c52253f1fb1bb29
  depends:
  - font-ttf-dejavu-sans-mono
  - font-ttf-inconsolata
  - font-ttf-source-code-pro
  - font-ttf-ubuntu
  license: BSD-3-Clause
  license_family: BSD
  size: 4102
  timestamp: 1566932280397
- kind: conda
  name: fonttools
  version: 4.53.1
  build: py310h5b4e0ec_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/fonttools-4.53.1-py310h5b4e0ec_0.conda
  sha256: 704527a916f81811043921205a7aa4fc8463c6e1069c771ad51078290529e9a9
  md5: 2c5257cb35d1946f5e80a0cfd69ed7ec
  depends:
  - __glibc >=2.17,<3.0.a0
  - brotli
  - libgcc-ng >=12
  - munkres
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - unicodedata2 >=14.0.0
  license: MIT
  license_family: MIT
  size: 2359986
  timestamp: 1720359222661
- kind: conda
  name: fqdn
  version: 1.5.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/fqdn-1.5.1-pyhd8ed1ab_0.tar.bz2
  sha256: 6cfd1f9bcd2358a69fb571f4b3af049b630d52647d906822dbedac03e84e4f63
  md5: 642d35437078749ef23a5dca2c9bb1f3
  depends:
  - cached-property >=1.3.0
  - python >=2.7,<4
  license: MPL-2.0
  license_family: MOZILLA
  size: 14395
  timestamp: 1638810388635
- kind: conda
  name: freetype
  version: 2.12.1
  build: h267a509_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/freetype-2.12.1-h267a509_2.conda
  sha256: b2e3c449ec9d907dd4656cb0dc93e140f447175b125a3824b31368b06c666bb6
  md5: 9ae35c3d96db2c94ce0cef86efdfa2cb
  depends:
  - libgcc-ng >=12
  - libpng >=1.6.39,<1.7.0a0
  - libzlib >=1.2.13,<2.0.0a0
  license: GPL-2.0-only OR FTL
  size: 634972
  timestamp: 1694615932610
- kind: conda
  name: fsspec
  version: 2024.6.1
  build: pyhff2d567_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/fsspec-2024.6.1-pyhff2d567_0.conda
  sha256: 2b8e98294c70d9a33ee0ef27539a8a8752a26efeafa0225e85dc876ef5bb49f4
  md5: 996bf792cdb8c0ac38ff54b9fde56841
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 133141
  timestamp: 1719515065535
- kind: conda
  name: gds-tools
  version: 1.9.1.3
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/gds-tools-1.9.1.3-0.tar.bz2
  sha256: 786e251ef09733a120829baa842ba9ba60d1598f10475a2962c5a7597426ae55
  md5: c434e7cafa6663ecf3953f00a099ac23
  depends:
  - libcufile >=1.9.1.3
  size: 42707168
  timestamp: 1710365911168
- kind: conda
  name: gettext
  version: 0.22.5
  build: he02047a_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gettext-0.22.5-he02047a_3.conda
  sha256: c3d9a453f523acbf2b3e1c82a42edfc7c7111b4686a2180ab48cb9b51a274218
  md5: c7f243bbaea97cd6ea1edd693270100e
  depends:
  - __glibc >=2.17,<3.0.a0
  - gettext-tools 0.22.5 he02047a_3
  - libasprintf 0.22.5 he8f35ee_3
  - libasprintf-devel 0.22.5 he8f35ee_3
  - libgcc-ng >=12
  - libgettextpo 0.22.5 he02047a_3
  - libgettextpo-devel 0.22.5 he02047a_3
  - libstdcxx-ng >=12
  license: LGPL-2.1-or-later AND GPL-3.0-or-later
  size: 479452
  timestamp: 1723626088190
- kind: conda
  name: gettext-tools
  version: 0.22.5
  build: he02047a_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gettext-tools-0.22.5-he02047a_3.conda
  sha256: 0fd003953ce1ce9f4569458aab9ffaa397e3be2bc069250e2f05fd93b0ad2976
  md5: fcd2016d1d299f654f81021e27496818
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  license: GPL-3.0-or-later
  license_family: GPL
  size: 2750908
  timestamp: 1723626056740
- kind: conda
  name: glib
  version: 2.80.2
  build: hf974151_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/glib-2.80.2-hf974151_0.conda
  sha256: d10a0f194d2c125617352a81a4ff43a17cf5835e88e8f151da9f9710e2db176d
  md5: d427988dc3dbd0a4c136f52db356cc6a
  depends:
  - glib-tools 2.80.2 hb6ce0ca_0
  - libffi >=3.4,<4.0a0
  - libgcc-ng >=12
  - libglib 2.80.2 hf974151_0
  - python *
  license: LGPL-2.1-or-later
  size: 600389
  timestamp: 1715252749399
- kind: conda
  name: glib-tools
  version: 2.80.2
  build: hb6ce0ca_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/glib-tools-2.80.2-hb6ce0ca_0.conda
  sha256: 221cd047f998301b96b1517d9f7d3fb0e459e8ee18778a1211f302496f6e110d
  md5: a965aeaf060289528a3fbe09326edae2
  depends:
  - libgcc-ng >=12
  - libglib 2.80.2 hf974151_0
  license: LGPL-2.1-or-later
  size: 114359
  timestamp: 1715252713902
- kind: conda
  name: gmp
  version: 6.3.0
  build: hac33072_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gmp-6.3.0-hac33072_2.conda
  sha256: 309cf4f04fec0c31b6771a5809a1909b4b3154a2208f52351e1ada006f4c750c
  md5: c94a5994ef49749880a8139cf9afcbe1
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: GPL-2.0-or-later OR LGPL-3.0-or-later
  size: 460055
  timestamp: 1718980856608
- kind: conda
  name: gmpy2
  version: 2.1.5
  build: py310hc7909c9_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gmpy2-2.1.5-py310hc7909c9_1.conda
  sha256: 5f6c80aeda212c5271c6482d5e9e97e5a2d4bd5c2592df83a5e9d0fff05db259
  md5: c22f487e9f1463c6650c2e37e9193e79
  depends:
  - gmp >=6.3.0,<7.0a0
  - libgcc-ng >=12
  - mpc >=1.3.1,<2.0a0
  - mpfr >=4.2.1,<5.0a0
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: LGPL-3.0-or-later
  license_family: LGPL
  size: 205664
  timestamp: 1715527404968
- kind: conda
  name: gnutls
  version: 3.6.13
  build: h85f3911_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gnutls-3.6.13-h85f3911_1.tar.bz2
  sha256: 6c9307f0fedce2c4d060bba9ac888b300bc0912effab423d67b8e1b661a93305
  md5: 7d1b6fff16c1431d96cb4934938799fd
  depends:
  - libgcc-ng >=7.5.0
  - libstdcxx-ng >=7.5.0
  - nettle >=3.4.1
  - nettle >=3.6,<3.7.0a0
  license: LGPL-2.1-or-later
  license_family: LGPL
  size: 2096527
  timestamp: 1605742597225
- kind: conda
  name: graphite2
  version: 1.3.13
  build: h59595ed_1003
  build_number: 1003
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/graphite2-1.3.13-h59595ed_1003.conda
  sha256: 0595b009f20f8f60f13a6398e7cdcbd2acea5f986633adcf85f5a2283c992add
  md5: f87c7b7c2cb45f323ffbce941c78ab7c
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: LGPL-2.0-or-later
  license_family: LGPL
  size: 96855
  timestamp: 1711634169756
- kind: conda
  name: gst-plugins-base
  version: 1.22.0
  build: h4243ec0_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gst-plugins-base-1.22.0-h4243ec0_2.conda
  sha256: e0f3e53f179440a8cdfd38c0b47d175aa560ff1600d43e15e6a6cbdaa7a01da3
  md5: 0d0c6604c8ac4ad5e51efa7bb58da05c
  depends:
  - __glibc >=2.17,<3.0.a0
  - alsa-lib >=1.2.8,<1.2.9.0a0
  - gettext >=0.21.1,<1.0a0
  - gstreamer 1.22.0 h25f0c4b_2
  - libgcc-ng >=12
  - libglib >=2.74.1,<3.0a0
  - libopus >=1.3.1,<2.0a0
  - libpng >=1.6.39,<1.7.0a0
  - libstdcxx-ng >=12
  - libvorbis >=1.3.7,<1.4.0a0
  - libxcb >=1.13,<1.14.0a0
  - libzlib >=1.2.13,<2.0.0a0
  license: LGPL-2.0-or-later
  license_family: LGPL
  size: 2708542
  timestamp: 1678159510042
- kind: conda
  name: gstreamer
  version: 1.22.0
  build: h25f0c4b_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gstreamer-1.22.0-h25f0c4b_2.conda
  sha256: b60bf8f5cae60d276e26f9de0f03faddc6dd341c910924ffe0f3c1aa7e0852c7
  md5: 461541cb1b387c2a28ab6217f3d38502
  depends:
  - __glibc >=2.17,<3.0.a0
  - gettext >=0.21.1,<1.0a0
  - glib >=2.74.1,<3.0a0
  - libgcc-ng >=12
  - libglib >=2.74.1,<3.0a0
  - libstdcxx-ng >=12
  license: LGPL-2.0-or-later
  license_family: LGPL
  size: 1985068
  timestamp: 1678159402537
- kind: conda
  name: gstreamer-orc
  version: 0.4.39
  build: h4bc722e_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gstreamer-orc-0.4.39-h4bc722e_0.conda
  sha256: 30cff05b87f16bd02874fe97376bc3766aea70bf76ba4c0319fca4c3f539369a
  md5: bd4ba5baa12faaad5ba06d13ee440a04
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  license: BSD-2-Clause AND BSD-3-Clause
  size: 285556
  timestamp: 1721663298189
- kind: conda
  name: gzip
  version: '1.13'
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gzip-1.13-hd590300_0.conda
  sha256: 91583f2d85cded2cd81af17f23464888d53a1f1e3424456ee1befc3f73436d7b
  md5: cb8143aa2e59e9684c41dfdf74af38ac
  depends:
  - libgcc-ng >=12
  license: GPL-3.0-or-later
  license_family: GPL
  size: 97116
  timestamp: 1697579107097
- kind: conda
  name: h11
  version: 0.14.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/h11-0.14.0-pyhd8ed1ab_0.tar.bz2
  sha256: 817d2c77d53afe3f3d9cf7f6eb8745cdd8ea76c7adaa9d7ced75c455a2c2c085
  md5: b21ed0883505ba1910994f1df031a428
  depends:
  - python >=3
  - typing_extensions
  license: MIT
  license_family: MIT
  size: 48251
  timestamp: 1664132995560
- kind: conda
  name: h2
  version: 4.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/h2-4.1.0-pyhd8ed1ab_0.tar.bz2
  sha256: bfc6a23849953647f4e255c782e74a0e18fe16f7e25c7bb0bc57b83bb6762c7a
  md5: b748fbf7060927a6e82df7cb5ee8f097
  depends:
  - hpack >=4.0,<5
  - hyperframe >=6.0,<7
  - python >=3.6.1
  license: MIT
  license_family: MIT
  size: 46754
  timestamp: 1634280590080
- kind: conda
  name: harfbuzz
  version: 6.0.0
  build: h8e241bc_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/harfbuzz-6.0.0-h8e241bc_0.conda
  sha256: f300fcb390253d6d63346ee71e56f82bc830783d1682ac933fe9ac86f39da942
  md5: 448fe40d2fed88ccf4d9ded37cbb2b38
  depends:
  - cairo >=1.16.0,<2.0a0
  - freetype >=2.12.1,<3.0a0
  - graphite2
  - icu >=70.1,<71.0a0
  - libgcc-ng >=12
  - libglib >=2.74.1,<3.0a0
  - libstdcxx-ng >=12
  license: MIT
  license_family: MIT
  size: 1300409
  timestamp: 1671365973953
- kind: conda
  name: hhsuite
  version: 3.3.0
  build: py310pl5321hc31ed2c_12
  build_number: 12
  subdir: linux-64
  url: https://conda.anaconda.org/bioconda/linux-64/hhsuite-3.3.0-py310pl5321hc31ed2c_12.tar.bz2
  sha256: b2b910c55aaa1fb3aca48286a62f3fe1e41f5216eb7692df0a7ea7f9172859bd
  md5: 0746555952ee310bf5ae50fa1b5beea2
  depends:
  - _openmp_mutex >=4.5
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - perl >=5.32.1,<5.33.0a0 *_perl5
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: GPLv3
  size: 28055934
  timestamp: 1720674718182
- kind: conda
  name: hpack
  version: 4.0.0
  build: pyh9f0ad1d_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/hpack-4.0.0-pyh9f0ad1d_0.tar.bz2
  sha256: 5dec948932c4f740674b1afb551223ada0c55103f4c7bf86a110454da3d27cb8
  md5: 914d6646c4dbb1fd3ff539830a12fd71
  depends:
  - python
  license: MIT
  license_family: MIT
  size: 25341
  timestamp: 1598856368685
- kind: conda
  name: httpcore
  version: 1.0.5
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/httpcore-1.0.5-pyhd8ed1ab_0.conda
  sha256: 4025644200eefa0598e4600a66fd4804a57d9fd7054a5c8c45e508fd875e0b84
  md5: a6b9a0158301e697e4d0a36a3d60e133
  depends:
  - anyio >=3.0,<5.0
  - certifi
  - h11 >=0.13,<0.15
  - h2 >=3,<5
  - python >=3.8
  - sniffio 1.*
  license: BSD-3-Clause
  license_family: BSD
  size: 45816
  timestamp: 1711597091407
- kind: conda
  name: httpx
  version: 0.27.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/httpx-0.27.2-pyhd8ed1ab_0.conda
  sha256: 1a33f160548bf447e15c0273899d27e4473f1d5b7ca1441232ec2d9d07c56d03
  md5: 7e9ac3faeebdbd7b53b462c41891e7f7
  depends:
  - anyio
  - certifi
  - httpcore 1.*
  - idna
  - python >=3.8
  - sniffio
  license: BSD-3-Clause
  license_family: BSD
  size: 65085
  timestamp: 1724778453275
- kind: conda
  name: huggingface_hub
  version: 0.17.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/huggingface_hub-0.17.3-pyhd8ed1ab_0.conda
  sha256: 9847287f52cb52ab33bb77959fc5af1a80a1a69139c1b543a24bf9b2b6de5a58
  md5: ec7be5374ac363f63c13bfc7e78144e2
  depends:
  - filelock
  - fsspec
  - packaging >=20.9
  - python >=3.8.0
  - pyyaml >=5.1
  - requests
  - tqdm >=4.42.1
  - typing-extensions >=3.7.4.3
  constrains:
  - pydantic <2.0
  - fastcore >=1.3.27
  - fastai >=2.4
  - InquirerPy ==0.3.4
  license: Apache-2.0
  license_family: APACHE
  size: 194655
  timestamp: 1695757324299
- kind: conda
  name: hydra-core
  version: 1.3.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/hydra-core-1.3.2-pyhd8ed1ab_0.conda
  sha256: 35044b4bb1059c4ed7d8392b776e663a390ad7a2bb6f7e2f09ecd5e9b5d40b75
  md5: 297d09ccdcec5b347d44c88f2b61cf03
  depends:
  - antlr-python-runtime 4.9.*
  - importlib_resources
  - omegaconf >=2.2,<2.4
  - packaging
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 290591
  timestamp: 1677543858686
- kind: conda
  name: hyperframe
  version: 6.0.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/hyperframe-6.0.1-pyhd8ed1ab_0.tar.bz2
  sha256: e374a9d0f53149328134a8d86f5d72bca4c6dcebed3c0ecfa968c02996289330
  md5: 9f765cbfab6870c8435b9eefecd7a1f4
  depends:
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 14646
  timestamp: 1619110249723
- kind: conda
  name: icecream
  version: 2.1.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/icecream-2.1.3-pyhd8ed1ab_0.tar.bz2
  sha256: c63d1f83d7b6577f38c28158533ef4d77c61756f20f7861aecd80136740d2ebb
  md5: 6e9df79dc265bd348b831b41d6c1784d
  depends:
  - asttokens >=2.0.1
  - colorama >=0.3.9
  - executing >=0.3.1
  - pygments >=2.2.0
  - python >=2.7
  license: MIT
  license_family: MIT
  size: 12530
  timestamp: 1658422260428
- kind: conda
  name: icu
  version: '70.1'
  build: h27087fc_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/icu-70.1-h27087fc_0.tar.bz2
  sha256: 1d7950f3be4637ab915d886304e57731d39a41ab705ffc95c4681655c459374a
  md5: 87473a15119779e021c314249d4b4aed
  depends:
  - libgcc-ng >=10.3.0
  - libstdcxx-ng >=10.3.0
  license: MIT
  license_family: MIT
  size: 14191488
  timestamp: 1648050221778
- kind: conda
  name: idna
  version: '3.8'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/idna-3.8-pyhd8ed1ab_0.conda
  sha256: 8660d38b272d3713ec8ac5ae918bc3bc80e1b81e1a7d61df554bded71ada6110
  md5: 99e164522f6bdf23c177c8d9ae63f975
  depends:
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 49275
  timestamp: 1724450633325
- kind: conda
  name: importlib-metadata
  version: 8.4.0
  build: pyha770c72_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/importlib-metadata-8.4.0-pyha770c72_0.conda
  sha256: 02c95f6f62675012e0b2ab945eba6fc14fa6a693c17bced3554db7b62d586f0c
  md5: 6e3dbc422d3749ad72659243d6ac8b2b
  depends:
  - python >=3.8
  - zipp >=0.5
  license: Apache-2.0
  license_family: APACHE
  size: 28338
  timestamp: 1724187329246
- kind: conda
  name: importlib_metadata
  version: 8.4.0
  build: hd8ed1ab_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/importlib_metadata-8.4.0-hd8ed1ab_0.conda
  sha256: c9c782fdf59fb169220b69ea0bbefc3fdc7f58c9fdbdf2d6ff734aa033647b59
  md5: 01b7411c765c3d863dcc920207f258bd
  depends:
  - importlib-metadata >=8.4.0,<8.4.1.0a0
  license: Apache-2.0
  license_family: APACHE
  size: 9292
  timestamp: 1724187331653
- kind: conda
  name: importlib_resources
  version: 6.4.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/importlib_resources-6.4.4-pyhd8ed1ab_0.conda
  sha256: 13e277624eaef453af3ff4d925ba1169376baa7008eabd8eaae7c5772bec9fc2
  md5: 99aa3edd3f452d61c305a30e78140513
  depends:
  - python >=3.8
  - zipp >=3.1.0
  constrains:
  - importlib-resources >=6.4.4,<6.4.5.0a0
  license: Apache-2.0
  license_family: APACHE
  size: 32258
  timestamp: 1724314749050
- kind: conda
  name: ipykernel
  version: 6.29.5
  build: pyh3099207_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ipykernel-6.29.5-pyh3099207_0.conda
  sha256: 33cfd339bb4efac56edf93474b37ddc049e08b1b4930cf036c893cc1f5a1f32a
  md5: b40131ab6a36ac2c09b7c57d4d3fbf99
  depends:
  - __linux
  - comm >=0.1.1
  - debugpy >=1.6.5
  - ipython >=7.23.1
  - jupyter_client >=6.1.12
  - jupyter_core >=4.12,!=5.0.*
  - matplotlib-inline >=0.1
  - nest-asyncio
  - packaging
  - psutil
  - python >=3.8
  - pyzmq >=24
  - tornado >=6.1
  - traitlets >=5.4.0
  license: BSD-3-Clause
  license_family: BSD
  size: 119084
  timestamp: 1719845605084
- kind: conda
  name: ipython
  version: 8.26.0
  build: pyh707e725_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ipython-8.26.0-pyh707e725_0.conda
  sha256: a40c2859a055d98ba234d67b233fb1ba55d86cbe632ec96eecb7c5019c16478b
  md5: f64d3520d5d00321c10f4dabb5b903f3
  depends:
  - __unix
  - decorator
  - exceptiongroup
  - jedi >=0.16
  - matplotlib-inline
  - pexpect >4.3
  - pickleshare
  - prompt-toolkit >=3.0.41,<3.1.0
  - pygments >=2.4.0
  - python >=3.10
  - stack_data
  - traitlets >=5.13.0
  - typing_extensions >=4.6
  license: BSD-3-Clause
  license_family: BSD
  size: 599279
  timestamp: 1719582627972
- kind: conda
  name: ipywidgets
  version: 8.1.5
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ipywidgets-8.1.5-pyhd8ed1ab_0.conda
  sha256: ae27447f300c85a184d5d4fa08674eaa93931c12275daca981eb986f5d7795b3
  md5: a022d34163147d16b27de86dc53e93fc
  depends:
  - comm >=0.1.3
  - ipython >=6.1.0
  - jupyterlab_widgets >=3.0.13,<3.1.0
  - python >=3.7
  - traitlets >=4.3.1
  - widgetsnbextension >=4.0.13,<4.1.0
  license: BSD-3-Clause
  license_family: BSD
  size: 113497
  timestamp: 1724334989324
- kind: conda
  name: isoduration
  version: 20.11.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/isoduration-20.11.0-pyhd8ed1ab_0.tar.bz2
  sha256: 7bb5c4d994361022f47a807b5e7d101b3dce16f7dd8a0af6ffad9f479d346493
  md5: 4cb68948e0b8429534380243d063a27a
  depends:
  - arrow >=0.15.0
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 17189
  timestamp: 1638811664194
- kind: conda
  name: jack
  version: 1.9.22
  build: h11f4161_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jack-1.9.22-h11f4161_0.conda
  sha256: 9f173c6633f7ef049b05cd92a9fc028402972ddc44a56d5bb51d8879d73bbde7
  md5: 504fa9e712b99494a9cf4630e3ca7d78
  depends:
  - alsa-lib >=1.2.8,<1.2.9.0a0
  - libdb >=6.2.32,<6.3.0a0
  - libgcc-ng >=12
  - libopus >=1.3.1,<2.0a0
  - libstdcxx-ng >=12
  license: LGPL-2.0-only
  license_family: LGPL
  size: 463582
  timestamp: 1675358702299
- kind: conda
  name: jax
  version: 0.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jax-0.3.0-pyhd8ed1ab_0.tar.bz2
  sha256: 1908dcc0b89a0e113c1073d91bee11f3faf5f23f7c963d5628242674d39c001b
  md5: b26638fcabe1b5e4aff88f31407ac13a
  depends:
  - absl-py
  - jaxlib >=0.1.74
  - numpy >=1.18
  - opt_einsum
  - python >=3.7
  - scipy >=1.2.1
  - typing_extensions
  license: Apache-2.0
  license_family: APACHE
  size: 766845
  timestamp: 1644532358662
- kind: conda
  name: jaxlib
  version: 0.1.75
  build: py310hb5077e9_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jaxlib-0.1.75-py310hb5077e9_0.tar.bz2
  sha256: 7da3fc3fe0088e19b3928a453c40d4d67eff0a8ad0ad1ee2dc5acc1a5f40e17b
  md5: 8690b3d1f80659d456845562a6b822c1
  depends:
  - absl-py
  - libgcc-ng >=9.4.0
  - libstdcxx-ng >=9.4.0
  - numpy >=1.21.4,<2.0a0
  - python >=3.10,<3.11.0a0
  - python-flatbuffers
  - python_abi 3.10.* *_cp310
  - scipy
  - six
  license: Apache-2.0
  license_family: APACHE
  size: 57360324
  timestamp: 1639133770942
- kind: conda
  name: jedi
  version: 0.19.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jedi-0.19.1-pyhd8ed1ab_0.conda
  sha256: 362f0936ef37dfd1eaa860190e42a6ebf8faa094eaa3be6aa4d9ace95f40047a
  md5: 81a3be0b2023e1ea8555781f0ad904a2
  depends:
  - parso >=0.8.3,<0.9.0
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 841312
  timestamp: 1696326218364
- kind: conda
  name: jinja2
  version: 3.1.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jinja2-3.1.4-pyhd8ed1ab_0.conda
  sha256: 27380d870d42d00350d2d52598cddaf02f9505fb24be09488da0c9b8d1428f2d
  md5: 7b86ecb7d3557821c649b3c31e3eb9f2
  depends:
  - markupsafe >=2.0
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 111565
  timestamp: 1715127275924
- kind: conda
  name: joblib
  version: 1.4.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/joblib-1.4.2-pyhd8ed1ab_0.conda
  sha256: 8ad719524b1039510fcbd75eb776123189d75e2c09228189257ddbcab86f5b64
  md5: 25df261d4523d9f9783bcdb7208d872f
  depends:
  - python >=3.8
  - setuptools
  license: BSD-3-Clause
  license_family: BSD
  size: 219731
  timestamp: 1714665585214
- kind: conda
  name: jpeg
  version: 9e
  build: h166bdaf_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jpeg-9e-h166bdaf_2.tar.bz2
  sha256: 0110ee167e8fe386f9019f98757e299a0c42dc6ccdcce161c9bb552b79e459a3
  md5: ee8b844357a0946870901c7c6f418268
  depends:
  - libgcc-ng >=12
  license: IJG
  size: 275125
  timestamp: 1656500806614
- kind: conda
  name: json5
  version: 0.9.25
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/json5-0.9.25-pyhd8ed1ab_0.conda
  sha256: 0c75e428970e8bb72ba1dd3a6dc32b8d68f6534b4fe16b38e53364963fdc8e38
  md5: 5d8c241a9261e720a34a07a3e1ac4109
  depends:
  - python >=3.7,<4.0
  license: Apache-2.0
  license_family: APACHE
  size: 27995
  timestamp: 1712986338874
- kind: conda
  name: jsonpointer
  version: 3.0.0
  build: py310hff52083_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jsonpointer-3.0.0-py310hff52083_1.conda
  sha256: ac8e92806a5017740b9a1113f0cab8559cd33884867ec7e99b556eb2fa847690
  md5: ce614a01b0aee1b29cee13d606bcb5d5
  depends:
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: BSD-3-Clause
  license_family: BSD
  size: 15658
  timestamp: 1725302992487
- kind: conda
  name: jsonschema
  version: 4.23.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jsonschema-4.23.0-pyhd8ed1ab_0.conda
  sha256: 7d0c4c0346b26be9f220682b7c5c0d84606d48c6dbc36fc238e4452dda733aff
  md5: da304c192ad59975202859b367d0f6a2
  depends:
  - attrs >=22.2.0
  - importlib_resources >=1.4.0
  - jsonschema-specifications >=2023.03.6
  - pkgutil-resolve-name >=1.3.10
  - python >=3.8
  - referencing >=0.28.4
  - rpds-py >=0.7.1
  license: MIT
  license_family: MIT
  size: 74323
  timestamp: 1720529611305
- kind: conda
  name: jsonschema-specifications
  version: 2023.12.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jsonschema-specifications-2023.12.1-pyhd8ed1ab_0.conda
  sha256: a9630556ddc3121c0be32f4cbf792dd9102bd380d5cd81d57759d172cf0c2da2
  md5: a0e4efb5f35786a05af4809a2fb1f855
  depends:
  - importlib_resources >=1.4.0
  - python >=3.8
  - referencing >=0.31.0
  license: MIT
  license_family: MIT
  size: 16431
  timestamp: 1703778502971
- kind: conda
  name: jsonschema-with-format-nongpl
  version: 4.23.0
  build: hd8ed1ab_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/jsonschema-with-format-nongpl-4.23.0-hd8ed1ab_0.conda
  sha256: 007a0a506a0d1805b099629cb0ee743ad0afe7d9749e57339f32c168119e0139
  md5: 16b37612b3a2fd77f409329e213b530c
  depends:
  - fqdn
  - idna
  - isoduration
  - jsonpointer >1.13
  - jsonschema >=4.23.0,<4.23.1.0a0
  - rfc3339-validator
  - rfc3986-validator >0.1.0
  - uri-template
  - webcolors >=24.6.0
  license: MIT
  license_family: MIT
  size: 7143
  timestamp: 1720529619500
- kind: conda
  name: jupyter
  version: 1.1.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter-1.1.1-pyhd8ed1ab_0.conda
  sha256: 5d92eb46552af180cd27a5e916206eb3f6725a0ae3d4bafa7a5f44adfada4332
  md5: 255a8fe52d1c57a6b46d0d16851883db
  depends:
  - ipykernel
  - ipywidgets
  - jupyter_console
  - jupyterlab
  - nbconvert-core
  - notebook
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 8728
  timestamp: 1725037618526
- kind: conda
  name: jupyter-lsp
  version: 2.2.5
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter-lsp-2.2.5-pyhd8ed1ab_0.conda
  sha256: 2151c2c63e0442a4c69ee0ad8a634195eedab10b7b74c0ec8266471842239a93
  md5: 885867f6adab3d7ecdf8ab6ca0785f51
  depends:
  - importlib-metadata >=4.8.3
  - jupyter_server >=1.1.2
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 55539
  timestamp: 1712707521811
- kind: conda
  name: jupyter_client
  version: 8.6.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_client-8.6.2-pyhd8ed1ab_0.conda
  sha256: 634f065cdd1d0aacd4bb6848ebf240dcebc8578135d65f4ad4aa42b2276c4e0c
  md5: 3cdbb2fa84490e5fd44c9f9806c0d292
  depends:
  - importlib_metadata >=4.8.3
  - jupyter_core >=4.12,!=5.0.*
  - python >=3.8
  - python-dateutil >=2.8.2
  - pyzmq >=23.0
  - tornado >=6.2
  - traitlets >=5.3
  license: BSD-3-Clause
  license_family: BSD
  size: 106248
  timestamp: 1716472312833
- kind: conda
  name: jupyter_console
  version: 6.6.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_console-6.6.3-pyhd8ed1ab_0.conda
  sha256: 4e51764d5fe2f6e43d83bcfbcf8b4da6569721bf82eaf4d647be8717cd6be75a
  md5: 7cf6f52a66f8e3cd9d8b6c231262dcab
  depends:
  - ipykernel >=6.14
  - ipython
  - jupyter_client >=7.0.0
  - jupyter_core >=4.12,!=5.0.*
  - prompt_toolkit >=3.0.30
  - pygments
  - python >=3.7
  - pyzmq >=17
  - traitlets >=5.4
  license: BSD-3-Clause
  license_family: BSD
  size: 26484
  timestamp: 1678118234022
- kind: conda
  name: jupyter_core
  version: 5.7.2
  build: py310hff52083_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jupyter_core-5.7.2-py310hff52083_0.conda
  sha256: 837039256d39a249b5bec850f87948e1967c47c9e747056df8155d80c4d3b094
  md5: cb92c27600d5716fd526a206aa43342c
  depends:
  - platformdirs >=2.5
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - traitlets >=5.3
  license: BSD-3-Clause
  license_family: BSD
  size: 79565
  timestamp: 1710257392136
- kind: conda
  name: jupyter_events
  version: 0.10.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_events-0.10.0-pyhd8ed1ab_0.conda
  sha256: cd3f41dc093162a41d4bae171e40a1b9b115c4d488e9bb837a8fa9d084931fb9
  md5: ed45423c41b3da15ea1df39b1f80c2ca
  depends:
  - jsonschema-with-format-nongpl >=4.18.0
  - python >=3.8
  - python-json-logger >=2.0.4
  - pyyaml >=5.3
  - referencing
  - rfc3339-validator
  - rfc3986-validator >=0.1.1
  - traitlets >=5.3
  license: BSD-3-Clause
  license_family: BSD
  size: 21475
  timestamp: 1710805759187
- kind: conda
  name: jupyter_server
  version: 2.14.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_server-2.14.2-pyhd8ed1ab_0.conda
  sha256: edab71a05feceac54bdb90e755a257545af7832b9911607c1a70f09be44ba985
  md5: ca23c71f70a7c7935b3d03f0f1a5801d
  depends:
  - anyio >=3.1.0
  - argon2-cffi >=21.1
  - jinja2 >=3.0.3
  - jupyter_client >=7.4.4
  - jupyter_core >=4.12,!=5.0.*
  - jupyter_events >=0.9.0
  - jupyter_server_terminals >=0.4.4
  - nbconvert-core >=6.4.4
  - nbformat >=5.3.0
  - overrides >=5.0
  - packaging >=22.0
  - prometheus_client >=0.9
  - python >=3.8
  - pyzmq >=24
  - send2trash >=1.8.2
  - terminado >=0.8.3
  - tornado >=6.2.0
  - traitlets >=5.6.0
  - websocket-client >=1.7
  license: BSD-3-Clause
  license_family: BSD
  size: 323978
  timestamp: 1720816754998
- kind: conda
  name: jupyter_server_terminals
  version: 0.5.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_server_terminals-0.5.3-pyhd8ed1ab_0.conda
  sha256: 038efbc7e4b2e72d49ed193cfb2bbbe9fbab2459786ce9350301f466a32567db
  md5: 219b3833aa8ed91d47d1be6ca03f30be
  depends:
  - python >=3.8
  - terminado >=0.8.3
  license: BSD-3-Clause
  license_family: BSD
  size: 19818
  timestamp: 1710262791393
- kind: conda
  name: jupyterlab
  version: 4.2.5
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyterlab-4.2.5-pyhd8ed1ab_0.conda
  sha256: db08036a6fd846c178ebdce7327be1130bda10ac96113c17b04bce2bc4d67dda
  md5: 594762eddc55b82feac6097165a88e3c
  depends:
  - async-lru >=1.0.0
  - httpx >=0.25.0
  - importlib_metadata >=4.8.3
  - importlib_resources >=1.4
  - ipykernel >=6.5.0
  - jinja2 >=3.0.3
  - jupyter-lsp >=2.0.0
  - jupyter_core
  - jupyter_server >=2.4.0,<3
  - jupyterlab_server >=2.27.1,<3
  - notebook-shim >=0.2
  - packaging
  - python >=3.8
  - setuptools >=40.1.0
  - tomli >=1.2.2
  - tornado >=6.2.0
  - traitlets
  license: BSD-3-Clause
  license_family: BSD
  size: 7361961
  timestamp: 1724745262468
- kind: conda
  name: jupyterlab_pygments
  version: 0.3.0
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_pygments-0.3.0-pyhd8ed1ab_1.conda
  sha256: 4aa622bbcf97e44cd1adf0100b7ff71b7e20268f043bdf6feae4d16152f1f242
  md5: afcd1b53bcac8844540358e33f33d28f
  depends:
  - pygments >=2.4.1,<3
  - python >=3.7
  constrains:
  - jupyterlab >=4.0.8,<5.0.0
  license: BSD-3-Clause
  license_family: BSD
  size: 18776
  timestamp: 1707149279640
- kind: conda
  name: jupyterlab_server
  version: 2.27.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_server-2.27.3-pyhd8ed1ab_0.conda
  sha256: a23b26d1a35bccdb91b9232119e5f402624e1e1a252b0e64cc20c6eb5b87cefb
  md5: af8239bf1ba7e8c69b689f780f653488
  depends:
  - babel >=2.10
  - importlib-metadata >=4.8.3
  - jinja2 >=3.0.3
  - json5 >=0.9.0
  - jsonschema >=4.18
  - jupyter_server >=1.21,<3
  - packaging >=21.3
  - python >=3.8
  - requests >=2.31
  constrains:
  - openapi-core >=0.18.0,<0.19.0
  license: BSD-3-Clause
  license_family: BSD
  size: 49355
  timestamp: 1721163412436
- kind: conda
  name: jupyterlab_widgets
  version: 3.0.13
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_widgets-3.0.13-pyhd8ed1ab_0.conda
  sha256: 0e7ec7936d766f39d5a0a8eafc63f5543f488883ad3645246bc22db6d632566e
  md5: ccea946e6dce9f330fbf7fca97fe8de7
  depends:
  - python >=3.7
  constrains:
  - jupyterlab >=3,<5
  license: BSD-3-Clause
  license_family: BSD
  size: 186024
  timestamp: 1724331451102
- kind: conda
  name: keyutils
  version: 1.6.1
  build: h166bdaf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/keyutils-1.6.1-h166bdaf_0.tar.bz2
  sha256: 150c05a6e538610ca7c43beb3a40d65c90537497a4f6a5f4d15ec0451b6f5ebb
  md5: 30186d27e2c9fa62b45fb1476b7200e3
  depends:
  - libgcc-ng >=10.3.0
  license: LGPL-2.1-or-later
  size: 117831
  timestamp: 1646151697040
- kind: conda
  name: kiwisolver
  version: 1.4.5
  build: py310hd41b1e2_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/kiwisolver-1.4.5-py310hd41b1e2_1.conda
  sha256: bb51906639bced3de1d4d7740ac284cdaa89e2f22e0b1ec796378b090b0648ba
  md5: b8d67603d43b23ce7e988a5d81a7ab79
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: BSD-3-Clause
  license_family: BSD
  size: 73123
  timestamp: 1695380074542
- kind: conda
  name: krb5
  version: 1.20.1
  build: h81ceb04_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/krb5-1.20.1-h81ceb04_0.conda
  sha256: 51a346807ce981e1450eb04c3566415b05eed705bc9e6c98c198ec62367b7c62
  md5: 89a41adce7106749573d883b2f657d78
  depends:
  - keyutils >=1.6.1,<2.0a0
  - libedit >=3.1.20191231,<3.2.0a0
  - libedit >=3.1.20191231,<4.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - openssl >=3.0.7,<4.0a0
  license: MIT
  license_family: MIT
  size: 1329877
  timestamp: 1671091750695
- kind: conda
  name: lame
  version: '3.100'
  build: h166bdaf_1003
  build_number: 1003
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/lame-3.100-h166bdaf_1003.tar.bz2
  sha256: aad2a703b9d7b038c0f745b853c6bb5f122988fe1a7a096e0e606d9cbec4eaab
  md5: a8832b479f93521a9e7b5b743803be51
  depends:
  - libgcc-ng >=12
  license: LGPL-2.0-only
  license_family: LGPL
  size: 508258
  timestamp: 1664996250081
- kind: conda
  name: lcms2
  version: '2.15'
  build: hfd0df8a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/lcms2-2.15-hfd0df8a_0.conda
  sha256: 443e926b585528112ec6aa4d85bf087722914ed8d85a2f75ae47c023c55c4238
  md5: aa8840cdf17ef0c6084d1e24abc7a28b
  depends:
  - jpeg >=9e,<10a
  - libgcc-ng >=12
  - libtiff >=4.5.0,<4.6.0a0
  license: MIT
  license_family: MIT
  size: 240794
  timestamp: 1678211140434
- kind: conda
  name: ld_impl_linux-64
  version: '2.40'
  build: hf3520f5_7
  build_number: 7
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ld_impl_linux-64-2.40-hf3520f5_7.conda
  sha256: 764b6950aceaaad0c67ef925417594dd14cd2e22fff864aeef455ac259263d15
  md5: b80f2f396ca2c28b8c14c437a4ed1e74
  constrains:
  - binutils_impl_linux-64 2.40
  license: GPL-3.0-only
  license_family: GPL
  size: 707602
  timestamp: 1718625640445
- kind: conda
  name: lerc
  version: 4.0.0
  build: h27087fc_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/lerc-4.0.0-h27087fc_0.tar.bz2
  sha256: cb55f36dcd898203927133280ae1dc643368af041a48bcf7c026acb7c47b0c12
  md5: 76bbff344f0134279f225174e9064c8f
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: Apache-2.0
  license_family: Apache
  size: 281798
  timestamp: 1657977462600
- kind: conda
  name: libabseil
  version: '20240116.2'
  build: cxx17_he02047a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libabseil-20240116.2-cxx17_he02047a_1.conda
  sha256: 945396726cadae174a661ce006e3f74d71dbd719219faf7cc74696b267f7b0b5
  md5: c48fc56ec03229f294176923c3265c05
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  constrains:
  - abseil-cpp =20240116.2
  - libabseil-static =20240116.2=cxx17*
  license: Apache-2.0
  license_family: Apache
  size: 1264712
  timestamp: 1720857377573
- kind: conda
  name: libasprintf
  version: 0.22.5
  build: he8f35ee_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libasprintf-0.22.5-he8f35ee_3.conda
  sha256: 2da5c735811cbf38c7f7844ab457ff8b25046bbf5fe5ebd5dc1c2fafdf4fbe1c
  md5: 4fab9799da9571266d05ca5503330655
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: LGPL-2.1-or-later
  size: 42817
  timestamp: 1723626012203
- kind: conda
  name: libasprintf-devel
  version: 0.22.5
  build: he8f35ee_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libasprintf-devel-0.22.5-he8f35ee_3.conda
  sha256: ccc7967e298ddf3124c8ad9741c7180dc6f778ae4135ec87978214f7b3c64dc2
  md5: 1091193789bb830127ed067a9e01ac57
  depends:
  - __glibc >=2.17,<3.0.a0
  - libasprintf 0.22.5 he8f35ee_3
  - libgcc-ng >=12
  license: LGPL-2.1-or-later
  size: 34172
  timestamp: 1723626026096
- kind: conda
  name: libblas
  version: 3.9.0
  build: 1_h86c2bf4_netlib
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libblas-3.9.0-1_h86c2bf4_netlib.tar.bz2
  sha256: c95bf82fbf258350d5f61c653a1a14d2e1cca7302bb348cc8347caa84e7ac9b1
  md5: 91273b91f1023d5c72ffc79e02e7812e
  depends:
  - libgcc-ng >=9.3.0
  - libgfortran-ng
  - libgfortran5 >=9.3.0
  track_features:
  - blas_netlib
  license: BSD-3-Clause
  license_family: BSD
  size: 203305
  timestamp: 1603052017387
- kind: conda
  name: libbrotlicommon
  version: 1.1.0
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libbrotlicommon-1.1.0-hd590300_1.conda
  sha256: 40f29d1fab92c847b083739af86ad2f36d8154008cf99b64194e4705a1725d78
  md5: aec6c91c7371c26392a06708a73c70e5
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 69403
  timestamp: 1695990007212
- kind: conda
  name: libbrotlidec
  version: 1.1.0
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libbrotlidec-1.1.0-hd590300_1.conda
  sha256: 86fc861246fbe5ad85c1b6b3882aaffc89590a48b42d794d3d5c8e6d99e5f926
  md5: f07002e225d7a60a694d42a7bf5ff53f
  depends:
  - libbrotlicommon 1.1.0 hd590300_1
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 32775
  timestamp: 1695990022788
- kind: conda
  name: libbrotlienc
  version: 1.1.0
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libbrotlienc-1.1.0-hd590300_1.conda
  sha256: f751b8b1c4754a2a8dfdc3b4040fa7818f35bbf6b10e905a47d3a194b746b071
  md5: 5fc11c6020d421960607d821310fcd4d
  depends:
  - libbrotlicommon 1.1.0 hd590300_1
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 282523
  timestamp: 1695990038302
- kind: conda
  name: libcap
  version: '2.67'
  build: he9d0100_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcap-2.67-he9d0100_0.conda
  sha256: 4dcf2290b9b90ad2654fbfff52e9c1d49885ce71f0bb853520e2b9d54809605b
  md5: d05556c80caffff164d17bdea0105a1a
  depends:
  - attr >=2.5.1,<2.6.0a0
  - libgcc-ng >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 99032
  timestamp: 1675412183349
- kind: conda
  name: libcblas
  version: 3.9.0
  build: 6_ha36c22a_netlib
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcblas-3.9.0-6_ha36c22a_netlib.conda
  sha256: 06179b81a465fc926a1ee33e03581617b4b8ad832046a0d48b8bfe6428f42d0b
  md5: 6a3b5e0412437b7269a787cea144cc0c
  depends:
  - libblas 3.9.0.*
  - libgcc-ng >=12
  - libgfortran-ng
  - libgfortran5 >=12.3.0
  track_features:
  - blas_netlib
  license: BSD-3-Clause
  license_family: BSD
  size: 52182
  timestamp: 1719209194230
- kind: conda
  name: libclang
  version: 15.0.7
  build: default_h127d8a8_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libclang-15.0.7-default_h127d8a8_5.conda
  sha256: 606b79c8a4a926334191d79f4a1447aac1d82c43344e3a603cbba31ace859b8f
  md5: 09b94dd3a7e304df5b83176239347920
  depends:
  - libclang13 15.0.7 default_h5d6823c_5
  - libgcc-ng >=12
  - libllvm15 >=15.0.7,<15.1.0a0
  - libstdcxx-ng >=12
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 133467
  timestamp: 1711064002817
- kind: conda
  name: libclang13
  version: 15.0.7
  build: default_h5d6823c_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libclang13-15.0.7-default_h5d6823c_5.conda
  sha256: 91ecfcf545a5d4588e9fad5db2b5b04eeef18cae1c03b790829ef8b978f06ccd
  md5: 2d694a9ffdcc30e89dea34a8dcdab6ae
  depends:
  - libgcc-ng >=12
  - libllvm15 >=15.0.7,<15.1.0a0
  - libstdcxx-ng >=12
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 9583734
  timestamp: 1711063939856
- kind: conda
  name: libcublas
  version: 12.1.0.26
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcublas-12.1.0.26-0.tar.bz2
  sha256: d269774ee934885d43c13464ffa8cec69440868c85a993b906bce56f8de203ae
  md5: 74f872929a02e01ef746a064fa46a80c
  size: 344950844
  timestamp: 1675918695837
- kind: conda
  name: libcublas-dev
  version: 12.1.0.26
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcublas-dev-12.1.0.26-0.tar.bz2
  sha256: c341858c1bf168676d1747d1142a0173f1b72d76b3dd33f39e844b94cfe46004
  md5: 41600d150d936797554be8c9ecec7570
  depends:
  - libcublas >=12.1.0.26
  size: 75704
  timestamp: 1675918825584
- kind: conda
  name: libcublas-static
  version: 12.1.0.26
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcublas-static-12.1.0.26-0.tar.bz2
  sha256: 908acc2b6c539936e6d80a141906689e4ac9014e71bc7d714f913363f4e5be7b
  md5: 7c444bf26c91e38b982c36b79b99f4a5
  depends:
  - libcublas-dev >=12.1.0.26
  size: 372378636
  timestamp: 1675918828279
- kind: conda
  name: libcufft
  version: 11.0.2.4
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcufft-11.0.2.4-0.tar.bz2
  sha256: 56936216c0abaa8a8ef46fa0be89f0c9066b8fd439b7bcab7f6c5a3c465670fc
  md5: b53f7ea28a363eb6d218bcbffb9d26aa
  size: 107875277
  timestamp: 1674621809610
- kind: conda
  name: libcufft-dev
  version: 11.0.2.4
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcufft-dev-11.0.2.4-0.tar.bz2
  sha256: c7bd092a0f0e2c50988bba4e1d9a4e4162e397b55643a57c1a6780eb5bda26e2
  md5: 495aa4c22b1310d07ed07dd50b9d5ba6
  depends:
  - libcufft >=11.0.2.4
  size: 14156
  timestamp: 1674621848934
- kind: conda
  name: libcufft-static
  version: 11.0.2.4
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcufft-static-11.0.2.4-0.tar.bz2
  sha256: 06a15fac153439b857edd355b99e5ec98c092a8a3ca7322da50016df65afd16a
  md5: 7323b57af26d737d4d45b7b7b011e9e0
  depends:
  - libcufft-dev >=11.0.2.4
  size: 199248500
  timestamp: 1674621850290
- kind: conda
  name: libcufile
  version: 1.9.1.3
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcufile-1.9.1.3-0.tar.bz2
  sha256: e820395b70a93832a3a8625c637d89c512e18b2158e43f982a74cfe05e168b60
  md5: 9cfc0beef98713d3be47f934251b5154
  size: 1056458
  timestamp: 1710365909934
- kind: conda
  name: libcufile-dev
  version: 1.9.1.3
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcufile-dev-1.9.1.3-0.tar.bz2
  sha256: c01420a94058ba58aa19d8dc07e99243ded68b424fd82e73ad0da12ef5a4c037
  md5: aed936244622103d2ca59a308ff0f421
  depends:
  - libcufile >=1.9.1.3
  size: 14955
  timestamp: 1710365923835
- kind: conda
  name: libcufile-static
  version: 1.9.1.3
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcufile-static-1.9.1.3-0.tar.bz2
  sha256: ae87b81f66a9c07584491d85a5e85483f3d44e870ccbced9729b82a67659b7ae
  md5: e87c66c78fc6406fec58301c7b0676d6
  depends:
  - libcufile-dev >=1.9.1.3
  size: 3793223
  timestamp: 1710365924278
- kind: conda
  name: libcups
  version: 2.3.3
  build: h36d4200_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcups-2.3.3-h36d4200_3.conda
  sha256: 0ccd610207807f53328f137b2adc99c413f8e1dcd1302f0325412796a94eaaf7
  md5: c9f4416a34bc91e0eb029f912c68f81f
  depends:
  - krb5 >=1.20.1,<1.21.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: Apache-2.0
  license_family: Apache
  size: 4519779
  timestamp: 1671148111233
- kind: conda
  name: libcurand
  version: 10.3.5.147
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcurand-10.3.5.147-0.tar.bz2
  sha256: cb15f89cfb48e735d93b0c96c81b36dd05c9b23f0d0228677016d5042bb6a928
  md5: e9406bdc4209f8cd5fdb40c8df41d3d9
  size: 54279240
  timestamp: 1710543564823
- kind: conda
  name: libcurand-dev
  version: 10.3.5.147
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcurand-dev-10.3.5.147-0.tar.bz2
  sha256: 8ab901ab07a45f37cf4a77f2fcc7ae92ec65de386afe9fe512452685e5a0293f
  md5: 3f0b52f4076c3d8c857664629319f1cf
  depends:
  - libcurand >=10.3.5.147
  size: 460690
  timestamp: 1710543587166
- kind: conda
  name: libcurand-static
  version: 10.3.5.147
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcurand-static-10.3.5.147-0.tar.bz2
  sha256: 7886e6bf30d36cc2f6b13034d4a1a7554384d378a9e80d530a302429e09518c0
  md5: f79397a11ae6036c79e346e5ba086d8d
  depends:
  - libcurand-dev >=10.3.5.147
  size: 54536748
  timestamp: 1710543588181
- kind: conda
  name: libcusolver
  version: 11.4.4.55
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcusolver-11.4.4.55-0.tar.bz2
  sha256: bdd75eaf46b00ec5c22401b33a8bf428ecbf1d3afa3034cfb0f5a270bae588fc
  md5: 2d2fe4a7af91ec8a1eee7f1f0cf7b050
  size: 103066878
  timestamp: 1674623229451
- kind: conda
  name: libcusolver-dev
  version: 11.4.4.55
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcusolver-dev-11.4.4.55-0.tar.bz2
  sha256: 1e334ba98f1f0037b1ebb54e0e1498a3e395f557634b2094ade3b9cbcf05fe89
  md5: 6609c0761e659b5624211b929593b15a
  depends:
  - libcusolver >=11.4.4.55
  size: 50897
  timestamp: 1674623297445
- kind: conda
  name: libcusolver-static
  version: 11.4.4.55
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcusolver-static-11.4.4.55-0.tar.bz2
  sha256: 0ded7f43e959f5d624e66c660e1d8723d3a90815c053fd15a58717e0a060acf9
  md5: 2f621ffa78fef4d9c8759a335f9fb7ab
  depends:
  - libcusolver-dev >=11.4.4.55
  size: 67147563
  timestamp: 1674623299476
- kind: conda
  name: libcusparse
  version: 12.0.2.55
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcusparse-12.0.2.55-0.tar.bz2
  sha256: 0f21ec4d7d31640816b3bd76c9028dfe5e5d75265c65b6a359535f7b7fc66e1c
  md5: c295ea64ea0654af0cbe833431de6daa
  size: 170873896
  timestamp: 1674620869487
- kind: conda
  name: libcusparse-dev
  version: 12.0.2.55
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcusparse-dev-12.0.2.55-0.tar.bz2
  sha256: 912485d1c8c12c5d66553ebaaec4bc543ffffd2da57857a18ec7b5caf7186165
  md5: f4b1cb0bdeabd4269a43fca8a762f0a2
  depends:
  - libcusparse >=12.0.2.55
  size: 170560392
  timestamp: 1674620926274
- kind: conda
  name: libcusparse-static
  version: 12.0.2.55
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libcusparse-static-12.0.2.55-0.tar.bz2
  sha256: dd6cf5cb9ec26e18aef2754bce78ef981a36c5a69b22cc0c3cfa1fda46ac413f
  md5: f5c4e451f9981d9c6657f6ac7d42e684
  depends:
  - libcusparse-dev >=12.0.2.55
  size: 177372905
  timestamp: 1674620980614
- kind: conda
  name: libdb
  version: 6.2.32
  build: h9c3ff4c_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libdb-6.2.32-h9c3ff4c_0.tar.bz2
  sha256: 21fac1012ff05b131d4b5d284003dbbe7b5c4c652aa9e401b46279ed5a784372
  md5: 3f3258d8f841fbac63b36b75bdac1afd
  depends:
  - libgcc-ng >=9.3.0
  - libstdcxx-ng >=9.3.0
  license: AGPL-3.0-only
  license_family: AGPL
  size: 24409456
  timestamp: 1609539093147
- kind: conda
  name: libdeflate
  version: '1.17'
  build: h0b41bf4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libdeflate-1.17-h0b41bf4_0.conda
  sha256: f9983a8ea03531f2c14bce76c870ca325c0fddf0c4e872bff1f78bc52624179c
  md5: 5cc781fd91968b11a8a7fdbee0982676
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 65017
  timestamp: 1673785897585
- kind: conda
  name: libedit
  version: 3.1.20191231
  build: he28a2e2_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libedit-3.1.20191231-he28a2e2_2.tar.bz2
  sha256: a57d37c236d8f7c886e01656f4949d9dcca131d2a0728609c6f7fa338b65f1cf
  md5: 4d331e44109e3f0e19b4cb8f9b82f3e1
  depends:
  - libgcc-ng >=7.5.0
  - ncurses >=6.2,<7.0.0a0
  license: BSD-2-Clause
  license_family: BSD
  size: 123878
  timestamp: 1597616541093
- kind: conda
  name: libevent
  version: 2.1.10
  build: h28343ad_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libevent-2.1.10-h28343ad_4.tar.bz2
  sha256: 31ac7124c92628cd1c6bea368e38d7f43f8ec68d88128ecdc177773e6d00c60a
  md5: 4a049fc560e00e43151dc51368915fdd
  depends:
  - libgcc-ng >=9.4.0
  - openssl >=3.0.0,<4.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 1169108
  timestamp: 1633489266107
- kind: conda
  name: libexpat
  version: 2.6.2
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libexpat-2.6.2-h59595ed_0.conda
  sha256: 331bb7c7c05025343ebd79f86ae612b9e1e74d2687b8f3179faec234f986ce19
  md5: e7ba12deb7020dd080c6c70e7b6f6a3d
  depends:
  - libgcc-ng >=12
  constrains:
  - expat 2.6.2.*
  license: MIT
  license_family: MIT
  size: 73730
  timestamp: 1710362120304
- kind: conda
  name: libffi
  version: 3.4.2
  build: h7f98852_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libffi-3.4.2-h7f98852_5.tar.bz2
  sha256: ab6e9856c21709b7b517e940ae7028ae0737546122f83c2aa5d692860c3b149e
  md5: d645c6d2ac96843a2bfaccd2d62b3ac3
  depends:
  - libgcc-ng >=9.4.0
  license: MIT
  license_family: MIT
  size: 58292
  timestamp: 1636488182923
- kind: conda
  name: libflac
  version: 1.4.3
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libflac-1.4.3-h59595ed_0.conda
  sha256: 65908b75fa7003167b8a8f0001e11e58ed5b1ef5e98b96ab2ba66d7c1b822c7d
  md5: ee48bf17cc83a00f59ca1494d5646869
  depends:
  - gettext >=0.21.1,<1.0a0
  - libgcc-ng >=12
  - libogg 1.3.*
  - libogg >=1.3.4,<1.4.0a0
  - libstdcxx-ng >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 394383
  timestamp: 1687765514062
- kind: conda
  name: libgcc
  version: 14.1.0
  build: h77fa898_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgcc-14.1.0-h77fa898_1.conda
  sha256: 10fa74b69266a2be7b96db881e18fa62cfa03082b65231e8d652e897c4b335a3
  md5: 002ef4463dd1e2b44a94a4ace468f5d2
  depends:
  - _libgcc_mutex 0.1 conda_forge
  - _openmp_mutex >=4.5
  constrains:
  - libgomp 14.1.0 h77fa898_1
  - libgcc-ng ==14.1.0=*_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 846380
  timestamp: 1724801836552
- kind: conda
  name: libgcc-ng
  version: 14.1.0
  build: h69a702a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgcc-ng-14.1.0-h69a702a_1.conda
  sha256: b91f7021e14c3d5c840fbf0dc75370d6e1f7c7ff4482220940eaafb9c64613b7
  md5: 1efc0ad219877a73ef977af7dbb51f17
  depends:
  - libgcc 14.1.0 h77fa898_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 52170
  timestamp: 1724801842101
- kind: conda
  name: libgcrypt
  version: 1.11.0
  build: h4ab18f5_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgcrypt-1.11.0-h4ab18f5_1.conda
  sha256: 9e97e4a753d2ee238cfc7375f0882830f0d8c1667431bc9d070a0f6718355570
  md5: 14858a47d4cc995892e79f2b340682d7
  depends:
  - libgcc-ng >=12
  - libgpg-error >=1.50,<2.0a0
  license: LGPL-2.1-or-later AND GPL-2.0-or-later
  license_family: GPL
  size: 684307
  timestamp: 1721392291497
- kind: conda
  name: libgettextpo
  version: 0.22.5
  build: he02047a_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgettextpo-0.22.5-he02047a_3.conda
  sha256: 7f2d1f4d69973e2c3c3d2b6420d5eb989982baba97d63ab2d7a2b25a92d886b4
  md5: efab66b82ec976930b96d62a976de8e7
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  license: GPL-3.0-or-later
  license_family: GPL
  size: 170646
  timestamp: 1723626019265
- kind: conda
  name: libgettextpo-devel
  version: 0.22.5
  build: he02047a_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgettextpo-devel-0.22.5-he02047a_3.conda
  sha256: 0a66cdd46d1cd5201061252535cd91905b3222328a9294c1a5bcd32e85531545
  md5: 9aba7960731e6b4547b3a52f812ed801
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - libgettextpo 0.22.5 he02047a_3
  license: GPL-3.0-or-later
  license_family: GPL
  size: 36790
  timestamp: 1723626032786
- kind: conda
  name: libgfortran-ng
  version: 14.1.0
  build: h69a702a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgfortran-ng-14.1.0-h69a702a_0.conda
  sha256: ef624dacacf97b2b0af39110b36e2fd3e39e358a1a6b7b21b85c9ac22d8ffed9
  md5: f4ca84fbd6d06b0a052fb2d5b96dde41
  depends:
  - libgfortran5 14.1.0 hc5f4f2c_0
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 49893
  timestamp: 1719538933879
- kind: conda
  name: libgfortran5
  version: 14.1.0
  build: hc5f4f2c_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgfortran5-14.1.0-hc5f4f2c_0.conda
  sha256: a67d66b1e60a8a9a9e4440cee627c959acb4810cb182e089a4b0729bfdfbdf90
  md5: 6456c2620c990cd8dde2428a27ba0bc5
  depends:
  - libgcc-ng >=14.1.0
  constrains:
  - libgfortran-ng 14.1.0
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 1457561
  timestamp: 1719538909168
- kind: conda
  name: libglib
  version: 2.80.2
  build: hf974151_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libglib-2.80.2-hf974151_0.conda
  sha256: 93e03b6cf4765bc06d64fa3dac65f22c53ae4a30247bb0e2dea0bd9c47a3fb26
  md5: 72724f6a78ecb15559396966226d5838
  depends:
  - libffi >=3.4,<4.0a0
  - libgcc-ng >=12
  - libiconv >=1.17,<2.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - pcre2 >=10.43,<10.44.0a0
  constrains:
  - glib 2.80.2 *_0
  license: LGPL-2.1-or-later
  size: 3912673
  timestamp: 1715252654366
- kind: conda
  name: libgpg-error
  version: '1.50'
  build: h4f305b6_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgpg-error-1.50-h4f305b6_0.conda
  sha256: c60969d5c315f33fee90a1f2dd5d169e2834ace5a55f5a6f822aa7485a3a84cc
  md5: 0d7ff1a8e69565ca3add6925e18e708f
  depends:
  - gettext
  - libasprintf >=0.22.5,<1.0a0
  - libgcc-ng >=12
  - libgettextpo >=0.22.5,<1.0a0
  - libstdcxx-ng >=12
  license: GPL-2.0-only
  license_family: GPL
  size: 273774
  timestamp: 1719390736440
- kind: conda
  name: libhwloc
  version: 2.9.1
  build: hd6dc26d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libhwloc-2.9.1-hd6dc26d_0.conda
  sha256: 39bb53aa6ae0cab734568a58ad31ffe82ea244a82f575cd5c67abba785e442ee
  md5: a3ede1b8e47f993ff1fe3908b23bb307
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxml2 >=2.10.3,<3.0.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 2569104
  timestamp: 1680713440274
- kind: conda
  name: libiconv
  version: '1.17'
  build: hd590300_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libiconv-1.17-hd590300_2.conda
  sha256: 8ac2f6a9f186e76539439e50505d98581472fedb347a20e7d1f36429849f05c9
  md5: d66573916ffcf376178462f1b61c941e
  depends:
  - libgcc-ng >=12
  license: LGPL-2.1-only
  size: 705775
  timestamp: 1702682170569
- kind: conda
  name: libjpeg-turbo
  version: 2.0.0
  build: h9bf148f_0
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/libjpeg-turbo-2.0.0-h9bf148f_0.tar.bz2
  sha256: 96e434e701013bc8bfc3c6414557a4af5d82f0da79a4f54d3485c394a59c0d2a
  md5: 0b3e9c9b60b181ed49c99c115fcab898
  depends:
  - libgcc-ng >=11.2.0
  license: IJG, modified 3-clause BSD and zlib
  size: 973037
  timestamp: 1686617972557
- kind: conda
  name: liblapack
  version: 3.9.0
  build: 6_ha36c22a_netlib
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/liblapack-3.9.0-6_ha36c22a_netlib.conda
  sha256: c8a288a2727d3f1a4161d68bb79501540c154e5710956958effc497b8ab123bc
  md5: fe07396c3775ef919d596359ccc566e7
  depends:
  - libblas 3.9.0.*
  - libgcc-ng >=12
  - libgfortran-ng
  - libgfortran5 >=12.3.0
  track_features:
  - blas_netlib
  license: BSD-3-Clause
  license_family: BSD
  size: 2758682
  timestamp: 1719209202374
- kind: conda
  name: libllvm15
  version: 15.0.7
  build: hadd5161_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libllvm15-15.0.7-hadd5161_1.conda
  sha256: f649fac60cb122bf0d85c4955725d94c353fdbd768bcd44f0444979b363cc9ab
  md5: 17d91085ccf5934ce652cb448d0cb65a
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxml2 >=2.10.3,<3.0.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - zstd >=1.5.2,<1.6.0a0
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 33016652
  timestamp: 1678862492181
- kind: conda
  name: libnpp
  version: 12.0.2.50
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnpp-12.0.2.50-0.tar.bz2
  sha256: 88f3813a1b1e4599b9e758c1db9eb3981c8e75a505b6a1a29749a1d997913277
  md5: 072e390c1e0e4909bdd7508dd6af1474
  size: 146548459
  timestamp: 1675314920197
- kind: conda
  name: libnpp-dev
  version: 12.0.2.50
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnpp-dev-12.0.2.50-0.tar.bz2
  sha256: 5668ebeadfb68ad5a5bef11e759f81b18b3356f6814ea72e0c1dbc69939e9069
  md5: 82198411e06b54727a4faf94fb5c4711
  depends:
  - libnpp >=12.0.2.50
  size: 524685
  timestamp: 1675314970741
- kind: conda
  name: libnpp-static
  version: 12.0.2.50
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnpp-static-12.0.2.50-0.tar.bz2
  sha256: 3db8a7b87e14b847bdcef6242aee3791c4774ac48dc3d52cbe8dd605402b2754
  md5: 9a1fa7617d5ad4e9bcad587538c64f67
  depends:
  - libnpp-dev >=12.0.2.50
  size: 142835164
  timestamp: 1675314973455
- kind: conda
  name: libnsl
  version: 2.0.1
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libnsl-2.0.1-hd590300_0.conda
  sha256: 26d77a3bb4dceeedc2a41bd688564fe71bf2d149fdcf117049970bc02ff1add6
  md5: 30fd6e37fe21f86f4bd26d6ee73eeec7
  depends:
  - libgcc-ng >=12
  license: LGPL-2.1-only
  license_family: GPL
  size: 33408
  timestamp: 1697359010159
- kind: conda
  name: libnvfatbin
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvfatbin-12.4.127-0.tar.bz2
  sha256: 9521855837d1463bf616818061822696e2c7eb8fb81b3515c24e4a65031dddb5
  md5: 87530433a48cf2cf5385ba5d40630b77
  size: 876527
  timestamp: 1710544187837
- kind: conda
  name: libnvfatbin-dev
  version: 12.4.127
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvfatbin-dev-12.4.127-0.tar.bz2
  sha256: 0b9f8c1ceaf780fccd6fbfada17b0905832fc2b861b119fdd66f7e3995e75c6f
  md5: 528d384524d9edf2af48102c02177958
  depends:
  - libnvfatbin >=12.4.127
  size: 701923
  timestamp: 1710544188897
- kind: conda
  name: libnvjitlink
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvjitlink-12.1.105-0.tar.bz2
  sha256: d9c56634049b45e5e1c1fb9b1c451378c6853490112d38f3325309575807ad15
  md5: 0155acf6f5117613ba17c65d9be4f2f1
  size: 17767798
  timestamp: 1680582102565
- kind: conda
  name: libnvjitlink-dev
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvjitlink-dev-12.1.105-0.tar.bz2
  sha256: ced2fa2fab60606c4d3ddfa5ba6d33394a439672964f206d3fde21380657f1c2
  md5: 9c7cca7e603be28b51c6ec5011478359
  depends:
  - libnvjitlink >=12.1.105
  size: 15163598
  timestamp: 1680582110615
- kind: conda
  name: libnvjpeg
  version: 12.1.1.14
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvjpeg-12.1.1.14-0.tar.bz2
  sha256: 8d06c6cf389011278fe912a20297c01f445ce68f69b3bd95199b6afe85de2981
  md5: 4dea93d43adfd03388b31f2ae9892558
  size: 3066598
  timestamp: 1682909013527
- kind: conda
  name: libnvjpeg-dev
  version: 12.1.1.14
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvjpeg-dev-12.1.1.14-0.tar.bz2
  sha256: 570dad0162274296a961283c287494c76b90dd16b8d520d9cc1583d9b8c89d58
  md5: fceb4d4ef73aa88beac4899b61c8371e
  depends:
  - libnvjpeg >=12.1.1.14
  size: 12922
  timestamp: 1682909016008
- kind: conda
  name: libnvjpeg-static
  version: 12.1.1.14
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvjpeg-static-12.1.1.14-0.tar.bz2
  sha256: 62ee2034c2a5ad9d2aece9f0b2496e1e020e1f230d2dbf665ae22cf6d5db63f1
  md5: 19663e234cc7fe2d79f4f7a133b1b0de
  depends:
  - libnvjpeg-dev >=12.1.1.14
  size: 2705742
  timestamp: 1682909016469
- kind: conda
  name: libnvvm-samples
  version: 12.1.105
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/libnvvm-samples-12.1.105-0.tar.bz2
  sha256: dd26e30a17f26597c9389201df90e134a4f13d6c1e48abd93b430f57fc51b88b
  md5: 50b049790eb60933f1dc99a88b3ea1ed
  size: 33128
  timestamp: 1680570936371
- kind: conda
  name: libogg
  version: 1.3.5
  build: h4ab18f5_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libogg-1.3.5-h4ab18f5_0.conda
  sha256: 5eda3fe92b99b25dd4737226a9485078ab405672d9f621be75edcb68f1e9026d
  md5: 601bfb4b3c6f0b844443bb81a56651e0
  depends:
  - libgcc-ng >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 205914
  timestamp: 1719301575771
- kind: conda
  name: libopus
  version: 1.3.1
  build: h7f98852_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libopus-1.3.1-h7f98852_1.tar.bz2
  sha256: 0e1c2740ebd1c93226dc5387461bbcf8142c518f2092f3ea7551f77755decc8f
  md5: 15345e56d527b330e1cacbdf58676e8f
  depends:
  - libgcc-ng >=9.3.0
  license: BSD-3-Clause
  license_family: BSD
  size: 260658
  timestamp: 1606823578035
- kind: conda
  name: libpng
  version: 1.6.43
  build: h2797004_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libpng-1.6.43-h2797004_0.conda
  sha256: 502f6ff148ac2777cc55ae4ade01a8fc3543b4ffab25c4e0eaa15f94e90dd997
  md5: 009981dd9cfcaa4dbfa25ffaed86bcae
  depends:
  - libgcc-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: zlib-acknowledgement
  size: 288221
  timestamp: 1708780443939
- kind: conda
  name: libpq
  version: '15.3'
  build: hbcd7760_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libpq-15.3-hbcd7760_1.conda
  sha256: 96031c853d1a8b32c50c04b791aa199508ab1f0fa879ab7fcce175ee24620f78
  md5: 8afb2a97d256ffde95b91a6283bc598c
  depends:
  - krb5 >=1.20.1,<1.21.0a0
  - libgcc-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - openssl >=3.1.0,<3.2.0a0
  license: PostgreSQL
  size: 2530642
  timestamp: 1684451981378
- kind: conda
  name: libsndfile
  version: 1.2.2
  build: hc60ed4a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsndfile-1.2.2-hc60ed4a_1.conda
  sha256: f709cbede3d4f3aee4e2f8d60bd9e256057f410bd60b8964cb8cf82ec1457573
  md5: ef1910918dd895516a769ed36b5b3a4e
  depends:
  - lame >=3.100,<3.101.0a0
  - libflac >=1.4.3,<1.5.0a0
  - libgcc-ng >=12
  - libogg >=1.3.4,<1.4.0a0
  - libopus >=1.3.1,<2.0a0
  - libstdcxx-ng >=12
  - libvorbis >=1.3.7,<1.4.0a0
  - mpg123 >=1.32.1,<1.33.0a0
  license: LGPL-2.1-or-later
  license_family: LGPL
  size: 354372
  timestamp: 1695747735668
- kind: conda
  name: libsodium
  version: 1.0.18
  build: h36c2ea0_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsodium-1.0.18-h36c2ea0_1.tar.bz2
  sha256: 53da0c8b79659df7b53eebdb80783503ce72fb4b10ed6e9e05cc0e9e4207a130
  md5: c3788462a6fbddafdb413a9f9053e58d
  depends:
  - libgcc-ng >=7.5.0
  license: ISC
  size: 374999
  timestamp: 1605135674116
- kind: conda
  name: libsqlite
  version: 3.46.0
  build: hde9e2c9_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsqlite-3.46.0-hde9e2c9_0.conda
  sha256: daee3f68786231dad457d0dfde3f7f1f9a7f2018adabdbb864226775101341a8
  md5: 18aa975d2094c34aef978060ae7da7d8
  depends:
  - libgcc-ng >=12
  - libzlib >=1.2.13,<2.0a0
  license: Unlicense
  size: 865346
  timestamp: 1718050628718
- kind: conda
  name: libstdcxx
  version: 14.1.0
  build: hc0a3c3a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-14.1.0-hc0a3c3a_1.conda
  sha256: 44decb3d23abacf1c6dd59f3c152a7101b7ca565b4ef8872804ceaedcc53a9cd
  md5: 9dbb9699ea467983ba8a4ba89b08b066
  depends:
  - libgcc 14.1.0 h77fa898_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 3892781
  timestamp: 1724801863728
- kind: conda
  name: libstdcxx-ng
  version: 14.1.0
  build: h4852527_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-ng-14.1.0-h4852527_1.conda
  sha256: a2dc44f97290740cc187bfe94ce543e6eb3c2ea8964d99f189a1d8c97b419b8c
  md5: bd2598399a70bb86d8218e95548d735e
  depends:
  - libstdcxx 14.1.0 hc0a3c3a_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 52219
  timestamp: 1724801897766
- kind: conda
  name: libsystemd0
  version: '253'
  build: h8c4010b_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsystemd0-253-h8c4010b_1.conda
  sha256: 13f5db46b7ded028f5b53fd5373e27a47789b9a655b52a92c4b324099602f29a
  md5: 9176b1e2cb8beca37a7510b0e801e38f
  depends:
  - __glibc >=2.17,<3.0.a0
  - libcap >=2.67,<2.68.0a0
  - libgcc-ng >=12
  - libgcrypt >=1.10.1,<2.0a0
  - lz4-c >=1.9.3,<1.10.0a0
  - xz >=5.2.6,<6.0a0
  - zstd >=1.5.2,<1.6.0a0
  license: LGPL-2.1-or-later
  size: 380557
  timestamp: 1677532757148
- kind: conda
  name: libtiff
  version: 4.5.0
  build: h6adf6a1_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libtiff-4.5.0-h6adf6a1_2.conda
  sha256: e3e18d91fb282b61288d4fd2574dfa31f7ae90ef2737f96722fb6ad3257862ee
  md5: 2e648a34072eb39d7c4fc2a9981c5f0c
  depends:
  - jpeg >=9e,<10a
  - lerc >=4.0.0,<5.0a0
  - libdeflate >=1.17,<1.18.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libwebp-base >=1.2.4,<2.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - xz >=5.2.6,<6.0a0
  - zstd >=1.5.2,<1.6.0a0
  license: HPND
  size: 406655
  timestamp: 1673817946777
- kind: conda
  name: libtool
  version: 2.4.7
  build: h27087fc_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libtool-2.4.7-h27087fc_0.conda
  sha256: 345b3b580ef91557a82425ea3f432a70a8748c040deb14570b9f4dca4af3e3d1
  md5: f204c8ba400ec475452737094fb81d52
  depends:
  - libgcc-ng >=12
  license: GPL-2.0-or-later
  license_family: GPL
  size: 411817
  timestamp: 1672361825713
- kind: conda
  name: libudev1
  version: '253'
  build: h0b41bf4_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libudev1-253-h0b41bf4_1.conda
  sha256: 1419fc6dc85f9aad95df733af4e442feb27da90ed74b9b67dbdc090151bdec24
  md5: bb38b19a41bb94e8a19dbfb062d499c7
  depends:
  - __glibc >=2.17,<3.0.a0
  - libcap >=2.67,<2.68.0a0
  - libgcc-ng >=12
  license: LGPL-2.1-or-later
  size: 118700
  timestamp: 1677532765365
- kind: conda
  name: libuuid
  version: 2.38.1
  build: h0b41bf4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libuuid-2.38.1-h0b41bf4_0.conda
  sha256: 787eb542f055a2b3de553614b25f09eefb0a0931b0c87dbcce6efdfd92f04f18
  md5: 40b61aab5c7ba9ff276c41cfffe6b80b
  depends:
  - libgcc-ng >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 33601
  timestamp: 1680112270483
- kind: conda
  name: libvorbis
  version: 1.3.7
  build: h9c3ff4c_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libvorbis-1.3.7-h9c3ff4c_0.tar.bz2
  sha256: 53080d72388a57b3c31ad5805c93a7328e46ff22fab7c44ad2a86d712740af33
  md5: 309dec04b70a3cc0f1e84a4013683bc0
  depends:
  - libgcc-ng >=9.3.0
  - libogg >=1.3.4,<1.4.0a0
  - libstdcxx-ng >=9.3.0
  license: BSD-3-Clause
  license_family: BSD
  size: 286280
  timestamp: 1610609811627
- kind: conda
  name: libwebp-base
  version: 1.4.0
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libwebp-base-1.4.0-hd590300_0.conda
  sha256: 49bc5f6b1e11cb2babf2a2a731d1a680a5e08a858280876a779dbda06c78c35f
  md5: b26e8aa824079e1be0294e7152ca4559
  depends:
  - libgcc-ng >=12
  constrains:
  - libwebp 1.4.0
  license: BSD-3-Clause
  license_family: BSD
  size: 438953
  timestamp: 1713199854503
- kind: conda
  name: libxcb
  version: '1.13'
  build: h7f98852_1004
  build_number: 1004
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxcb-1.13-h7f98852_1004.tar.bz2
  sha256: 8d5d24cbeda9282dd707edd3156e5fde2e3f3fe86c802fa7ce08c8f1e803bfd9
  md5: b3653fdc58d03face9724f602218a904
  depends:
  - libgcc-ng >=9.4.0
  - pthread-stubs
  - xorg-libxau
  - xorg-libxdmcp
  license: MIT
  license_family: MIT
  size: 399895
  timestamp: 1636658924671
- kind: conda
  name: libxcrypt
  version: 4.4.36
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxcrypt-4.4.36-hd590300_1.conda
  sha256: 6ae68e0b86423ef188196fff6207ed0c8195dd84273cb5623b85aa08033a410c
  md5: 5aa797f8787fe7a17d1b0821485b5adc
  depends:
  - libgcc-ng >=12
  license: LGPL-2.1-or-later
  size: 100393
  timestamp: 1702724383534
- kind: conda
  name: libxkbcommon
  version: 1.5.0
  build: h79f4944_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxkbcommon-1.5.0-h79f4944_1.conda
  sha256: f57aa3eeeb4abbeeafb6e61fbffa6f89fa2434e914c1eb65551e6e0905b363aa
  md5: 04a39cdd663f295653fc143851830563
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxcb >=1.13,<1.14.0a0
  - libxml2 >=2.10.3,<3.0.0a0
  - xkeyboard-config
  license: MIT/X11 Derivative
  license_family: MIT
  size: 563179
  timestamp: 1678659270113
- kind: conda
  name: libxml2
  version: 2.10.3
  build: hca2bb57_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxml2-2.10.3-hca2bb57_4.conda
  sha256: d4170f1fe356768758b13a51db123f990bff81b0eae0d5a0ba11c7ca6b9536f4
  md5: bb808b654bdc3c783deaf107a2ffb503
  depends:
  - icu >=70.1,<71.0a0
  - libgcc-ng >=12
  - libiconv >=1.17,<2.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - xz >=5.2.6,<6.0a0
  license: MIT
  license_family: MIT
  size: 713891
  timestamp: 1679341466192
- kind: conda
  name: libzlib
  version: 1.2.13
  build: h4ab18f5_6
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libzlib-1.2.13-h4ab18f5_6.conda
  sha256: 8ced4afed6322172182af503f21725d072a589a6eb918f8a58135c1e00d35980
  md5: 27329162c0dc732bcf67a4e0cd488125
  depends:
  - libgcc-ng >=12
  constrains:
  - zlib 1.2.13 *_6
  license: Zlib
  license_family: Other
  size: 61571
  timestamp: 1716874066944
- kind: conda
  name: llvm-openmp
  version: 15.0.7
  build: h0cdce71_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/llvm-openmp-15.0.7-h0cdce71_0.conda
  sha256: 7c67d383a8b1f3e7bf9e046e785325c481f6868194edcfb9d78d261da4ad65d4
  md5: 589c9a3575a050b583241c3d688ad9aa
  depends:
  - libzlib >=1.2.13,<2.0.0a0
  constrains:
  - openmp 15.0.7|15.0.7.*
  license: Apache-2.0 WITH LLVM-exception
  license_family: APACHE
  size: 3268766
  timestamp: 1673584331056
- kind: conda
  name: locket
  version: 1.0.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/locket-1.0.0-pyhd8ed1ab_0.tar.bz2
  sha256: 9afe0b5cfa418e8bdb30d8917c5a6cec10372b037924916f1f85b9f4899a67a6
  md5: 91e27ef3d05cc772ce627e51cff111c4
  depends:
  - python >=2.7,!=3.0.*,!=3.1.*,!=3.2.*,!=3.3.*
  license: BSD-2-Clause
  license_family: BSD
  size: 8250
  timestamp: 1650660473123
- kind: conda
  name: lz4
  version: 4.3.3
  build: py310h350c4a5_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/lz4-4.3.3-py310h350c4a5_0.conda
  sha256: 119189a08204d97b1866e97d127d85574980547bc3b4aedc59ac6bb0b521a5c7
  md5: 943866d33b651ae9a3287e84383f6ddc
  depends:
  - libgcc-ng >=12
  - lz4-c >=1.9.3,<1.10.0a0
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: BSD-3-Clause
  license_family: BSD
  size: 37353
  timestamp: 1704831243355
- kind: conda
  name: lz4-c
  version: 1.9.4
  build: hcb278e6_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/lz4-c-1.9.4-hcb278e6_0.conda
  sha256: 1b4c105a887f9b2041219d57036f72c4739ab9e9fe5a1486f094e58c76b31f5f
  md5: 318b08df404f9c9be5712aaa5a6f0bb0
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: BSD-2-Clause
  license_family: BSD
  size: 143402
  timestamp: 1674727076728
- kind: conda
  name: markupsafe
  version: 2.1.5
  build: py310h2372a71_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/markupsafe-2.1.5-py310h2372a71_0.conda
  sha256: 3c18347adf1d091ee9248612308a6bef79038f80b626ef67f58cd0e8d25c65b8
  md5: f6703fa0214a00bf49d1bef6dc7672d0
  depends:
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  constrains:
  - jinja2 >=3.0.0
  license: BSD-3-Clause
  license_family: BSD
  size: 24493
  timestamp: 1706900070478
- kind: conda
  name: matplotlib
  version: 3.9.1
  build: py310hff52083_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-3.9.1-py310hff52083_1.conda
  sha256: cb09b80cc66273c9a33164c23415aaa75eb5e3866dbeaa227d4bf195f9b9a3b8
  md5: 1afd9986895d26433cd2d3aecc265cb0
  depends:
  - matplotlib-base >=3.9.1,<3.9.2.0a0
  - pyqt >=5.10
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - tornado >=5
  license: PSF-2.0
  license_family: PSF
  size: 8717
  timestamp: 1722568761190
- kind: conda
  name: matplotlib-base
  version: 3.9.1
  build: py310hf02ac8c_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-base-3.9.1-py310hf02ac8c_2.conda
  sha256: ee29885abf90e9c59459346dd5aa19026f02f66e0e586a95b2c442e7f913c67b
  md5: 123acef757eb89e8dd6eb37af3f65821
  depends:
  - __glibc >=2.17,<3.0.a0
  - certifi >=2020.06.20
  - contourpy >=1.0.1
  - cycler >=0.10
  - fonttools >=4.22.0
  - freetype >=2.12.1,<3.0a0
  - kiwisolver >=1.3.1
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - numpy >=1.19,<3
  - numpy >=1.23
  - packaging >=20.0
  - pillow >=8
  - pyparsing >=2.3.1
  - python >=3.10,<3.11.0a0
  - python-dateutil >=2.7
  - python_abi 3.10.* *_cp310
  - qhull >=2020.2,<2020.3.0a0
  - tk >=8.6.13,<8.7.0a0
  license: PSF-2.0
  license_family: PSF
  size: 7018180
  timestamp: 1722732874975
- kind: conda
  name: matplotlib-inline
  version: 0.1.7
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/matplotlib-inline-0.1.7-pyhd8ed1ab_0.conda
  sha256: 7ea68676ea35fbb095420bbcc1c82c4767b8be7bb56abb6989b7f89d957a3bab
  md5: 779345c95648be40d22aaa89de7d4254
  depends:
  - python >=3.6
  - traitlets
  license: BSD-3-Clause
  license_family: BSD
  size: 14599
  timestamp: 1713250613726
- kind: conda
  name: mistune
  version: 3.0.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/mistune-3.0.2-pyhd8ed1ab_0.conda
  sha256: f95cb70007e3cc2ba44e17c29a056b499e6dadf08746706d0c817c8e2f47e05c
  md5: 5cbee699846772cc939bef23a0d524ed
  depends:
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 66022
  timestamp: 1698947249750
- kind: conda
  name: mkl
  version: 2023.0.0
  build: h84fe81f_26648
  build_number: 26648
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mkl-2023.0.0-h84fe81f_26648.conda
  sha256: 989c614ec8417a22f61e9d4ec920c88910bbc3239885a6f20ad4eacad09f277c
  md5: 2a37425a272410241c7613c38e3955b2
  depends:
  - _openmp_mutex * *_llvm
  - _openmp_mutex >=4.5
  - llvm-openmp >=15.0.7
  - tbb 2021.*
  license: LicenseRef-ProprietaryIntel
  license_family: Proprietary
  size: 161440193
  timestamp: 1674673370494
- kind: conda
  name: mkl-include
  version: 2023.2.0
  build: h84fe81f_50496
  build_number: 50496
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mkl-include-2023.2.0-h84fe81f_50496.conda
  sha256: da1720a3e065273e2456481b28abd64abc2396d221d87a02db5f14053be61a68
  md5: 7af9fd0b2d7219f4a4200a34561340f6
  license: LicenseRef-ProprietaryIntel
  license_family: Proprietary
  size: 704619
  timestamp: 1698351108112
- kind: conda
  name: ml-collections
  version: 0.1.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ml-collections-0.1.1-pyhd8ed1ab_0.tar.bz2
  sha256: 017ce04cd1f456e8a8bfe8768ba6edf59bf2a905a4c384d7d624a153641553a6
  md5: 678522de10f2352cb732eb67d508bd22
  depends:
  - absl-py
  - contextlib2
  - python >=3.7
  - pyyaml
  - six
  license: Apache-2.0
  license_family: APACHE
  size: 66839
  timestamp: 1664451756771
- kind: conda
  name: mpc
  version: 1.3.1
  build: hfe3b2da_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mpc-1.3.1-hfe3b2da_0.conda
  sha256: 2f88965949ba7b4b21e7e5facd62285f7c6efdb17359d1b365c3bb4ecc968d29
  md5: 289c71e83dc0daa7d4c81f04180778ca
  depends:
  - gmp >=6.2.1,<7.0a0
  - libgcc-ng >=12
  - mpfr >=4.1.0,<5.0a0
  license: LGPL-3.0-or-later
  license_family: LGPL
  size: 116276
  timestamp: 1674263855481
- kind: conda
  name: mpfr
  version: 4.2.1
  build: h38ae2d0_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mpfr-4.2.1-h38ae2d0_2.conda
  sha256: 016981edf60146a6c553e22457ca3d121ff52b98d24b2191b82ef2aefa89cc7f
  md5: 168e18a2bba4f8520e6c5e38982f5847
  depends:
  - __glibc >=2.17,<3.0.a0
  - gmp >=6.3.0,<7.0a0
  - libgcc-ng >=12
  license: LGPL-3.0-only
  license_family: LGPL
  size: 640978
  timestamp: 1722132616744
- kind: conda
  name: mpg123
  version: 1.32.6
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mpg123-1.32.6-h59595ed_0.conda
  sha256: 8895a5ce5122a3b8f59afcba4b032f198e8a690a0efc95ef61f2135357ef0d72
  md5: 9160cdeb523a1b20cf8d2a0bf821f45d
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: LGPL-2.1-only
  license_family: LGPL
  size: 491811
  timestamp: 1712327176955
- kind: conda
  name: mpmath
  version: 1.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/mpmath-1.3.0-pyhd8ed1ab_0.conda
  sha256: a4f025c712ec1502a55c471b56a640eaeebfce38dd497d5a1a33729014cac47a
  md5: dbf6e2d89137da32fa6670f3bffc024e
  depends:
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 438339
  timestamp: 1678228210181
- kind: conda
  name: msgpack-numpy
  version: 0.4.8
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/msgpack-numpy-0.4.8-pyhd8ed1ab_0.tar.bz2
  sha256: c1630db1f2477794cdacb98ee4814e3c86b66a6b03dbc8938453d42e8f68a78a
  md5: eb8559668a936aa9d1bb01c6a69bb125
  depends:
  - msgpack-python >=0.5.2
  - numpy >=1.9.0
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 10728
  timestamp: 1654920155083
- kind: conda
  name: msgpack-python
  version: 1.0.8
  build: py310h25c7140_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/msgpack-python-1.0.8-py310h25c7140_0.conda
  sha256: d7de996a5188f89b149fcfad848968c279c05f291801a28b10ae758e7355cc44
  md5: ad681a3290620ca6196bcd46ed3101cd
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Apache-2.0
  license_family: Apache
  size: 96849
  timestamp: 1715670779124
- kind: conda
  name: munkres
  version: 1.1.4
  build: pyh9f0ad1d_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/munkres-1.1.4-pyh9f0ad1d_0.tar.bz2
  sha256: f86fb22b58e93d04b6f25e0d811b56797689d598788b59dcb47f59045b568306
  md5: 2ba8498c1018c1e9c61eb99b973dfe19
  depends:
  - python
  license: Apache-2.0
  license_family: Apache
  size: 12452
  timestamp: 1600387789153
- kind: conda
  name: mysql-common
  version: 8.0.33
  build: hf1915f5_6
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mysql-common-8.0.33-hf1915f5_6.conda
  sha256: c8b2c5c9d0d013a4f6ef96cb4b339bfdc53a74232d8c61ed08178e5b1ec4eb63
  md5: 80bf3b277c120dd294b51d404b931a75
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - openssl >=3.1.4,<4.0a0
  size: 753467
  timestamp: 1698937026421
- kind: conda
  name: mysql-libs
  version: 8.0.33
  build: hca2cd23_6
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mysql-libs-8.0.33-hca2cd23_6.conda
  sha256: 78c905637dac79b197395065c169d452b8ca2a39773b58e45e23114f1cb6dcdb
  md5: e87530d1b12dd7f4e0f856dc07358d60
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - mysql-common 8.0.33 hf1915f5_6
  - openssl >=3.1.4,<4.0a0
  - zstd >=1.5.5,<1.6.0a0
  size: 1530126
  timestamp: 1698937116126
- kind: conda
  name: nbclient
  version: 0.10.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/nbclient-0.10.0-pyhd8ed1ab_0.conda
  sha256: 589d72d36d61a23b39d6fff2c488f93e29e20de4fc6f5d315b5f2c16e81028bf
  md5: 15b51397e0fe8ea7d7da60d83eb76ebc
  depends:
  - jupyter_client >=6.1.12
  - jupyter_core >=4.12,!=5.0.*
  - nbformat >=5.1
  - python >=3.8
  - traitlets >=5.4
  license: BSD-3-Clause
  license_family: BSD
  size: 27851
  timestamp: 1710317767117
- kind: conda
  name: nbconvert-core
  version: 7.16.4
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/nbconvert-core-7.16.4-pyhd8ed1ab_1.conda
  sha256: 074d858c5808e0a832acc0da37cd70de1565e8d6e17a62d5a11b3902b5e78319
  md5: e2d2abb421c13456a9a9f80272fdf543
  depends:
  - beautifulsoup4
  - bleach
  - defusedxml
  - entrypoints >=0.2.2
  - jinja2 >=3.0
  - jupyter_core >=4.7
  - jupyterlab_pygments
  - markupsafe >=2.0
  - mistune >=2.0.3,<4
  - nbclient >=0.5.0
  - nbformat >=5.1
  - packaging
  - pandocfilters >=1.4.1
  - pygments >=2.4.1
  - python >=3.8
  - tinycss2
  - traitlets >=5.0
  constrains:
  - nbconvert =7.16.4=*_1
  - pandoc >=2.9.2,<4.0.0
  license: BSD-3-Clause
  license_family: BSD
  size: 189599
  timestamp: 1718135529468
- kind: conda
  name: nbformat
  version: 5.10.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/nbformat-5.10.4-pyhd8ed1ab_0.conda
  sha256: 36fe73da4d37bc7ac2d1540526ecd294fbd09acda04e096181ab8f1ccd2b464c
  md5: 0b57b5368ab7fc7cdc9e3511fa867214
  depends:
  - jsonschema >=2.6
  - jupyter_core >=4.12,!=5.0.*
  - python >=3.8
  - python-fastjsonschema >=2.15
  - traitlets >=5.1
  license: BSD-3-Clause
  license_family: BSD
  size: 101232
  timestamp: 1712239122969
- kind: conda
  name: ncurses
  version: '6.5'
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ncurses-6.5-h59595ed_0.conda
  sha256: 4fc3b384f4072b68853a0013ea83bdfd3d66b0126e2238e1d6e1560747aa7586
  md5: fcea371545eda051b6deafb24889fc69
  depends:
  - libgcc-ng >=12
  license: X11 AND BSD-3-Clause
  size: 887465
  timestamp: 1715194722503
- kind: conda
  name: nest-asyncio
  version: 1.6.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/nest-asyncio-1.6.0-pyhd8ed1ab_0.conda
  sha256: 30db21d1f7e59b3408b831a7e0417b83b53ee6223afae56482c5f26da3ceb49a
  md5: 6598c056f64dc8800d40add25e4e2c34
  depends:
  - python >=3.5
  license: BSD-2-Clause
  license_family: BSD
  size: 11638
  timestamp: 1705850780510
- kind: conda
  name: nettle
  version: '3.6'
  build: he412f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/nettle-3.6-he412f7d_0.tar.bz2
  sha256: d929f0c53f2bb74c8e3d97dc1c53cc76b7cec97837fcf87998fa3dd447f03b36
  md5: f050099af540c1c960c813b06bca89ad
  depends:
  - libgcc-ng >=7.5.0
  license: GPL 2 and LGPL3
  license_family: GPL
  size: 6773272
  timestamp: 1605211080998
- kind: conda
  name: networkx
  version: '3.3'
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/networkx-3.3-pyhd8ed1ab_1.conda
  sha256: cbd8a6de87ad842e7665df38dcec719873fe74698bc761de5431047b8fada41a
  md5: d335fd5704b46f4efb89a6774e81aef0
  depends:
  - python >=3.10
  constrains:
  - pandas >=1.4
  - numpy >=1.22
  - matplotlib >=3.5
  - scipy >=1.9,!=1.11.0,!=1.11.1
  license: BSD-3-Clause
  license_family: BSD
  size: 1185670
  timestamp: 1712540499262
- kind: conda
  name: notebook
  version: 7.2.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/notebook-7.2.2-pyhd8ed1ab_0.conda
  sha256: 613242d5151a4d70438bb2d65041c509e4376b7e18c06c3795c52a18176e41dc
  md5: c4d5a58f43ce9ffa430e6ecad6c30a42
  depends:
  - jupyter_server >=2.4.0,<3
  - jupyterlab >=4.2.0,<4.3
  - jupyterlab_server >=2.27.1,<3
  - notebook-shim >=0.2,<0.3
  - python >=3.8
  - tornado >=6.2.0
  license: BSD-3-Clause
  license_family: BSD
  size: 3904930
  timestamp: 1724861465900
- kind: conda
  name: notebook-shim
  version: 0.2.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/notebook-shim-0.2.4-pyhd8ed1ab_0.conda
  sha256: 9b5fdef9ebe89222baa9da2796ebe7bc02ec6c5a1f61327b651d6b92cf9a0230
  md5: 3d85618e2c97ab896b5b5e298d32b5b3
  depends:
  - jupyter_server >=1.8,<3
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 16880
  timestamp: 1707957948029
- kind: conda
  name: nsight-compute
  version: 2024.1.1.4
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/nsight-compute-2024.1.1.4-0.tar.bz2
  sha256: 33935f28b007d3d5f584abd22485251ad7eea91b4b9f11c960a053fdd7be8a48
  md5: 217ed2ff255f52cbef787aba3f9b9637
  size: 699526661
  timestamp: 1709778043113
- kind: conda
  name: nspr
  version: '4.35'
  build: h27087fc_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/nspr-4.35-h27087fc_0.conda
  sha256: 8fadeebb2b7369a4f3b2c039a980d419f65c7b18267ba0c62588f9f894396d0c
  md5: da0ec11a6454ae19bff5b02ed881a2b1
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: MPL-2.0
  license_family: MOZILLA
  size: 226848
  timestamp: 1669784948267
- kind: conda
  name: nss
  version: '3.100'
  build: hca3bf56_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/nss-3.100-hca3bf56_0.conda
  sha256: a4146d2b6636999a21afcaf957029d066637bf26239fd3170242501e38fb1fa4
  md5: 949c4a82290ee58b3c970cef4bcfd4ad
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - libsqlite >=3.45.3,<4.0a0
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - nspr >=4.35,<5.0a0
  license: MPL-2.0
  license_family: MOZILLA
  size: 2047723
  timestamp: 1715184444840
- kind: conda
  name: numpy
  version: 1.26.4
  build: py310hb13e2d6_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/numpy-1.26.4-py310hb13e2d6_0.conda
  sha256: 028fe2ea8e915a0a032b75165f11747770326f3d767e642880540c60a3256425
  md5: 6593de64c935768b6bad3e19b3e978be
  depends:
  - libblas >=3.9.0,<4.0a0
  - libcblas >=3.9.0,<4.0a0
  - libgcc-ng >=12
  - liblapack >=3.9.0,<4.0a0
  - libstdcxx-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  constrains:
  - numpy-base <0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 7009070
  timestamp: 1707225917496
- kind: conda
  name: omegaconf
  version: 2.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/omegaconf-2.3.0-pyhd8ed1ab_0.conda
  sha256: df806841be847e5287b22b6ae7f380874f81ea51f1b51ae14a570f3385c7b133
  md5: 23cc056834cab53849b91f78d6ee3ea0
  depends:
  - antlr-python-runtime 4.9.*
  - python >=3.7
  - pyyaml >=5.1.0
  - typing_extensions
  license: BSD-3-Clause
  license_family: BSD
  size: 166453
  timestamp: 1670575519562
- kind: conda
  name: openbabel
  version: 3.1.1
  build: py310heaf86c6_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openbabel-3.1.1-py310heaf86c6_5.tar.bz2
  sha256: 8e4f0dd1fd2aac08be1c1d0ca4e282a13be6dc1dae11370722e66a8d4d3e8f07
  md5: 39786fb51043e91f0fdd7076d2b02618
  depends:
  - cairo >=1.16.0,<2.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxml2 >=2.10.3,<3.0.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: GPL-2.0-only
  license_family: GPL
  size: 5886105
  timestamp: 1666985854824
- kind: conda
  name: openh264
  version: 2.1.1
  build: h780b84a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openh264-2.1.1-h780b84a_0.tar.bz2
  sha256: 2ce3df1edb23541595443c7697e5568ae6426fa4d365dede45b16b0310bd6a06
  md5: 034a6f90f1bbc7ba11d04b84ec9d74c8
  depends:
  - libgcc-ng >=9.3.0
  - libstdcxx-ng >=9.3.0
  - zlib >=1.2.11,<1.3.0a0
  license: BSD-2-Clause
  license_family: BSD
  size: 1585354
  timestamp: 1609583081716
- kind: conda
  name: openjpeg
  version: 2.5.0
  build: hfec8fc6_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openjpeg-2.5.0-hfec8fc6_2.conda
  sha256: 3cbfb1fe9bb492dcb672f98f0ddc7b4e029f51f77101d9c301caa3acaea8cba2
  md5: 5ce6a42505c6e9e6151c54c3ec8d68ea
  depends:
  - libgcc-ng >=12
  - libpng >=1.6.39,<1.7.0a0
  - libstdcxx-ng >=12
  - libtiff >=4.5.0,<4.6.0a0
  - libzlib >=1.2.13,<2.0.0a0
  license: BSD-2-Clause
  license_family: BSD
  size: 352022
  timestamp: 1671435172657
- kind: conda
  name: openssl
  version: 3.1.6
  build: h4ab18f5_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openssl-3.1.6-h4ab18f5_0.conda
  sha256: a666d9a71dd6a809c30c51f54df2f11f57e98f5d0edbd0a5f4940e892a076d77
  md5: 371a0089f4c14239ecb919cf6d44b1ac
  depends:
  - ca-certificates
  - libgcc-ng >=12
  constrains:
  - pyopenssl >=22.1
  license: Apache-2.0
  license_family: Apache
  size: 2657670
  timestamp: 1717533967905
- kind: conda
  name: opt-einsum
  version: 3.3.0
  build: hd8ed1ab_2
  build_number: 2
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/opt-einsum-3.3.0-hd8ed1ab_2.conda
  sha256: 7cc87658f3ef09bd6f85afdf6c55db0c274960132de4050328759e8b3784df22
  md5: ab262acd95cb73f3ed9426cc4204ac3a
  depends:
  - opt_einsum >=3.3.0,<3.3.1.0a0
  license: MIT
  license_family: MIT
  size: 6594
  timestamp: 1696449067022
- kind: conda
  name: opt_einsum
  version: 3.3.0
  build: pyhc1e730c_2
  build_number: 2
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/opt_einsum-3.3.0-pyhc1e730c_2.conda
  sha256: 1995657f10e23dbe534219f754c66b7fb2a805d68a3385abdacb7807a915b0c3
  md5: 7a94ac68b892daa9f17ae8a52b31ed81
  depends:
  - numpy
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 58004
  timestamp: 1696449058916
- kind: conda
  name: opt_einsum_fx
  version: 0.1.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/opt_einsum_fx-0.1.4-pyhd8ed1ab_0.tar.bz2
  sha256: 56629c0e4162ef3c5a1227ca75d2d4ecad1a0d6babb48e71a9a86523d7601f37
  md5: c5ae76aafb76020949fa5bbcba00c732
  depends:
  - opt-einsum
  - packaging
  - python >=3.6
  - pytorch >=1.8.0
  license: MIT
  license_family: MIT
  size: 15223
  timestamp: 1653480123156
- kind: conda
  name: ordered-set
  version: 4.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ordered-set-4.1.0-pyhd8ed1ab_0.tar.bz2
  sha256: 78d92f848a6b4a89148dfa1f6e65c0b75e8f3a267b6401be38fb3401853b4afa
  md5: 9a8714decb3967b290263817e876d8a9
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 11469
  timestamp: 1643221437437
- kind: conda
  name: orjson
  version: 3.10.7
  build: py310h42e942d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/orjson-3.10.7-py310h42e942d_0.conda
  sha256: 0354fed164c9c3447a289bba58ed03b682b8d18fdd37ec832f142d27ad1adf05
  md5: b209ae54f79b62fc390dd22467fc3c31
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  constrains:
  - __glibc >=2.17
  license: Apache-2.0
  license_family: Apache
  size: 302184
  timestamp: 1723206189588
- kind: conda
  name: overrides
  version: 7.7.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/overrides-7.7.0-pyhd8ed1ab_0.conda
  sha256: 5e238e5e646414d517a13f6786c7227206ace58271e3ef63f6adca4d6a4c2839
  md5: 24fba5a9d161ad8103d4e84c0e1a3ed4
  depends:
  - python >=3.6
  - typing_utils
  license: Apache-2.0
  license_family: APACHE
  size: 30232
  timestamp: 1706394723472
- kind: conda
  name: packaging
  version: '24.1'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/packaging-24.1-pyhd8ed1ab_0.conda
  sha256: 36aca948219e2c9fdd6d80728bcc657519e02f06c2703d8db3446aec67f51d81
  md5: cbe1bb1f21567018ce595d9c2be0f0db
  depends:
  - python >=3.8
  license: Apache-2.0
  license_family: APACHE
  size: 50290
  timestamp: 1718189540074
- kind: conda
  name: pandas
  version: 2.2.2
  build: py310hf9f9076_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pandas-2.2.2-py310hf9f9076_1.conda
  sha256: 7f7ed5de8066c1b275942ac183472acc9501c91cc4c25ab3197020a87f5a3495
  md5: 18100768350158f1795ab9ad7d06d5ca
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - numpy >=1.19,<3
  - python >=3.10,<3.11.0a0
  - python-dateutil >=2.8.1
  - python-tzdata >=2022a
  - python_abi 3.10.* *_cp310
  - pytz >=2020.1
  license: BSD-3-Clause
  license_family: BSD
  size: 13024685
  timestamp: 1715898109537
- kind: conda
  name: pandocfilters
  version: 1.5.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pandocfilters-1.5.0-pyhd8ed1ab_0.tar.bz2
  sha256: 2bb9ba9857f4774b85900c2562f7e711d08dd48e2add9bee4e1612fbee27e16f
  md5: 457c2c8c08e54905d6954e79cb5b5db9
  depends:
  - python !=3.0,!=3.1,!=3.2,!=3.3
  license: BSD-3-Clause
  license_family: BSD
  size: 11627
  timestamp: 1631603397334
- kind: conda
  name: parso
  version: 0.8.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/parso-0.8.4-pyhd8ed1ab_0.conda
  sha256: bfe404eebb930cc41782d34f8fc04c0388ea692eeebe2c5fc28df8ec8d4d61ae
  md5: 81534b420deb77da8833f2289b8d47ac
  depends:
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 75191
  timestamp: 1712320447201
- kind: conda
  name: partd
  version: 1.4.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/partd-1.4.2-pyhd8ed1ab_0.conda
  sha256: 472fc587c63ec4f6eba0cc0b06008a6371e0a08a5986de3cf4e8024a47b4fe6c
  md5: 0badf9c54e24cecfb0ad2f99d680c163
  depends:
  - locket
  - python >=3.9
  - toolz
  license: BSD-3-Clause
  license_family: BSD
  size: 20884
  timestamp: 1715026639309
- kind: conda
  name: pcre2
  version: '10.43'
  build: hcad00b1_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pcre2-10.43-hcad00b1_0.conda
  sha256: 766dd986a7ed6197676c14699000bba2625fd26c8a890fcb7a810e5cf56155bc
  md5: 8292dea9e022d9610a11fce5e0896ed8
  depends:
  - bzip2 >=1.0.8,<2.0a0
  - libgcc-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 950847
  timestamp: 1708118050286
- kind: conda
  name: perl
  version: 5.32.1
  build: 7_hd590300_perl5
  build_number: 7
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/perl-5.32.1-7_hd590300_perl5.conda
  sha256: 9ec32b6936b0e37bcb0ed34f22ec3116e75b3c0964f9f50ecea5f58734ed6ce9
  md5: f2cfec9406850991f4e3d960cc9e3321
  depends:
  - libgcc-ng >=12
  - libxcrypt >=4.4.36
  license: GPL-1.0-or-later OR Artistic-1.0-Perl
  size: 13344463
  timestamp: 1703310653947
- kind: conda
  name: pexpect
  version: 4.9.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pexpect-4.9.0-pyhd8ed1ab_0.conda
  sha256: 90a09d134a4a43911b716d4d6eb9d169238aff2349056f7323d9db613812667e
  md5: 629f3203c99b32e0988910c93e77f3b6
  depends:
  - ptyprocess >=0.5
  - python >=3.7
  license: ISC
  size: 53600
  timestamp: 1706113273252
- kind: conda
  name: pickleshare
  version: 0.7.5
  build: py_1003
  build_number: 1003
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pickleshare-0.7.5-py_1003.tar.bz2
  sha256: a1ed1a094dd0d1b94a09ed85c283a0eb28943f2e6f22161fb45e128d35229738
  md5: 415f0ebb6198cc2801c73438a9fb5761
  depends:
  - python >=3
  license: MIT
  license_family: MIT
  size: 9332
  timestamp: 1602536313357
- kind: conda
  name: pillow
  version: 9.4.0
  build: py310h023d228_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pillow-9.4.0-py310h023d228_1.conda
  sha256: 6d17af4c8bc8d8668d033725dd4691cfac86fdf0f46f655ab6f5df3e3ae0bb7c
  md5: bbea829b541aa15df5c65bd40b8c1981
  depends:
  - freetype >=2.12.1,<3.0a0
  - jpeg >=9e,<10a
  - lcms2 >=2.14,<3.0a0
  - libgcc-ng >=12
  - libtiff >=4.5.0,<4.6.0a0
  - libwebp-base >=1.2.4,<2.0a0
  - libxcb >=1.13,<1.14.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - openjpeg >=2.5.0,<3.0a0
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - tk >=8.6.12,<8.7.0a0
  license: LicenseRef-PIL
  size: 46458896
  timestamp: 1675487348403
- kind: conda
  name: pip
  version: '24.2'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pip-24.2-pyhd8ed1ab_0.conda
  sha256: 15b480571a7a4d896aa187648cce99f98bac3926253f028f228d2e9e1cf7c1e1
  md5: 6721aef6bfe5937abe70181545dd2c51
  depends:
  - python >=3.8
  - setuptools
  - wheel
  license: MIT
  license_family: MIT
  size: 1238498
  timestamp: 1722451042495
- kind: conda
  name: pixman
  version: 0.43.2
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pixman-0.43.2-h59595ed_0.conda
  sha256: 366d28e2a0a191d6c535e234741e0cd1d94d713f76073d8af4a5ccb2a266121e
  md5: 71004cbf7924e19c02746ccde9fd7123
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: MIT
  license_family: MIT
  size: 386826
  timestamp: 1706549500138
- kind: conda
  name: pkgutil-resolve-name
  version: 1.3.10
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pkgutil-resolve-name-1.3.10-pyhd8ed1ab_1.conda
  sha256: fecf95377134b0e8944762d92ecf7b0149c07d8186fb5db583125a2705c7ea0a
  md5: 405678b942f2481cecdb3e010f4925d9
  depends:
  - python >=3.6
  license: MIT AND PSF-2.0
  size: 10778
  timestamp: 1694617398467
- kind: conda
  name: platformdirs
  version: 4.2.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/platformdirs-4.2.2-pyhd8ed1ab_0.conda
  sha256: adc59384cf0b2fc6dc7362840151e8cb076349197a38f7230278252698a88442
  md5: 6f6cf28bf8e021933869bae3f84b8fc9
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 20572
  timestamp: 1715777739019
- kind: conda
  name: ply
  version: '3.11'
  build: pyhd8ed1ab_2
  build_number: 2
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ply-3.11-pyhd8ed1ab_2.conda
  sha256: d8faaf4dcc13caed560fa32956523b35928a70499a2d08c51320947d637e3a41
  md5: 18c6deb6f9602e32446398203c8f0e91
  depends:
  - python >=2.6
  license: BSD-3-Clause
  license_family: BSD
  size: 49196
  timestamp: 1712243121626
- kind: conda
  name: prody
  version: 2.4.0
  build: py310heca2aa9_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/prody-2.4.0-py310heca2aa9_0.conda
  sha256: d79e5f142c73fcdc46c133c81d1c48ce2dcc0c9baf720a4ae2463f2c3af99d64
  md5: 34af224d0e56e1e082d669f8bf68fc79
  depends:
  - biopython
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - matplotlib-base
  - numpy >=1.24.1,<2.0a0
  - pyparsing
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - requests
  - scipy
  - setuptools
  license: MIT
  license_family: MIT
  size: 10927918
  timestamp: 1675531714845
- kind: conda
  name: prometheus_client
  version: 0.20.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/prometheus_client-0.20.0-pyhd8ed1ab_0.conda
  sha256: 757cd91d01c2e0b64fadf6bc9a11f558cf7638d897dfbaf7415ddf324d5405c9
  md5: 9a19b94034dd3abb2b348c8b93388035
  depends:
  - python >=3.8
  license: Apache-2.0
  license_family: Apache
  size: 48913
  timestamp: 1707932844383
- kind: conda
  name: prompt-toolkit
  version: 3.0.47
  build: pyha770c72_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/prompt-toolkit-3.0.47-pyha770c72_0.conda
  sha256: d93ac5853e398aaa10f0dd7addd64b411f94ace1f9104d619cd250e19a5ac5b4
  md5: 1247c861065d227781231950e14fe817
  depends:
  - python >=3.7
  - wcwidth
  constrains:
  - prompt_toolkit 3.0.47
  license: BSD-3-Clause
  license_family: BSD
  size: 270710
  timestamp: 1718048095491
- kind: conda
  name: prompt_toolkit
  version: 3.0.47
  build: hd8ed1ab_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/prompt_toolkit-3.0.47-hd8ed1ab_0.conda
  sha256: 081ef6c9fbc280940c8d65683371795a8876cd4994b3fbdd0ccda7cc3ee87f74
  md5: 3e0c82ddcfe27eb4ae77f887cfd9f45b
  depends:
  - prompt-toolkit >=3.0.47,<3.0.48.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 6784
  timestamp: 1718048101184
- kind: conda
  name: psipred
  version: '4.01'
  build: '1'
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/biocore/linux-64/psipred-4.01-1.tar.bz2
  md5: 70c459362f14521511dfdd2ad5b8b73f
  depends:
  - blast-legacy ==2.2.26
  arch: x86_64
  platform: linux
  size: 15527968
- kind: conda
  name: psutil
  version: 6.0.0
  build: py310hc51659f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/psutil-6.0.0-py310hc51659f_0.conda
  sha256: d23e0a2bf49a752fcc8267484c5eff3e5b267703853c11cc7b4f762412d0f7ef
  md5: b04405826f96f4eb2f502e642d121bb5
  depends:
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: BSD-3-Clause
  license_family: BSD
  size: 371633
  timestamp: 1719274668659
- kind: conda
  name: pthread-stubs
  version: '0.4'
  build: h36c2ea0_1001
  build_number: 1001
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pthread-stubs-0.4-h36c2ea0_1001.tar.bz2
  sha256: 67c84822f87b641d89df09758da498b2d4558d47b920fd1d3fe6d3a871e000ff
  md5: 22dad4df6e8630e8dff2428f6f6a7036
  depends:
  - libgcc-ng >=7.5.0
  license: MIT
  license_family: MIT
  size: 5625
  timestamp: 1606147468727
- kind: conda
  name: ptyprocess
  version: 0.7.0
  build: pyhd3deb0d_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ptyprocess-0.7.0-pyhd3deb0d_0.tar.bz2
  sha256: fb31e006a25eb2e18f3440eb8d17be44c8ccfae559499199f73584566d0a444a
  md5: 359eeb6536da0e687af562ed265ec263
  depends:
  - python
  license: ISC
  size: 16546
  timestamp: 1609419417991
- kind: conda
  name: pulseaudio
  version: '16.1'
  build: hcb278e6_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-16.1-hcb278e6_3.conda
  sha256: 59f58bbe5ead04537ffcd6262674daf71e9702e88d1c142a38dcd641b4eab936
  md5: 8b452ab959166d91949af4c2d28f81db
  depends:
  - libgcc-ng >=12
  - pulseaudio-client 16.1 h5195f5e_3
  - pulseaudio-daemon 16.1 ha8d29e2_3
  license: LGPL-2.1-or-later
  license_family: LGPL
  size: 16628
  timestamp: 1679504551442
- kind: conda
  name: pulseaudio-client
  version: '16.1'
  build: h5195f5e_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-client-16.1-h5195f5e_3.conda
  sha256: da289229ca472fa17f5c194c86362354f6dc66311502bb44959a93e7bb88e320
  md5: caeb3302ef1dc8b342b20c710a86f8a9
  depends:
  - dbus >=1.13.6,<2.0a0
  - libgcc-ng >=12
  - libglib >=2.74.1,<3.0a0
  - libsndfile >=1.2.0,<1.3.0a0
  - libsystemd0 >=253
  constrains:
  - pulseaudio 16.1 *_3
  license: LGPL-2.1-or-later
  license_family: LGPL
  size: 752233
  timestamp: 1679504427309
- kind: conda
  name: pulseaudio-daemon
  version: '16.1'
  build: ha8d29e2_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-daemon-16.1-ha8d29e2_3.conda
  sha256: ce549c137b7d2711a6fe65d07ca9926fe267143d1c72c3f75d058470391c2ed2
  md5: 34d9d75ca896f5919c372a34e25f23ea
  depends:
  - alsa-lib >=1.2.8,<1.2.9.0a0
  - dbus >=1.13.6,<2.0a0
  - fftw >=3.3.10,<4.0a0
  - gstreamer-orc >=0.4.33,<0.5.0a0
  - jack >=1.9.22,<1.10.0a0
  - libcap >=2.67,<2.68.0a0
  - libgcc-ng >=12
  - libglib >=2.74.1,<3.0a0
  - libsndfile >=1.2.0,<1.3.0a0
  - libsystemd0 >=253
  - libtool >=2.4.7,<3.0a0
  - libudev1 >=253
  - openssl >=3.1.0,<4.0a0
  - pulseaudio-client 16.1 h5195f5e_3
  constrains:
  - pulseaudio 16.1 *_3
  license: GPL-2.0-or-later
  license_family: GPL
  size: 848588
  timestamp: 1679504539092
- kind: conda
  name: pure_eval
  version: 0.2.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pure_eval-0.2.3-pyhd8ed1ab_0.conda
  sha256: dcfcb3cee1ae0a89729601582cc3edea20ba13c9493967a03a693c67567af0c8
  md5: 0f051f09d992e0d08941706ad519ee0e
  depends:
  - python >=3.5
  license: MIT
  license_family: MIT
  size: 16551
  timestamp: 1721585805256
- kind: conda
  name: pycparser
  version: '2.22'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pycparser-2.22-pyhd8ed1ab_0.conda
  sha256: 406001ebf017688b1a1554b49127ca3a4ac4626ec0fd51dc75ffa4415b720b64
  md5: 844d9eb3b43095b031874477f7d70088
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 105098
  timestamp: 1711811634025
- kind: conda
  name: pydantic
  version: 1.10.17
  build: py310h5b4e0ec_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pydantic-1.10.17-py310h5b4e0ec_0.conda
  sha256: 61d0c0871e8a24df94f3d7e3506dfebc40a497ebad29f31dcd8440cc30ccb909
  md5: 98a3d7060b5c2d4257dacb81e8245217
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - typing-extensions >=4.2.0
  license: MIT
  license_family: MIT
  size: 2183356
  timestamp: 1722890192347
- kind: conda
  name: pygments
  version: 2.18.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pygments-2.18.0-pyhd8ed1ab_0.conda
  sha256: 78267adf4e76d0d64ea2ffab008c501156c108bb08fecb703816fb63e279780b
  md5: b7f5c092b8f9800150d998a71b76d5a1
  depends:
  - python >=3.8
  license: BSD-2-Clause
  license_family: BSD
  size: 879295
  timestamp: 1714846885370
- kind: conda
  name: pyparsing
  version: 3.1.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pyparsing-3.1.1-pyhd8ed1ab_0.conda
  sha256: 4a1332d634b6c2501a973655d68f08c9c42c0bd509c349239127b10572b8354b
  md5: 176f7d56f0cfe9008bdf1bccd7de02fb
  depends:
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 89521
  timestamp: 1690737983548
- kind: conda
  name: pyqt
  version: 5.15.9
  build: py310h04931ad_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyqt-5.15.9-py310h04931ad_5.conda
  sha256: 92fe1c9eda6be7879ba798066016c1065047cc13d730105f5109835cbfeae8f1
  md5: f4fe7a6e3d7c78c9de048ea9dda21690
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - pyqt5-sip 12.12.2 py310hc6cd4ac_5
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - qt-main >=5.15.8,<5.16.0a0
  - sip >=6.7.11,<6.8.0a0
  license: GPL-3.0-only
  license_family: GPL
  size: 5282574
  timestamp: 1695420653225
- kind: conda
  name: pyqt5-sip
  version: 12.12.2
  build: py310hc6cd4ac_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyqt5-sip-12.12.2-py310hc6cd4ac_5.conda
  sha256: a6aec078683ed3cf1650b7c47e3f0fe185015d54ea37fe76b9f31f05e1fd087d
  md5: ef5333594a958b25912002886b82b253
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - packaging
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - sip
  - toml
  license: GPL-3.0-only
  license_family: GPL
  size: 84579
  timestamp: 1695418069976
- kind: conda
  name: pyrsistent
  version: 0.20.0
  build: py310h2372a71_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyrsistent-0.20.0-py310h2372a71_0.conda
  sha256: 04911fec3b8d3065e5ef414c1687dd2c203d37edee46b044c91d500463b9696b
  md5: e7f8dc8c62e136573c84116a5e743aed
  depends:
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: MIT
  license_family: MIT
  size: 99987
  timestamp: 1698753969994
- kind: conda
  name: pysocks
  version: 1.7.1
  build: pyha2e5f31_6
  build_number: 6
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pysocks-1.7.1-pyha2e5f31_6.tar.bz2
  sha256: a42f826e958a8d22e65b3394f437af7332610e43ee313393d1cf143f0a2d274b
  md5: 2a7de29fb590ca14b5243c4c812c8025
  depends:
  - __unix
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 18981
  timestamp: 1661604969727
- kind: conda
  name: python
  version: 3.10.13
  build: hd12c33a_0_cpython
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/python-3.10.13-hd12c33a_0_cpython.conda
  sha256: a53410f459f314537b379982717b1c5911efc2f0cc26d63c4d6f831bcb31c964
  md5: f3a8c32aa764c3e7188b4b810fc9d6ce
  depends:
  - bzip2 >=1.0.8,<2.0a0
  - ld_impl_linux-64 >=2.36.1
  - libffi >=3.4,<4.0a0
  - libgcc-ng >=12
  - libnsl >=2.0.1,<2.1.0a0
  - libsqlite >=3.43.2,<4.0a0
  - libuuid >=2.38.1,<3.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - ncurses >=6.4,<7.0a0
  - openssl >=3.1.4,<4.0a0
  - readline >=8.2,<9.0a0
  - tk >=8.6.13,<8.7.0a0
  - tzdata
  - xz >=5.2.6,<6.0a0
  constrains:
  - python_abi 3.10.* *_cp310
  license: Python-2.0
  size: 25476977
  timestamp: 1698344640413
- kind: conda
  name: python-dateutil
  version: 2.9.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/python-dateutil-2.9.0-pyhd8ed1ab_0.conda
  sha256: f3ceef02ac164a8d3a080d0d32f8e2ebe10dd29e3a685d240e38b3599e146320
  md5: 2cf4264fffb9e6eff6031c5b6884d61c
  depends:
  - python >=3.7
  - six >=1.5
  license: Apache-2.0
  license_family: APACHE
  size: 222742
  timestamp: 1709299922152
- kind: conda
  name: python-fastjsonschema
  version: 2.20.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/python-fastjsonschema-2.20.0-pyhd8ed1ab_0.conda
  sha256: 7d8c931b89c9980434986b4deb22c2917b58d9936c3974139b9c10ae86fdfe60
  md5: b98d2018c01ce9980c03ee2850690fab
  depends:
  - python >=3.3
  license: BSD-3-Clause
  license_family: BSD
  size: 226165
  timestamp: 1718477110630
- kind: conda
  name: python-flatbuffers
  version: 24.3.25
  build: pyh59ac667_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/python-flatbuffers-24.3.25-pyh59ac667_0.conda
  sha256: 6a9d285fef959480eccbc69e276ede64e292c8eee35ddc727d5a0fb9a4bcc3a2
  md5: dfc884dcd61ff6543fde37a41b7d7f31
  depends:
  - python >=3.6
  license: Apache-2.0
  license_family: Apache
  size: 34336
  timestamp: 1711466847930
- kind: conda
  name: python-json-logger
  version: 2.0.7
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/python-json-logger-2.0.7-pyhd8ed1ab_0.conda
  sha256: 4790787fe1f4e8da616edca4acf6a4f8ed4e7c6967aa31b920208fc8f95efcca
  md5: a61bf9ec79426938ff785eb69dbb1960
  depends:
  - python >=3.6
  license: BSD-2-Clause
  license_family: BSD
  size: 13383
  timestamp: 1677079727691
- kind: conda
  name: python-tzdata
  version: '2024.1'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/python-tzdata-2024.1-pyhd8ed1ab_0.conda
  sha256: 9da9a849d53705dee450b83507df1ca8ffea5f83bd21a215202221f1c492f8ad
  md5: 98206ea9954216ee7540f0c773f2104d
  depends:
  - python >=3.6
  license: Apache-2.0
  license_family: APACHE
  size: 144024
  timestamp: 1707747742930
- kind: conda
  name: python_abi
  version: '3.10'
  build: 5_cp310
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/python_abi-3.10-5_cp310.conda
  sha256: 074d2f0b31f0333b7e553042b17ea54714b74263f8adda9a68a4bd8c7e219971
  md5: 2921c34715e74b3587b4cff4d36844f9
  constrains:
  - python 3.10.* *_cpython
  license: BSD-3-Clause
  license_family: BSD
  size: 6227
  timestamp: 1723823165457
- kind: conda
  name: pytorch
  version: 2.3.0
  build: py3.10_cuda12.1_cudnn8.9.2_0
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/pytorch-2.3.0-py3.10_cuda12.1_cudnn8.9.2_0.tar.bz2
  sha256: 24bc0934eb009d0d45ffd37979da71d97b220bec191e31bbe5740295b71b9fab
  md5: 160408071c52b7580ba983e508d424ce
  depends:
  - blas * mkl
  - filelock
  - jinja2
  - llvm-openmp <16
  - mkl >=2018
  - networkx
  - python >=3.10,<3.11.0a0
  - pytorch-cuda >=12.1,<12.2
  - pytorch-mutex 1.0 cuda
  - pyyaml
  - sympy
  - torchtriton 2.3.0
  - typing_extensions
  constrains:
  - cpuonly <0
  license: BSD 3-Clause
  license_family: BSD
  size: 1473874412
  timestamp: 1712617118031
- kind: conda
  name: pytorch-cuda
  version: '12.1'
  build: ha16c6d3_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/pytorch-cuda-12.1-ha16c6d3_5.tar.bz2
  sha256: 912c544df4e7abd8510e572bc50cd11c6fa880273858a057fc451563f04d3cf6
  md5: ffc0937cf6ba3ffb299b0c256accc53f
  depends:
  - cuda-cudart >=12.1,<12.2
  - cuda-cupti >=12.1,<12.2
  - cuda-libraries >=12.1,<12.2
  - cuda-nvrtc >=12.1,<12.2
  - cuda-nvtx >=12.1,<12.2
  - cuda-runtime >=12.1,<12.2
  - libcublas >=12.1.0.26,<12.1.3.1
  - libcufft >=11.0.2.4,<11.0.2.54
  - libcusolver >=11.4.4.55,<11.4.5.107
  - libcusparse >=12.0.2.55,<12.1.0.106
  - libnpp >=12.0.2.50,<12.1.0.40
  - libnvjitlink >=12.1.105,<12.2.0
  - libnvjpeg >=12.1.0.39,<12.2.0.2
  size: 3564
  timestamp: 1682528087188
- kind: conda
  name: pytorch-mutex
  version: '1.0'
  build: cuda
  build_number: 100
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/pytorch/noarch/pytorch-mutex-1.0-cuda.tar.bz2
  sha256: c16316183f51b74ca5eee4dcb8631052f328c0bbf244176734a0b7d390b81ee3
  md5: a948316e36fb5b11223b3fcfa93f8358
  size: 2906
  timestamp: 1628062930777
- kind: conda
  name: pytz
  version: '2024.1'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pytz-2024.1-pyhd8ed1ab_0.conda
  sha256: 1a7d6b233f7e6e3bbcbad054c8fd51e690a67b129a899a056a5e45dd9f00cb41
  md5: 3eeeeb9e4827ace8c0c1419c85d590ad
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 188538
  timestamp: 1706886944988
- kind: conda
  name: pyyaml
  version: 6.0.2
  build: py310h5b4e0ec_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyyaml-6.0.2-py310h5b4e0ec_0.conda
  sha256: e7b3d6ee96fedc29b49a3705401765743082e79ea9f6359fdc6d3a2245fd6747
  md5: ad8de7b4ac482217959cc1e8fe0cc56d
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - yaml >=0.2.5,<0.3.0a0
  license: MIT
  license_family: MIT
  size: 181235
  timestamp: 1723018382019
- kind: conda
  name: pyzmq
  version: 26.2.0
  build: py310h71f11fc_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyzmq-26.2.0-py310h71f11fc_1.conda
  sha256: 1a94abe41fa2dd52b83b2aee7f21501a13a8c491f0a36ada0dba8ae92da5f81b
  md5: e646f5fbd704997c3d61d0a45b62dbd6
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libsodium >=1.0.18,<1.0.19.0a0
  - libstdcxx >=13
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - zeromq >=4.3.5,<4.4.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 337725
  timestamp: 1725430524029
- kind: conda
  name: qhull
  version: '2020.2'
  build: h434a139_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/qhull-2020.2-h434a139_5.conda
  sha256: 776363493bad83308ba30bcb88c2552632581b143e8ee25b1982c8c743e73abc
  md5: 353823361b1d27eb3960efb076dfcaf6
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: LicenseRef-Qhull
  size: 552937
  timestamp: 1720813982144
- kind: conda
  name: qt-main
  version: 5.15.8
  build: h5d23da1_6
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/qt-main-5.15.8-h5d23da1_6.conda
  sha256: fd0b6b8365fd4d0e86476a3047ba6a281eea0bdfef770df83b897fd73e959dd9
  md5: 59c73debd9405771690ddbbad6c57b69
  depends:
  - __glibc >=2.17,<3.0.a0
  - alsa-lib >=1.2.8,<1.2.9.0a0
  - dbus >=1.13.6,<2.0a0
  - expat >=2.5.0,<3.0a0
  - fontconfig >=2.14.2,<3.0a0
  - fonts-conda-ecosystem
  - freetype >=2.12.1,<3.0a0
  - gst-plugins-base >=1.22.0,<1.23.0a0
  - gstreamer >=1.22.0,<1.23.0a0
  - harfbuzz >=6.0.0,<7.0a0
  - icu >=70.1,<71.0a0
  - jpeg >=9e,<10a
  - krb5 >=1.20.1,<1.21.0a0
  - libclang >=15.0.7,<16.0a0
  - libclang13 >=15.0.7
  - libcups >=2.3.3,<2.4.0a0
  - libevent >=2.1.10,<2.1.11.0a0
  - libgcc-ng >=12
  - libglib >=2.74.1,<3.0a0
  - libpng >=1.6.39,<1.7.0a0
  - libpq >=15.1,<16.0a0
  - libsqlite >=3.40.0,<4.0a0
  - libstdcxx-ng >=12
  - libxcb >=1.13,<1.14.0a0
  - libxkbcommon >=1.0.3,<2.0a0
  - libxml2 >=2.10.3,<3.0.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - mysql-libs >=8.0.32,<8.1.0a0
  - nspr >=4.35,<5.0a0
  - nss >=3.82,<4.0a0
  - openssl >=3.0.8,<4.0a0
  - pulseaudio >=16.1,<16.2.0a0
  - xcb-util
  - xcb-util-image
  - xcb-util-keysyms
  - xcb-util-renderutil
  - xcb-util-wm
  - zstd >=1.5.2,<1.6.0a0
  constrains:
  - qt 5.15.8
  license: LGPL-3.0-only
  license_family: LGPL
  size: 52472654
  timestamp: 1675839238854
- kind: conda
  name: readline
  version: '8.2'
  build: h8228510_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/readline-8.2-h8228510_1.conda
  sha256: 5435cf39d039387fbdc977b0a762357ea909a7694d9528ab40f005e9208744d7
  md5: 47d31b792659ce70f470b5c82fdfb7a4
  depends:
  - libgcc-ng >=12
  - ncurses >=6.3,<7.0a0
  license: GPL-3.0-only
  license_family: GPL
  size: 281456
  timestamp: 1679532220005
- kind: conda
  name: referencing
  version: 0.35.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/referencing-0.35.1-pyhd8ed1ab_0.conda
  sha256: be8d6d9e86b1a3fef5424127ff81782f8ca63d3058980859609f6f1ecdd34cb3
  md5: 0fc8b52192a8898627c3efae1003e9f6
  depends:
  - attrs >=22.2.0
  - python >=3.8
  - rpds-py >=0.7.0
  license: MIT
  license_family: MIT
  size: 42210
  timestamp: 1714619625532
- kind: conda
  name: regex
  version: 2024.7.24
  build: py310h5b4e0ec_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/regex-2024.7.24-py310h5b4e0ec_0.conda
  sha256: 502f08a5ef65e5d1ffd7e67fac0862ca8a275ae9e8ea364375a49c6cd5e1ff63
  md5: b8b20692fca7f60a11d18c694cfce91d
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Python-2.0
  license_family: PSF
  size: 349226
  timestamp: 1721873132985
- kind: conda
  name: requests
  version: 2.32.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/requests-2.32.3-pyhd8ed1ab_0.conda
  sha256: 5845ffe82a6fa4d437a2eae1e32a1ad308d7ad349f61e337c0a890fe04c513cc
  md5: 5ede4753180c7a550a443c430dc8ab52
  depends:
  - certifi >=2017.4.17
  - charset-normalizer >=2,<4
  - idna >=2.5,<4
  - python >=3.8
  - urllib3 >=1.21.1,<3
  constrains:
  - chardet >=3.0.2,<6
  license: Apache-2.0
  license_family: APACHE
  size: 58810
  timestamp: 1717057174842
- kind: conda
  name: rfc3339-validator
  version: 0.1.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/rfc3339-validator-0.1.4-pyhd8ed1ab_0.tar.bz2
  sha256: 7c7052b51de0b5c558f890bb11f8b5edbb9934a653d76be086b1182b9f54185d
  md5: fed45fc5ea0813240707998abe49f520
  depends:
  - python >=3.5
  - six
  license: MIT
  license_family: MIT
  size: 8064
  timestamp: 1638811838081
- kind: conda
  name: rfc3986-validator
  version: 0.1.1
  build: pyh9f0ad1d_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/rfc3986-validator-0.1.1-pyh9f0ad1d_0.tar.bz2
  sha256: 2a5b495a1de0f60f24d8a74578ebc23b24aa53279b1ad583755f223097c41c37
  md5: 912a71cc01012ee38e6b90ddd561e36f
  depends:
  - python
  license: MIT
  license_family: MIT
  size: 7818
  timestamp: 1598024297745
- kind: conda
  name: rpds-py
  version: 0.20.0
  build: py310h505e2c1_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/rpds-py-0.20.0-py310h505e2c1_1.conda
  sha256: 30b77b0487e78092117a60df392568d622c784138bccc026b4bcd32492c388aa
  md5: 315cebbd626f425e8abfa9a447fbe924
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  constrains:
  - __glibc >=2.17
  license: MIT
  license_family: MIT
  size: 331772
  timestamp: 1725327229240
- kind: conda
  name: sacremoses
  version: 0.0.53
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/sacremoses-0.0.53-pyhd8ed1ab_0.tar.bz2
  sha256: 2fdc52c648c0a0d80f2f6f484cd0933f9b553d2e568bf8b63abe444974eb75b5
  md5: 76c3c384fe0941f1b08193736e8e277a
  depends:
  - click
  - joblib
  - python >=3.6
  - regex
  - six
  - tqdm
  license: LGPL-2.1-or-later
  license_family: LGPL
  size: 437464
  timestamp: 1651557733363
- kind: conda
  name: scikit-learn
  version: 1.5.1
  build: py310h146d792_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/scikit-learn-1.5.1-py310h146d792_0.conda
  sha256: 0ab645a36e8f407f3d6f3e478c9b68d1bc66a032c9a6243867bd8aa75c377967
  md5: e780dce0374928b56e9012fb07ad2603
  depends:
  - __glibc >=2.17,<3.0.a0
  - _openmp_mutex >=4.5
  - joblib >=1.2.0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - numpy >=1.19,<3
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - scipy
  - threadpoolctl >=3.1.0
  license: BSD-3-Clause
  license_family: BSD
  size: 9233185
  timestamp: 1719998552337
- kind: conda
  name: scipy
  version: 1.14.1
  build: py310ha3fb0e1_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/scipy-1.14.1-py310ha3fb0e1_0.conda
  sha256: abd577d8a89cb6d4f21ac07bdf9fbc2d105794ed4e1348482d5f3819eea83d09
  md5: dcca3051fda0f861e8111c6368842a28
  depends:
  - __glibc >=2.17,<3.0.a0
  - libblas >=3.9.0,<4.0a0
  - libcblas >=3.9.0,<4.0a0
  - libgcc-ng >=13
  - libgfortran-ng
  - libgfortran5 >=13.3.0
  - liblapack >=3.9.0,<4.0a0
  - libstdcxx-ng >=13
  - numpy <2.3
  - numpy >=1.19,<3
  - numpy >=1.23.5
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: BSD-3-Clause
  license_family: BSD
  size: 16907009
  timestamp: 1724328294898
- kind: conda
  name: send2trash
  version: 1.8.3
  build: pyh0d859eb_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/send2trash-1.8.3-pyh0d859eb_0.conda
  sha256: c4401b071e86ddfa0ea4f34b85308db2516b6aeca50053535996864cfdee7b3f
  md5: 778594b20097b5a948c59e50ae42482a
  depends:
  - __linux
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 22868
  timestamp: 1712585140895
- kind: conda
  name: setuptools
  version: 65.6.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/setuptools-65.6.3-pyhd8ed1ab_0.conda
  sha256: ea9f7eee2648d8078391cf9f968d848b400349c784e761501fb32ae01d323acf
  md5: 9600fc9524d3f821e6a6d58c52f5bf5a
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 633713
  timestamp: 1671393917119
- kind: conda
  name: signalp6
  version: 6.0g
  build: '1'
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/predector/noarch/signalp6-6.0g-1.tar.bz2
  md5: 407d60174615bf8a43bce519525df9cc
  depends:
  - gzip
  - matplotlib >3.3.2
  - numpy >1.19.2
  - pip
  - python >=3.6
  - pytorch >1.7.0
  - setuptools
  - tqdm >4.46.1
  - unzip
  - wheel
  - zip
  license: proprietary
  size: 12840
  timestamp: 1643874689882
- kind: conda
  name: sip
  version: 6.7.12
  build: py310hc6cd4ac_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/sip-6.7.12-py310hc6cd4ac_0.conda
  sha256: 4c350a7ed9f5fd98196a50bc74ce1dc3bb05b0c90d17ea120439755fe2075796
  md5: 68d5bfccaba2d89a7812098dd3966d9b
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - packaging
  - ply
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - tomli
  license: GPL-3.0-only
  license_family: GPL
  size: 494293
  timestamp: 1697300616950
- kind: conda
  name: six
  version: 1.16.0
  build: pyh6c4a22f_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/six-1.16.0-pyh6c4a22f_0.tar.bz2
  sha256: a85c38227b446f42c5b90d9b642f2c0567880c15d72492d8da074a59c8f91dd6
  md5: e5f25f8dbc060e9a8d912e432202afc2
  depends:
  - python
  license: MIT
  license_family: MIT
  size: 14259
  timestamp: 1620240338595
- kind: conda
  name: sniffio
  version: 1.3.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/sniffio-1.3.1-pyhd8ed1ab_0.conda
  sha256: bc12100b2d8836b93c55068b463190505b8064d0fc7d025e89f20ebf22fe6c2b
  md5: 490730480d76cf9c8f8f2849719c6e2b
  depends:
  - python >=3.7
  license: Apache-2.0
  license_family: Apache
  size: 15064
  timestamp: 1708953086199
- kind: conda
  name: sortedcontainers
  version: 2.4.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/sortedcontainers-2.4.0-pyhd8ed1ab_0.tar.bz2
  sha256: 0cea408397d50c2afb2d25e987ebac4546ae11e549d65b1403d80dc368dfaaa6
  md5: 6d6552722448103793743dabfbda532d
  depends:
  - python >=2.7
  license: Apache-2.0
  license_family: APACHE
  size: 26314
  timestamp: 1621217159824
- kind: conda
  name: soupsieve
  version: '2.5'
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/soupsieve-2.5-pyhd8ed1ab_1.conda
  sha256: 54ae221033db8fbcd4998ccb07f3c3828b4d77e73b0c72b18c1d6a507059059c
  md5: 3f144b2c34f8cb5a9abd9ed23a39c561
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 36754
  timestamp: 1693929424267
- kind: conda
  name: stack_data
  version: 0.6.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/stack_data-0.6.2-pyhd8ed1ab_0.conda
  sha256: a58433e75229bec39f3be50c02efbe9b7083e53a1f31d8ee247564f370191eec
  md5: e7df0fdd404616638df5ece6e69ba7af
  depends:
  - asttokens
  - executing
  - pure_eval
  - python >=3.5
  license: MIT
  license_family: MIT
  size: 26205
  timestamp: 1669632203115
- kind: conda
  name: sympy
  version: 1.13.2
  build: pypyh2585a3b_103
  build_number: 103
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/sympy-1.13.2-pypyh2585a3b_103.conda
  sha256: ef2e841c53aff71fcbf5922883543374040a9799d064d152516b30ff6694e022
  md5: 7327125b427c98b81564f164c4a75d4c
  depends:
  - __unix
  - gmpy2 >=2.0.8
  - mpmath >=0.19
  - python * *_cpython
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 4568532
  timestamp: 1723500430872
- kind: conda
  name: tbb
  version: 2021.9.0
  build: hf52228f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/tbb-2021.9.0-hf52228f_0.conda
  sha256: 86352f4361e8dc2374a95d9d1dfee742beecaa59dcb0e76ca36ca06a4efe1df2
  md5: f495e42d3d2020b025705625edf35490
  depends:
  - libgcc-ng >=12
  - libhwloc >=2.9.1,<2.9.2.0a0
  - libstdcxx-ng >=12
  license: Apache-2.0
  license_family: APACHE
  size: 1527865
  timestamp: 1681486787952
- kind: conda
  name: tblib
  version: 3.0.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/tblib-3.0.0-pyhd8ed1ab_0.conda
  sha256: 2e2c255b6f24a6d75b9938cb184520e27db697db2c24f04e18342443ae847c0a
  md5: 04eedddeb68ad39871c8127dd1c21f4f
  depends:
  - python >=3.7
  license: BSD-2-Clause
  license_family: BSD
  size: 17386
  timestamp: 1702066480361
- kind: conda
  name: termcolor
  version: 2.4.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/termcolor-2.4.0-pyhd8ed1ab_0.conda
  sha256: 59588d41f2c02d599fd6528583013d85bd47d17b1acec11edbb29deadd81fbca
  md5: a5033708ad9283907c3b1bc1f90d0d0d
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 12721
  timestamp: 1704358124294
- kind: conda
  name: terminado
  version: 0.18.1
  build: pyh0d859eb_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/terminado-0.18.1-pyh0d859eb_0.conda
  sha256: b300557c0382478cf661ddb520263508e4b3b5871b471410450ef2846e8c352c
  md5: efba281bbdae5f6b0a1d53c6d4a97c93
  depends:
  - __linux
  - ptyprocess
  - python >=3.8
  - tornado >=6.1.0
  license: BSD-2-Clause
  license_family: BSD
  size: 22452
  timestamp: 1710262728753
- kind: conda
  name: threadpoolctl
  version: 3.5.0
  build: pyhc1e730c_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/threadpoolctl-3.5.0-pyhc1e730c_0.conda
  sha256: 45e402941f6bed094022c5726a2ca494e6224b85180d2367fb6ddd9aea68079d
  md5: df68d78237980a159bd7149f33c0e8fd
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 23548
  timestamp: 1714400228771
- kind: conda
  name: tinycss2
  version: 1.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/tinycss2-1.3.0-pyhd8ed1ab_0.conda
  sha256: bc55e5899e66805589c02061e315bfc23ae6cc2f2811f5cc13fb189a5ed9d90f
  md5: 8662629d9a05f9cff364e31ca106c1ac
  depends:
  - python >=3.5
  - webencodings >=0.4
  license: BSD-3-Clause
  license_family: BSD
  size: 25405
  timestamp: 1713975078735
- kind: conda
  name: tk
  version: 8.6.13
  build: noxft_h4845f30_101
  build_number: 101
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/tk-8.6.13-noxft_h4845f30_101.conda
  sha256: e0569c9caa68bf476bead1bed3d79650bb080b532c64a4af7d8ca286c08dea4e
  md5: d453b98d9c83e71da0741bb0ff4d76bc
  depends:
  - libgcc-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: TCL
  license_family: BSD
  size: 3318875
  timestamp: 1699202167581
- kind: conda
  name: tokenizers
  version: 0.15.0
  build: py310h320607d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/tokenizers-0.15.0-py310h320607d_0.conda
  sha256: 7d687a87980211e2c097f6f3ffa4dd55880e5872f21e4bf925bd2445a44c537b
  md5: 1479bf9e85d28af32f1857939860726a
  depends:
  - huggingface_hub >=0.16.4,<0.18
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - openssl >=3.1.4,<4.0a0
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Apache-2.0
  license_family: APACHE
  size: 2890145
  timestamp: 1700119577086
- kind: conda
  name: toml
  version: 0.10.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/toml-0.10.2-pyhd8ed1ab_0.tar.bz2
  sha256: f0f3d697349d6580e4c2f35ba9ce05c65dc34f9f049e85e45da03800b46139c1
  md5: f832c45a477c78bebd107098db465095
  depends:
  - python >=2.7
  license: MIT
  license_family: MIT
  size: 18433
  timestamp: 1604308660817
- kind: conda
  name: tomli
  version: 2.0.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/tomli-2.0.1-pyhd8ed1ab_0.tar.bz2
  sha256: 4cd48aba7cd026d17e86886af48d0d2ebc67ed36f87f6534f4b67138f5a5a58f
  md5: 5844808ffab9ebdb694585b50ba02a96
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 15940
  timestamp: 1644342331069
- kind: conda
  name: toolz
  version: 0.12.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/toolz-0.12.1-pyhd8ed1ab_0.conda
  sha256: 22b0a9790317526e08609d5dfdd828210ae89e6d444a9e954855fc29012e90c6
  md5: 2fcb582444635e2c402e8569bb94e039
  depends:
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 52358
  timestamp: 1706112720607
- kind: conda
  name: torchaudio
  version: 2.3.0
  build: py310_cu121
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/torchaudio-2.3.0-py310_cu121.tar.bz2
  sha256: ea082c3c2b43439f8d32a3dafbf967aeb0302d5aa8eb7cbfc4a3f4eb370dd54e
  md5: dccb50ebe8b8f3e2ba31b72b10cbdee2
  depends:
  - numpy
  - python >=3.10,<3.11.0a0
  - pytorch 2.3.0
  - pytorch-cuda 12.1.*
  - pytorch-mutex 1.0 cuda
  constrains:
  - cpuonly <0
  license: BSD
  size: 6513096
  timestamp: 1712671163588
- kind: conda
  name: torchdata
  version: 0.8.0
  build: py310
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/torchdata-0.8.0-py310.tar.bz2
  sha256: 907580bb7c67501b5fe8f8b4d25c9f765b4f791c294c92241982d4757ecc7918
  md5: 532b2c2abed87386fa6cbcbd5affaa07
  depends:
  - openssl >=3.0.14,<4.0a0
  - python >=3.10,<3.11.0a0
  - pytorch >=2.0
  - requests
  - urllib3 >=1.25
  - zlib >=1.2.13,<1.3.0a0
  license: BSD
  size: 2555611
  timestamp: 1722365837933
- kind: conda
  name: torchtext
  version: 0.18.0
  build: py310
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/torchtext-0.18.0-py310.tar.bz2
  sha256: fc68a72167c0041255e0a734a3c75879219c7b72f98a5115d9124d06802f75a7
  md5: e266b15b923297a70c6b316fccf0c8ab
  depends:
  - python >=3.10,<3.11.0a0
  - pytorch 2.3.0
  - requests
  - tqdm
  license: BSD
  size: 6502493
  timestamp: 1712863598003
- kind: conda
  name: torchtriton
  version: 2.3.0
  build: py310
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/torchtriton-2.3.0-py310.tar.bz2
  sha256: c18d9c804c3766544efc71c84d5537531b3b27fe3dcd08f967e488d4aa66fb2f
  md5: aac3facd7b9aa4de1c6bb2df0fac600d
  depends:
  - filelock
  - python >=3.10,<3.11.0a0
  - pytorch
  license: MIT
  size: 186009396
  timestamp: 1712608890813
- kind: conda
  name: torchvision
  version: 0.18.0
  build: py310_cu121
  subdir: linux-64
  url: https://conda.anaconda.org/pytorch/linux-64/torchvision-0.18.0-py310_cu121.tar.bz2
  sha256: 64b0a924f8f6aaf30ffa7813af1eaa3c84ed4dcbed574ddc951344d36c589c73
  md5: 7347c565df96b9dbd7b6729aee1758bb
  depends:
  - ffmpeg >=4.2
  - libjpeg-turbo
  - libpng
  - numpy >=1.11
  - pillow >=5.3.0,!=8.3.*
  - python >=3.10,<3.11.0a0
  - pytorch 2.3.0
  - pytorch-cuda 12.1.*
  - pytorch-mutex 1.0 cuda
  - requests
  constrains:
  - cpuonly <0
  license: BSD
  size: 8554504
  timestamp: 1712670150235
- kind: conda
  name: tornado
  version: 6.4.1
  build: py310hc51659f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/tornado-6.4.1-py310hc51659f_0.conda
  sha256: a7475a82b31221c327ab9892b63a8da97d48572af6c11d894746600af31ffbc5
  md5: c5a6aac4a1e0989986d9f06b3c2be2a0
  depends:
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Apache-2.0
  license_family: Apache
  size: 652717
  timestamp: 1717722929287
- kind: conda
  name: tqdm
  version: 4.66.5
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/tqdm-4.66.5-pyhd8ed1ab_0.conda
  sha256: f2384902cef72048b0e9bad5c03d7a843de02ba6bc8618a9ecab6ff81a131312
  md5: c6e94fc2b2ec71ea33fe7c7da259acb4
  depends:
  - colorama
  - python >=3.7
  license: MPL-2.0 or MIT
  size: 89519
  timestamp: 1722737568509
- kind: conda
  name: traitlets
  version: 5.14.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/traitlets-5.14.3-pyhd8ed1ab_0.conda
  sha256: 8a64fa0f19022828513667c2c7176cfd125001f3f4b9bc00d33732e627dd2592
  md5: 3df84416a021220d8b5700c613af2dc5
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 110187
  timestamp: 1713535244513
- kind: conda
  name: transformers
  version: 4.17.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/transformers-4.17.0-pyhd8ed1ab_0.tar.bz2
  sha256: edc16f4757e99a1c551a35891aea3906a4f2796fadbb64e6528ddbc9519e74a4
  md5: abfe19c52b76fac5be28b83f75bd0052
  depends:
  - dataclasses
  - filelock
  - huggingface_hub
  - importlib_metadata
  - numpy
  - packaging
  - python >=3.6
  - pytorch
  - pyyaml
  - regex !=2019.12.17
  - requests
  - sacremoses
  - tokenizers >=0.11.1,!=0.11.3
  - tqdm >=4.27
  license: Apache-2.0
  license_family: APACHE
  size: 1967391
  timestamp: 1653165665988
- kind: conda
  name: types-python-dateutil
  version: 2.9.0.20240821
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/types-python-dateutil-2.9.0.20240821-pyhd8ed1ab_0.conda
  sha256: 26b5939438e31ffc9ea5c56aaea5799804186887bd0d8d639d8fad1898f07bdd
  md5: a0637bb6a2428c10448807b9d87f082c
  depends:
  - python >=3.6
  license: Apache-2.0 AND MIT
  size: 21636
  timestamp: 1724221199053
- kind: conda
  name: typing-extensions
  version: 4.12.2
  build: hd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/typing-extensions-4.12.2-hd8ed1ab_0.conda
  sha256: d3b9a8ed6da7c9f9553c5fd8a4fca9c3e0ab712fa5f497859f82337d67533b73
  md5: 52d648bd608f5737b123f510bb5514b5
  depends:
  - typing_extensions 4.12.2 pyha770c72_0
  license: PSF-2.0
  license_family: PSF
  size: 10097
  timestamp: 1717802659025
- kind: conda
  name: typing_extensions
  version: 4.12.2
  build: pyha770c72_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/typing_extensions-4.12.2-pyha770c72_0.conda
  sha256: 0fce54f8ec3e59f5ef3bb7641863be4e1bf1279623e5af3d3fa726e8f7628ddb
  md5: ebe6952715e1d5eb567eeebf25250fa7
  depends:
  - python >=3.8
  license: PSF-2.0
  license_family: PSF
  size: 39888
  timestamp: 1717802653893
- kind: conda
  name: typing_utils
  version: 0.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/typing_utils-0.1.0-pyhd8ed1ab_0.tar.bz2
  sha256: 9e3758b620397f56fb709f796969de436d63b7117897159619b87938e1f78739
  md5: eb67e3cace64c66233e2d35949e20f92
  depends:
  - python >=3.6.1
  license: Apache-2.0
  license_family: APACHE
  size: 13829
  timestamp: 1622899345711
- kind: conda
  name: tzdata
  version: 2024a
  build: h0c530f3_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/tzdata-2024a-h0c530f3_0.conda
  sha256: 7b2b69c54ec62a243eb6fba2391b5e443421608c3ae5dbff938ad33ca8db5122
  md5: 161081fc7cec0bfda0d86d7cb595f8d8
  license: LicenseRef-Public-Domain
  size: 119815
  timestamp: 1706886945727
- kind: conda
  name: unicodedata2
  version: 15.1.0
  build: py310h2372a71_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/unicodedata2-15.1.0-py310h2372a71_0.conda
  sha256: 5ab2f2d4542ba0cc27d222c08ae61706babe7173b0c6dfa748aa37ff2fa9d824
  md5: 72637c58d36d9475fda24700c9796f19
  depends:
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  license: Apache-2.0
  license_family: Apache
  size: 374055
  timestamp: 1695848183607
- kind: conda
  name: unzip
  version: '6.0'
  build: h7f98852_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/unzip-6.0-h7f98852_3.tar.bz2
  sha256: 29ce83db159a99eaeb816a9833481aa0eb495c6f69772e779d86ea2924bb5f06
  md5: 7cb7109505433a5abbf68bb34b31edac
  depends:
  - libgcc-ng >=9.4.0
  license: LicenseRef-BSD-like
  size: 169143
  timestamp: 1643809621661
- kind: conda
  name: uri-template
  version: 1.3.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/uri-template-1.3.0-pyhd8ed1ab_0.conda
  sha256: b76904b53721dc88a46352324c79d2b077c2f74a9f7208ad2c4249892669ae94
  md5: 0944dc65cb4a9b5b68522c3bb585d41c
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 23999
  timestamp: 1688655976471
- kind: conda
  name: urllib3
  version: 2.2.2
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/urllib3-2.2.2-pyhd8ed1ab_1.conda
  sha256: 00c47c602c03137e7396f904eccede8cc64cc6bad63ce1fc355125df8882a748
  md5: e804c43f58255e977093a2298e442bb8
  depends:
  - brotli-python >=1.0.9
  - h2 >=4,<5
  - pysocks >=1.5.6,<2.0,!=1.5.7
  - python >=3.8
  - zstandard >=0.18.0
  license: MIT
  license_family: MIT
  size: 95048
  timestamp: 1719391384778
- kind: conda
  name: wcwidth
  version: 0.2.13
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/wcwidth-0.2.13-pyhd8ed1ab_0.conda
  sha256: b6cd2fee7e728e620ec736d8dfee29c6c9e2adbd4e695a31f1d8f834a83e57e3
  md5: 68f0738df502a14213624b288c60c9ad
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 32709
  timestamp: 1704731373922
- kind: conda
  name: webcolors
  version: 24.8.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/webcolors-24.8.0-pyhd8ed1ab_0.conda
  sha256: ec71f97c332a7d328ae038990b8090cbfa772f82845b5d2233defd167b7cc5ac
  md5: eb48b812eb4fbb9ff238a6651fdbbcae
  depends:
  - python >=3.5
  license: BSD-3-Clause
  license_family: BSD
  size: 18378
  timestamp: 1723294800217
- kind: conda
  name: webencodings
  version: 0.5.1
  build: pyhd8ed1ab_2
  build_number: 2
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/webencodings-0.5.1-pyhd8ed1ab_2.conda
  sha256: 2adf9bd5482802837bc8814cbe28d7b2a4cbd2e2c52e381329eaa283b3ed1944
  md5: daf5160ff9cde3a468556965329085b9
  depends:
  - python >=2.6
  license: BSD-3-Clause
  license_family: BSD
  size: 15600
  timestamp: 1694681458271
- kind: conda
  name: websocket-client
  version: 1.8.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/websocket-client-1.8.0-pyhd8ed1ab_0.conda
  sha256: 44a5e3b97feef24cd719f7851cca9af9799dc9c17d3e0298d5856baab2d682f5
  md5: f372c576b8774922da83cda2b12f9d29
  depends:
  - python >=3.8
  license: Apache-2.0
  license_family: APACHE
  size: 47066
  timestamp: 1713923494501
- kind: conda
  name: wheel
  version: 0.44.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/wheel-0.44.0-pyhd8ed1ab_0.conda
  sha256: d828764736babb4322b8102094de38074dedfc71f5ff405c9dfee89191c14ebc
  md5: d44e3b085abcaef02983c6305b84b584
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 58585
  timestamp: 1722797131787
- kind: conda
  name: widgetsnbextension
  version: 4.0.13
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/widgetsnbextension-4.0.13-pyhd8ed1ab_0.conda
  sha256: d155adc10f8c96f76d4468dbe37b33b4334dadf5cd4a95841aa009ca9bced5fa
  md5: 6372cd99502721bd7499f8d16b56268d
  depends:
  - python >=3.7
  license: BSD-3-Clause
  license_family: BSD
  size: 898656
  timestamp: 1724331433259
- kind: conda
  name: xcb-util
  version: 0.4.0
  build: h516909a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-0.4.0-h516909a_0.tar.bz2
  sha256: d797cecb10d9d20970656db803186b2d87e51f58202a87a359b18bae6f0b0d1e
  md5: a88ab22508ba067b689dc12696157cee
  depends:
  - libgcc-ng >=7.3.0
  - libxcb >=1.13
  license: MIT
  license_family: MIT
  size: 20109
  timestamp: 1574273086272
- kind: conda
  name: xcb-util-image
  version: 0.4.0
  build: h166bdaf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-image-0.4.0-h166bdaf_0.tar.bz2
  sha256: 6db358d4afa0eb1225e24871f6c64c1b6c433f203babdd43508b0d61252467d1
  md5: c9b568bd804cb2903c6be6f5f68182e4
  depends:
  - libgcc-ng >=12
  - libxcb >=1.13
  - libxcb >=1.13,<1.14.0a0
  - xcb-util >=0.4.0,<0.5.0a0
  license: MIT
  license_family: MIT
  size: 24256
  timestamp: 1654738819647
- kind: conda
  name: xcb-util-keysyms
  version: 0.4.0
  build: h516909a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-keysyms-0.4.0-h516909a_0.tar.bz2
  sha256: cdb8ed921d076daed3c3d485370ea821c45eb95b858a587ff2a53d9271f1287c
  md5: d04a6285315c4f03ebaf37355be272f9
  depends:
  - libgcc-ng >=7.3.0
  - libxcb >=1.13
  license: MIT
  license_family: MIT
  size: 11763
  timestamp: 1574268798739
- kind: conda
  name: xcb-util-renderutil
  version: 0.3.9
  build: h166bdaf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-renderutil-0.3.9-h166bdaf_0.tar.bz2
  sha256: 19d27b7af8fb8047e044de2b87244337343c51fe7caa0fbaa9c53c2215787188
  md5: 732e22f1741bccea861f5668cf7342a7
  depends:
  - libgcc-ng >=12
  - libxcb >=1.13
  - libxcb >=1.13,<1.14.0a0
  license: MIT
  license_family: MIT
  size: 15659
  timestamp: 1654738584558
- kind: conda
  name: xcb-util-wm
  version: 0.4.1
  build: h516909a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-wm-0.4.1-h516909a_0.tar.bz2
  sha256: 1ab62607ded0815b9a570e66a2af859cf4d9c79a3bfdd8b06f5d773fc1211ea5
  md5: 847df113dba16f0079758cacf9024409
  depends:
  - libgcc-ng >=7.3.0
  - libxcb >=1.13
  license: MIT
  license_family: MIT
  size: 56020
  timestamp: 1574276788949
- kind: conda
  name: xkeyboard-config
  version: '2.38'
  build: h0b41bf4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xkeyboard-config-2.38-h0b41bf4_0.conda
  sha256: 0518e65929deded6afc5f91f31febb15e8c93f7ee599a18b787f9fab3f79cfd6
  md5: 9ac34337e5101a87e5d91da05d84aa48
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 882013
  timestamp: 1676563054660
- kind: conda
  name: xorg-kbproto
  version: 1.0.7
  build: h7f98852_1002
  build_number: 1002
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-kbproto-1.0.7-h7f98852_1002.tar.bz2
  sha256: e90b0a6a5d41776f11add74aa030f789faf4efd3875c31964d6f9cfa63a10dd1
  md5: 4b230e8381279d76131116660f5a241a
  depends:
  - libgcc-ng >=9.3.0
  license: MIT
  license_family: MIT
  size: 27338
  timestamp: 1610027759842
- kind: conda
  name: xorg-libice
  version: 1.1.1
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libice-1.1.1-hd590300_0.conda
  sha256: 5aa9b3682285bb2bf1a8adc064cb63aff76ef9178769740d855abb42b0d24236
  md5: b462a33c0be1421532f28bfe8f4a7514
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 58469
  timestamp: 1685307573114
- kind: conda
  name: xorg-libsm
  version: 1.2.4
  build: h7391055_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libsm-1.2.4-h7391055_0.conda
  sha256: 089ad5f0453c604e18985480218a84b27009e9e6de9a0fa5f4a20b8778ede1f1
  md5: 93ee23f12bc2e684548181256edd2cf6
  depends:
  - libgcc-ng >=12
  - libuuid >=2.38.1,<3.0a0
  - xorg-libice >=1.1.1,<2.0a0
  license: MIT
  license_family: MIT
  size: 27433
  timestamp: 1685453649160
- kind: conda
  name: xorg-libx11
  version: 1.8.4
  build: h0b41bf4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libx11-1.8.4-h0b41bf4_0.conda
  sha256: 3c6862a01a39cdea3870b132706ad7256824299947a3a94ae361d863d402d704
  md5: ea8fbfeb976ac49cbeb594e985393514
  depends:
  - libgcc-ng >=12
  - libxcb 1.*
  - libxcb >=1.13,<1.14.0a0
  - xorg-kbproto
  - xorg-xextproto >=7.3.0,<8.0a0
  - xorg-xproto
  license: MIT
  license_family: MIT
  size: 829872
  timestamp: 1677611125385
- kind: conda
  name: xorg-libxau
  version: 1.0.11
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxau-1.0.11-hd590300_0.conda
  sha256: 309751371d525ce50af7c87811b435c176915239fc9e132b99a25d5e1703f2d4
  md5: 2c80dc38fface310c9bd81b17037fee5
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 14468
  timestamp: 1684637984591
- kind: conda
  name: xorg-libxdmcp
  version: 1.1.3
  build: h7f98852_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxdmcp-1.1.3-h7f98852_0.tar.bz2
  sha256: 4df7c5ee11b8686d3453e7f3f4aa20ceef441262b49860733066c52cfd0e4a77
  md5: be93aabceefa2fac576e971aef407908
  depends:
  - libgcc-ng >=9.3.0
  license: MIT
  license_family: MIT
  size: 19126
  timestamp: 1610071769228
- kind: conda
  name: xorg-libxext
  version: 1.3.4
  build: h0b41bf4_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxext-1.3.4-h0b41bf4_2.conda
  sha256: 73e5cfbdff41ef8a844441f884412aa5a585a0f0632ec901da035a03e1fe1249
  md5: 82b6df12252e6f32402b96dacc656fec
  depends:
  - libgcc-ng >=12
  - xorg-libx11 >=1.7.2,<2.0a0
  - xorg-xextproto
  license: MIT
  license_family: MIT
  size: 50143
  timestamp: 1677036907815
- kind: conda
  name: xorg-libxrender
  version: 0.9.10
  build: h7f98852_1003
  build_number: 1003
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxrender-0.9.10-h7f98852_1003.tar.bz2
  sha256: 7d907ed9e2ec5af5d7498fb3ab744accc298914ae31497ab6dcc6ef8bd134d00
  md5: f59c1242cc1dd93e72c2ee2b360979eb
  depends:
  - libgcc-ng >=9.3.0
  - xorg-libx11 >=1.7.0,<2.0a0
  - xorg-renderproto
  license: MIT
  license_family: MIT
  size: 32906
  timestamp: 1614866792944
- kind: conda
  name: xorg-renderproto
  version: 0.11.1
  build: h7f98852_1002
  build_number: 1002
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-renderproto-0.11.1-h7f98852_1002.tar.bz2
  sha256: 38942930f233d1898594dd9edf4b0c0786f3dbc12065a0c308634c37fd936034
  md5: 06feff3d2634e3097ce2fe681474b534
  depends:
  - libgcc-ng >=9.3.0
  license: MIT
  license_family: MIT
  size: 9621
  timestamp: 1614866326326
- kind: conda
  name: xorg-xextproto
  version: 7.3.0
  build: h0b41bf4_1003
  build_number: 1003
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-xextproto-7.3.0-h0b41bf4_1003.conda
  sha256: b8dda3b560e8a7830fe23be1c58cc41f407b2e20ae2f3b6901eb5842ba62b743
  md5: bce9f945da8ad2ae9b1d7165a64d0f87
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 30270
  timestamp: 1677036833037
- kind: conda
  name: xorg-xproto
  version: 7.0.31
  build: h7f98852_1007
  build_number: 1007
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-xproto-7.0.31-h7f98852_1007.tar.bz2
  sha256: f197bb742a17c78234c24605ad1fe2d88b1d25f332b75d73e5ba8cf8fbc2a10d
  md5: b4a4381d54784606820704f7b5f05a15
  depends:
  - libgcc-ng >=9.3.0
  license: MIT
  license_family: MIT
  size: 74922
  timestamp: 1607291557628
- kind: conda
  name: xz
  version: 5.2.6
  build: h166bdaf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xz-5.2.6-h166bdaf_0.tar.bz2
  sha256: 03a6d28ded42af8a347345f82f3eebdd6807a08526d47899a42d62d319609162
  md5: 2161070d867d1b1204ea749c8eec4ef0
  depends:
  - libgcc-ng >=12
  license: LGPL-2.1 and GPL-2.0
  size: 418368
  timestamp: 1660346797927
- kind: conda
  name: yaml
  version: 0.2.5
  build: h7f98852_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/yaml-0.2.5-h7f98852_2.tar.bz2
  sha256: a4e34c710eeb26945bdbdaba82d3d74f60a78f54a874ec10d373811a5d217535
  md5: 4cb3ad778ec2d5a7acbdf254eb1c42ae
  depends:
  - libgcc-ng >=9.4.0
  license: MIT
  license_family: MIT
  size: 89141
  timestamp: 1641346969816
- kind: conda
  name: zeromq
  version: 4.3.5
  build: h59595ed_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zeromq-4.3.5-h59595ed_1.conda
  sha256: 3bec658f5c23abf5e200d98418add7a20ff7b45c928ad4560525bef899496256
  md5: 7fc9d3288d2420bb3637647621018000
  depends:
  - libgcc-ng >=12
  - libsodium >=1.0.18,<1.0.19.0a0
  - libstdcxx-ng >=12
  license: MPL-2.0
  license_family: MOZILLA
  size: 343438
  timestamp: 1709135220800
- kind: conda
  name: zict
  version: 3.0.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/zict-3.0.0-pyhd8ed1ab_0.conda
  sha256: 3d65c081514569ab3642ba7e6c2a6b4615778b596db6b1c82ee30a2d912539e5
  md5: cf30c2c15b82aacb07f9c09e28ff2275
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 36325
  timestamp: 1681770298596
- kind: conda
  name: zip
  version: '3.0'
  build: hd590300_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zip-3.0-hd590300_3.conda
  sha256: 36278352573704156e60a8db8e7d8c1d20bc55b7d13db779303bffb3427effcb
  md5: 4ff9a959f824eb05cc82024369d61e2b
  depends:
  - libgcc-ng >=12
  license: BSD-like
  size: 176792
  timestamp: 1696102326008
- kind: conda
  name: zipp
  version: 3.20.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/zipp-3.20.0-pyhd8ed1ab_0.conda
  sha256: 72fa72af24006e37a9f027d6d9f407369edcbd9bbb93db299820eb63ea07e404
  md5: 05b6bcb391b5be17374f7ad0aeedc479
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 20857
  timestamp: 1723591347715
- kind: conda
  name: zlib
  version: 1.2.13
  build: h4ab18f5_6
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zlib-1.2.13-h4ab18f5_6.conda
  sha256: 534824ea44939f3e59ca8ebb95e3ece6f50f9d2a0e69999fbc692311252ed6ac
  md5: 559d338a4234c2ad6e676f460a093e67
  depends:
  - libgcc-ng >=12
  - libzlib 1.2.13 h4ab18f5_6
  license: Zlib
  license_family: Other
  size: 92883
  timestamp: 1716874088980
- kind: conda
  name: zstandard
  version: 0.23.0
  build: py310h64cae3c_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zstandard-0.23.0-py310h64cae3c_0.conda
  sha256: de35f156899fc51bf28895989bd04a048849657ddd7a8baa29d09c4e254cd336
  md5: b527de1849629f2635dafc77745b015a
  depends:
  - __glibc >=2.17,<3.0.a0
  - cffi >=1.11
  - libgcc-ng >=12
  - python >=3.10,<3.11.0a0
  - python_abi 3.10.* *_cp310
  - zstd >=1.5.6,<1.5.7.0a0
  - zstd >=1.5.6,<1.6.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 407508
  timestamp: 1721044137484
- kind: conda
  name: zstd
  version: 1.5.6
  build: ha6fb4c9_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zstd-1.5.6-ha6fb4c9_0.conda
  sha256: c558b9cc01d9c1444031bd1ce4b9cff86f9085765f17627a6cd85fc623c8a02b
  md5: 4d056880988120e29d75bfff282e0f45
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 554846
  timestamp: 1714722996770
EOF

cd $ENVIRONMENT

export PIXI_FROZEN=true
# export PIXI_LOCKED=true
pixi install

RESULT=$?
if [ $RESULT -ne 0 ]; then
  echo "FAILED PIXI"
  exit
fi

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
# rfdiffusion_aa
################################################################################

git clone https://github.com/baker-laboratory/rf_diffusion_all_atom.git ${REPOS}/rf_diffusion_all_atom
wget http://files.ipd.uw.edu/pub/RF-All-Atom/weights/RFDiffusionAA_paper_weights.pt \
     -O ${REPOS}/rf_diffusion_all_atom/RFDiffusionAA_paper_weights.pt

cd ${REPOS}/rf_diffusion_all_atom
git submodule init
git submodule update

################################################################################
# openmm
################################################################################

wget https://github.com/openmm/openmm/archive/refs/tags/8.1.2.tar.gz -O /tmp/openmm-8.1.2.tar.gz
tar -xf /tmp/openmm-8.1.2.tar.gz -C /tmp
mkdir -p /tmp/openmm-8.1.2/build && cd /tmp/openmm-8.1.2/build

cmake -DCMAKE_INSTALL_PREFIX=${PROGS}/openmm-8.1.2 .. #-DOPENMM_BUILD_CUDA_LIB

make -j4
# make test
make install
make PythonInstall
python3 -m openmm.testInstallation
# make && make install && make PythonInstall

rm -rf /tmp/openmm-8.1.2.tar.gz
rm -rf /tmp/openmm-8.1.2
