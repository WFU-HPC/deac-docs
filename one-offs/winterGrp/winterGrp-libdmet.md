# Libdmet (Updated for 2025 after DSS, BUT MAYBE NO WORH PORTING? I DUNNO ANY MORE)

```sh
export ENVTARG=/home/anderss/hdeac/phy/winterGrp/members/ganto21/libdmet/env-libdmet
export SOFTARG=/home/anderss/hdeac/phy/winterGrp/members/ganto21/libdmet/libdmet/libdmet_preview
mkdir -p $ENVTARG

# module purge && module load compilers/gcc/10.2.0 mpi/openmpi/4.1.1/gcc/10.2.0 libs/libxc/6.2.2/gcc/10.2.0 python/3.8.13 utils/cmake/3.23.1
module purge && module load compilers/gcc/12.3.0 apps/python/3.11.8 mpi/openmpi/4.1.6 libs/libxc/6.2.2
export PVER=$(python3 --version | awk '{print $2}' | awk -F. '{print $1"."$2}')

python3 -m venv $ENVTARG
source ${ENVTARG}/bin/activate

python3 -m pip install block2-mpi matplotlib
export LIBRARY_PATH="${ENVTARG}/lib:$LIBRARY_PATH"
export LD_LIBRARY_PATH="${ENVTARG}/lib:$LD_LIBRARY_PATH"
# export CMAKE_CONFIGURE_ARGS="-DBLA_VENDOR=Intel10_64lp_seq -DBUILD_MARCH_NATIVE=ON -DBUILD_LIBXC=OFF"
export CMAKE_CONFIGURE_ARGS="-DBLAS_LIBRARIES=-l:libmkl_gf_lp64.so.1;-l:libmkl_sequential.so.1;-l:libmkl_core.so.1 -DBUILD_MARCH_NATIVE=ON -DBUILD_LIBXC=OFF"
python3 -m pip install git+https://github.com/pyscf/pyscf
python3 -m pip install git+https://github.com/pyscf/dmrgscf 

cat <<EOF > ${ENVTARG}/lib/python${PVER}/site-packages/pyscf/dmrgscf/settings.py
#
# This file is an example to set the environment.
# The configs will be used in dmrgci.py and chemps2.py
#

import os
from pyscf import lib

# To install Block as the FCI solver for CASSCF, see
#       http://sunqm.github.io/Block/build.html
#       https://github.com/sanshar/Block
BLOCKEXE = '${ENVTARG}/bin/block2'
BLOCKEXE_COMPRESS_NEVPT = '${ENVTARG}/bin/block2'
BLOCKSCRATCHDIR = os.path.join('/scratch', str(os.environ.get("SLURM_JOB_ID")), str(os.getpid()))
#BLOCKRUNTIMEDIR = '.'
BLOCKRUNTIMEDIR = os.path.join(os.path.join('/scratch', str(os.environ.get("SLURM_JOB_ID")), str(os.getpid())))
MPIPREFIX = 'mpirun'  # change to srun for SLURM job system
BLOCKVERSION = None
EOF

chmod +x ${ENVTARG}/lib/python${PVER}/site-packages/pyscf/dmrgscf/nevpt_mpi.py

cat <<EOF > ${SOFTARG}/libdmet/solver/settings.py
# YOU NEED TO COPY THIS TO libdmet/solver/settings.py IN ORDER TO USE BLOCK
# block folder
#BLOCKPATH = '/deac/phy/winterGrp/members/ganto21/libdmet/env-libdmet/bin/'
BLOCKPATH = '/deac/phy/winterGrp/software/bin'
use_prebuild = False
BLOCK2PATH = "/deac/phy/winterGrp/members/ganto21/libdmet/env-libdmet/bin"

# Genetic algorithm reorder
GAOPTEXE = "/deac/phy/winterGrp/members/ganto21/libdmet/env-libdmet/bin/gaopt"
GAOPT2 = BLOCK2PATH + "/gaopt"
EOF

################################################################################
################################################################################

git clone https://github.com/gkclab/libdmet_preview.git ${SOFTARG}
find $SOFTARG \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i -e 's|np\.product|np\.prod|g'
find $SOFTARG \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i -e 's|np\.complex|complex|g'
find $SOFTARG \( -type d -name .git -prune \) -o -type f -print0 | xargs -0 sed -i -e 's|complex128|complex|g'


cat <<EOF > ${SOFTARG}/settings_DEAC.py
# YOU NEED TO COPY THIS TO libdmet/solver/settings.py IN ORDER TO USE BLOCK
# block folder
BLOCKPATH = '${ENVTARG}/bin/'
use_prebuild = False
BLOCK2PATH = "${ENVTARG}/bin"

# Genetic algorithm reorder
GAOPTEXE = "${ENVTARG}/bin/gaopt"
GAOPT2 = BLOCK2PATH + "/gaopt"
EOF

cat <<EOF > ${SOFTARG}/libdmet/solver/settings.py
# YOU NEED TO COPY THIS TO libdmet/solver/settings.py IN ORDER TO USE BLOCK
# block folder
BLOCKPATH = '${ENVTARG}/bin/'
use_prebuild = False
BLOCK2PATH = "${ENVTARG}/bin"

# Genetic algorithm reorder
GAOPTEXE = "${ENVTARG}/bin/gaopt"
GAOPT2 = BLOCK2PATH + "/gaopt"
EOF

################################################################################
################################################################################

mkdir -p /home/anderss/hdeac/phy/winterGrp/members/ganto21/libdmet/modulefiles

cat <<EOF > /home/anderss/hdeac/phy/winterGrp/members/ganto21/libdmet/modulefiles/libdmet
#%Module########################################################################
##
## Custom module for winterGrp 'libdmet' software environment
## PySCF+DMRGSCF installed into virtualenv with Block2+OMPI+MKL
## 

proc ModulesHelp { } {
    puts stderr "\tCustom module for winterGrp 'libdmet' software environment.\n"
    puts stderr "\tIncludes: PySCF + DMRGSCF\n"
}

module-whatis   "Custom module for winterGrp 'libdmet' software environment"

if { [module-info command load] } {
    if {[getenv --return-value VIRTUAL_ENV] ne ""} {
        puts stderr ""
        puts stderr "########################################################################"
        puts stderr "It seems like you may have another virtual environment activated!"
        puts stderr "Please deactivate other environments before loading this module."
        puts stderr "########################################################################"
        exit
    }
}

module load compilers/gcc/12.3.0 apps/python/3.11.8 mpi/openmpi/4.1.6 libs/libxc/6.2.2

set envdir  "$ENVTARG"
set sofdir  "$SOFTARG"
set basedir "$TARGET"

if { [module-info shelltype sh] && [module-info mode load] } {
    puts stdout ". \$envdir/bin/activate ;"
} elseif { [module-info shelltype csh] && [module-info mode load] } {
    puts stdout "source \$envdir/bin/activate.csh ;"
}

if { [module-info mode load] } {
    puts stderr ""
    puts stderr "########################################################################"
    puts stderr "This module activates the Python virtual environment located at:"
    puts stderr "\$envdir"
    puts stderr "WARNING: Your shell prompt will not change!"
    puts stderr "WARNING: You need to deactivate any previously activated environments!"
    puts stderr "########################################################################"
}

if { [module-info command unload] && [module-info command purge] } {
    puts stdout "deactivate ;"
}

if {[getenv --return-value SLURM_JOB_ID] ne ""} {
    setenv  PYSCF_TMPDIR    "/scratch/\$env(SLURM_JOB_ID)"
} else {
    setenv  PYSCF_TMPDIR    "/scratch/\$env(USER)"
}

################################################################################
################################################################################

prepend-path    PATH                \$envdir/bin
prepend-path    LD_LIBRARY_PATH     \$envdir/lib
prepend-path    LIBRARY_PATH        \$envdir/lib
prepend-path    LD_PRELOAD          libgomp.so
prepend-path    LD_PRELOAD          \$envdir/lib/libmkl_gnu_thread.so.1
prepend-path    LD_PRELOAD          \$envdir/lib/libmkl_gf_lp64.so.1
prepend-path    LD_PRELOAD          \$envdir/lib/libmkl_core.so.1
prepend-path    LD_PRELOAD          \$envdir/lib/libmkl_avx2.so.1
prepend-path    LD_PRELOAD          \$envdir/lib/libmkl_def.so.1
prepend-path    PYTHONPATH          \$sofdir

setenv  OMP_NUM_THREADS  1
setenv  VIRTUAL_ENV                 \$envdir
setenv  VIRTUAL_ENV_DISABLE_PROMPT  1
setenv  VIRTUAL_ENV_PROMPT          "(env-libdmet) "
EOF
```

How to run:

```sh
module purge && module load libdmet

export PYSCF_TMPDIR="/scratch/${SLURM_JOB_ID}"

source ${ENVTARG}/bin/activate
```


















































































## DEPRECATED

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

cat <<EOF > ${PREFIX}/modules/apps/libdmet
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
```
