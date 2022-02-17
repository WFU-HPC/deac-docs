.. contents::
   :depth: 3
..

Documentation for Python package PyEMMA

PyEMMA is a module developed for Python 3. While PyEMMA can be installed
via pip, previous attempts to install PyEMMA this way have led to
defunct behavior. It is best to attempt and install the module locally
to your research path and then source the environment in your SLURM
submission script.

Install
=======

Installation Instructions referenced from
http://www.emma-project.org/latest/INSTALL.html

The installation script installs the PyEMMA package in your home
directory. You will need to install the PyEMMA package to your research
group path to access it through SLURM job submissions.

`` export HOME=/deac/generalGrp/usershare/stevenca``

Download and execute the installation script.

`` curl -s ``\ ```https://raw.githubusercontent.com/markovmodel/PyEMMA/devel/install_miniconda%2Bpyemma.sh`` <https://raw.githubusercontent.com/markovmodel/PyEMMA/devel/install_miniconda%2Bpyemma.sh>`__\ `` | bash``

Once the package downloads and installs to the directory specified in
HOME you are ready to use the script in your SLURM submission script.

Use
===

Once you have installed the PyEMMA package to your research path you
should find a directory labelled miniconda3 in your installation path.
To setup the environment for PyEMMA you will need to activate the PyEMMA
environment in your .slurm script.

| `` WORKDIR=/deac/generalGrp/usershare/stevenca``
| `` $WORKDIR/miniconda3/envs/pyemma/lib/python3.6/venv/scripts/common/activate``
| `` module load python/3.5.2``
