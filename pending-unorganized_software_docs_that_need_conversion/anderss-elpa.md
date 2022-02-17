# ELPA (WORK IN PROGRESS)


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

* Intel compilers (`module load compilers/intel/2020`)
* Open MPI compiled with Intel compilers (`module load mpi/openmpi/4.0.3-intel`)
* Intel MKL (`module load libs/intel/mkl/2020`)


### Compilation

Natalie sent me this:
```sh
./configure \
--prefix="/home/sunlight/work2/cp2k/libs/libelpa/201911001" \
--libdir="/home/sunlight/work2/cp2k/libs/libelpa/201911001/lib" \
--enable-openmp=no \
--enable-shared=no \
--enable-static=yes \
--enable-avx=yes \
--enable-avx2=yes \
--enable-avx512=yes \
--enable-option-checking=fatal \
FC=/opt/intel2020up1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/bin/mpiifort \
CC=/opt/intel2020up1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/bin/mpiicc \
CXX=/opt/intel2020up1/compilers_and_libraries_2020.1.217/linux/mpi/intel64/bin/mpiicpc \
FCFLAGS="-O3 -xAVX2" CFLAGS="-O3 -xAVX2" \
SCALAPACK_LDFLAGS="-L/opt/intel2020up1/mkl/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread " \
SCALAPACK_FCFLAGS="-I/opt/intel2020up1/mkl/include/intel64/lp64"

./configure --enable-openmp=no --enable-shared=no --enable-static=yes --enable-avx=yes --enable-avx2=yes --enable-avx512=yes --enable-option-checking=fatal FC=mpiifort CC=mpiicc CXX=mpiicpc FCFLAGS="-O3 -xAVX2" CFLAGS="-O3 -xAVX2" SCALAPACK_LDFLAGS="-L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread" SCALAPACK_FCFLAGS="-I${MKLROOT}/include/intel64/lp64"
```


```sh
./configure CC=mpicc FC=mpifort CXX=mpicxx CFLAGS="-O2" FCFLAGS="-O2" SCALAPACK_LDFLAGS="${MKL_SCALAPACK_SEQUENTIAL}" SCALAPACK_FCFLAGS="${MKL_SCALAPACK_SEQUENTIAL} -I${MKLROOT}/include/intel64/lp64"
```

```sh
# same as above
./configure CC=mpicc FC=mpifort CXX=mpicxx SCALAPACK_LDFLAGS="-L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_openmpi_lp64 -lpthread -lm -ldl" SCALAPACK_FCFLAGS="-I${MKLROOT}/include/intel64/lp64"
```

```sh
# bad
./configure CC=mpicc FC=mpifort SCALAPACK_LDFLAGS="-L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -Wl,-rpath,${MKLROOT}/lib/intel64" SCALAPACK_FCFLAGS="-L${MKLROOT}/lib/intel64 -lmkl_scalapack_lp64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lmkl_blacs_intelmpi_lp64 -lpthread -lm -I${MKLROOT}/include/intel64/lp64"
```

```
make -j8
```


## Useful guides

* https://gitlab.mpcdf.mpg.de/elpa/elpa/-/wikis/INSTALL
* https://github.com/hfp/xconfigure/blob/master/config/elpa/configure-elpa-skx.sh
