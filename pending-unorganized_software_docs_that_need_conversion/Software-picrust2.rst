.. contents::
   :depth: 3
..

This page is to document the software picrust2 installed on the DEAC
Cluster.

Installation
============

picrust2 requires conda to be installed. To install conda, please follow
these instructions.

After installing conda please proceed with the following steps:
`Software:conda </Software:conda>`__

-  Download picrust2 source code.

| `` export WORKDIR=/deac/generalGrp/usershare/stevenca``
| `` cd $WORKDIR``
| `` wget ``\ ```https://github.com/picrust/picrust2/archive/master.zip`` <https://github.com/picrust/picrust2/archive/master.zip>`__
| `` unzip master.zip``

-  Load GCC compilers.

| `` module load gcc/6.2.0``
| `` module load gcc/6.2.0-libs``

-  Create dependency bin directory.

| `` mkdir $WORKDIR/picrust2-master/placement_tools/bin``
| `` echo "export PATH=/deac/generalGrp/usershare/stevenca/picrust2-master/placement_tools/bin:$PATH" >> ~/.bashrc``

-  Install epa dependency.

| `` cd $WORKDIR/picrust2-master/placement_tools``
| `` tar xvf epa-ng-0.2.1-beta-dev.tar.gz``
| `` cd epa-ng-0.2.1-beta-dev``
| `` make``
| `` ln -s $WORKDIR/picrust2-master/placement_tools/epa-ng-0.2.1-beta-dev/bin/epa-ng $WORKDIR/picrust2-master/placement_tools/bin``

-  Install gappa dependency.

| `` cd $WORKDIR/picrust2-master/placement_tools``
| `` tar xvf gappa-0.0.0-dev.tar.gz``
| `` cd gappa-0.0.0-dev``
| `` make``
| `` ln -s $WORKDIR/picrust2-master/placement_tools/gappa-0.0.0-dev/bin/gappa $WORKDIR/picrust2-master/placement_tools/bin``

-  Install papara dependency.

| `` cd $WORKDIR/picrust2-master/placement_tools/bin``
| `` wget ``\ ```https://sco.h-its.org/exelixis/resource/download/software/papara_nt-2.5-static_x86_64.tar.gz`` <https://sco.h-its.org/exelixis/resource/download/software/papara_nt-2.5-static_x86_64.tar.gz>`__
| `` tar xvf papara_nt-2.5-static_x86_64.tar.gz``
| `` mv papara_static_x86_64 papara``

-  Create conda environment for picrust2 and install picrust2 module.

| `` cd $WORKDIR/picrust2-master/``
| `` conda env create -f dev-environment.yml``
| `` source activate picrust2-dev``
| `` pip install --editable .``
