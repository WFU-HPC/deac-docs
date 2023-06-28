# Libxc

## Introduction

Libxc is a library of exchange-correlation functionals for density-functional
theory. The aim is to provide a portable, well tested and reliable set of
exchange and correlation functionals that can be used by all the ETSF codes and
also other codes. Libxc can be downloaded directly from the
[website](https://www.tddft.org/programs/libxc/).

## Installation (REVISED FOR 2023)

### GCC Toolchain

```sh
module purge
module load compilers/gcc/10.2.0

cd $SCRATCH
wget https://www.tddft.org/programs/libxc/down/6.2.2/libxc-6.2.2.tar.gz --no-check-certificate
tar -xvf libxc-6.2.2.tar.gz
cd libxc-6.2.2

./configure --prefix=/deac/opt/rhel7/libxc/6.2.2-gcc_10.2.0_static \
            --enable-shared \
            --enable-static \
            --enable-kxc \
            CFLAGS='-g -O2 -march=cascadelake -mtune=cascadelake' \
            FCFLAGS='-pipe -O3 -funroll-loops -ffast-math -ffree-line-length-none -march=cascadelake -mtune=cascadelake'
make -j4 # makes the software
make -j4 check # runs check, but is all-or-nothing and usually fails with intel
cd testsuite/ && ./xc-run_testsuite && cd .. # better output, but slower
make install && make clean
```

### Intel Toolchain

```sh
module purge
module load compilers/gcc/10.2.0 \
            compilers/intel/2021.2

cd $SCRATCH
wget https://www.tddft.org/programs/libxc/down/6.2.2/libxc-6.2.2.tar.gz --no-check-certificate
tar -xvf libxc-6.2.2.tar.gz
cd libxc-6.2.2

./configure --prefix=/deac/opt/rhel7/libxc/6.2.2-intel_2021.2_static \
            --enable-shared \
            --enable-static \
            --enable-kxc \
            CFLAGS='-g -O2 -march=cascadelake -mtune=cascadelake' \
            FCFLAGS='-u -fpp1 -nbs -pc80 -pad -align -unroll -O3 -ip -no-fp-port -mno-ieee-fp -vec-report0 -no-prec-div -march=cascadelake -mtune=cascadelake'
make -j4 # makes the software
make -j4 check # runs check, but is all-or-nothing and usually fails with intel
cd testsuite/ && ./xc-run_testsuite && cd .. # better output, but slower
make install && make clean
```
