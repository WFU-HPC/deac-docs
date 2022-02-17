# Libxc

## Introduction

Libxc is a library of exchange-correlation functionals for density-functional
theory. The aim is to provide a portable, well tested and reliable set of
exchange and correlation functionals that can be used by all the ETSF codes and
also other codes.


## Installation

Libxc can be downloaded directly from the
[website](https://www.tddft.org/programs/libxc/). Compiling the library with the
Intel compilers is very straightforward.


### Prerequisites

* Intel compilers (`module load compilers/intel/2020`)


### Compilation

You can configure the build process and compile using 4 cores,

```
./configure --prefix=/deac/opt/rhel7/libxc/4.3.4-intel-2020 CC=icc FC=ifort
make -j4
```

and then test your build using the built-in regression tests by issuing

```
make check
```

or by manually running the test suite (with more visual results),

```
cd testsuite/
./xc-run_testsuite
```

These tests should take only a few minutes to complete. If the tests
are successful, install the library:

```
make install
```

# REVISED FOR 2021

```sh
module load compilers/gcc/10.2.0 compilers/intel/2021.2
./configure --prefix=/deac/opt/rhel7/libxc/5.1.7-intel_2021.2 --enable-shared --enable-static CFLAGS='-g -O2 -march=broadwell -mtune=broadwell' FCFLAGS='-u -fpp1 -nbs -pc80 -pad -align -unroll -O3 -ip -no-fp-port -mno-ieee-fp -vec-report0 -no-prec-div -march=broadwell -mtune=broadwell'
make -j4
make -j4 check
make install
make clean
```
