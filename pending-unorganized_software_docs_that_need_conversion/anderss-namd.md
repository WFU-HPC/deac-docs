# NAMD on the DEAC Cluster


## Introduction

NAMD, recipient of a 2002 Gordon Bell Award and a 2012 Sidney Fernbach Award, is
a parallel molecular dynamics code designed for high-performance simulation of
large biomolecular systems. Based on Charm++ parallel objects, NAMD scales to
hundreds of cores for typical simulations and beyond 500,000 cores for the
largest simulations. NAMD uses the popular molecular graphics program VMD for
simulation setup and trajectory analysis, but is also file-compatible with
AMBER, CHARMM, and X-PLOR. NAMD is distributed free of charge with source code.

DEAC users can load NAMD package using the available module,

```sh
module load rhel7/namd/2.13-multicore-intel
```

which is the 64-bit, single node, multicore variant. It was compiled using the
Intel compilers and Math Kernel Library (MKL), yielding binaries with
performance enhancements that take advantage of the DEAC hardware. What follows
are instructions on how to compile the source code using the Intel Parallel
Studio XE 2018, for users who wish to compile their own versions.


## Compiling with the Intel Parallel Studio XE 2018

General usage and installation instructions can be found in the `notes.txt`
document included in the source code. Load the Intel compiler module in order to
access the Intel compilers and libraries.

```sh
module load rhel7/compilers/intel-2018-lp64
```


### Charm++

Download and uncompress the NAMD source tarball, and then uncompress the
included Charm++ tarball (as indicated in the aforementioned `notes.txt`). Issue
the following build command for Charm++,

```sh
./build charm++ multicore-linux-x86_64 iccstatic --with-production
```

where the `iccstatic` option indicates that we are using the Intel compiler for
creating a static library, and the `--with-production` flag will enable
aggressive optimization. For DEAC nodes, this will include AVX-specific
optimizations that can significantly extend compile time, but generally
yield good performance. After successfully compiling, test your new Charm++
library,

```sh
cd multicore-linux-x86_64-iccstatic/tests/charm++/megatest
make pgm
./pgm +p4
```


### Tcl

NAMD requires Tcl, but the developers provide all the necessary files for download,

```sh
wget http://www.ks.uiuc.edu/Research/namd/libraries/tcl8.5.9-linux-x86_64-threaded.tar.gz
tar xzf tcl8.5.9-linux-x86_64-threaded.tar.gz
mv tcl8.5.9-linux-x86_64-threaded tcl-threaded
```

Since we are compiling the multicore variant, we want to use threaded Tcl.


### Arch files, configure, and build

Copy a couple of arch files to facilitate the building process for the Intel toolset,

```sh
cp arch/Linux-x86_64.mkl arch/Linux-x86_64-icc.fftw
cp arch/Linux-x86_64.tcl arch/Linux-x86_64-icc.tcl
```

and check the `arch/Linux-x86_64-icc.arch`, `arch/Linux-x86_64-icc.tcl`, and
`arch/Linux-x86_64-icc.fftw` to ensure that all the paths are correct. In this
case, the `CHARMARCH` variable should be set to
`multicore-linux-x86_64-iccstatic`, as mentioned above. You will most likely
need to update `arch/Linux-x86_64-icc.tcl` with the path to the tcl-threaded
directory from the previous step. These files are included here for

Issue the following commands to configure NAMD with our selected
`Linux-x86_64-icc` architecture, and then build using four cores,

```sh
./config Linux-x86_64-icc
cd Linux-x86_64-icc/
gmake -j4
```

and lastly, test your new build by running a simple test case,

```sh
./namd2 src/alanin
./charmrun +p2 ./namd2 src/alanin
```

If these tests complete with no errors, you have now successfully compiled NAMD!
The binaries are located in `Linux-x86_64-icc` directory.
