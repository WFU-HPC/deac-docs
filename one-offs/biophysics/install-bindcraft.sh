#!/bin/bash

export SOFTWARE=/deac/opt/rocky9-noarch/deac-envs/biophysics
export ENVIRONMENT=${SOFTWARE}/env-bindcraft
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
channels = ["conda-forge", "nvidia", "https://conda.graylab.jhu.edu"]
description = "A python environment for bindcraft (https://github.com/martinpacesa/BindCraft)"
name = "bindcraft"
platforms = ["linux-64"]
version = "0.1.0"

[system-requirements]
cuda = "12"

[tasks]

[dependencies]
pip = "*"
pandas = "*"
matplotlib = "*"
jupyter = "*"
jupyterlab = "*"
numpy = "<2"
biopython = "*"
scipy = "*"
pdbfixer = "*"
seaborn = "*"
tqdm = "*"
fsspec = "*"
py3dmol = "*"
chex = "*"
dm-haiku = "*"
dm-tree = "*"
joblib = "*"
ml-collections = "*"
immutabledict = "*"
optax = "*"
jax = "*"
jaxlib = { version = "0.4.*", build = "cuda120py311*" }
cuda-nvcc = { version = "*", channel = "nvidia" }
cudnn = { version = "*", channel = "conda-forge" }
pyrosetta = "2023.*"
EOF

cat << EOF > ${ENVIRONMENT}/pixi.lock
version: 5
environments:
  default:
    channels:
    - url: https://conda.anaconda.org/conda-forge/
    - url: https://conda.anaconda.org/nvidia/
    - url: https://conda.graylab.jhu.edu/
    packages:
      linux-64:
      - conda: https://conda.anaconda.org/conda-forge/linux-64/_libgcc_mutex-0.1-conda_forge.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/_openmp_mutex-4.5-2_gnu.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/absl-py-2.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/alsa-lib-1.2.12-h4ab18f5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/anyio-4.6.2.post1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/aom-3.9.1-hac33072_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/argon2-cffi-23.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/argon2-cffi-bindings-21.2.0-py311h9ecbd09_5.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/arrow-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/asttokens-2.4.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/async-lru-2.0.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/attr-2.5.1-h166bdaf_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/attrs-24.2.0-pyh71513ae_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/babel-2.14.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/beautifulsoup4-4.12.3-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/binutils_impl_linux-64-2.43-h4bf12b8_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/binutils_linux-64-2.43-h4852527_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/biopython-1.84-py311h331c9d8_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/bleach-6.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/blosc-1.21.5-hc2324a3_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/brotli-1.1.0-hb9d3cd8_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/brotli-bin-1.1.0-hb9d3cd8_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/brotli-python-1.1.0-py311hfdbb021_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/bzip2-1.0.8-h4bc722e_7.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/c-ares-1.34.2-heb4867d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ca-certificates-2024.8.30-hbcca054_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cached-property-1.5.2-hd8ed1ab_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/cached_property-1.5.2-pyha770c72_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cairo-1.18.0-h3faef2a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/certifi-2024.8.30-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cffi-1.17.1-py311hf29c0ef_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/charset-normalizer-3.4.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/chex-0.1.86-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/colorama-0.4.6-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/comm-0.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/contextlib2-21.6.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/contourpy-1.3.0-py311hd18a35c_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-cccl_linux-64-12.6.77-ha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-crt-dev_linux-64-12.6.77-ha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-crt-tools-12.6.77-ha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-cudart-12.6.77-h5888daf_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-cudart-dev-12.6.77-h5888daf_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-cudart-dev_linux-64-12.6.77-h3f2d84a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-cudart-static-12.6.77-h5888daf_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-cudart-static_linux-64-12.6.77-h3f2d84a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-cudart_linux-64-12.6.77-h3f2d84a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-cupti-12.6.80-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-driver-dev_linux-64-12.6.77-h3f2d84a_0.conda
      - conda: https://conda.anaconda.org/nvidia/linux-64/cuda-nvcc-12.6.77-0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-nvcc-dev_linux-64-12.6.77-he91c749_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvcc-impl-12.6.77-h85509e4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvcc-tools-12.6.77-he02047a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvcc_linux-64-12.6.77-h8a487aa_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvrtc-12.6.77-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvtx-12.6.77-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-nvvm-dev_linux-64-12.6.77-ha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvvm-impl-12.6.77-he02047a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvvm-tools-12.6.77-he02047a_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cuda-version-12.6-h7480c83_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/cudnn-8.9.7.29-h092f7fd_3.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/cycler-0.12.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/dataclasses-0.8-pyhc8e2a94_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/dav1d-1.2.1-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/dbus-1.13.6-h5008d03_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/debugpy-1.8.7-py311hfdbb021_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/decorator-5.1.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/defusedxml-0.7.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/dm-haiku-0.0.12-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/dm-tree-0.1.8-py311hbffca5d_5.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/entrypoints-0.4-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/etils-1.10.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/exceptiongroup-1.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/executing-2.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/expat-2.6.3-h5888daf_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/flax-0.9.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-dejavu-sans-mono-2.37-hab24e00_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-inconsolata-3.000-h77eed37_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-source-code-pro-2.038-h77eed37_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/font-ttf-ubuntu-0.83-h77eed37_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/fontconfig-2.14.2-h14ed4e7_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fonts-conda-ecosystem-1-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/fonts-conda-forge-1-0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/fonttools-4.54.1-py311h9ecbd09_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fqdn-1.5.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/freetype-2.12.1-h267a509_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/fsspec-2024.9.0-pyhff2d567_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gcc_impl_linux-64-13.3.0-hfea6d02_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gcc_linux-64-13.3.0-hc28eda2_4.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gettext-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gettext-tools-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/glib-2.80.2-hf974151_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/glib-tools-2.80.2-hb6ce0ca_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/graphite2-1.3.13-h59595ed_1003.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gst-plugins-base-1.24.4-h9ad1361_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gstreamer-1.24.4-haf2f30d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gxx_impl_linux-64-13.3.0-hdbfa832_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/gxx_linux-64-13.3.0-h6834431_4.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/h11-0.14.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/h2-4.1.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/harfbuzz-8.5.0-hfac3d4d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/hpack-4.0.0-pyh9f0ad1d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/httpcore-1.0.6-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/httpx-0.27.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/hyperframe-6.0.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/icu-73.2-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/idna-3.10-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/immutabledict-4.2.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/importlib-metadata-8.5.0-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/importlib_metadata-8.5.0-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/importlib_resources-6.4.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ipykernel-6.29.5-pyh3099207_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ipython-8.28.0-pyh707e725_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ipywidgets-8.1.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/isoduration-20.11.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/jax-0.4.27-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jaxlib-0.4.23-cuda120py311h5a49573_202.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jedi-0.19.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jinja2-3.1.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jmp-0.0.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/joblib-1.4.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/json5-0.9.25-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/jsonpointer-3.0.0-py311h38be061_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jsonschema-4.23.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jsonschema-specifications-2024.10.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jsonschema-with-format-nongpl-4.23.0-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter-1.1.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter-lsp-2.2.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_client-8.6.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_console-6.6.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_core-5.7.2-pyh31011fe_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_events-0.10.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_server-2.14.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyter_server_terminals-0.5.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab-4.2.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_pygments-0.3.0-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_server-2.27.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/jupyterlab_widgets-3.0.13-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/kernel-headers_linux-64-3.10.0-he073ed8_17.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/keyutils-1.6.1-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/kiwisolver-1.4.7-py311hd18a35c_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/krb5-1.21.3-h659f571_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lame-3.100-h166bdaf_1003.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lcms2-2.16-hb7c19ff_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ld_impl_linux-64-2.43-h712a8e2_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lerc-4.0.0-h27087fc_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libabseil-20240116.2-cxx17_he02047a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libasprintf-0.22.5-he8f35ee_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libasprintf-devel-0.22.5-he8f35ee_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libavif16-1.1.1-h104a339_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libblas-3.9.0-24_linux64_openblas.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libbrotlicommon-1.1.0-hb9d3cd8_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libbrotlidec-1.1.0-hb9d3cd8_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libbrotlienc-1.1.0-hb9d3cd8_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcap-2.69-h0f662aa_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcblas-3.9.0-24_linux64_openblas.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libclang-cpp15-15.0.7-default_h127d8a8_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libclang13-18.1.7-default_h087397f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcublas-12.6.3.3-hbd13f7d_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcufft-11.3.0.4-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcups-2.3.3-h4637d8d_4.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcurand-10.3.7.77-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcurl-8.8.0-hca28451_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcusolver-11.7.1.2-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libcusparse-12.5.4.2-hbd13f7d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libdeflate-1.20-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libedit-3.1.20191231-he28a2e2_2.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libev-4.33-hd590300_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libevent-2.1.12-hf998b51_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libexpat-2.6.3-h5888daf_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libffi-3.4.2-h7f98852_5.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libflac-1.4.3-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgcc-14.2.0-h77fa898_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/libgcc-devel_linux-64-13.3.0-h84ea5a7_101.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgcc-ng-14.2.0-h69a702a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgcrypt-1.11.0-h4ab18f5_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgettextpo-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgettextpo-devel-0.22.5-he02047a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgfortran-14.2.0-h69a702a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgfortran-ng-14.2.0-h69a702a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgfortran5-14.2.0-hd5240d6_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libglib-2.80.2-hf974151_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgomp-14.2.0-h77fa898_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgpg-error-1.50-h4f305b6_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libgrpc-1.62.2-h15f2491_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libiconv-1.17-hd590300_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libjpeg-turbo-3.0.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/liblapack-3.9.0-24_linux64_openblas.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libllvm15-15.0.7-hb3ce162_4.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libllvm18-18.1.7-hb77312f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libnghttp2-1.58.0-h47da74e_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libnsl-2.0.1-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libnvjitlink-12.6.77-hbd13f7d_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libogg-1.3.5-h4ab18f5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libopenblas-0.3.27-pthreads_hac2b453_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libopus-1.3.1-h7f98852_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libpng-1.6.43-h2797004_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libpq-16.4-h2d7952a_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libprotobuf-4.25.3-h08a7969_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libre2-11-2023.09.01-h5a48ba9_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsanitizer-13.3.0-heb74ff8_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsndfile-1.2.2-hc60ed4a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsodium-1.0.20-h4ab18f5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsqlite-3.46.0-hde9e2c9_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libssh2-1.11.0-h0841786_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-14.2.0-hc0a3c3a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/libstdcxx-devel_linux-64-13.3.0-h84ea5a7_101.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-ng-14.2.0-h4852527_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libsystemd0-256.7-h2774228_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libtiff-4.6.0-h1dd3fc0_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libuuid-2.38.1-h0b41bf4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libvorbis-1.3.7-h9c3ff4c_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libwebp-base-1.4.0-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxcb-1.15-h0b41bf4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxcrypt-4.4.36-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxkbcommon-1.7.0-h662e7e4_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libxml2-2.12.7-hc051c1a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/libzlib-1.2.13-h4ab18f5_6.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/lz4-c-1.9.4-hcb278e6_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/markdown-it-py-3.0.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/markupsafe-3.0.1-py311h2dc5d0c_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-3.9.1-py311h38be061_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-base-3.9.1-py311h74b4f7c_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/matplotlib-inline-0.1.7-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/mdurl-0.1.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/mistune-3.0.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ml-collections-0.1.1-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ml_dtypes-0.5.0-py311h7db5c69_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mpg123-1.32.6-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/msgpack-python-1.1.0-py311hd18a35c_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/munkres-1.1.4-pyh9f0ad1d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mysql-common-8.3.0-hf1915f5_4.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/mysql-libs-8.3.0-hca2cd23_4.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nbclient-0.10.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nbconvert-core-7.16.4-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nbformat-5.10.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/nccl-2.23.4.1-h52f6c39_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ncurses-6.5-he02047a_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/nest-asyncio-1.6.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/notebook-7.2.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/notebook-shim-0.2.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/nspr-4.35-h27087fc_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/nss-3.100-hca3bf56_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/numpy-1.26.4-py311h64a7726_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ocl-icd-2.3.2-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/ocl-icd-system-1.0.0-1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openjpeg-2.5.2-h488ebb8_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openmm-8.1.2-py311h5db57db_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/openssl-3.3.2-hb9d3cd8_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/opt-einsum-3.4.0-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/opt_einsum-3.4.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/optax-0.2.2-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/orbax-checkpoint-0.4.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/overrides-7.7.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/packaging-24.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pandas-2.2.3-py311h7db5c69_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pandocfilters-1.5.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/parso-0.8.4-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/patsy-0.5.6-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pcre2-10.43-hcad00b1_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pdbfixer-1.9-pyh1a96a4e_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pexpect-4.9.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pickleshare-0.7.5-py_1003.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pillow-10.3.0-py311h18e6fac_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pip-24.2-pyh8b19718_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pixman-0.43.2-h59595ed_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pkgutil-resolve-name-1.3.10-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/platformdirs-4.3.6-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ply-3.11-pyhd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/prometheus_client-0.21.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/prompt-toolkit-3.0.48-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/prompt_toolkit-3.0.48-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/protobuf-4.25.3-py311hbffca5d_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/psutil-6.0.0-py311h9ecbd09_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pthread-stubs-0.4-hb9d3cd8_1002.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/ptyprocess-0.7.0-pyhd3deb0d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-client-17.0-hb77b528_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pure_eval-0.2.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/py3dmol-2.4.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pybind11-abi-4-hd8ed1ab_3.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/pycparser-2.22-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pygments-2.18.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pyparsing-3.2.0-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyqt-5.15.9-py311hf0fb5b6_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyqt5-sip-12.12.2-py311hb755f60_5.conda
      - conda: https://conda.graylab.jhu.edu/linux-64/pyrosetta-2023.49+release.9891f2c-py311_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/pysocks-1.7.1-pyha2e5f31_6.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/python-3.11.9-hb806964_0_cpython.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-dateutil-2.9.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-fastjsonschema-2.20.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-json-logger-2.0.7-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/python-tzdata-2024.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/python_abi-3.11-5_cp311.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/pytz-2024.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyyaml-6.0.2-py311h9ecbd09_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/pyzmq-26.2.0-py311h7deb3e3_3.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/qhull-2020.2-h434a139_5.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/qt-main-5.15.8-hc9dc06e_21.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/rav1e-0.6.6-he8a937b_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/re2-2023.09.01-h7f4b329_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/readline-8.2-h8228510_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/referencing-0.35.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/requests-2.32.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/rfc3339-validator-0.1.4-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/rfc3986-validator-0.1.1-pyh9f0ad1d_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/rich-13.9.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/rpds-py-0.20.0-py311h9e33e62_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/scipy-1.14.1-py311he1f765f_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/seaborn-0.13.2-hd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/seaborn-base-0.13.2-pyhd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/send2trash-1.8.3-pyh0d859eb_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/setuptools-75.1.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/sip-6.7.12-py311hb755f60_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/six-1.16.0-pyh6c4a22f_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/snappy-1.2.1-ha2e4443_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/sniffio-1.3.1-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/soupsieve-2.5-pyhd8ed1ab_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/stack_data-0.6.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/statsmodels-0.14.4-py311h9f3472d_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/svt-av1-2.2.1-h5888daf_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/sysroot_linux-64-2.17-h4a8ded7_17.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/tabulate-0.9.0-pyhd8ed1ab_1.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tensorstore-0.1.60-py311hbe3d8c9_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/terminado-0.18.1-pyh0d859eb_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/tinycss2-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tk-8.6.13-noxft_h4845f30_101.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/toml-0.10.2-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/tomli-2.0.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/toolz-1.0.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/tornado-6.4.1-py311h9ecbd09_1.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/tqdm-4.66.5-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/traitlets-5.14.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/types-python-dateutil-2.9.0.20241003-pyhff2d567_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/typing-extensions-4.12.2-hd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/typing_extensions-4.12.2-pyha770c72_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/typing_utils-0.1.0-pyhd8ed1ab_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/noarch/tzdata-2024b-hc8b5060_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/uri-template-1.3.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/urllib3-2.2.3-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/wcwidth-0.2.13-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/webcolors-24.8.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/webencodings-0.5.1-pyhd8ed1ab_2.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/websocket-client-1.8.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/wheel-0.44.0-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/widgetsnbextension-4.0.13-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-0.4.0-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-image-0.4.0-h8ee46fc_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-keysyms-0.4.0-h8ee46fc_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-renderutil-0.3.9-hd590300_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-wm-0.4.1-h8ee46fc_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xkeyboard-config-2.42-h4ab18f5_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-kbproto-1.0.7-hb9d3cd8_1003.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libice-1.1.1-hb9d3cd8_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libsm-1.2.4-he73a12e_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libx11-1.8.9-h8ee46fc_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxau-1.0.11-hb9d3cd8_1.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxdmcp-1.1.5-hb9d3cd8_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxext-1.3.4-h0b41bf4_2.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxrender-0.9.11-hd590300_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-renderproto-0.11.1-hb9d3cd8_1003.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-xextproto-7.3.0-hb9d3cd8_1004.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-xf86vidmodeproto-2.3.1-hb9d3cd8_1004.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xorg-xproto-7.0.31-hb9d3cd8_1008.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/xz-5.2.6-h166bdaf_0.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/yaml-0.2.5-h7f98852_2.tar.bz2
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zeromq-4.3.5-h3b0a872_6.conda
      - conda: https://conda.anaconda.org/conda-forge/noarch/zipp-3.20.2-pyhd8ed1ab_0.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zlib-1.2.13-h4ab18f5_6.conda
      - conda: https://conda.anaconda.org/conda-forge/linux-64/zstandard-0.23.0-py311hbc35293_1.conda
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
  build: 2_gnu
  build_number: 16
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/_openmp_mutex-4.5-2_gnu.tar.bz2
  sha256: fbe2c5e56a653bebb982eda4876a9178aedfc2b545f25d0ce9c4c0b508253d22
  md5: 73aaf86a425cc6e73fcf236a5a46396d
  depends:
  - _libgcc_mutex 0.1 conda_forge
  - libgomp >=7.5.0
  constrains:
  - openmp_impl 9999
  license: BSD-3-Clause
  license_family: BSD
  size: 23621
  timestamp: 1650670423406
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
  version: 1.2.12
  build: h4ab18f5_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/alsa-lib-1.2.12-h4ab18f5_0.conda
  sha256: 64b95dd06d7ca6b54cea03b02da8f1657b9899ca376d0ca7b47823064f55fb16
  md5: 7ed427f0871fd41cb1d9c17727c17589
  depends:
  - libgcc-ng >=12
  license: LGPL-2.1-or-later
  license_family: GPL
  size: 555868
  timestamp: 1718118368236
- kind: conda
  name: anyio
  version: 4.6.2.post1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/anyio-4.6.2.post1-pyhd8ed1ab_0.conda
  sha256: 4b54b7ce79d818e3cce54ae4d552dba51b7afac160ceecdefd04b3917a37c502
  md5: 688697ec5e9588bdded167d19577625b
  depends:
  - exceptiongroup >=1.0.2
  - idna >=2.8
  - python >=3.9
  - sniffio >=1.1
  - typing_extensions >=4.1
  constrains:
  - uvloop >=0.21.0b1
  - trio >=0.26.1
  license: MIT
  license_family: MIT
  size: 109864
  timestamp: 1728935803440
- kind: conda
  name: aom
  version: 3.9.1
  build: hac33072_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/aom-3.9.1-hac33072_0.conda
  sha256: b08ef033817b5f9f76ce62dfcac7694e7b6b4006420372de22494503decac855
  md5: 346722a0be40f6edc53f12640d301338
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: BSD-2-Clause
  license_family: BSD
  size: 2706396
  timestamp: 1718551242397
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
  build: py311h9ecbd09_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/argon2-cffi-bindings-21.2.0-py311h9ecbd09_5.conda
  sha256: d1af1fbcb698c2e07b0d1d2b98384dd6021fa55c8bcb920e3652e0b0c393881b
  md5: 18143eab7fcd6662c604b85850f0db1e
  depends:
  - __glibc >=2.17,<3.0.a0
  - cffi >=1.0.1
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: MIT
  license_family: MIT
  size: 35025
  timestamp: 1725356735679
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
  name: binutils_impl_linux-64
  version: '2.43'
  build: h4bf12b8_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/binutils_impl_linux-64-2.43-h4bf12b8_1.conda
  sha256: 6f945b3b150112c7c6e4783e6c3132410a7b226f2a8965adfd23895318151d46
  md5: 5f354010f194e85dc681dec92405ef9e
  depends:
  - ld_impl_linux-64 2.43 h712a8e2_1
  - sysroot_linux-64
  license: GPL-3.0-only
  license_family: GPL
  size: 6233238
  timestamp: 1727304698672
- kind: conda
  name: binutils_linux-64
  version: '2.43'
  build: h4852527_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/binutils_linux-64-2.43-h4852527_1.conda
  sha256: 16739398bff4d77e151e037f4c2932ad2a3ed57bb92396d50c33d3c395ad8e22
  md5: 8d70caec6e4c8754066ea278f0a282dd
  depends:
  - binutils_impl_linux-64 2.43 h4bf12b8_1
  license: GPL-3.0-only
  license_family: GPL
  size: 34906
  timestamp: 1727304732860
- kind: conda
  name: biopython
  version: '1.84'
  build: py311h331c9d8_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/biopython-1.84-py311h331c9d8_0.conda
  sha256: 8e32dc54555f02617ef943b35aa1e04131e6081a787c2c39d982a820e8930939
  md5: 1a76abea9989d7e690ad88c1743f2f13
  depends:
  - libgcc-ng >=12
  - numpy
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: LicenseRef-Biopython
  size: 3452010
  timestamp: 1720015072718
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
  name: blosc
  version: 1.21.5
  build: hc2324a3_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/blosc-1.21.5-hc2324a3_1.conda
  sha256: fde5e8ad75d2a5f154e29da7763a5dd9ee5b5b5c3fc22a1f5170296c8f6f3f62
  md5: 11d76bee958b1989bd1ac6ee7372ea6d
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - lz4-c >=1.9.3,<1.10.0a0
  - snappy >=1.2.0,<1.3.0a0
  - zstd >=1.5.5,<1.6.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 48693
  timestamp: 1712681892833
- kind: conda
  name: brotli
  version: 1.1.0
  build: hb9d3cd8_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/brotli-1.1.0-hb9d3cd8_2.conda
  sha256: fcb0b5b28ba7492093e54f3184435144e074dfceab27ac8e6a9457e736565b0b
  md5: 98514fe74548d768907ce7a13f680e8f
  depends:
  - __glibc >=2.17,<3.0.a0
  - brotli-bin 1.1.0 hb9d3cd8_2
  - libbrotlidec 1.1.0 hb9d3cd8_2
  - libbrotlienc 1.1.0 hb9d3cd8_2
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 19264
  timestamp: 1725267697072
- kind: conda
  name: brotli-bin
  version: 1.1.0
  build: hb9d3cd8_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/brotli-bin-1.1.0-hb9d3cd8_2.conda
  sha256: 261364d7445513b9a4debc345650fad13c627029bfc800655a266bf1e375bc65
  md5: c63b5e52939e795ba8d26e35d767a843
  depends:
  - __glibc >=2.17,<3.0.a0
  - libbrotlidec 1.1.0 hb9d3cd8_2
  - libbrotlienc 1.1.0 hb9d3cd8_2
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 18881
  timestamp: 1725267688731
- kind: conda
  name: brotli-python
  version: 1.1.0
  build: py311hfdbb021_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/brotli-python-1.1.0-py311hfdbb021_2.conda
  sha256: 949913bbd1f74d1af202d3e4bff2e0a4e792ec00271dc4dd08641d4221aa2e12
  md5: d21daab070d76490cb39a8f1d1729d79
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  constrains:
  - libbrotlicommon 1.1.0 hb9d3cd8_2
  license: MIT
  license_family: MIT
  size: 350367
  timestamp: 1725267768486
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
  name: c-ares
  version: 1.34.2
  build: heb4867d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/c-ares-1.34.2-heb4867d_0.conda
  sha256: c2a515e623ac3e17a56027c06098fbd5ab47afefefbd386b4c21289f2ec55139
  md5: 2b780c0338fc0ffa678ac82c54af51fd
  depends:
  - __glibc >=2.28,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 205797
  timestamp: 1729006575652
- kind: conda
  name: ca-certificates
  version: 2024.8.30
  build: hbcca054_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ca-certificates-2024.8.30-hbcca054_0.conda
  sha256: afee721baa6d988e27fef1832f68d6f32ac8cc99cdf6015732224c2841a09cea
  md5: c27d1c142233b5bc9ca570c6e2e0c244
  license: ISC
  size: 159003
  timestamp: 1725018903918
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
  version: 1.18.0
  build: h3faef2a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cairo-1.18.0-h3faef2a_0.conda
  sha256: 142e2639a5bc0e99c44d76f4cc8dce9c6a2d87330c4beeabb128832cd871a86e
  md5: f907bb958910dc404647326ca80c263e
  depends:
  - fontconfig >=2.14.2,<3.0a0
  - fonts-conda-ecosystem
  - freetype >=2.12.1,<3.0a0
  - icu >=73.2,<74.0a0
  - libgcc-ng >=12
  - libglib >=2.78.0,<3.0a0
  - libpng >=1.6.39,<1.7.0a0
  - libstdcxx-ng >=12
  - libxcb >=1.15,<1.16.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - pixman >=0.42.2,<1.0a0
  - xorg-libice >=1.1.1,<2.0a0
  - xorg-libsm >=1.2.4,<2.0a0
  - xorg-libx11 >=1.8.6,<2.0a0
  - xorg-libxext >=1.3.4,<2.0a0
  - xorg-libxrender >=0.9.11,<0.10.0a0
  - zlib
  license: LGPL-2.1-only or MPL-1.1
  size: 982351
  timestamp: 1697028423052
- kind: conda
  name: certifi
  version: 2024.8.30
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/certifi-2024.8.30-pyhd8ed1ab_0.conda
  sha256: 7020770df338c45ac6b560185956c32f0a5abf4b76179c037f115fc7d687819f
  md5: 12f7d00853807b0531775e9be891cb11
  depends:
  - python >=3.7
  license: ISC
  size: 163752
  timestamp: 1725278204397
- kind: conda
  name: cffi
  version: 1.17.1
  build: py311hf29c0ef_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cffi-1.17.1-py311hf29c0ef_0.conda
  sha256: bc47aa39c8254e9e487b8bcd74cfa3b4a3de3648869eb1a0b89905986b668e35
  md5: 55553ecd5328336368db611f350b7039
  depends:
  - __glibc >=2.17,<3.0.a0
  - libffi >=3.4,<4.0a0
  - libgcc >=13
  - pycparser
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: MIT
  license_family: MIT
  size: 302115
  timestamp: 1725560701719
- kind: conda
  name: charset-normalizer
  version: 3.4.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/charset-normalizer-3.4.0-pyhd8ed1ab_0.conda
  sha256: 1873ac45ea61f95750cb0b4e5e675d1c5b3def937e80c7eebb19297f76810be8
  md5: a374efa97290b8799046df7c5ca17164
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 47314
  timestamp: 1728479405343
- kind: conda
  name: chex
  version: 0.1.86
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/chex-0.1.86-pyhd8ed1ab_0.conda
  sha256: a95341e3131c7d9ad06188e0b5b8da3aa63214689bad5c7a0685c21800dacf26
  md5: a07f390c9f7e17295521faf5385e136f
  depends:
  - absl-py >=0.9.0
  - jax >=0.4.16
  - jaxlib >=0.1.37
  - numpy >=1.24.1
  - python >=3.9
  - toolz >=0.9.0
  - typing-extensions >=4.2.0
  license: Apache-2.0
  license_family: APACHE
  size: 77788
  timestamp: 1710851026888
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
  version: 1.3.0
  build: py311hd18a35c_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/contourpy-1.3.0-py311hd18a35c_2.conda
  sha256: 9d0abbb1f3bbfdd9070afbe389d6f9bf71e33bd53c0b3d1dcf12e63084f7993b
  md5: 66266cd4f20e47dc1de458c93fb4d2a9
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - numpy >=1.23
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: BSD-3-Clause
  license_family: BSD
  size: 277946
  timestamp: 1727293740030
- kind: conda
  name: cuda-cccl_linux-64
  version: 12.6.77
  build: ha770c72_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-cccl_linux-64-12.6.77-ha770c72_0.conda
  sha256: 00a7de1d084896758dc2d24b1faf4bf59e596790b22a3a08bf163a810bbacde8
  md5: 365a924cf93535157d61debac807e9e4
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 1067930
  timestamp: 1727807050610
- kind: conda
  name: cuda-crt-dev_linux-64
  version: 12.6.77
  build: ha770c72_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-crt-dev_linux-64-12.6.77-ha770c72_0.conda
  sha256: ca93253af634089e27c3bd400580093c314655f1a38039638c0d7dc5d1bdd82b
  md5: af318c4daebfb4c070f93102990fb621
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 87304
  timestamp: 1727815130222
- kind: conda
  name: cuda-crt-tools
  version: 12.6.77
  build: ha770c72_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-crt-tools-12.6.77-ha770c72_0.conda
  sha256: 743cc4ff922e70d35e334c2cb919d3d76c77a91a8167168a3d3c39b38b1c3786
  md5: c5a16b9df8b57743b06b016f941c80b0
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 26279
  timestamp: 1727815134930
- kind: conda
  name: cuda-cudart
  version: 12.6.77
  build: h5888daf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-cudart-12.6.77-h5888daf_0.conda
  sha256: e7a256a61d5b8c9d7d31932b5f4f35a8fda5a18c789cb971d98dca266fdd8792
  md5: feb533cb1e5f7ffbbb82d8465e0adaad
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-cudart_linux-64 12.6.77 h3f2d84a_0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 22397
  timestamp: 1727810461651
- kind: conda
  name: cuda-cudart-dev
  version: 12.6.77
  build: h5888daf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-cudart-dev-12.6.77-h5888daf_0.conda
  sha256: 527329f312ac6feb775e8e4d22d5b634feab2fe5cc8afb15b453d64a773945d9
  md5: 86e47562bfe92a529ae1c75bbcff814b
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-cudart 12.6.77 h5888daf_0
  - cuda-cudart-dev_linux-64 12.6.77 h3f2d84a_0
  - cuda-cudart-static 12.6.77 h5888daf_0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 22830
  timestamp: 1727810484719
- kind: conda
  name: cuda-cudart-dev_linux-64
  version: 12.6.77
  build: h3f2d84a_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-cudart-dev_linux-64-12.6.77-h3f2d84a_0.conda
  sha256: 60847bd8c74b02ca17d68d742fe545db84a18bf808344eb99929f32f79bffcf9
  md5: f967e2449b6c066f6d09497fff12d803
  depends:
  - cuda-cccl_linux-64
  - cuda-cudart-static_linux-64
  - cuda-cudart_linux-64
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 365370
  timestamp: 1727810466552
- kind: conda
  name: cuda-cudart-static
  version: 12.6.77
  build: h5888daf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-cudart-static-12.6.77-h5888daf_0.conda
  sha256: 79a58bc3eb216dd32f7adb8fe13619c34c23705d997460864293859ecea38f33
  md5: ae37b405ef74e57ef9685fcf820a2dde
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-cudart-static_linux-64 12.6.77 h3f2d84a_0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 22446
  timestamp: 1727810474901
- kind: conda
  name: cuda-cudart-static_linux-64
  version: 12.6.77
  build: h3f2d84a_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-cudart-static_linux-64-12.6.77-h3f2d84a_0.conda
  sha256: aefed29499bdbe5d0c65ca44ef596929cf34cc3014f0ae225cdd45a0e66f2660
  md5: 3ad8eacbf716ddbca1b5292a3668c821
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 762328
  timestamp: 1727810443982
- kind: conda
  name: cuda-cudart_linux-64
  version: 12.6.77
  build: h3f2d84a_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-cudart_linux-64-12.6.77-h3f2d84a_0.conda
  sha256: cf8433afa236108dba2a94ea5d4f605c50f0e297ee54eb6cb37175fd84ced907
  md5: 314908ad05e2c4833475a7d93f4149ca
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 188616
  timestamp: 1727810451690
- kind: conda
  name: cuda-cupti
  version: 12.6.80
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-cupti-12.6.80-hbd13f7d_0.conda
  sha256: 41cef2d389f5e467de25446aa0d856d9f3bb358d9671db3d4a06ecdb5802a317
  md5: 85e9354a9e32f7526d2451ed2bb93347
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 1999085
  timestamp: 1727807734169
- kind: conda
  name: cuda-driver-dev_linux-64
  version: 12.6.77
  build: h3f2d84a_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-driver-dev_linux-64-12.6.77-h3f2d84a_0.conda
  sha256: 0045dfd95c42eee2cf093d0a34bdecf2ecfcf155416adf3f11b01c9efd8c119c
  md5: f2b7f45acf027c7de8c383b1d2f6a298
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 35748
  timestamp: 1727810456749
- kind: conda
  name: cuda-nvcc
  version: 12.6.77
  build: '0'
  subdir: linux-64
  url: https://conda.anaconda.org/nvidia/linux-64/cuda-nvcc-12.6.77-0.conda
  sha256: 41fe3b7a7cfa0670f3afa162e56e74488e1dde6bca3081ebcd05ef28132160a3
  md5: e94085859258ab2ddc4524fadd05231e
  depends:
  - cuda-nvcc_linux-64 12.6.77.*
  - gcc_linux-64
  - gxx_linux-64
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 16919
  timestamp: 1726135863518
- kind: conda
  name: cuda-nvcc-dev_linux-64
  version: 12.6.77
  build: he91c749_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-nvcc-dev_linux-64-12.6.77-he91c749_0.conda
  sha256: beb2c13d89970b0561f075352ab007e5be886187b4baf9720edeb3771be4d400
  md5: dac2d9f46787aee9c7c4d76876efbaae
  depends:
  - cuda-crt-dev_linux-64 12.6.77 ha770c72_0
  - cuda-nvvm-dev_linux-64 12.6.77 ha770c72_0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc-ng >=6
  constrains:
  - gcc_impl_linux-64 >=6,<14.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 11364818
  timestamp: 1727815235199
- kind: conda
  name: cuda-nvcc-impl
  version: 12.6.77
  build: h85509e4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvcc-impl-12.6.77-h85509e4_0.conda
  sha256: 88285de0656a5fbc34ceafe8eec151f2627aa3332dfceb982edb200d47772e99
  md5: 0a61598ad25ee66a251717366a565590
  depends:
  - cuda-cudart >=12.6.77,<13.0a0
  - cuda-cudart-dev
  - cuda-nvcc-dev_linux-64 12.6.77 he91c749_0
  - cuda-nvcc-tools 12.6.77 he02047a_0
  - cuda-nvvm-impl 12.6.77 he02047a_0
  - cuda-version >=12.6,<12.7.0a0
  constrains:
  - gcc_impl_linux-64 >=6,<14.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 24635
  timestamp: 1727815268119
- kind: conda
  name: cuda-nvcc-tools
  version: 12.6.77
  build: he02047a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvcc-tools-12.6.77-he02047a_0.conda
  sha256: 211e92ff19be530833657a63cc5f2a963234a8f5247bf578514655ea4e1dc605
  md5: 91084ce9bca09feb3a5517f34b287821
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-crt-tools 12.6.77 ha770c72_0
  - cuda-nvvm-tools 12.6.77 he02047a_0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=12
  - libstdcxx >=12
  constrains:
  - gcc_impl_linux-64 >=6,<14.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 23943999
  timestamp: 1727815190727
- kind: conda
  name: cuda-nvcc_linux-64
  version: 12.6.77
  build: h8a487aa_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvcc_linux-64-12.6.77-h8a487aa_0.conda
  sha256: 4d41b8f7a247ee22520682b7e6af2be19e366065637de3e4f9e458feec991dfd
  md5: 42988224a384a61d9004fc10fdc72f6f
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-cudart-dev_linux-64 12.6.*
  - cuda-driver-dev_linux-64 12.6.*
  - cuda-nvcc-dev_linux-64 12.6.77.*
  - cuda-nvcc-impl 12.6.77.*
  - cuda-nvcc-tools 12.6.77.*
  - sysroot_linux-64 >=2.17,<3.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 25352
  timestamp: 1727818324485
- kind: conda
  name: cuda-nvrtc
  version: 12.6.77
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvrtc-12.6.77-hbd13f7d_0.conda
  sha256: 7d542f849de54c0707dbdaff04bf944439386488b11ec47877b6fab5a8a4e012
  md5: 4a3a1e9f0f211958b0338cfc283add2c
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 18144954
  timestamp: 1727808125222
- kind: conda
  name: cuda-nvtx
  version: 12.6.77
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvtx-12.6.77-hbd13f7d_0.conda
  sha256: 98bdf2e5017069691e8b807e0ceba4327d427b57147249ca0a505b8ad6844148
  md5: 3fe3afe309918465f82f984b3a1a85e9
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 31364
  timestamp: 1727816542389
- kind: conda
  name: cuda-nvvm-dev_linux-64
  version: 12.6.77
  build: ha770c72_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-nvvm-dev_linux-64-12.6.77-ha770c72_0.conda
  sha256: 197e5f06d0c93ac026354981fe979bf9364c7716ef2c32ea8abccc80c99e9e72
  md5: e5c415ccf982f1ccaf89be7343eb79e8
  depends:
  - cuda-version >=12.6,<12.7.0a0
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 24324
  timestamp: 1727815138754
- kind: conda
  name: cuda-nvvm-impl
  version: 12.6.77
  build: he02047a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvvm-impl-12.6.77-he02047a_0.conda
  sha256: ede6d1d1f5ca3caa00c824595ea8fbcf248be13f87b797163939807c7c402519
  md5: 7188e337f0e87dce955639f8d4270994
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=12
  - libstdcxx >=12
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 8082239
  timestamp: 1727815148977
- kind: conda
  name: cuda-nvvm-tools
  version: 12.6.77
  build: he02047a_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cuda-nvvm-tools-12.6.77-he02047a_0.conda
  sha256: 273e28d87f437d527d0bea440a6274d1059e23647b4efff9c9f81d2aa176ed8c
  md5: a7585a41a850af7d83bbd1212b2a643a
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=12
  - libstdcxx >=12
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 10978718
  timestamp: 1727815167442
- kind: conda
  name: cuda-version
  version: '12.6'
  build: h7480c83_3
  build_number: 3
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/cuda-version-12.6-h7480c83_3.conda
  sha256: fd9104d73199040285b6a6ad56322b38af04828fabbac1f5a268a83509358425
  md5: 1c8b99e65a4423b1e4ac2e4c76fb0978
  constrains:
  - cudatoolkit 12.6|12.6.*
  - __cuda >=12
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 20940
  timestamp: 1722603990914
- kind: conda
  name: cudnn
  version: 8.9.7.29
  build: h092f7fd_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/cudnn-8.9.7.29-h092f7fd_3.conda
  sha256: 27156736f5a0a30e6fb426f35216b903968b58bdf209d0a04b6eeb6530838456
  md5: 2242eab289d88f2f819f8aee5aa49823
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-nvrtc
  - cuda-version >=12.0,<13
  - cuda-version >=12.0,<13.0a0
  - libcublas
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: LicenseRef-cuDNN-Software-License-Agreement
  size: 468267309
  timestamp: 1710307755197
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
  name: dav1d
  version: 1.2.1
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/dav1d-1.2.1-hd590300_0.conda
  sha256: 22053a5842ca8ee1cf8e1a817138cdb5e647eb2c46979f84153f6ad7bde73020
  md5: 418c6ca5929a611cbd69204907a83995
  depends:
  - libgcc-ng >=12
  license: BSD-2-Clause
  license_family: BSD
  size: 760229
  timestamp: 1685695754230
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
  version: 1.8.7
  build: py311hfdbb021_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/debugpy-1.8.7-py311hfdbb021_0.conda
  sha256: 540d6b509d68ba77f6ad06f3bc419ba42930f1b3139ab4fda0476e12de8d7f4d
  md5: e02dac14097eb3605342cd35c13f0a26
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: MIT
  license_family: MIT
  size: 2544636
  timestamp: 1728594337523
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
  name: dm-haiku
  version: 0.0.12
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/dm-haiku-0.0.12-pyhd8ed1ab_0.conda
  sha256: accf2f1d11989adf1d321b90a2165997dd2b900555558d5f588ee4fa9b77cfcb
  md5: ce5a99dacf46b9c87eaff773fa96543f
  depends:
  - absl-py >=0.7.1
  - flax >=0.7.1
  - jmp >=0.0.2
  - numpy >=1.18.0
  - python >=3.6
  - tabulate >=0.8.9
  license: Apache-2.0
  license_family: OTHER
  size: 222477
  timestamp: 1709158647017
- kind: conda
  name: dm-tree
  version: 0.1.8
  build: py311hbffca5d_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/dm-tree-0.1.8-py311hbffca5d_5.conda
  sha256: ae897dd994e02f4d5c94799a87b6735df895f4a7b604d18a4472a988f378c8e3
  md5: 63b2cd83ac0d3139421135f24663d021
  depends:
  - __glibc >=2.17,<3.0.a0
  - libabseil * cxx17*
  - libabseil >=20240116.2,<20240117.0a0
  - libgcc >=13
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: Apache-2.0
  license_family: Apache
  size: 124353
  timestamp: 1725380879672
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
  name: etils
  version: 1.10.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/etils-1.10.0-pyhd8ed1ab_0.conda
  sha256: b0bed572d37b302f18745f421c9b23f901a6714730bd2018bf921965653fc072
  md5: 2fd249bf6bb8ff00b520bedfa4531eb6
  depends:
  - python >=3.10
  license: Apache-2.0
  size: 785364
  timestamp: 1729178937043
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
  version: 2.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/executing-2.1.0-pyhd8ed1ab_0.conda
  sha256: a52d7516e2e11d3eb10908e10d3eb3f8ef267fea99ed9b09d52d96c4db3441b8
  md5: d0441db20c827c11721889a241df1220
  depends:
  - python >=2.7
  license: MIT
  license_family: MIT
  size: 28337
  timestamp: 1725214501850
- kind: conda
  name: expat
  version: 2.6.3
  build: h5888daf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/expat-2.6.3-h5888daf_0.conda
  sha256: 65bd479c75ce876f26600cb230d6ebc474086e31fa384af9b4282b36842ed7e2
  md5: 6595440079bed734b113de44ffd3cd0a
  depends:
  - __glibc >=2.17,<3.0.a0
  - libexpat 2.6.3 h5888daf_0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 137891
  timestamp: 1725568750673
- kind: conda
  name: flax
  version: 0.9.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/flax-0.9.0-pyhd8ed1ab_0.conda
  sha256: 4ffd86c3d8044bdda04f42f2e8f0687bcb32ac85ed167fde0267449ec759c953
  md5: 1547043c44e99a04ff042a991f82c3f1
  depends:
  - jax >=0.4.11
  - matplotlib-base
  - msgpack-python
  - numpy >=1.12
  - optax
  - orbax-checkpoint
  - python >=3.9
  - pyyaml >=5.4.1
  - rich >=11.1.0
  - tensorstore
  - typing_extensions >=4.2.0
  license: Apache-2.0
  license_family: APACHE
  size: 562082
  timestamp: 1724791887629
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
  build: h77eed37_3
  build_number: 3
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/font-ttf-ubuntu-0.83-h77eed37_3.conda
  sha256: 2821ec1dc454bd8b9a31d0ed22a7ce22422c0aef163c59f49dfdf915d0f0ca14
  md5: 49023d73832ef61042f6a237cb2687e7
  license: LicenseRef-Ubuntu-Font-Licence-Version-1.0
  license_family: Other
  size: 1620504
  timestamp: 1727511233259
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
  version: 4.54.1
  build: py311h9ecbd09_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/fonttools-4.54.1-py311h9ecbd09_0.conda
  sha256: bcedd32e032289bcc504000b54d276647caaba1dc1e69a0e9c50cc48a7006e39
  md5: e46c9797470e25be729606421d5de2d1
  depends:
  - __glibc >=2.17,<3.0.a0
  - brotli
  - libgcc >=13
  - munkres
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: MIT
  license_family: MIT
  size: 2868064
  timestamp: 1727206484680
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
  version: 2024.9.0
  build: pyhff2d567_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/fsspec-2024.9.0-pyhff2d567_0.conda
  sha256: 8f4e9805b4ec223dea0d99f9e7e57c391d9026455eb9f0d6e0784c5d1a1200dc
  md5: ace4329fbff4c69ab0309db6da182987
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 134378
  timestamp: 1725543368393
- kind: conda
  name: gcc_impl_linux-64
  version: 13.3.0
  build: hfea6d02_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gcc_impl_linux-64-13.3.0-hfea6d02_1.conda
  sha256: 998ade1d487e93fc8a7a16b90e2af69ebb227355bf4646488661f7ae5887873c
  md5: 0d043dbc126b64f79d915a0e96d3a1d5
  depends:
  - binutils_impl_linux-64 >=2.40
  - libgcc >=13.3.0
  - libgcc-devel_linux-64 13.3.0 h84ea5a7_101
  - libgomp >=13.3.0
  - libsanitizer 13.3.0 heb74ff8_1
  - libstdcxx >=13.3.0
  - sysroot_linux-64
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 67464415
  timestamp: 1724801227937
- kind: conda
  name: gcc_linux-64
  version: 13.3.0
  build: hc28eda2_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gcc_linux-64-13.3.0-hc28eda2_4.conda
  sha256: 56feff3b6c28da5cdc3e9413a8b4f7782529c9440ee85b2d4e9264facd1da63f
  md5: 134bce313fe195be28a74597224441f1
  depends:
  - binutils_linux-64
  - gcc_impl_linux-64 13.3.0.*
  - sysroot_linux-64
  license: BSD-3-Clause
  license_family: BSD
  size: 31879
  timestamp: 1727281534736
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
  version: 1.24.4
  build: h9ad1361_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gst-plugins-base-1.24.4-h9ad1361_0.conda
  sha256: 4726f1905bbc84b44c8a78a53c0b2bc20b0f6780614b897e83bdfb9f1f94e9d5
  md5: 147cce520ec59367549fd0d96d404213
  depends:
  - __glibc >=2.17,<3.0.a0
  - alsa-lib >=1.2.11,<1.3.0a0
  - gstreamer 1.24.4 haf2f30d_0
  - libexpat >=2.6.2,<3.0a0
  - libgcc-ng >=12
  - libglib >=2.80.2,<3.0a0
  - libogg >=1.3.4,<1.4.0a0
  - libopus >=1.3.1,<2.0a0
  - libpng >=1.6.43,<1.7.0a0
  - libstdcxx-ng >=12
  - libvorbis >=1.3.7,<1.4.0a0
  - libxcb >=1.15,<1.16.0a0
  - libzlib >=1.2.13,<2.0a0
  - xorg-libx11 >=1.8.9,<2.0a0
  - xorg-libxau >=1.0.11,<2.0a0
  - xorg-libxext >=1.3.4,<2.0a0
  - xorg-libxrender >=0.9.11,<0.10.0a0
  license: LGPL-2.0-or-later
  license_family: LGPL
  size: 2784812
  timestamp: 1717008701241
- kind: conda
  name: gstreamer
  version: 1.24.4
  build: haf2f30d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gstreamer-1.24.4-haf2f30d_0.conda
  sha256: d20031196ed30ee5eb1e225f6cf0ed605d95158612589602a9d893a7386a4608
  md5: 926c2c7ee7a0b48d6d70783a33f7bc80
  depends:
  - __glibc >=2.17,<3.0.a0
  - glib >=2.80.2,<3.0a0
  - libgcc-ng >=12
  - libglib >=2.80.2,<3.0a0
  - libiconv >=1.17,<2.0a0
  - libstdcxx-ng >=12
  license: LGPL-2.0-or-later
  license_family: LGPL
  size: 2019311
  timestamp: 1717008522417
- kind: conda
  name: gxx_impl_linux-64
  version: 13.3.0
  build: hdbfa832_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gxx_impl_linux-64-13.3.0-hdbfa832_1.conda
  sha256: 746dff24bb1efc89ab0ec108838d0711683054e3bbbcb94d042943410a98eca1
  md5: 806367e23a0a6ad21e51875b34c57d7e
  depends:
  - gcc_impl_linux-64 13.3.0 hfea6d02_1
  - libstdcxx-devel_linux-64 13.3.0 h84ea5a7_101
  - sysroot_linux-64
  - tzdata
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 13337720
  timestamp: 1724801455825
- kind: conda
  name: gxx_linux-64
  version: 13.3.0
  build: h6834431_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/gxx_linux-64-13.3.0-h6834431_4.conda
  sha256: b9c1f9f886b48c7423ba905bece1d7e02b432a6d5daeee81614d5bbd33653c72
  md5: 9101274fec035244a7fb08d03b50c458
  depends:
  - binutils_linux-64
  - gcc_linux-64 13.3.0 hc28eda2_4
  - gxx_impl_linux-64 13.3.0.*
  - sysroot_linux-64
  license: BSD-3-Clause
  license_family: BSD
  size: 30213
  timestamp: 1727281552259
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
  version: 8.5.0
  build: hfac3d4d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/harfbuzz-8.5.0-hfac3d4d_0.conda
  sha256: a141fc55f8bfdab7db03fe9d8e61cb0f8c8b5970ed6540eda2db7186223f4444
  md5: f5126317dd0ce0ba26945e411ecc6960
  depends:
  - cairo >=1.18.0,<2.0a0
  - freetype >=2.12.1,<3.0a0
  - graphite2
  - icu >=73.2,<74.0a0
  - libgcc-ng >=12
  - libglib >=2.80.2,<3.0a0
  - libstdcxx-ng >=12
  license: MIT
  license_family: MIT
  size: 1598244
  timestamp: 1715701061364
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
  version: 1.0.6
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/httpcore-1.0.6-pyhd8ed1ab_0.conda
  sha256: 8952c3f1eb18bf4d7e813176c3b23e0af4e863e8b05087e73f74f371d73077ca
  md5: b8e1901ef9a215fc41ecfb6bef7e0943
  depends:
  - anyio >=3.0,<5.0
  - certifi
  - h11 >=0.13,<0.15
  - h2 >=3,<5
  - python >=3.8
  - sniffio 1.*
  license: BSD-3-Clause
  license_family: BSD
  size: 45711
  timestamp: 1727821031365
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
  name: icu
  version: '73.2'
  build: h59595ed_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/icu-73.2-h59595ed_0.conda
  sha256: e12fd90ef6601da2875ebc432452590bc82a893041473bc1c13ef29001a73ea8
  md5: cc47e1facc155f91abd89b11e48e72ff
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: MIT
  license_family: MIT
  size: 12089150
  timestamp: 1692900650789
- kind: conda
  name: idna
  version: '3.10'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/idna-3.10-pyhd8ed1ab_0.conda
  sha256: 8c57fd68e6be5eecba4462e983aed7e85761a519aab80e834bbd7794d4b545b2
  md5: 7ba2ede0e7c795ff95088daf0dc59753
  depends:
  - python >=3.6
  license: BSD-3-Clause
  license_family: BSD
  size: 49837
  timestamp: 1726459583613
- kind: conda
  name: immutabledict
  version: 4.2.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/immutabledict-4.2.0-pyhd8ed1ab_0.conda
  sha256: 59a220c50f12328a63dc86014949675ba234e6929d0422580a2142597f7de3fc
  md5: 478289657e25f285abaaad83a74481c1
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 10349
  timestamp: 1709835365134
- kind: conda
  name: importlib-metadata
  version: 8.5.0
  build: pyha770c72_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/importlib-metadata-8.5.0-pyha770c72_0.conda
  sha256: 7194700ce1a5ad2621fd68e894dd8c1ceaff9a38723e6e0e5298fdef13017b1c
  md5: 54198435fce4d64d8a89af22573012a8
  depends:
  - python >=3.8
  - zipp >=0.5
  license: Apache-2.0
  license_family: APACHE
  size: 28646
  timestamp: 1726082927916
- kind: conda
  name: importlib_metadata
  version: 8.5.0
  build: hd8ed1ab_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/importlib_metadata-8.5.0-hd8ed1ab_0.conda
  sha256: 313b8a05211bacd6b15ab2621cb73d7f41ea5c6cae98db53367d47833f03fef1
  md5: 2a92e152208121afadf85a5e1f3a5f4d
  depends:
  - importlib-metadata >=8.5.0,<8.5.1.0a0
  license: Apache-2.0
  license_family: APACHE
  size: 9385
  timestamp: 1726082930346
- kind: conda
  name: importlib_resources
  version: 6.4.5
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/importlib_resources-6.4.5-pyhd8ed1ab_0.conda
  sha256: 2cb9db3e40033c3df72d3defc678a012840378fd55a67e4351363d4b321a0dc1
  md5: c808991d29b9838fb4d96ce8267ec9ec
  depends:
  - python >=3.8
  - zipp >=3.1.0
  constrains:
  - importlib-resources >=6.4.5,<6.4.6.0a0
  license: Apache-2.0
  license_family: APACHE
  size: 32725
  timestamp: 1725921462405
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
  version: 8.28.0
  build: pyh707e725_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/ipython-8.28.0-pyh707e725_0.conda
  sha256: b18adc659d43fc8eef026312a74cd39944ffe9d8decee71ec60a1974fb8ec86c
  md5: 7142a7dff2a47e40b55d304decadd78a
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
  size: 600094
  timestamp: 1727944801855
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
  name: jax
  version: 0.4.27
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jax-0.4.27-pyhd8ed1ab_0.conda
  sha256: 7a85619d6b6890fe15b60818d3f3533d044b84a62ad019b919738f834d56e6c4
  md5: 9dbe68d48348ffbe603c0fbe44428d7c
  depends:
  - importlib_metadata >=4.6
  - jaxlib >=0.4.23
  - ml_dtypes >=0.2.0
  - numpy >=1.22
  - opt-einsum
  - python >=3.9
  - scipy >=1.9
  license: Apache-2.0
  license_family: APACHE
  size: 1275628
  timestamp: 1715569349254
- kind: conda
  name: jaxlib
  version: 0.4.23
  build: cuda120py311h5a49573_202
  build_number: 202
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jaxlib-0.4.23-cuda120py311h5a49573_202.conda
  sha256: 81acde99bc62efbb9e128c52434bd5e59f6d23eb6529c352b5db7e3a0a239cb1
  md5: 0306f40f0820ca3e4fd4ccc4509da6f3
  depends:
  - __cuda
  - __glibc >=2.17,<3.0.a0
  - cuda-cudart >=12.0.107,<13.0a0
  - cuda-cupti >=12.0.90,<13.0a0
  - cuda-nvcc
  - cuda-nvtx >=12.0.76,<13.0a0
  - cuda-version >=12.0,<13
  - cudnn >=8.9.7.29,<9.0a0
  - libabseil * cxx17*
  - libabseil >=20240116.2,<20240117.0a0
  - libcublas >=12.0.1.189,<13.0a0
  - libcufft >=11.0.0.21,<12.0a0
  - libcurand >=10.3.1.50,<11.0a0
  - libcusolver >=11.4.2.57,<12.0a0
  - libcusparse >=12.0.0.76,<13.0a0
  - libgcc-ng >=12
  - libgrpc >=1.62.2,<1.63.0a0
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - ml_dtypes >=0.2.0
  - nccl >=2.21.5.1,<3.0a0
  - numpy >=1.23.5,<2.0a0
  - openssl >=3.3.0,<4.0a0
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - scipy >=1.9
  constrains:
  - jax >=0.4.23
  license: Apache-2.0
  license_family: APACHE
  size: 87918910
  timestamp: 1716397666328
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
  name: jmp
  version: 0.0.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jmp-0.0.4-pyhd8ed1ab_0.conda
  sha256: f04ea86247bb5a2a4c9f2fb5be6b6a70404b22282691b11217e14d9f57502b50
  md5: 66f7f78385410f68bbef68fe4db0f7b6
  depends:
  - dataclasses >=0.7
  - jax
  - numpy >=1.19.5
  - python >=3.6
  license: Apache-2.0
  license_family: Apache
  size: 20421
  timestamp: 1675096111470
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
  build: py311h38be061_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/jsonpointer-3.0.0-py311h38be061_1.conda
  sha256: 2f082f7b12a7c6824e051321c1029452562ad6d496ad2e8c8b7b3dea1c8feb92
  md5: 5ca76f61b00a15a9be0612d4d883badc
  depends:
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: BSD-3-Clause
  license_family: BSD
  size: 17645
  timestamp: 1725303065473
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
  version: 2024.10.1
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jsonschema-specifications-2024.10.1-pyhd8ed1ab_0.conda
  sha256: 82f8bed0f21dc0b3aff40dd4e39d77e85b93b0417bc5659b001e0109341b8b98
  md5: 720745920222587ef942acfbc578b584
  depends:
  - python >=3.8
  - referencing >=0.31.0
  license: MIT
  license_family: MIT
  size: 16165
  timestamp: 1728418976382
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
  version: 8.6.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_client-8.6.3-pyhd8ed1ab_0.conda
  sha256: 4419c85e209a715f551a5c9bead746f29ee9d0fc41e772a76db3868622795671
  md5: a14218cfb29662b4a19ceb04e93e298e
  depends:
  - importlib-metadata >=4.8.3
  - jupyter_core >=4.12,!=5.0.*
  - python >=3.8
  - python-dateutil >=2.8.2
  - pyzmq >=23.0
  - tornado >=6.2
  - traitlets >=5.3
  license: BSD-3-Clause
  license_family: BSD
  size: 106055
  timestamp: 1726610805505
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
  build: pyh31011fe_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/jupyter_core-5.7.2-pyh31011fe_1.conda
  sha256: 732b1e8536bc22a5a174baa79842d79db2f4956d90293dd82dc1b3f6099bcccd
  md5: 0a2980dada0dd7fd0998f0342308b1b1
  depends:
  - __unix
  - platformdirs >=2.5
  - python >=3.8
  - traitlets >=5.3
  license: BSD-3-Clause
  license_family: BSD
  size: 57671
  timestamp: 1727163547058
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
  name: kernel-headers_linux-64
  version: 3.10.0
  build: he073ed8_17
  build_number: 17
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/kernel-headers_linux-64-3.10.0-he073ed8_17.conda
  sha256: c28d69ca84533f0e2093f17ae6d3e19ee3661dd397618630830b1b9afc3bfb4d
  md5: 285931bd28b3b8f176d46dd9fd627a09
  constrains:
  - sysroot_linux-64 ==2.17
  license: LGPL-2.0-or-later AND LGPL-2.0-or-later WITH exceptions AND GPL-2.0-or-later AND MPL-2.0
  license_family: GPL
  size: 945088
  timestamp: 1727437651716
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
  version: 1.4.7
  build: py311hd18a35c_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/kiwisolver-1.4.7-py311hd18a35c_0.conda
  sha256: 4af11cbc063096a284fe1689b33424e7e49732a27fd396d74c7dee03d1e788ee
  md5: be34c90cce87090d24da64a7c239ca96
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: BSD-3-Clause
  license_family: BSD
  size: 72393
  timestamp: 1725459421768
- kind: conda
  name: krb5
  version: 1.21.3
  build: h659f571_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/krb5-1.21.3-h659f571_0.conda
  sha256: 99df692f7a8a5c27cd14b5fb1374ee55e756631b9c3d659ed3ee60830249b238
  md5: 3f43953b7d3fb3aaa1d0d0723d91e368
  depends:
  - keyutils >=1.6.1,<2.0a0
  - libedit >=3.1.20191231,<3.2.0a0
  - libedit >=3.1.20191231,<4.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - openssl >=3.3.1,<4.0a0
  license: MIT
  license_family: MIT
  size: 1370023
  timestamp: 1719463201255
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
  version: '2.16'
  build: hb7c19ff_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/lcms2-2.16-hb7c19ff_0.conda
  sha256: 5c878d104b461b7ef922abe6320711c0d01772f4cd55de18b674f88547870041
  md5: 51bb7010fc86f70eee639b4bb7a894f5
  depends:
  - libgcc-ng >=12
  - libjpeg-turbo >=3.0.0,<4.0a0
  - libtiff >=4.6.0,<4.8.0a0
  license: MIT
  license_family: MIT
  size: 245247
  timestamp: 1701647787198
- kind: conda
  name: ld_impl_linux-64
  version: '2.43'
  build: h712a8e2_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ld_impl_linux-64-2.43-h712a8e2_1.conda
  sha256: 0c21387f9a411e3d1f7f2969026bacfece133c8f1e72faea9cde29c0c19e1f3a
  md5: 83e1364586ceb8d0739fbc85b5c95837
  depends:
  - __glibc >=2.17,<3.0.a0
  constrains:
  - binutils_impl_linux-64 2.43
  license: GPL-3.0-only
  license_family: GPL
  size: 669616
  timestamp: 1727304687962
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
  name: libavif16
  version: 1.1.1
  build: h104a339_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libavif16-1.1.1-h104a339_1.conda
  sha256: 6de4cbccfe7193ee749beadf34a6ab140e2cd361efc4685621c0a785a73d4aca
  md5: 9ef052c2eee74c792833ac2e820e481e
  depends:
  - __glibc >=2.17,<3.0.a0
  - aom >=3.9.1,<3.10.0a0
  - dav1d >=1.2.1,<1.2.2.0a0
  - libgcc-ng >=13
  - rav1e >=0.6.6,<1.0a0
  - svt-av1 >=2.2.1,<2.2.2.0a0
  license: BSD-2-Clause
  license_family: BSD
  size: 116148
  timestamp: 1724672468333
- kind: conda
  name: libblas
  version: 3.9.0
  build: 24_linux64_openblas
  build_number: 24
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libblas-3.9.0-24_linux64_openblas.conda
  sha256: 3097f7913bda527d4fe9f824182b314e130044e582455037fca6f4e97965d83c
  md5: 80aea6603a6813b16ec119d00382b772
  depends:
  - libopenblas >=0.3.27,<0.3.28.0a0
  - libopenblas >=0.3.27,<1.0a0
  constrains:
  - blas * openblas
  - liblapack 3.9.0 24_linux64_openblas
  - libcblas 3.9.0 24_linux64_openblas
  - liblapacke 3.9.0 24_linux64_openblas
  license: BSD-3-Clause
  license_family: BSD
  size: 14981
  timestamp: 1726668454790
- kind: conda
  name: libbrotlicommon
  version: 1.1.0
  build: hb9d3cd8_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libbrotlicommon-1.1.0-hb9d3cd8_2.conda
  sha256: d9db2de60ea917298e658143354a530e9ca5f9c63471c65cf47ab39fd2f429e3
  md5: 41b599ed2b02abcfdd84302bff174b23
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 68851
  timestamp: 1725267660471
- kind: conda
  name: libbrotlidec
  version: 1.1.0
  build: hb9d3cd8_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libbrotlidec-1.1.0-hb9d3cd8_2.conda
  sha256: 2892d512cad096cb03f1b66361deeab58b64e15ba525d6592bb6d609e7045edf
  md5: 9566f0bd264fbd463002e759b8a82401
  depends:
  - __glibc >=2.17,<3.0.a0
  - libbrotlicommon 1.1.0 hb9d3cd8_2
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 32696
  timestamp: 1725267669305
- kind: conda
  name: libbrotlienc
  version: 1.1.0
  build: hb9d3cd8_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libbrotlienc-1.1.0-hb9d3cd8_2.conda
  sha256: 779f58174e99de3600e939fa46eddb453ec5d3c60bb46cdaa8b4c127224dbf29
  md5: 06f70867945ea6a84d35836af780f1de
  depends:
  - __glibc >=2.17,<3.0.a0
  - libbrotlicommon 1.1.0 hb9d3cd8_2
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 281750
  timestamp: 1725267679782
- kind: conda
  name: libcap
  version: '2.69'
  build: h0f662aa_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcap-2.69-h0f662aa_0.conda
  sha256: 942f9564b4228609f017b6617425d29a74c43b8a030e12239fa4458e5cb6323c
  md5: 25cb5999faa414e5ccb2c1388f62d3d5
  depends:
  - attr >=2.5.1,<2.6.0a0
  - libgcc-ng >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 100582
  timestamp: 1684162447012
- kind: conda
  name: libcblas
  version: 3.9.0
  build: 24_linux64_openblas
  build_number: 24
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcblas-3.9.0-24_linux64_openblas.conda
  sha256: 2a52bccc5b03cdf014d856d0b85dbd591faa335ab337d620cd6aded121d7153c
  md5: f5b8822297c9c790cec0795ca1fc9be6
  depends:
  - libblas 3.9.0 24_linux64_openblas
  constrains:
  - blas * openblas
  - liblapack 3.9.0 24_linux64_openblas
  - liblapacke 3.9.0 24_linux64_openblas
  license: BSD-3-Clause
  license_family: BSD
  size: 14910
  timestamp: 1726668461033
- kind: conda
  name: libclang-cpp15
  version: 15.0.7
  build: default_h127d8a8_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libclang-cpp15-15.0.7-default_h127d8a8_5.conda
  sha256: 9b0238e705a33da74ca82efd03974f499550f7dada1340cc9cb7c35a92411ed8
  md5: d0a9633b53cdc319b8a1a532ae7822b8
  depends:
  - libgcc-ng >=12
  - libllvm15 >=15.0.7,<15.1.0a0
  - libstdcxx-ng >=12
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 17206402
  timestamp: 1711063711931
- kind: conda
  name: libclang13
  version: 18.1.7
  build: default_h087397f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libclang13-18.1.7-default_h087397f_0.conda
  sha256: d981a2734c3af6217dd42c1bccc13b99fc3ca5a64c379739612d6cf67f992a1d
  md5: 536526073c2e7f9056fdce8584da779e
  depends:
  - libgcc-ng >=12
  - libllvm18 >=18.1.7,<18.2.0a0
  - libstdcxx-ng >=12
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 11057579
  timestamp: 1717819075043
- kind: conda
  name: libcublas
  version: 12.6.3.3
  build: hbd13f7d_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcublas-12.6.3.3-hbd13f7d_1.conda
  sha256: ff7bb0924eda7f70e206a3c81b332deba9ffaec4448e5aa4a11b516b3cd8ca73
  md5: 997af9b5258ce460f9a0f233b5a6d1d0
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-nvrtc
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 268446498
  timestamp: 1729121354477
- kind: conda
  name: libcufft
  version: 11.3.0.4
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcufft-11.3.0.4-hbd13f7d_0.conda
  sha256: fc64a2611a15db7baef61efee2059f090b8f866d06b8f65808c8d2ee191cf7db
  md5: a296940fa2e0448d066d03bf6b586772
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 163772747
  timestamp: 1727808246058
- kind: conda
  name: libcups
  version: 2.3.3
  build: h4637d8d_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcups-2.3.3-h4637d8d_4.conda
  sha256: bc67b9b21078c99c6bd8595fe7e1ed6da1f721007726e717f0449de7032798c4
  md5: d4529f4dff3057982a7617c7ac58fde3
  depends:
  - krb5 >=1.21.1,<1.22.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: Apache-2.0
  license_family: Apache
  size: 4519402
  timestamp: 1689195353551
- kind: conda
  name: libcurand
  version: 10.3.7.77
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcurand-10.3.7.77-hbd13f7d_0.conda
  sha256: 58ee962804a9df475638e0e83f1116bfbf00a5e4681ed180eb872990d49d7902
  md5: d8b8a1e6e6205447289cd09212c914ac
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 41790488
  timestamp: 1727807993172
- kind: conda
  name: libcurl
  version: 8.8.0
  build: hca28451_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcurl-8.8.0-hca28451_1.conda
  sha256: 6b5b64cdcdb643368ebe236de07eedee99b025bb95129bbe317c46e5bdc693f3
  md5: b8afb3e3cb3423cc445cf611ab95fdb0
  depends:
  - krb5 >=1.21.3,<1.22.0a0
  - libgcc-ng >=12
  - libnghttp2 >=1.58.0,<2.0a0
  - libssh2 >=1.11.0,<2.0a0
  - libzlib >=1.2.13,<2.0a0
  - openssl >=3.3.1,<4.0a0
  - zstd >=1.5.6,<1.6.0a0
  license: curl
  license_family: MIT
  size: 410158
  timestamp: 1719602718702
- kind: conda
  name: libcusolver
  version: 11.7.1.2
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcusolver-11.7.1.2-hbd13f7d_0.conda
  sha256: 3de5457807dd30f9509863324cfbe9d74d20f477dfeb5ed7de68bbb3da4064bd
  md5: 035db50d5e949de81e015df72a834e79
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libcublas >=12.6.3.3,<12.7.0a0
  - libcusparse >=12.5.4.2,<12.6.0a0
  - libgcc >=13
  - libnvjitlink >=12.6.77,<12.7.0a0
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 100482680
  timestamp: 1727816156921
- kind: conda
  name: libcusparse
  version: 12.5.4.2
  build: hbd13f7d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libcusparse-12.5.4.2-hbd13f7d_0.conda
  sha256: 9db5d983d102c20f2cecc494ea22d84c44df37d373982815fc2eb669bf0bd376
  md5: 8186e9de34f321aa34965c1cb72c0c26
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.6,<12.7.0a0
  - libgcc >=13
  - libnvjitlink >=12.6.77,<12.7.0a0
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 124403455
  timestamp: 1727811455861
- kind: conda
  name: libdeflate
  version: '1.20'
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libdeflate-1.20-hd590300_0.conda
  sha256: f8e0f25c382b1d0b87a9b03887a34dbd91485453f1ea991fef726dba57373612
  md5: 8e88f9389f1165d7c0936fe40d9a9a79
  depends:
  - libgcc-ng >=12
  license: MIT
  license_family: MIT
  size: 71500
  timestamp: 1711196523408
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
  name: libev
  version: '4.33'
  build: hd590300_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libev-4.33-hd590300_2.conda
  sha256: 1cd6048169fa0395af74ed5d8f1716e22c19a81a8a36f934c110ca3ad4dd27b4
  md5: 172bf1cd1ff8629f2b1179945ed45055
  depends:
  - libgcc-ng >=12
  license: BSD-2-Clause
  license_family: BSD
  size: 112766
  timestamp: 1702146165126
- kind: conda
  name: libevent
  version: 2.1.12
  build: hf998b51_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libevent-2.1.12-hf998b51_1.conda
  sha256: 2e14399d81fb348e9d231a82ca4d816bf855206923759b69ad006ba482764131
  md5: a1cfcc585f0c42bf8d5546bb1dfb668d
  depends:
  - libgcc-ng >=12
  - openssl >=3.1.1,<4.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 427426
  timestamp: 1685725977222
- kind: conda
  name: libexpat
  version: 2.6.3
  build: h5888daf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libexpat-2.6.3-h5888daf_0.conda
  sha256: 4bb47bb2cd09898737a5211e2992d63c555d63715a07ba56eae0aff31fb89c22
  md5: 59f4c43bb1b5ef1c71946ff2cbf59524
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  constrains:
  - expat 2.6.3.*
  license: MIT
  license_family: MIT
  size: 73616
  timestamp: 1725568742634
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
  version: 14.2.0
  build: h77fa898_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgcc-14.2.0-h77fa898_1.conda
  sha256: 53eb8a79365e58849e7b1a068d31f4f9e718dc938d6f2c03e960345739a03569
  md5: 3cb76c3f10d3bc7f1105b2fc9db984df
  depends:
  - _libgcc_mutex 0.1 conda_forge
  - _openmp_mutex >=4.5
  constrains:
  - libgomp 14.2.0 h77fa898_1
  - libgcc-ng ==14.2.0=*_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 848745
  timestamp: 1729027721139
- kind: conda
  name: libgcc-devel_linux-64
  version: 13.3.0
  build: h84ea5a7_101
  build_number: 101
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/libgcc-devel_linux-64-13.3.0-h84ea5a7_101.conda
  sha256: 027cfb011328a108bc44f512a2dec6d954db85709e0b79b748c3392f85de0c64
  md5: 0ce69d40c142915ac9734bc6134e514a
  depends:
  - __unix
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 2598313
  timestamp: 1724801050802
- kind: conda
  name: libgcc-ng
  version: 14.2.0
  build: h69a702a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgcc-ng-14.2.0-h69a702a_1.conda
  sha256: 3a76969c80e9af8b6e7a55090088bc41da4cffcde9e2c71b17f44d37b7cb87f7
  md5: e39480b9ca41323497b05492a63bc35b
  depends:
  - libgcc 14.2.0 h77fa898_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 54142
  timestamp: 1729027726517
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
  name: libgfortran
  version: 14.2.0
  build: h69a702a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgfortran-14.2.0-h69a702a_1.conda
  sha256: fc9e7f22a17faf74da904ebfc4d88699013d2992e55505e4aa0eb01770290977
  md5: f1fd30127802683586f768875127a987
  depends:
  - libgfortran5 14.2.0 hd5240d6_1
  constrains:
  - libgfortran-ng ==14.2.0=*_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 53997
  timestamp: 1729027752995
- kind: conda
  name: libgfortran-ng
  version: 14.2.0
  build: h69a702a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgfortran-ng-14.2.0-h69a702a_1.conda
  sha256: 423f1e2403f0c665748e42d335e421e53fd03c08d457cfb6f360d329d9459851
  md5: 0a7f4cd238267c88e5d69f7826a407eb
  depends:
  - libgfortran 14.2.0 h69a702a_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 54106
  timestamp: 1729027945817
- kind: conda
  name: libgfortran5
  version: 14.2.0
  build: hd5240d6_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgfortran5-14.2.0-hd5240d6_1.conda
  sha256: d149a37ca73611e425041f33b9d8dbed6e52ec506fe8cc1fc0ee054bddeb6d5d
  md5: 9822b874ea29af082e5d36098d25427d
  depends:
  - libgcc >=14.2.0
  constrains:
  - libgfortran 14.2.0
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 1462645
  timestamp: 1729027735353
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
  name: libgomp
  version: 14.2.0
  build: h77fa898_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgomp-14.2.0-h77fa898_1.conda
  sha256: 1911c29975ec99b6b906904040c855772ccb265a1c79d5d75c8ceec4ed89cd63
  md5: cc3573974587f12dda90d96e3e55a702
  depends:
  - _libgcc_mutex 0.1 conda_forge
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 460992
  timestamp: 1729027639220
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
  name: libgrpc
  version: 1.62.2
  build: h15f2491_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libgrpc-1.62.2-h15f2491_0.conda
  sha256: 28241ed89335871db33cb6010e9ccb2d9e9b6bb444ddf6884f02f0857363c06a
  md5: 8dabe607748cb3d7002ad73cd06f1325
  depends:
  - c-ares >=1.28.1,<2.0a0
  - libabseil * cxx17*
  - libabseil >=20240116.1,<20240117.0a0
  - libgcc-ng >=12
  - libprotobuf >=4.25.3,<4.25.4.0a0
  - libre2-11 >=2023.9.1
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - openssl >=3.2.1,<4.0a0
  - re2
  constrains:
  - grpc-cpp =1.62.2
  license: Apache-2.0
  license_family: APACHE
  size: 7316832
  timestamp: 1713390645548
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
  version: 3.0.0
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libjpeg-turbo-3.0.0-hd590300_1.conda
  sha256: b954e09b7e49c2f2433d6f3bb73868eda5e378278b0f8c1dd10a7ef090e14f2f
  md5: ea25936bb4080d843790b586850f82b8
  depends:
  - libgcc-ng >=12
  constrains:
  - jpeg <0.0.0a
  license: IJG AND BSD-3-Clause AND Zlib
  size: 618575
  timestamp: 1694474974816
- kind: conda
  name: liblapack
  version: 3.9.0
  build: 24_linux64_openblas
  build_number: 24
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/liblapack-3.9.0-24_linux64_openblas.conda
  sha256: a15da20c3c0fb5f356e5b4e2f1e87b0da11b9a46805a7f2609bf30f23453831a
  md5: fd540578678aefe025705f4b58b36b2e
  depends:
  - libblas 3.9.0 24_linux64_openblas
  constrains:
  - blas * openblas
  - libcblas 3.9.0 24_linux64_openblas
  - liblapacke 3.9.0 24_linux64_openblas
  license: BSD-3-Clause
  license_family: BSD
  size: 14911
  timestamp: 1726668467187
- kind: conda
  name: libllvm15
  version: 15.0.7
  build: hb3ce162_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libllvm15-15.0.7-hb3ce162_4.conda
  sha256: e71584c0f910140630580fdd0a013029a52fd31e435192aea2aa8d29005262d1
  md5: 8a35df3cbc0c8b12cc8af9473ae75eef
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxml2 >=2.12.1,<3.0.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - zstd >=1.5.5,<1.6.0a0
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 33321457
  timestamp: 1701375836233
- kind: conda
  name: libllvm18
  version: 18.1.7
  build: hb77312f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libllvm18-18.1.7-hb77312f_0.conda
  sha256: 9a9167b3e8e05abc517671fe45e5d40ae866d3e8195865ddad3c68131d059e25
  md5: bc0ea7e1f75a9b1c8467597fbbd9f86b
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxml2 >=2.12.7,<3.0a0
  - libzlib >=1.2.13,<2.0a0
  - zstd >=1.5.6,<1.6.0a0
  license: Apache-2.0 WITH LLVM-exception
  license_family: Apache
  size: 38423980
  timestamp: 1717781615068
- kind: conda
  name: libnghttp2
  version: 1.58.0
  build: h47da74e_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libnghttp2-1.58.0-h47da74e_1.conda
  sha256: 1910c5306c6aa5bcbd623c3c930c440e9c77a5a019008e1487810e3c1d3716cb
  md5: 700ac6ea6d53d5510591c4344d5c989a
  depends:
  - c-ares >=1.23.0,<2.0a0
  - libev >=4.33,<4.34.0a0
  - libev >=4.33,<5.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - openssl >=3.2.0,<4.0a0
  license: MIT
  license_family: MIT
  size: 631936
  timestamp: 1702130036271
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
  name: libnvjitlink
  version: 12.6.77
  build: hbd13f7d_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libnvjitlink-12.6.77-hbd13f7d_1.conda
  sha256: e710efb2e2662000ffba193e3ba09816044fc348a3a6ecdc1955c0fff3e2c572
  md5: b498ee094aec216a89ccbd70520c61c3
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12,<12.7.0a0
  - libgcc >=13
  - libstdcxx >=13
  license: LicenseRef-NVIDIA-End-User-License-Agreement
  size: 15590346
  timestamp: 1727808170622
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
  name: libopenblas
  version: 0.3.27
  build: pthreads_hac2b453_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libopenblas-0.3.27-pthreads_hac2b453_1.conda
  sha256: 714cb82d7c4620ea2635a92d3df263ab841676c9b183d0c01992767bb2451c39
  md5: ae05ece66d3924ac3d48b4aa3fa96cec
  depends:
  - libgcc-ng >=12
  - libgfortran-ng
  - libgfortran5 >=12.3.0
  constrains:
  - openblas >=0.3.27,<0.3.28.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 5563053
  timestamp: 1720426334043
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
  version: '16.4'
  build: h2d7952a_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libpq-16.4-h2d7952a_3.conda
  sha256: 51dddb6e5879960a1b9b3c5de0eb970373903977c0fa68a42f86bb7197c695cf
  md5: 50e2dddb3417a419cbc2388d0b1c06f7
  depends:
  - __glibc >=2.17,<3.0.a0
  - krb5 >=1.21.3,<1.22.0a0
  - libgcc >=13
  - openssl >=3.3.2,<4.0a0
  license: PostgreSQL
  size: 2530022
  timestamp: 1729085009049
- kind: conda
  name: libprotobuf
  version: 4.25.3
  build: h08a7969_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libprotobuf-4.25.3-h08a7969_0.conda
  sha256: 70e0eef046033af2e8d21251a785563ad738ed5281c74e21c31c457780845dcd
  md5: 6945825cebd2aeb16af4c69d97c32c13
  depends:
  - libabseil * cxx17*
  - libabseil >=20240116.1,<20240117.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 2811207
  timestamp: 1709514552541
- kind: conda
  name: libre2-11
  version: 2023.09.01
  build: h5a48ba9_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libre2-11-2023.09.01-h5a48ba9_2.conda
  sha256: 3f3c65fe0e9e328b4c1ebc2b622727cef3e5b81b18228cfa6cf0955bc1ed8eff
  md5: 41c69fba59d495e8cf5ffda48a607e35
  depends:
  - libabseil * cxx17*
  - libabseil >=20240116.1,<20240117.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  constrains:
  - re2 2023.09.01.*
  license: BSD-3-Clause
  license_family: BSD
  size: 232603
  timestamp: 1708946763521
- kind: conda
  name: libsanitizer
  version: 13.3.0
  build: heb74ff8_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsanitizer-13.3.0-heb74ff8_1.conda
  sha256: c86d130f0a3099e46ff51aa7ffaab73cb44fc420d27a96076aab3b9a326fc137
  md5: c4cb22f270f501f5c59a122dc2adf20a
  depends:
  - libgcc >=13.3.0
  - libstdcxx >=13.3.0
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 4133922
  timestamp: 1724801171589
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
  version: 1.0.20
  build: h4ab18f5_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsodium-1.0.20-h4ab18f5_0.conda
  sha256: 0105bd108f19ea8e6a78d2d994a6d4a8db16d19a41212070d2d1d48a63c34161
  md5: a587892d3c13b6621a6091be690dbca2
  depends:
  - libgcc-ng >=12
  license: ISC
  size: 205978
  timestamp: 1716828628198
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
  name: libssh2
  version: 1.11.0
  build: h0841786_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libssh2-1.11.0-h0841786_0.conda
  sha256: 50e47fd9c4f7bf841a11647ae7486f65220cfc988ec422a4475fe8d5a823824d
  md5: 1f5a58e686b13bcfde88b93f547d23fe
  depends:
  - libgcc-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - openssl >=3.1.1,<4.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 271133
  timestamp: 1685837707056
- kind: conda
  name: libstdcxx
  version: 14.2.0
  build: hc0a3c3a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-14.2.0-hc0a3c3a_1.conda
  sha256: 4661af0eb9bdcbb5fb33e5d0023b001ad4be828fccdcc56500059d56f9869462
  md5: 234a5554c53625688d51062645337328
  depends:
  - libgcc 14.2.0 h77fa898_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 3893695
  timestamp: 1729027746910
- kind: conda
  name: libstdcxx-devel_linux-64
  version: 13.3.0
  build: h84ea5a7_101
  build_number: 101
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/libstdcxx-devel_linux-64-13.3.0-h84ea5a7_101.conda
  sha256: 0a9226c1b994f996229ffb54fa40d608cd4e4b48e8dc73a66134bea8ce949412
  md5: 29b5a4ed4613fa81a07c21045e3f5bf6
  depends:
  - __unix
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 14074676
  timestamp: 1724801075448
- kind: conda
  name: libstdcxx-ng
  version: 14.2.0
  build: h4852527_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libstdcxx-ng-14.2.0-h4852527_1.conda
  sha256: 25bb30b827d4f6d6f0522cc0579e431695503822f144043b93c50237017fffd8
  md5: 8371ac6457591af2cf6159439c1fd051
  depends:
  - libstdcxx 14.2.0 hc0a3c3a_1
  license: GPL-3.0-only WITH GCC-exception-3.1
  license_family: GPL
  size: 54105
  timestamp: 1729027780628
- kind: conda
  name: libsystemd0
  version: '256.7'
  build: h2774228_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libsystemd0-256.7-h2774228_0.conda
  sha256: bea3dfd8b5caaa3a0f3f77dc86a0059312b3c1ea5996dbe1d301bc3c96a207f1
  md5: cdf7c26c2f9cc1e4ac01d57b03a85323
  depends:
  - __glibc >=2.17,<3.0.a0
  - libcap >=2.69,<2.70.0a0
  - libgcc >=13
  - libgcrypt >=1.11.0,<2.0a0
  - lz4-c >=1.9.3,<1.10.0a0
  - xz >=5.2.6,<6.0a0
  - zstd >=1.5.6,<1.6.0a0
  license: LGPL-2.1-or-later
  size: 409958
  timestamp: 1728421147693
- kind: conda
  name: libtiff
  version: 4.6.0
  build: h1dd3fc0_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libtiff-4.6.0-h1dd3fc0_3.conda
  sha256: fc3b210f9584a92793c07396cb93e72265ff3f1fa7ca629128bf0a50d5cb15e4
  md5: 66f03896ffbe1a110ffda05c7a856504
  depends:
  - lerc >=4.0.0,<5.0a0
  - libdeflate >=1.20,<1.21.0a0
  - libgcc-ng >=12
  - libjpeg-turbo >=3.0.0,<4.0a0
  - libstdcxx-ng >=12
  - libwebp-base >=1.3.2,<2.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - xz >=5.2.6,<6.0a0
  - zstd >=1.5.5,<1.6.0a0
  license: HPND
  size: 282688
  timestamp: 1711217970425
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
  version: '1.15'
  build: h0b41bf4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxcb-1.15-h0b41bf4_0.conda
  sha256: a670902f0a3173a466c058d2ac22ca1dd0df0453d3a80e0212815c20a16b0485
  md5: 33277193f5b92bad9fdd230eb700929c
  depends:
  - libgcc-ng >=12
  - pthread-stubs
  - xorg-libxau
  - xorg-libxdmcp
  license: MIT
  license_family: MIT
  size: 384238
  timestamp: 1682082368177
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
  version: 1.7.0
  build: h662e7e4_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxkbcommon-1.7.0-h662e7e4_0.conda
  sha256: 3d97d7f964237f42452295d461afdbc51e93f72e2c80be516f56de80e3bb6621
  md5: b32c0da42b1f24a98577bb3d7fc0b995
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libxcb >=1.15,<1.16.0a0
  - libxml2 >=2.12.6,<3.0a0
  - xkeyboard-config
  - xorg-libxau >=1.0.11,<2.0a0
  license: MIT/X11 Derivative
  license_family: MIT
  size: 593534
  timestamp: 1711303445595
- kind: conda
  name: libxml2
  version: 2.12.7
  build: hc051c1a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/libxml2-2.12.7-hc051c1a_1.conda
  sha256: 576ea9134176636283ff052897bf7a91ffd8ac35b2c505dfde2890ec52849698
  md5: 340278ded8b0dc3a73f3660bbb0adbc6
  depends:
  - icu >=73.2,<74.0a0
  - libgcc-ng >=12
  - libiconv >=1.17,<2.0a0
  - libzlib >=1.2.13,<2.0a0
  - xz >=5.2.6,<6.0a0
  license: MIT
  license_family: MIT
  size: 704984
  timestamp: 1717546454837
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
  name: markdown-it-py
  version: 3.0.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/markdown-it-py-3.0.0-pyhd8ed1ab_0.conda
  sha256: c041b0eaf7a6af3344d5dd452815cdc148d6284fec25a4fa3f4263b3a021e962
  md5: 93a8e71256479c62074356ef6ebf501b
  depends:
  - mdurl >=0.1,<1
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 64356
  timestamp: 1686175179621
- kind: conda
  name: markupsafe
  version: 3.0.1
  build: py311h2dc5d0c_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/markupsafe-3.0.1-py311h2dc5d0c_1.conda
  sha256: 3f632607bf3b12a5a98845f2c8b2d52104ad945eaa06d0bf778822db7bbc1cc2
  md5: 137fc3129d21210605d8ee63db86b66f
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  constrains:
  - jinja2 >=3.0.0
  license: BSD-3-Clause
  license_family: BSD
  size: 25450
  timestamp: 1728489178847
- kind: conda
  name: matplotlib
  version: 3.9.1
  build: py311h38be061_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-3.9.1-py311h38be061_1.conda
  sha256: d8d8bc621d652f7f70bb8f0914ba2cb5071c5c8d5638c686927a60f1a3d85df3
  md5: 41c69da88172782ae410c283e32608c7
  depends:
  - matplotlib-base >=3.9.1,<3.9.2.0a0
  - pyqt >=5.10
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - tornado >=5
  license: PSF-2.0
  license_family: PSF
  size: 8704
  timestamp: 1722568760705
- kind: conda
  name: matplotlib-base
  version: 3.9.1
  build: py311h74b4f7c_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/matplotlib-base-3.9.1-py311h74b4f7c_2.conda
  sha256: d35b8a68d6d803d4977ccf3354abe14a0d1037c06f7519701c0c3247265d489a
  md5: e4a26e6bd32d4af38492ba68caaa16d1
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
  - python >=3.11,<3.12.0a0
  - python-dateutil >=2.7
  - python_abi 3.11.* *_cp311
  - qhull >=2020.2,<2020.3.0a0
  - tk >=8.6.13,<8.7.0a0
  license: PSF-2.0
  license_family: PSF
  size: 7989076
  timestamp: 1722732854413
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
  name: mdurl
  version: 0.1.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/mdurl-0.1.2-pyhd8ed1ab_0.conda
  sha256: 64073dfb6bb429d52fff30891877b48c7ec0f89625b1bf844905b66a81cce6e1
  md5: 776a8dd9e824f77abac30e6ef43a8f7a
  depends:
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 14680
  timestamp: 1704317789138
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
  name: ml_dtypes
  version: 0.5.0
  build: py311h7db5c69_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ml_dtypes-0.5.0-py311h7db5c69_0.conda
  sha256: d04d21af12bd6fef67093e0f9089a3636acb4d719e50ae08241c81f6427f6ff0
  md5: 579f4f9f577a5c7bc2b506813e531bcc
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - numpy >=1.19,<3
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: MPL-2.0 AND Apache-2.0
  size: 287661
  timestamp: 1726376463116
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
  name: msgpack-python
  version: 1.1.0
  build: py311hd18a35c_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/msgpack-python-1.1.0-py311hd18a35c_0.conda
  sha256: 9033fa7084cbfd10e1b7ed3b74cee17169a0731ec98244d05c372fc4a935d5c9
  md5: 682f76920687f7d9283039eb542fdacf
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: Apache-2.0
  license_family: Apache
  size: 104809
  timestamp: 1725975116412
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
  version: 8.3.0
  build: hf1915f5_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mysql-common-8.3.0-hf1915f5_4.conda
  sha256: 4cf6d29e091398735348550cb74cfd5006e04892d54b6b1ba916935f1af1a151
  md5: 784a4df6676c581ca624fbe460703a6d
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - openssl >=3.2.1,<4.0a0
  license: GPL-2.0-or-later
  license_family: GPL
  size: 784844
  timestamp: 1709910607121
- kind: conda
  name: mysql-libs
  version: 8.3.0
  build: hca2cd23_4
  build_number: 4
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/mysql-libs-8.3.0-hca2cd23_4.conda
  sha256: c39cdd1a5829aeffc611f789bdfd4dbd4ce1aa829c73d728defec180b5265d91
  md5: 1b50eebe2a738a3146c154d2eceaa8b6
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - libzlib >=1.2.13,<2.0.0a0
  - mysql-common 8.3.0 hf1915f5_4
  - openssl >=3.2.1,<4.0a0
  - zstd >=1.5.5,<1.6.0a0
  license: GPL-2.0-or-later
  license_family: GPL
  size: 1537884
  timestamp: 1709910705541
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
  name: nccl
  version: 2.23.4.1
  build: h52f6c39_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/nccl-2.23.4.1-h52f6c39_0.conda
  sha256: 97c2afb30a74bb521378bdcba6874b2748347ebc59aa00a03b7d9b09d1f8e456
  md5: 90e2f166f125777963277ad9b780f808
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-version >=12.0,<13
  - cuda-version >=12.0,<13.0a0
  - libgcc >=12
  - libstdcxx >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 114380753
  timestamp: 1727484909105
- kind: conda
  name: ncurses
  version: '6.5'
  build: he02047a_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ncurses-6.5-he02047a_1.conda
  sha256: 6a1d5d8634c1a07913f1c525db6455918cbc589d745fac46d9d6e30340c8731a
  md5: 70caf8bb6cf39a0b6b7efc885f51c0fe
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=12
  license: X11 AND BSD-3-Clause
  size: 889086
  timestamp: 1724658547447
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
  build: py311h64a7726_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/numpy-1.26.4-py311h64a7726_0.conda
  sha256: 3f4365e11b28e244c95ba8579942b0802761ba7bb31c026f50d1a9ea9c728149
  md5: a502d7aad449a1206efb366d6a12c52d
  depends:
  - libblas >=3.9.0,<4.0a0
  - libcblas >=3.9.0,<4.0a0
  - libgcc-ng >=12
  - liblapack >=3.9.0,<4.0a0
  - libstdcxx-ng >=12
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  constrains:
  - numpy-base <0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 8065890
  timestamp: 1707225944355
- kind: conda
  name: ocl-icd
  version: 2.3.2
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ocl-icd-2.3.2-hd590300_1.conda
  sha256: 0e01384423e48e5011eb6b224da8dc5e3567c87dbcefbe60cd9d5cead276cdcd
  md5: c66f837ac65e4d1cdeb80e2a1d5fcc3d
  depends:
  - libgcc-ng >=12
  license: BSD-2-Clause
  license_family: BSD
  size: 135681
  timestamp: 1710946531879
- kind: conda
  name: ocl-icd-system
  version: 1.0.0
  build: '1'
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/ocl-icd-system-1.0.0-1.tar.bz2
  sha256: cb0ce5ce5ede1be2fd9edf88abd3ce3e6c2b7397c0283d623e4d8ccf96a1ed09
  md5: 577a4bd049737b11a24524e39a16a1f3
  depends:
  - ocl-icd
  license: BSD 3-Clause
  license_family: BSD
  size: 4253
  timestamp: 1575483836797
- kind: conda
  name: openjpeg
  version: 2.5.2
  build: h488ebb8_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openjpeg-2.5.2-h488ebb8_0.conda
  sha256: 5600a0b82df042bd27d01e4e687187411561dfc11cc05143a08ce29b64bf2af2
  md5: 7f2e286780f072ed750df46dc2631138
  depends:
  - libgcc-ng >=12
  - libpng >=1.6.43,<1.7.0a0
  - libstdcxx-ng >=12
  - libtiff >=4.6.0,<4.8.0a0
  - libzlib >=1.2.13,<2.0.0a0
  license: BSD-2-Clause
  license_family: BSD
  size: 341592
  timestamp: 1709159244431
- kind: conda
  name: openmm
  version: 8.1.2
  build: py311h5db57db_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openmm-8.1.2-py311h5db57db_2.conda
  sha256: d65c5e41af3e38293c660da9d28e20a8102dad441036830dcc08486272126057
  md5: 4e06d2a16a2fe0d2caab2de3e6c0328c
  depends:
  - __glibc >=2.17,<3.0.a0
  - cuda-nvrtc >=12.0.76,<13.0a0
  - cuda-version >=12.0,<13
  - libcufft >=11.0.0.21,<12.0a0
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - numpy >=1.23.5,<2.0a0
  - ocl-icd >=2.3.2,<3.0a0
  - ocl-icd-system
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - scipy
  license: LGPL-3.0-or-later
  license_family: LGPL
  size: 11534586
  timestamp: 1721253242511
- kind: conda
  name: openssl
  version: 3.3.2
  build: hb9d3cd8_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/openssl-3.3.2-hb9d3cd8_0.conda
  sha256: cee91036686419f6dd6086902acf7142b4916e1c4ba042e9ca23e151da012b6d
  md5: 4d638782050ab6faa27275bed57e9b4e
  depends:
  - __glibc >=2.17,<3.0.a0
  - ca-certificates
  - libgcc >=13
  license: Apache-2.0
  license_family: Apache
  size: 2891789
  timestamp: 1725410790053
- kind: conda
  name: opt-einsum
  version: 3.4.0
  build: hd8ed1ab_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/opt-einsum-3.4.0-hd8ed1ab_0.conda
  sha256: 583cb8748a9821e301a404806da0de62e8ba01607feecf12c0ef06d8bc77077e
  md5: 73d0b1d98a9030bdefe712648af583a0
  depends:
  - opt_einsum >=3.4.0,<3.4.1.0a0
  license: MIT
  license_family: MIT
  size: 6470
  timestamp: 1727392480705
- kind: conda
  name: opt_einsum
  version: 3.4.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/opt_einsum-3.4.0-pyhd8ed1ab_0.conda
  sha256: 69e979dfea8b8d82e51684f77d189e1d00cdcbc5c85868415b879719882e2df4
  md5: ff80afedd76f436acddbd1e14f5c2909
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 62487
  timestamp: 1727392477628
- kind: conda
  name: optax
  version: 0.2.2
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/optax-0.2.2-pyhd8ed1ab_1.conda
  sha256: 68ab5cd076de8d3ec6971a78bd3786a129a2c0d172a0fc66776b36d28b54f5f8
  md5: dd370641d3610ed329ae747f0eae09c8
  depends:
  - absl-py >=0.7.1
  - chex >=0.1.86
  - jax >=0.1.55
  - jaxlib >=0.1.37
  - numpy >=1.18.0
  - python >=3.9
  - typing_extensions >=3.10
  license: Apache-2.0
  license_family: APACHE
  size: 145268
  timestamp: 1718550769933
- kind: conda
  name: orbax-checkpoint
  version: 0.4.4
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/orbax-checkpoint-0.4.4-pyhd8ed1ab_0.conda
  sha256: 79012b755ed91777ed50d60ed790bf9cc5abff7bf05be807331cf15535618d1b
  md5: 1f3efaebaa9f6e6b6af781bcb60718be
  depends:
  - absl-py
  - etils
  - importlib_resources
  - jax >=0.4.9
  - jaxlib
  - msgpack-python
  - nest-asyncio
  - numpy
  - protobuf
  - python >=3.9
  - pyyaml
  - tensorstore >=0.1.35
  - typing_extensions
  license: Apache-2.0
  license_family: APACHE
  size: 86896
  timestamp: 1701452697513
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
  version: 2.2.3
  build: py311h7db5c69_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pandas-2.2.3-py311h7db5c69_1.conda
  sha256: dce121d3838996b77b810ca9097cc17068552075c761408a9b2eb788cf8fd1b0
  md5: 643f8cb35133eb1be4919fb953f0a25f
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libstdcxx >=13
  - numpy >=1.19,<3
  - numpy >=1.22.4
  - python >=3.11,<3.12.0a0
  - python-dateutil >=2.8.1
  - python-tzdata >=2022a
  - python_abi 3.11.* *_cp311
  - pytz >=2020.1,<2024.2
  license: BSD-3-Clause
  license_family: BSD
  size: 15695466
  timestamp: 1726879158862
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
  name: patsy
  version: 0.5.6
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/patsy-0.5.6-pyhd8ed1ab_0.conda
  sha256: 35ad5cab1d9c08cf98576044bf28f75e62f8492afe6d1a89c94bbe93dc8d7258
  md5: a5b55d1cb110cdcedc748b5c3e16e687
  depends:
  - numpy >=1.4.0
  - python >=3.6
  - six
  license: BSD-2-Clause AND PSF-2.0
  license_family: BSD
  size: 187218
  timestamp: 1704469432353
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
  name: pdbfixer
  version: '1.9'
  build: pyh1a96a4e_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pdbfixer-1.9-pyh1a96a4e_0.conda
  sha256: 053b4e535b178345c5666d04819c63004855eb38c5b49ae7c847e47a465b28c4
  md5: 20be3519aa2058a7088bf1474390638f
  depends:
  - numpy
  - openmm >=8.0
  - python >=3.6
  - setuptools
  license: MIT
  license_family: MIT
  size: 500978
  timestamp: 1684358498270
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
  version: 10.3.0
  build: py311h18e6fac_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pillow-10.3.0-py311h18e6fac_0.conda
  sha256: 6e54cc2acead8884e81e3e1b4f299b18d5daa0e3d11f4db5686db9e2ada2a353
  md5: 6c520a9d36c9d7270988c7a6c360d6d4
  depends:
  - freetype >=2.12.1,<3.0a0
  - lcms2 >=2.16,<3.0a0
  - libgcc-ng >=12
  - libjpeg-turbo >=3.0.0,<4.0a0
  - libtiff >=4.6.0,<4.8.0a0
  - libwebp-base >=1.3.2,<2.0a0
  - libxcb >=1.15,<1.16.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - openjpeg >=2.5.2,<3.0a0
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - tk >=8.6.13,<8.7.0a0
  license: HPND
  size: 42600867
  timestamp: 1712154582003
- kind: conda
  name: pip
  version: '24.2'
  build: pyh8b19718_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pip-24.2-pyh8b19718_1.conda
  sha256: d820e5358bcb117fa6286e55d4550c60b0332443df62121df839eab2d11c890b
  md5: 6c78fbb8ddfd64bcb55b5cbafd2d2c43
  depends:
  - python >=3.8,<3.13.0a0
  - setuptools
  - wheel
  license: MIT
  license_family: MIT
  size: 1237976
  timestamp: 1724954490262
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
  version: 4.3.6
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/platformdirs-4.3.6-pyhd8ed1ab_0.conda
  sha256: c81bdeadc4adcda216b2c7b373f0335f5c78cc480d1d55d10f21823590d7e46f
  md5: fd8f2b18b65bbf62e8f653100690c8d2
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 20625
  timestamp: 1726613611845
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
  name: prometheus_client
  version: 0.21.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/prometheus_client-0.21.0-pyhd8ed1ab_0.conda
  sha256: 01f0c3dd00081637ed920a922b17bcc8ed49608404ee466ced806856e671f6b9
  md5: 07e9550ddff45150bfc7da146268e165
  depends:
  - python >=3.8
  license: Apache-2.0
  license_family: Apache
  size: 49024
  timestamp: 1726902073034
- kind: conda
  name: prompt-toolkit
  version: 3.0.48
  build: pyha770c72_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/prompt-toolkit-3.0.48-pyha770c72_0.conda
  sha256: 44e4e6108d425a666856a52d1523e5d70890256a8920bb0dcd3d55cc750f3207
  md5: 4c05134c48b6a74f33bbb9938e4a115e
  depends:
  - python >=3.7
  - wcwidth
  constrains:
  - prompt_toolkit 3.0.48
  license: BSD-3-Clause
  license_family: BSD
  size: 270271
  timestamp: 1727341744544
- kind: conda
  name: prompt_toolkit
  version: 3.0.48
  build: hd8ed1ab_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/prompt_toolkit-3.0.48-hd8ed1ab_0.conda
  sha256: a26eed22badba036b35b8f0a3cc4d17130d7e43c80d3aa258b465dd7d69362a0
  md5: 60a2aeff42b5d629d45cc1be38ec1c5d
  depends:
  - prompt-toolkit >=3.0.48,<3.0.49.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 6664
  timestamp: 1727341747447
- kind: conda
  name: protobuf
  version: 4.25.3
  build: py311hbffca5d_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/protobuf-4.25.3-py311hbffca5d_1.conda
  sha256: 3e06dcdd3ec2e73fb456d5c2fdf9c8829d7f70c15d724f9920a24276a0a1d6b5
  md5: 27089f71e28d01bcc070460d822d5acb
  depends:
  - __glibc >=2.17,<3.0.a0
  - libabseil * cxx17*
  - libabseil >=20240116.2,<20240117.0a0
  - libgcc >=13
  - libprotobuf >=4.25.3,<4.25.4.0a0
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - setuptools
  license: BSD-3-Clause
  license_family: BSD
  size: 398881
  timestamp: 1725018534875
- kind: conda
  name: psutil
  version: 6.0.0
  build: py311h9ecbd09_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/psutil-6.0.0-py311h9ecbd09_2.conda
  sha256: dda8211015c82fd3f9f54a1e0b58826b02800426480fb3ab4f9ce7fdd2d8ef98
  md5: 8b746f1e8fc1cd8f7ce67ad694d7530b
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: BSD-3-Clause
  license_family: BSD
  size: 510027
  timestamp: 1728965276551
- kind: conda
  name: pthread-stubs
  version: '0.4'
  build: hb9d3cd8_1002
  build_number: 1002
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pthread-stubs-0.4-hb9d3cd8_1002.conda
  sha256: 9c88f8c64590e9567c6c80823f0328e58d3b1efb0e1c539c0315ceca764e0973
  md5: b3c17d95b5a10c6e64a21fa17573e70e
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 8252
  timestamp: 1726802366959
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
  name: pulseaudio-client
  version: '17.0'
  build: hb77b528_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pulseaudio-client-17.0-hb77b528_0.conda
  sha256: b27c0c8671bd95c205a61aeeac807c095b60bc76eb5021863f919036d7a964fc
  md5: 07f45f1be1c25345faddb8db0de8039b
  depends:
  - dbus >=1.13.6,<2.0a0
  - libgcc-ng >=12
  - libglib >=2.78.3,<3.0a0
  - libsndfile >=1.2.2,<1.3.0a0
  - libsystemd0 >=255
  constrains:
  - pulseaudio 17.0 *_0
  license: LGPL-2.1-or-later
  license_family: LGPL
  size: 757633
  timestamp: 1705690081905
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
  name: py3dmol
  version: 2.4.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/py3dmol-2.4.0-pyhd8ed1ab_0.conda
  sha256: 77e5b2a7f9b1085e6969182e3eeebff393019052acc93dbf35223e6596d274e5
  md5: 18462883a6f5aac4b59a1ab05d3ed5dc
  depends:
  - ipython
  - python >=3.6
  license: MIT
  license_family: MIT
  size: 12730
  timestamp: 1725956218447
- kind: conda
  name: pybind11-abi
  version: '4'
  build: hd8ed1ab_3
  build_number: 3
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/pybind11-abi-4-hd8ed1ab_3.tar.bz2
  sha256: d4fb485b79b11042a16dc6abfb0c44c4f557707c2653ac47c81e5d32b24a3bb0
  md5: 878f923dd6acc8aeb47a75da6c4098be
  license: BSD-3-Clause
  license_family: BSD
  size: 9906
  timestamp: 1610372835205
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
  version: 3.2.0
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/pyparsing-3.2.0-pyhd8ed1ab_1.conda
  sha256: b846e3965cd106438cf0b9dc0de8d519670ac065f822a7d66862e9423e0229cb
  md5: 035c17fbf099f50ff60bf2eb303b0a83
  depends:
  - python >=3.9
  license: MIT
  license_family: MIT
  size: 92444
  timestamp: 1728880549923
- kind: conda
  name: pyqt
  version: 5.15.9
  build: py311hf0fb5b6_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyqt-5.15.9-py311hf0fb5b6_5.conda
  sha256: 74fcdb8772c7eaf654b32922f77d9a8a1350b3446111c69a32ba4d15be74905a
  md5: ec7e45bc76d9d0b69a74a2075932b8e8
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - pyqt5-sip 12.12.2 py311hb755f60_5
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - qt-main >=5.15.8,<5.16.0a0
  - sip >=6.7.11,<6.8.0a0
  license: GPL-3.0-only
  license_family: GPL
  size: 5315719
  timestamp: 1695420475603
- kind: conda
  name: pyqt5-sip
  version: 12.12.2
  build: py311hb755f60_5
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyqt5-sip-12.12.2-py311hb755f60_5.conda
  sha256: cf6936273d92e5213b085bfd9ce1a37defb46b317b6ee991f2712bf4a25b8456
  md5: e4d262cc3600e70b505a6761d29f6207
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - packaging
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - sip
  - toml
  license: GPL-3.0-only
  license_family: GPL
  size: 85162
  timestamp: 1695418076285
- kind: conda
  name: pyrosetta
  version: 2023.49+release.9891f2c
  build: py311_0
  subdir: linux-64
  url: https://conda.graylab.jhu.edu/linux-64/pyrosetta-2023.49+release.9891f2c-py311_0.tar.bz2
  sha256: f65439ca671d3866aff9c7a2072dfaf16b0c9e2ac10a98fc808194ab732322e3
  md5: 31d498af88e22f222329dff3ee44147b
  depends:
  - numpy >=1.20.2
  - python >=3.11,<3.12.0a0
  - zlib >=1.2.13,<1.3.0a0
  size: 1610642836
  timestamp: 1701923239989
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
  version: 3.11.9
  build: hb806964_0_cpython
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/python-3.11.9-hb806964_0_cpython.conda
  sha256: 177f33a1fb8d3476b38f73c37b42f01c0b014fa0e039a701fd9f83d83aae6d40
  md5: ac68acfa8b558ed406c75e98d3428d7b
  depends:
  - bzip2 >=1.0.8,<2.0a0
  - ld_impl_linux-64 >=2.36.1
  - libexpat >=2.6.2,<3.0a0
  - libffi >=3.4,<4.0a0
  - libgcc-ng >=12
  - libnsl >=2.0.1,<2.1.0a0
  - libsqlite >=3.45.3,<4.0a0
  - libuuid >=2.38.1,<3.0a0
  - libxcrypt >=4.4.36
  - libzlib >=1.2.13,<2.0.0a0
  - ncurses >=6.4.20240210,<7.0a0
  - openssl >=3.2.1,<4.0a0
  - readline >=8.2,<9.0a0
  - tk >=8.6.13,<8.7.0a0
  - tzdata
  - xz >=5.2.6,<6.0a0
  constrains:
  - python_abi 3.11.* *_cp311
  license: Python-2.0
  size: 30884494
  timestamp: 1713553104915
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
  version: '2024.2'
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/python-tzdata-2024.2-pyhd8ed1ab_0.conda
  sha256: fe3f62ce2bc714bdaa222ab3f0344a2815ad9e853c6df38d15c9f25de8a3a6d4
  md5: 986287f89929b2d629bd6ef6497dc307
  depends:
  - python >=3.6
  license: Apache-2.0
  license_family: APACHE
  size: 142527
  timestamp: 1727140688093
- kind: conda
  name: python_abi
  version: '3.11'
  build: 5_cp311
  build_number: 5
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/python_abi-3.11-5_cp311.conda
  sha256: 2660b8059b3ee854bc5d3c6b1fce946e5bd2fe8fbca7827de2c5885ead6209de
  md5: 139a8d40c8a2f430df31048949e450de
  constrains:
  - python 3.11.* *_cpython
  license: BSD-3-Clause
  license_family: BSD
  size: 6211
  timestamp: 1723823324668
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
  build: py311h9ecbd09_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyyaml-6.0.2-py311h9ecbd09_1.conda
  sha256: e721e5ff389a7b2135917c04b27391be3d3382e261bb60a369b1620655365c3d
  md5: abeb54d40f439b86f75ea57045ab8496
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - yaml >=0.2.5,<0.3.0a0
  license: MIT
  license_family: MIT
  size: 212644
  timestamp: 1725456264282
- kind: conda
  name: pyzmq
  version: 26.2.0
  build: py311h7deb3e3_3
  build_number: 3
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/pyzmq-26.2.0-py311h7deb3e3_3.conda
  sha256: 3fdef7b3c43474b7225868776a373289a8fd92787ffdf8bed11cf7f39b4ac741
  md5: e0897de1d8979a3bb20ef031ae1f7d28
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libsodium >=1.0.20,<1.0.21.0a0
  - libstdcxx >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - zeromq >=4.3.5,<4.4.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 389074
  timestamp: 1728642373938
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
  build: hc9dc06e_21
  build_number: 21
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/qt-main-5.15.8-hc9dc06e_21.conda
  sha256: 6b4594f6f2fad65a7ed52993f602e3ab183193755fe4a492aaa48e463b23105b
  md5: b325046180590c868ce0dbf267b82eb8
  depends:
  - __glibc >=2.17,<3.0.a0
  - alsa-lib >=1.2.11,<1.3.0a0
  - dbus >=1.13.6,<2.0a0
  - fontconfig >=2.14.2,<3.0a0
  - fonts-conda-ecosystem
  - freetype >=2.12.1,<3.0a0
  - gst-plugins-base >=1.24.1,<1.25.0a0
  - gstreamer >=1.24.1,<1.25.0a0
  - harfbuzz >=8.3.0,<9.0a0
  - icu >=73.2,<74.0a0
  - krb5 >=1.21.2,<1.22.0a0
  - libclang-cpp15 >=15.0.7,<15.1.0a0
  - libclang13 >=15.0.7
  - libcups >=2.3.3,<2.4.0a0
  - libevent >=2.1.12,<2.1.13.0a0
  - libexpat >=2.6.2,<3.0a0
  - libgcc-ng >=12
  - libglib >=2.80.0,<3.0a0
  - libjpeg-turbo >=3.0.0,<4.0a0
  - libllvm15 >=15.0.7,<15.1.0a0
  - libpng >=1.6.43,<1.7.0a0
  - libpq >=16.2,<17.0a0
  - libsqlite >=3.45.2,<4.0a0
  - libstdcxx-ng >=12
  - libxcb >=1.15,<1.16.0a0
  - libxkbcommon >=1.7.0,<2.0a0
  - libxml2 >=2.12.6,<3.0a0
  - libzlib >=1.2.13,<2.0.0a0
  - mysql-libs >=8.3.0,<8.4.0a0
  - nspr >=4.35,<5.0a0
  - nss >=3.98,<4.0a0
  - openssl >=3.2.1,<4.0a0
  - pulseaudio-client >=17.0,<17.1.0a0
  - xcb-util >=0.4.0,<0.5.0a0
  - xcb-util-image >=0.4.0,<0.5.0a0
  - xcb-util-keysyms >=0.4.0,<0.5.0a0
  - xcb-util-renderutil >=0.3.9,<0.4.0a0
  - xcb-util-wm >=0.4.1,<0.5.0a0
  - xorg-libice >=1.1.1,<2.0a0
  - xorg-libsm >=1.2.4,<2.0a0
  - xorg-libx11 >=1.8.9,<2.0a0
  - xorg-libxext >=1.3.4,<2.0a0
  - xorg-xf86vidmodeproto
  - zstd >=1.5.5,<1.6.0a0
  constrains:
  - qt 5.15.8
  license: LGPL-3.0-only
  license_family: LGPL
  size: 61305384
  timestamp: 1712549380352
- kind: conda
  name: rav1e
  version: 0.6.6
  build: he8a937b_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/rav1e-0.6.6-he8a937b_2.conda
  sha256: 91b3c1ced90d04ee2eded1f72cf3cbc19ff05a25e41876ef0758266a5bab009f
  md5: 77d9955b4abddb811cb8ab1aa7d743e4
  depends:
  - libgcc-ng >=12
  license: BSD-2-Clause
  license_family: BSD
  size: 15423721
  timestamp: 1694329261357
- kind: conda
  name: re2
  version: 2023.09.01
  build: h7f4b329_2
  build_number: 2
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/re2-2023.09.01-h7f4b329_2.conda
  sha256: f0f520f57e6b58313e8c41abc7dfa48742a05f1681f05654558127b667c769a8
  md5: 8f70e36268dea8eb666ef14c29bd3cda
  depends:
  - libre2-11 2023.09.01 h5a48ba9_2
  license: BSD-3-Clause
  license_family: BSD
  size: 26617
  timestamp: 1708946796423
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
  name: rich
  version: 13.9.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/rich-13.9.2-pyhd8ed1ab_0.conda
  sha256: 7d481312e97df9ab914151c8294caff4a48f6427e109715445897166435de2ff
  md5: e56b63ff450389ba95a86e97816de7a4
  depends:
  - markdown-it-py >=2.2.0
  - pygments >=2.13.0,<3.0.0
  - python >=3.8
  - typing_extensions >=4.0.0,<5.0.0
  license: MIT
  license_family: MIT
  size: 185770
  timestamp: 1728057948663
- kind: conda
  name: rpds-py
  version: 0.20.0
  build: py311h9e33e62_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/rpds-py-0.20.0-py311h9e33e62_1.conda
  sha256: efcd140e5655816ce813c6e510db734bfa00c520e2d7fcc104d4402a33c48a0a
  md5: 3989f9a93796221aff20be94300e3b93
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  constrains:
  - __glibc >=2.17
  license: MIT
  license_family: MIT
  size: 331891
  timestamp: 1725327207078
- kind: conda
  name: scipy
  version: 1.14.1
  build: py311he1f765f_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/scipy-1.14.1-py311he1f765f_0.conda
  sha256: 36fd14d01a746bad1f9bc56045aa4fcfcdfe7b064a6d0c5a415dcdc8c0056983
  md5: eb7e2a849cd47483d7e9eeb728c7a8c5
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
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: BSD-3-Clause
  license_family: BSD
  size: 17723918
  timestamp: 1724328196061
- kind: conda
  name: seaborn
  version: 0.13.2
  build: hd8ed1ab_2
  build_number: 2
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/seaborn-0.13.2-hd8ed1ab_2.conda
  sha256: 79943fbbf1fafbf969257989a7d88638c0c3e7b89a81a75c9347c28768dd6141
  md5: a79d8797f62715255308d92d3a91ef2e
  depends:
  - seaborn-base 0.13.2 pyhd8ed1ab_2
  - statsmodels >=0.12
  license: BSD-3-Clause
  license_family: BSD
  size: 6996
  timestamp: 1714494772218
- kind: conda
  name: seaborn-base
  version: 0.13.2
  build: pyhd8ed1ab_2
  build_number: 2
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/seaborn-base-0.13.2-pyhd8ed1ab_2.conda
  sha256: 5de8b9e88a0f2daf58b07e3f144da26f894e9a20071304fa37329664eb2a29a7
  md5: b713b116feaf98acdba93ad4d7f90ca1
  depends:
  - matplotlib-base >=3.4,!=3.6.1
  - numpy >=1.20,!=1.24.0
  - pandas >=1.2
  - python >=3.8
  - scipy >=1.7
  constrains:
  - seaborn =0.13.2=*_2
  license: BSD-3-Clause
  license_family: BSD
  size: 234550
  timestamp: 1714494767378
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
  version: 75.1.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/setuptools-75.1.0-pyhd8ed1ab_0.conda
  sha256: 6725235722095c547edd24275053c615158d6163f396550840aebd6e209e4738
  md5: d5cd48392c67fb6849ba459c2c2b671f
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 777462
  timestamp: 1727249510532
- kind: conda
  name: sip
  version: 6.7.12
  build: py311hb755f60_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/sip-6.7.12-py311hb755f60_0.conda
  sha256: 71a0ee22522b232bf50d4d03d012e53cd5d1251d09dffc1c72d7c33a1086fe6f
  md5: 02336abab4cb5dd794010ef53c54bd09
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  - packaging
  - ply
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - tomli
  license: GPL-3.0-only
  license_family: GPL
  size: 585197
  timestamp: 1697300605264
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
  name: snappy
  version: 1.2.1
  build: ha2e4443_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/snappy-1.2.1-ha2e4443_0.conda
  sha256: dc7c8e0e8c3e8702aae81c52d940bfaabe756953ee51b1f1757e891bab62cf7f
  md5: 6b7dcc7349efd123d493d2dbe85a045f
  depends:
  - libgcc-ng >=12
  - libstdcxx-ng >=12
  license: BSD-3-Clause
  license_family: BSD
  size: 42465
  timestamp: 1720003704360
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
  name: statsmodels
  version: 0.14.4
  build: py311h9f3472d_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/statsmodels-0.14.4-py311h9f3472d_0.conda
  sha256: b5925165bdd694f2d22f4d367c31faeb5a43861b0e3fce575e459038a5f42f62
  md5: 81e81b5b7a744fcb279e98aa6d2e6683
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - numpy <3,>=1.22.3
  - numpy >=1.19,<3
  - packaging >=21.3
  - pandas !=2.1.0,>=1.4
  - patsy >=0.5.6
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - scipy !=1.9.2,>=1.8
  license: BSD-3-Clause
  license_family: BSD
  size: 12291537
  timestamp: 1727987151832
- kind: conda
  name: svt-av1
  version: 2.2.1
  build: h5888daf_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/svt-av1-2.2.1-h5888daf_0.conda
  sha256: a1c197ea17dac43ad6c223e42d78726b9f37f31f63d65e0c062e418cb98c7a8f
  md5: 0d9c441855be3d8dfdb2e800fe755059
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc-ng >=13
  - libstdcxx-ng >=13
  license: BSD-2-Clause
  license_family: BSD
  size: 2404332
  timestamp: 1724459503486
- kind: conda
  name: sysroot_linux-64
  version: '2.17'
  build: h4a8ded7_17
  build_number: 17
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/sysroot_linux-64-2.17-h4a8ded7_17.conda
  sha256: 5629b0e93c8e9fb9152de46e244d32ff58184b2cbf0f67757826a9610f3d1a21
  md5: f58cb23983633068700a756f0b5f165a
  depends:
  - kernel-headers_linux-64 3.10.0 he073ed8_17
  - tzdata
  license: LGPL-2.0-or-later AND LGPL-2.0-or-later WITH exceptions AND GPL-2.0-or-later AND MPL-2.0
  license_family: GPL
  size: 15141219
  timestamp: 1727437660028
- kind: conda
  name: tabulate
  version: 0.9.0
  build: pyhd8ed1ab_1
  build_number: 1
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/tabulate-0.9.0-pyhd8ed1ab_1.tar.bz2
  sha256: f6e4a0dd24ba060a4af69ca79d32361a6678e61d78c73eb5e357909b025b4620
  md5: 4759805cce2d914c38472f70bf4d8bcb
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 35912
  timestamp: 1665138565317
- kind: conda
  name: tensorstore
  version: 0.1.60
  build: py311hbe3d8c9_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/tensorstore-0.1.60-py311hbe3d8c9_0.conda
  sha256: 78345d1f60fd079d1e5b00030fc707588c03e3cbc8dc8dd7fd1e6dc7a952cdaa
  md5: aacc014cdb56cf6dfd6e11837fa6c0a3
  depends:
  - blosc >=1.21.5,<2.0a0
  - bzip2 >=1.0.8,<2.0a0
  - libavif16 >=1.0.4,<2.0a0
  - libcurl >=8.8.0,<9.0a0
  - libgcc-ng >=12
  - libjpeg-turbo >=3.0.0,<4.0a0
  - libpng >=1.6.43,<1.7.0a0
  - libprotobuf >=4.25.3,<4.25.4.0a0
  - libstdcxx-ng >=12
  - libwebp-base >=1.4.0,<2.0a0
  - libzlib >=1.2.13,<2.0a0
  - ml_dtypes
  - numpy >=1.23.5,<2.0a0
  - openssl >=3.3.0,<4.0a0
  - pybind11-abi 4
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - xz >=5.2.6,<6.0a0
  license: Apache-2.0 AND MIT AND BSD-3-Clause AND BSD-2-Clause
  size: 8344163
  timestamp: 1717069393535
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
  version: 2.0.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/tomli-2.0.2-pyhd8ed1ab_0.conda
  sha256: 5e742ba856168b606ac3c814d247657b1c33b8042371f1a08000bdc5075bc0cc
  md5: e977934e00b355ff55ed154904044727
  depends:
  - python >=3.7
  license: MIT
  license_family: MIT
  size: 18203
  timestamp: 1727974767524
- kind: conda
  name: toolz
  version: 1.0.0
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/toolz-1.0.0-pyhd8ed1ab_0.conda
  sha256: 6371cf3cf8292f2abdcc2bf783d6e70203d72f8ff0c1625f55a486711e276c75
  md5: 34feccdd4177f2d3d53c73fc44fd9a37
  depends:
  - python >=3.8
  license: BSD-3-Clause
  license_family: BSD
  size: 52623
  timestamp: 1728059623353
- kind: conda
  name: tornado
  version: 6.4.1
  build: py311h9ecbd09_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/tornado-6.4.1-py311h9ecbd09_1.conda
  sha256: 21390d0c5708581959ebd89702433c1d06a56ddd834797a194b217f98e38df53
  md5: 616fed0b6f5c925250be779b05d1d7f7
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  license: Apache-2.0
  license_family: Apache
  size: 856725
  timestamp: 1724956239832
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
  name: types-python-dateutil
  version: 2.9.0.20241003
  build: pyhff2d567_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/types-python-dateutil-2.9.0.20241003-pyhff2d567_0.conda
  sha256: 8489af986daebfbcd13d3748ba55431259206e37f184ab42a57e107fecd85e02
  md5: 3d326f8a2aa2d14d51d8c513426b5def
  depends:
  - python >=3.6
  license: Apache-2.0 AND MIT
  size: 21765
  timestamp: 1727940339297
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
  version: 2024b
  build: hc8b5060_0
  subdir: noarch
  noarch: generic
  url: https://conda.anaconda.org/conda-forge/noarch/tzdata-2024b-hc8b5060_0.conda
  sha256: 4fde5c3008bf5d2db82f2b50204464314cc3c91c1d953652f7bd01d9e52aefdf
  md5: 8ac3367aafb1cc0a068483c580af8015
  license: LicenseRef-Public-Domain
  size: 122354
  timestamp: 1728047496079
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
  version: 2.2.3
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/urllib3-2.2.3-pyhd8ed1ab_0.conda
  sha256: b6bb34ce41cd93956ad6eeee275ed52390fb3788d6c75e753172ea7ac60b66e5
  md5: 6b55867f385dd762ed99ea687af32a69
  depends:
  - brotli-python >=1.0.9
  - h2 >=4,<5
  - pysocks >=1.5.6,<2.0,!=1.5.7
  - python >=3.8
  - zstandard >=0.18.0
  license: MIT
  license_family: MIT
  size: 98076
  timestamp: 1726496531769
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
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-0.4.0-hd590300_1.conda
  sha256: 0c91d87f0efdaadd4e56a5f024f8aab20ec30f90aa2ce9e4ebea05fbc20f71ad
  md5: 9bfac7ccd94d54fd21a0501296d60424
  depends:
  - libgcc-ng >=12
  - libxcb >=1.13
  - libxcb >=1.15,<1.16.0a0
  license: MIT
  license_family: MIT
  size: 19728
  timestamp: 1684639166048
- kind: conda
  name: xcb-util-image
  version: 0.4.0
  build: h8ee46fc_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-image-0.4.0-h8ee46fc_1.conda
  sha256: 92ffd68d2801dbc27afe223e04ae7e78ef605fc8575f107113c93c7bafbd15b0
  md5: 9d7bcddf49cbf727730af10e71022c73
  depends:
  - libgcc-ng >=12
  - libxcb >=1.15,<1.16.0a0
  - xcb-util >=0.4.0,<0.5.0a0
  license: MIT
  license_family: MIT
  size: 24474
  timestamp: 1684679894554
- kind: conda
  name: xcb-util-keysyms
  version: 0.4.0
  build: h8ee46fc_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-keysyms-0.4.0-h8ee46fc_1.conda
  sha256: 8451d92f25d6054a941b962179180728c48c62aab5bf20ac10fef713d5da6a9a
  md5: 632413adcd8bc16b515cab87a2932913
  depends:
  - libgcc-ng >=12
  - libxcb >=1.15,<1.16.0a0
  license: MIT
  license_family: MIT
  size: 14186
  timestamp: 1684680497805
- kind: conda
  name: xcb-util-renderutil
  version: 0.3.9
  build: hd590300_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-renderutil-0.3.9-hd590300_1.conda
  sha256: 6987588e6fff5892056021c2ea52f7a0deefb2c7348e70d24750e2d60dabf009
  md5: e995b155d938b6779da6ace6c6b13816
  depends:
  - libgcc-ng >=12
  - libxcb >=1.13
  - libxcb >=1.15,<1.16.0a0
  license: MIT
  license_family: MIT
  size: 16955
  timestamp: 1684639112393
- kind: conda
  name: xcb-util-wm
  version: 0.4.1
  build: h8ee46fc_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xcb-util-wm-0.4.1-h8ee46fc_1.conda
  sha256: 08ba7147c7579249b6efd33397dc1a8c2404278053165aaecd39280fee705724
  md5: 90108a432fb5c6150ccfee3f03388656
  depends:
  - libgcc-ng >=12
  - libxcb >=1.15,<1.16.0a0
  license: MIT
  license_family: MIT
  size: 52114
  timestamp: 1684679248466
- kind: conda
  name: xkeyboard-config
  version: '2.42'
  build: h4ab18f5_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xkeyboard-config-2.42-h4ab18f5_0.conda
  sha256: 240caab7d9d85154ef373ecbac3ff9fb424add2029dbb124e949c6cbab2996dd
  md5: b193af204da1bfb8c13882d131a14bd2
  depends:
  - libgcc-ng >=12
  - xorg-libx11 >=1.8.9,<2.0a0
  license: MIT
  license_family: MIT
  size: 388998
  timestamp: 1717817668629
- kind: conda
  name: xorg-kbproto
  version: 1.0.7
  build: hb9d3cd8_1003
  build_number: 1003
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-kbproto-1.0.7-hb9d3cd8_1003.conda
  sha256: 849555ddf7fee334a5a6be9f159d2931c9d076ffb310a9e75b9124f789049d3e
  md5: e87bfacb110d85e1eb6099c9ed8e7236
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 30242
  timestamp: 1726846706299
- kind: conda
  name: xorg-libice
  version: 1.1.1
  build: hb9d3cd8_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libice-1.1.1-hb9d3cd8_1.conda
  sha256: ec276da68d1c4a3d34a63195b35ca5b248d4aff0812464dcd843d74649b5cec4
  md5: 19608a9656912805b2b9a2f6bd257b04
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 58159
  timestamp: 1727531850109
- kind: conda
  name: xorg-libsm
  version: 1.2.4
  build: he73a12e_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libsm-1.2.4-he73a12e_1.conda
  sha256: 70e903370977d44c9120a5641ab563887bd48446e9ef6fc2a3f5f60531c2cd6c
  md5: 05a8ea5f446de33006171a7afe6ae857
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  - libuuid >=2.38.1,<3.0a0
  - xorg-libice >=1.1.1,<2.0a0
  license: MIT
  license_family: MIT
  size: 27516
  timestamp: 1727634669421
- kind: conda
  name: xorg-libx11
  version: 1.8.9
  build: h8ee46fc_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libx11-1.8.9-h8ee46fc_0.conda
  sha256: 3e53ba247f1ad68353f18aceba5bf8ce87e3dea930de85d36946844a7658c9fb
  md5: 077b6e8ad6a3ddb741fce2496dd01bec
  depends:
  - libgcc-ng >=12
  - libxcb >=1.15,<1.16.0a0
  - xorg-kbproto
  - xorg-xextproto >=7.3.0,<8.0a0
  - xorg-xproto
  license: MIT
  license_family: MIT
  size: 828060
  timestamp: 1712415742569
- kind: conda
  name: xorg-libxau
  version: 1.0.11
  build: hb9d3cd8_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxau-1.0.11-hb9d3cd8_1.conda
  sha256: 532a046fee0b3a402db867b6ec55c84ba4cdedb91d817147c8feeae9766be3d6
  md5: 77cbc488235ebbaab2b6e912d3934bae
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 14679
  timestamp: 1727034741045
- kind: conda
  name: xorg-libxdmcp
  version: 1.1.5
  build: hb9d3cd8_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxdmcp-1.1.5-hb9d3cd8_0.conda
  sha256: 6b250f3e59db07c2514057944a3ea2044d6a8cdde8a47b6497c254520fade1ee
  md5: 8035c64cb77ed555e3f150b7b3972480
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 19901
  timestamp: 1727794976192
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
  version: 0.9.11
  build: hd590300_0
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-libxrender-0.9.11-hd590300_0.conda
  sha256: 26da4d1911473c965c32ce2b4ff7572349719eaacb88a066db8d968a4132c3f7
  md5: ed67c36f215b310412b2af935bf3e530
  depends:
  - libgcc-ng >=12
  - xorg-libx11 >=1.8.6,<2.0a0
  - xorg-renderproto
  license: MIT
  license_family: MIT
  size: 37770
  timestamp: 1688300707994
- kind: conda
  name: xorg-renderproto
  version: 0.11.1
  build: hb9d3cd8_1003
  build_number: 1003
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-renderproto-0.11.1-hb9d3cd8_1003.conda
  sha256: 54dd934b0e1c942e54759eb13672fd59b7e523fabea6e69a32d5bf483e45b329
  md5: bf90782559bce8447609933a7d45995a
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 11867
  timestamp: 1726802820431
- kind: conda
  name: xorg-xextproto
  version: 7.3.0
  build: hb9d3cd8_1004
  build_number: 1004
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-xextproto-7.3.0-hb9d3cd8_1004.conda
  sha256: f302a3f6284ee9ad3b39e45251d7ed15167896564dc33e006077a896fd3458a6
  md5: bc4cd53a083b6720d61a1519a1900878
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 30549
  timestamp: 1726846235301
- kind: conda
  name: xorg-xf86vidmodeproto
  version: 2.3.1
  build: hb9d3cd8_1004
  build_number: 1004
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-xf86vidmodeproto-2.3.1-hb9d3cd8_1004.conda
  sha256: f649e15e53d82fe5cece0b1fcc82deea3cd71a01ea4b3ebdc2cef1cdfeaf19b3
  md5: 24831329718daa6cbe35fcd071b778d4
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 26209
  timestamp: 1728918994652
- kind: conda
  name: xorg-xproto
  version: 7.0.31
  build: hb9d3cd8_1008
  build_number: 1008
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/xorg-xproto-7.0.31-hb9d3cd8_1008.conda
  sha256: ea02425c898d6694167952794e9a865e02e14e9c844efb067374f90b9ce8ce33
  md5: a63f5b66876bb1ec734ab4bdc4d11e86
  depends:
  - __glibc >=2.17,<3.0.a0
  - libgcc >=13
  license: MIT
  license_family: MIT
  size: 73315
  timestamp: 1726845753874
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
  build: h3b0a872_6
  build_number: 6
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zeromq-4.3.5-h3b0a872_6.conda
  sha256: e67288b1c98a31ee58a5c07bdd873dbe08e75f752e1ad605d5e8c0697339903e
  md5: 113506c8d2d558e733f5c38f6bf08c50
  depends:
  - __glibc >=2.17,<3.0.a0
  - krb5 >=1.21.3,<1.22.0a0
  - libgcc >=13
  - libsodium >=1.0.20,<1.0.21.0a0
  - libstdcxx >=13
  license: MPL-2.0
  license_family: MOZILLA
  size: 335528
  timestamp: 1728364029042
- kind: conda
  name: zipp
  version: 3.20.2
  build: pyhd8ed1ab_0
  subdir: noarch
  noarch: python
  url: https://conda.anaconda.org/conda-forge/noarch/zipp-3.20.2-pyhd8ed1ab_0.conda
  sha256: 1e84fcfa41e0afdd87ff41e6fbb719c96a0e098c1f79be342293ab0bd8dea322
  md5: 4daaed111c05672ae669f7036ee5bba3
  depends:
  - python >=3.8
  license: MIT
  license_family: MIT
  size: 21409
  timestamp: 1726248679175
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
  build: py311hbc35293_1
  build_number: 1
  subdir: linux-64
  url: https://conda.anaconda.org/conda-forge/linux-64/zstandard-0.23.0-py311hbc35293_1.conda
  sha256: a5cf0eef1ffce0d710eb3dffcb07d9d5922d4f7a141abc96f6476b98600f718f
  md5: aec590674ba365e50ae83aa2d6e1efae
  depends:
  - __glibc >=2.17,<3.0.a0
  - cffi >=1.11
  - libgcc >=13
  - python >=3.11,<3.12.0a0
  - python_abi 3.11.* *_cp311
  - zstd >=1.5.6,<1.5.7.0a0
  - zstd >=1.5.6,<1.6.0a0
  license: BSD-3-Clause
  license_family: BSD
  size: 417923
  timestamp: 1725305669690
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

# pixi shell --manifest-path ${ENVIRONMENT}/pixi.toml
eval "$(pixi shell-hook --manifest-path ${ENVIRONMENT}/pixi.toml)"

################################################################################
# colabdesign
################################################################################

# install ColabDesign
python3 -m pip install git+https://github.com/sokrypton/ColabDesign.git --no-deps

################################################################################
# bindcraft
################################################################################

# download bindcraft
git clone git@github.com:martinpacesa/BindCraft.git ${REPOS}/BindCraft

# download alphafold2 weights
mkdir -p ${REPOS}/BindCraft/params/
wget -P ${REPOS}/BindCraft/params/params https://storage.googleapis.com/alphafold/alphafold_params_2022-12-06.tar
tar -xvf ${REPOS}/BindCraft/params/params/alphafold_params_2022-12-06.tar -C ${REPOS}/BindCraft/params/

# chmod executables
chmod +x ${REPOS}/BindCraft/functions/dssp
chmod +x ${REPOS}/BindCraft/functions/DAlphaBall.gcc

cat << EOF > ${REPOS}/BindCraft/settings_target/PDL1.json
{
    "design_path": "./PDL1/",
    "binder_name": "PDL1",
    "starting_pdb": "./example/PDL1.pdb",
    "chains": "A",
    "target_hotspot_residues": "56",
    "lengths": [65, 150],
    "number_of_final_designs": 100
}
EOF

# example
# cd ${REPOS}/BindCraft
# python3 -u ./bindcraft.py \
#             --settings './settings_target/PDL1.json' \
#             --filters './settings_filters/default_filters.json' \
#             --advanced './settings_advanced/4stage_multimer.json'
