# NWChem (updated for 2022)

```sh
srun -p gpu --pty -N 1 -n 32 --mem=16G --time=00-24:00:00 /bin/bash

module load python/3.8.13 compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/openmpi/4.1.1/intel/2021.2 libs/intel/mkl/2021.2 libs/elpa/2022.05.001/intel/2021.2

export TMPDIR="/scratch/${SLURM_JOB_ID}"
export NWCHEM_TOP="${TMPDIR}/nwchem-7.0.2"
export NWCHEM_TARGET=LINUX64
export ARMCI_NETWORK=MPI-PR
export NWCHEM_MODULES="all python"
export USE_MPI=y
export USE_SCALAPACK=y
export BLAS_SIZE=8
export SCALAPACK_SIZE=8
export BLASOPT="-L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl"
export LAPACK_LIB="$BLASOPT"
export SCALAPACK="-L$MKLROOT/lib/intel64 -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lmkl_blacs_openmpi_ilp64 -lpthread -lm -ldl"
export ELPA="-I$ELPAHOME/include -L$ELPAHOME/lib -lelpa"
export USE_OPENMP=0
export CCSDTQ=TRUE
export PYTHONVERSION=3.8
## The following two options help if only shared storage is available. Since
## our users can run on the local /scratch directory of each node, these are
## not necessary.
# export USE_NOFSCHECK=TRUE
# export USE_NOIO=TRUE

cd $TMPDIR
wget https://github.com/nwchemgit/nwchem/releases/download/v7.0.2-release/nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.bz2
tar -xvf nwchem-7.0.2-release.revision-b9985dfa-src.2020-10-12.tar.bz2
# cd nwchem-7.0.2

## Build, takes a VERY long time (almost 10 hours!!)
# sed -i 's/CPP=fpp -P//g' ${NWCHEM_TOP}/src/config/makefile.h
cd ${NWCHEM_TOP}/src
make nwchem_config
time make -j32
make test && mpirun -np 2 ./nwchem_test

## Site installation, just copying several things
export NWCHEM_PREFIX="/deac/opt/rhel7/NWChem/7.0.2-intel_2021.2"
mkdir -p $NWCHEM_PREFIX
mkdir -p ${NWCHEM_PREFIX}/bin
mkdir -p ${NWCHEM_PREFIX}/data

cp    ${NWCHEM_TOP}/bin/${NWCHEM_TARGET}/nwchem   ${NWCHEM_PREFIX}/bin
cp -r ${NWCHEM_TOP}/src/basis/libraries           ${NWCHEM_PREFIX}/data
cp -r ${NWCHEM_TOP}/src/data                      $NWCHEM_PREFIX
cp -r ${NWCHEM_TOP}/src/nwpw/libraryps            ${NWCHEM_PREFIX}/data
cp -r ${NWCHEM_TOP}/examples                      $NWCHEM_PREFIX
chmod 755 ${NWCHEM_PREFIX}/bin/nwchem

cat <<EOF > ${NWCHEM_PREFIX}/data/default.nwchemrc
nwchem_basis_library    ${NWCHEM_PREFIX}/data/libraries/
nwchem_nwpw_library     ${NWCHEM_PREFIX}/data/libraryps/
ffield                  amber
amber_1                 ${NWCHEM_PREFIX}/data/amber_s/
amber_2                 ${NWCHEM_PREFIX}/data/amber_q/
amber_3                 ${NWCHEM_PREFIX}/data/amber_x/
amber_4                 ${NWCHEM_PREFIX}/data/amber_u/
spce                    ${NWCHEM_PREFIX}/data/solvents/spce.rst
charmm_s                ${NWCHEM_PREFIX}/data/charmm_s/
charmm_x                ${NWCHEM_PREFIX}/data/charmm_x/
EOF
```
