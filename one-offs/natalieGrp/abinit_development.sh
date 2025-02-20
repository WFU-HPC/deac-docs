#!/bin/bash

## DEAC Software System
## The HPC Team (hpc.wfu.edu, github.com/WFU-HPC)
## Wake Forest University

################################################################################
# TO-DO
################################################################################
# * OMP_NUM_THREADS=1 ON EVERYTHING!!!!!!!!!!!!!!!!!!
# * leverage Python to call configure, make, make check, etc.
# * generate scripts that are fully contained
# * integrate slurm support for asynchronous building
# * https://stackoverflow.com/questions/15535655/optional-arguments-in-initializer-of-python-class
# * https://stackoverflow.com/questions/27318243/running-bash-commands-in-python-and-handling-errors
################################################################################
################################################################################

source ./dss-functions.sh

## enable modules, just in case
# . /usr/share/Modules/init/bash

## global environment variables
export LANG="en_US.UTF-8"

# parallelization
export CORES=32

# arch parameters
export ARCHDIR=zen4
export ARCHOPT=znver4

_DSS_abinit              "10.3.4.26" \
                         "/deac/opt/rocky9-${ARCHDIR}/abinit/10.3.4.26" \
                         "compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/libxc/6.2.2 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 libs/netcdf-fortran/4.6.1 libs/intel/mkl/2023.2.0" \
                         "/deac/opt/modulefiles/rocky9-noarch /deac/opt/modulefiles/rocky9-${ARCHDIR}" \
                         "\$MKL_GNU_SCALAPACK_MULTITHREAD_STATIC" \
                         "/deac/inf/adminGrp/anderss/tarballs/abinit-10.3.4.26.tar.gz"

_DSS_abinit_mod          "10.3.4.26" \
                         "/deac/opt/rocky9-${ARCHDIR}/abinit/10.3.4.26" \
                         "compilers/gcc/12.3.0 mpi/openmpi/4.1.6 libs/libxc/6.2.2 libs/hdf5/1.14.3 libs/netcdf-c/4.9.2 libs/netcdf-fortran/4.6.1" \
                         "/deac/opt/modulefiles/rocky9-${ARCHDIR}/apps/abinit/10.3.4.26"
