# PROFESS + QE


## Introduction

This software has a very non-standard install process, and relies on out-of-date
libraries. Initial thoughts are that this will not be able to be a standardized
install for the cluster.

From what I can tell, there are three primary components:
    * The patches that allow PROFESS3 to work with Quantum-Espresso
      (`ProfAtQE2.0.1_20181012.tgz`), which is what you download from
      [here](http://www.qtp.ufl.edu/ofdft/research/computation.shtml). We will
      refer to this as ProfessAtQE for the remainder of this document.
    * The PROFESS3 code, which can be obtained [after a few clicks
      here](https://data.mendeley.com/datasets/jc57mcyv6t/1)
      (`aebn_v3_0.tar.gz`).
    * The QE 5.2.1 code, which is not identical to the one that can be
      downloaded from the QE website. I obtained this via the [archive.org
      Wayback Machine](https://archive.org/web/) (`espresso-5.2.1.tar.gz`).

The remainder of the pre-requisites are FFTW3, FFTW2, LAPACK, and an old version
of Libxc. I believe that some of these can be included via the Intel MKL.
Apparently, the intel MPI compilers act very differently when invoked as `mpicc`
and `mpif90` compared to `mpiicc` and `mpiifort`. The latter seem to have some
automatic connection with MKL, and thus, the various LAPACK, BLAS, FFTW3, and
FFTW2 libraries/interfaces that are available in it. It is worth exploring this
as an alternative to having to manually compile these libraries as detailed
below. This may not work for FFTW2, as the PROFESS+QE package includes a patch
for this library, and thus may not be compatible with the MKL version.

From talks with people smarter than me, it would seem like this is the perfect
candidate for containerization.


## Work


### Preamble

Set up your a directory for you to work in. Uncompress the three components:

```sh
RESEARCH_PATH="${HOME}/scratch"
cd $RESEARCH_PATH/profess/
tar -xvf $RESEARCH_PATH/tarballs/profess/ProfAtQE2.0.1_20181012.tgz
tar -xvf $RESEARCH_PATH/tarballs/profess/aebn_v3_0.tar.gz
tar -xvf $RESEARCH_PATH/tarballs/profess/espresso-5.2.1.tar.gz
```

Patch the necessary files:

```sh
cd $RESEARCH_PATH/profess/PROFESS3.0
patch -p1 < $RESEARCH_PATH/profess/OFQE2.0.1/patches/PROFESS3.0-PROFESS3.0m5B.diff

cd $RESEARCH_PATH/profess/espresso-5.2.1
patch -p1 < $RESEARCH_PATH/profess/OFQE2.0.1/patches/espresso-5.2.1-5.2.1m5.diff
```


### FFTW 3.3.8

```sh
./configure --prefix=$RESEARCH_PATH/profess/fftw-3.3.8 CC=icc F77=ifort MPICC=mpiicc --enable-mpi
make -j16
make install
```


### FFTW 2.1.5 (profftw)

For whatever reason, this does not like using `mpiicc` and `mpiifort`. Modify
makefile line 146 and remove 'doc'. This version of FFTW uses Texinfo 4
which is obsolete.

```sh
./configure --prefix=$RESEARCH_PATH/profess/fftw-2.1.5 CC=mpicc F77=mpif77 --enable-mpi
make clean
make
make install
```


### Libxc 2.0.1


Unfortunately, PROFESS relies on an old version of Libxc (< 2.1.0, circa
2013-2014), which I have not been able to compile correctly with any recent
compiler. I have tried compiling it on the cluster (lancaster and gemini) and
also on my desktop computer, using both gcc and Intel compilers. The regression
tests fail; I have manually compared the test results and they are indeed
different values. I assume it has to do with the modern C libraries prsent on
the OS. I have also tried on a CentOS 6 machine with old versions of GCC and the
Intel Compilers, and the tests continue to fail.

You may get an error about "Unclassifiable statement" from `src/libxc.f90`. Just
comment out all the text at the beginning with `!!`.

```sh
./configure --prefix=$RESEARCH_PATH/profess/libxc-2.0.1 CC=mpicc FC=mpif90
make clean
make
make check
make install
```


### PROFESS

See the attached modified makefiles, modify paths accordingly.

```sh
make clean
make parallel
```


### QE 5.2.1

```sh
./configure FC=ifort CC=mpiicc F77=ifort MPIF90=mpiifort
```
