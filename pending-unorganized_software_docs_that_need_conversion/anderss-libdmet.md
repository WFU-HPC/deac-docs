# Libdmet

This software is pretty rough. It wants to use ancient Boost libraries and Python 2. User beware!

```sh
TMPDIR="/scratch/${USER}"
PREFIX="/deac/phy/winterGrp/software"

mkdir -p ${TMPDIR}
mkdir -p ${PREFIX}
mkdir -p ${PREFIX}/python
mkdir -p ${PREFIX}/modules

module purge && module load compilers/gcc/10.2.0 libs/intel/mkl/2021.2 python/3.8.13
export PATH="${PREFIX}/bin:${PATH}"
export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
export INCLUDE="${PREFIX}/include:${INCLUDE}"

################################################################################
################################################################################

cd $TMPDIR
wget https://download.open-mpi.org/release/open-mpi/v1.10/openmpi-1.10.7.tar.bz2
tar -xvf openmpi-1.10.7.tar.bz2
cd openmpi-1.10.7
./configure --prefix=${PREFIX} --with-usnic --enable-mpi-cxx --enable-mpi-cxx-seek --enable-cxx-exceptions --without-psm --without-psm2
make -j4 all
make check
make install
cd $HOME && rm -rf ${TMPDIR}/openmpi-1.10.7*

################################################################################
################################################################################

# Refer to boost documentation in deac-docs

################################################################################
################################################################################

wget -P ${PREFIX}/bin http://www.sunqm.net/pyscf/files/bin/block.spin_adapted-1.5.3.gz
wget -P ${PREFIX}/bin http://www.sunqm.net/pyscf/files/bin/block.spin_adapted-1.5.3-serial.gz
gunzip ${PREFIX}/bin/block.spin_adapted-1.5.3.gz && chmod +x ${PREFIX}/bin/block.spin_adapted-1.5.3
gunzip ${PREFIX}/bin/block.spin_adapted-1.5.3-serial.gz && chmod +x ${PREFIX}/bin/block.spin_adapted-1.5.3-serial

################################################################################
################################################################################

# https://pyscf.org/install.html#environment-variables-and-global-configures
pip3 install git+https://github.com/pyscf/dmrgscf --target=${PREFIX}/python --upgrade

cat <<EOF > ${PREFIX}/python/pyscf/dmrgscf/settings.py
#
# This file is an example to set the environment.
# The configs will be used in dmrgci.py and chemps2.py
#

import os
from pyscf import lib

# To install Block as the FCI solver for CASSCF, see
#       http://sunqm.github.io/Block/build.html
#       https://github.com/sanshar/Block
BLOCKEXE = '${PREFIX}/bin/block.spin_adapted-1.5.3'
BLOCKEXE_COMPRESS_NEVPT = '${PREFIX}/bin/block.spin_adapted-1.5.3-serial'
BLOCKSCRATCHDIR = os.path.join('/scratch', str(os.environ.get("SLURM_JOB_ID")), str(os.getpid()))
#BLOCKRUNTIMEDIR = '.'
BLOCKRUNTIMEDIR = os.path.join(os.path.join('/scratch', str(os.environ.get("SLURM_JOB_ID")), str(os.getpid())))
MPIPREFIX = 'mpirun'  # change to srun for SLURM job system
BLOCKVERSION = None
EOF

################################################################################
################################################################################

git clone https://github.com/gkclab/libdmet_preview.git ${PREFIX}/python/libdmet_preview

cat <<EOF > ${PREFIX}/python/libdmet_preview/libdmet/solver/settings.py
# Stackblock folder
BLOCKPATH = '${PREFIX}/bin/'
use_prebuild = False
BLOCK2PATH = "${PREFIX}/block2/pyblock2/driver/"

# Genetic algorithm reorder
GAOPTEXE = "${PREFIX}/stackblock_hc/genetic/gaopt"
GAOPT2 = BLOCK2PATH + "/gaopt"
EOF

################################################################################
################################################################################

cat <<EOF > ${PREFIX}/modules/libdmet
#%Module########################################################################
##
## Custom module for winterGrp 'libdmet' software environment
## OMPI 1.10.7, Boost 1.55.0, StackBlock 1.5.3, PySCF+DMRGSCF
## Built with GCC 10.2.0, MKL 2021.2, and Python 3.8.13
## 

proc ModulesHelp { } {
    puts stderr "\tCustom module for winterGrp 'libdmet' software environment.\n"
    puts stderr "\tIncludes: Open MPI 1.10.7\n"
    puts stderr "\t          Boost 1.55.0\n"
    puts stderr "\t          StackBlock 1.5.3\n"
    puts stderr "\t          PySCF + DMRGSCF\n"
    puts stderr "\tBuilt with GCC 10.2.0, MKL 2021.2, and Python 3.8.13.\n"
}

module-whatis   "Custom module for winterGrp 'libdmet' software environment"

set basedir "${PREFIX}"

module load compilers/gcc/10.2.0 libs/intel/mkl/2021.2 python/3.8.13

################################################################################
################################################################################

prepend-path    PATH                \$basedir/bin
prepend-path    MANPATH             \$basedir/share/man
prepend-path    LD_LIBRARY_PATH     \$basedir/lib
prepend-path    LIBRARY_PATH        \$basedir/lib
prepend-path    C_INCLUDE_PATH      \$basedir/include
prepend-path    CPLUS_INCLUDE_PATH  \$basedir/include
prepend-path    INCLUDE             \$basedir/include
prepend-path    PKG_CONFIG_PATH     \$basedir/lib/pkgconfig
prepend-path    CMAKE_PREFIX_PATH   \$basedir/
prepend-path    PYTHONPATH          \$basedir/python
prepend-path    PYTHONPATH          \$basedir/python/libdmet_preview
EOF

echo "export MODULEPATH=\"${PREFIX}/modules:${MODULEPATH}\"" >> ${HOME}/.bashrc

################################################################################
################################################################################

## Actually running the thing

# module load libdmet

# export OMP_NUM_THREADS=1
# export PYSCF_TMPDIR="/scratch/${SLURM_JOB_ID}"
```
