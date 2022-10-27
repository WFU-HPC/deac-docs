# ELPA (UPDATED FOR 2022)


## Introduction

The computation of selected or all eigenvalues and eigenvectors of a symmetric
(Hermitian) matrix has high relevance for various scientific disciplines. For
the calculation of a significant part of the eigensystem typically direct
eigensolvers are used. For large problems, the eigensystem calculations with
existing solvers can become the computational bottleneck. As a consequence, the
ELPA project was initiated with the aim to develop and implement an efficient
eigenvalue solver for petaflop applications.


## Installation

The ELPA library can be downloaded directly from the
[website](https://elpa.mpcdf.mpg.de/).


### Prerequisites

* Compilers (`compilers/gcc/10.2.0 compilers/intel/2021.2`)
* Open MPI compiled with Intel compilers (`mpi/openmpi/4.1.1/intel/2021.2l`)
* Intel MKL (`libs/intel/mkl/2021.2`)


### Building

```sh
cd $TMPDIR
wget https://elpa.mpcdf.mpg.de/software/tarball-archive/Releases/2022.05.001/elpa-2022.05.001.tar.gz
tar -xvf elpa-2022.05.001.tar.gz

cd $TMPDIR/elpa-2022.05.001
rm -rf build; mkdir -p build && cd build
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/openmpi/4.1.1/intel/2021.2 libs/intel/mkl/2021.2
../configure \
    FCFLAGS="-O3 -xCORE-AVX512" \
    CFLAGS="-O3 -march=skylake-avx512 -mfma" \
    SCALAPACK_LDFLAGS="${MKL_SCALAPACK_SEQUENTIAL}" \
    SCALAPACK_FCFLAGS="-I${MKLROOT}/include/intel64/lp64" \
    --prefix=/deac/opt/rhel7/elpa/2022.05.001-intel_2021.2 \
    --enable-avx2 \
    --enable-avx512 \
    --enable-option-checking=fatal \
    --enable-scalapack-tests
time make -j8 && make check && make install

cd $TMPDIR/elpa-2022.05.001
rm -rf build; mkdir -p build && cd build
module purge && module load compilers/gcc/10.2.0 mpi/openmpi/4.1.1/gcc/10.2.0 libs/intel/mkl/2021.2
../configure \
    FCFLAGS="-O3 -march=skylake-avx512 -mfma" \
    CFLAGS="-O3 -march=skylake-avx512 -mfma" \
    SCALAPACK_LDFLAGS="${MKL_GCC_SCALAPACK_SEQUENTIAL}" \
    SCALAPACK_FCFLAGS="-I${MKLROOT}/include/intel64/lp64" \
    --prefix=/deac/opt/rhel7/elpa/2022.05.001-gcc_10.2.0 \
    --enable-avx2 \
    --enable-avx512 \
    --enable-option-checking=fatal \
    --enable-scalapack-tests
time make -j8 && make check && make install
```


## Useful guides

* https://gitlab.mpcdf.mpg.de/elpa/elpa/-/wikis/INSTALL
* https://github.com/hfp/xconfigure/blob/master/config/elpa/configure-elpa-skx.sh
