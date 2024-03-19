# Open MPI (CONVERTED TO DSS)


## Introduction

The Open MPI Project is an open source Message Passing Interface implementation
that is developed and maintained by a consortium of academic, research, and
industry partners. Open MPI is therefore able to combine the expertise,
technologies, and resources from all across the High Performance Computing
community in order to build the best MPI library available. Open MPI offers
advantages for system and software vendors, application developers and computer
science researchers.


## Installation

The build process for Open MPI is can be quite time consuming, but the configure
script does a good job of auto-detecting most options. The following process is
for using the Intel 2020 compilers.


### Prerequisites

* Intel compilers (`module load compilers/gcc/10.2.0 compilers/intel/2021.2`)


### Compilation

Configure the software to automatically link with SLURM, enable the low-latency
usNIC connectivity, the FORTRAN and CXX interfaces, and have maximum
compatability with Spack you can configure as follows,

```sh
./configure --prefix=/deac/opt/rhel7/openmpi/4.1.1-intel_2021.2 \
            --with-ofi=/deac/opt/rhel7/openmpi/static-libs/libfabric \
            --with-libnl=/deac/opt/rhel7/openmpi/static-libs/libnl \
            --without-psm \
            --without-psm2 \
            --without-verbs \
            --without-cuda \
            --disable-dlopen \
            --enable-static \
            --disable-builtin-atomics \
            --enable-mpi1-compatibility
```

You can tune which
compiler is being use with the standard environment variables like `CC=icc
CXX=icpc FC=ifort` but be aware that those are typically set correctly by the
compiler modulefile. Lastly, you can set the correct link paths within the
`rpaths` explicitly with
`--with-wrapper-ldflags="-Wl,-rpath,/deac/opt/rhel7/gcc/10.1.0/lib64
-Wl,-rpath,/deac/opt/rhel7/gcc/10.1.0/lib"`, but I really doubt that is
necessary. Start the make process using 4 processors,

```
make -j4 all
```

noting that this can be very time consuming (30+ min.). After a successful
build, run the built-in tests,

```
make check
```

If the tests pass, install your new software,

```
make install
```

Even the final installation command can take longer than 5 minutes so do not
despair.

## OpenFabrics Libfabric Library



# --mca pml_base_verbose 100
