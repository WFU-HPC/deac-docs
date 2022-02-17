# CP2K on the DEAC Cluster


## To-Do

* Look into
  [toolchain](https://github.com/cp2k/cp2k/tree/master/tools/toolchain) for
  insight on how to compile
* Potential libraries:
    x libxc
    * elpa (WORK IN PROGRESS)
    * libxsmm
    * libint


## Introduction

CP2K is a quantum chemistry and solid state physics software package that can
perform atomistic simulations of solid state, liquid, molecular, periodic,
material, crystal, and biological systems. CP2K provides a general framework
for different modeling methods such as DFT using the mixed Gaussian and plane
waves approaches GPW and GAPW. Supported theory levels include DFTB, LDA, GGA,
MP2, RPA, semi-empirical methods (AM1, PM3, PM6, RM1, MNDO, ...), and classical
force fields (AMBER, CHARMM, ...). CP2K can do simulations of molecular
dynamics, metadynamics, Monte Carlo, Ehrenfest dynamics, vibrational analysis,
core level spectroscopy, energy minimization, and transition state optimization
using NEB or dimer method.


## Installation

CP2K comes packaged with a "toolchain" script that builds all required
dependencies from scratch. Using this script is very time consuming, and
entirely unnecessary in a well-configured HPC environment.


### Prerequisites

* Intel compilers (`module load compilers/intel/2020`)
* Open MPI  (`module load mpi/openmpi/4.0.3-intel`)
* Libxc (`module load libs/libxc/4.3.4`)
* ELPA (WORK IN PROGRESS)


### Compiling

The correct way to compile the software is by creating or modifying a 'arch'
file with the appropriate paths and executables. We have included a few
examples of these that are optimized for compiling on the DEAC cluster. The
'arch' file needs to be placed in `$CP2k/arch` directory. The naming scheme for
these files is `ARCH.VERSION`, which are then referenced when invoking the
`make` command. For instance,

```sh
make -j 8 ARCH=Linux-x86-64-intel-dynamic+libxc VERSION=popt
```

uses the Linux-x86-64-intel-dynamic+libxc.popt file located in the `arch`
directory. Making and running the built-in regression tests can be done in a
very similar manner,

```sh
make -j 8 ARCH=Linux-x86-64-intel-dynamic+libxc VERSION=popt test
```

These tests can be be very time consuming (30+ minutes). Clean your build:

```sh
make ARCH=Linux-x86-64-intel-dynamic+libxc VERSION=popt clean # regular clean
make ARCH=Linux-x86-64-intel-dynamic+libxc VERSION=popt realclean # complete restart
```


### Memory testing


The `psrecord` Python utility comes in handy for monitoring overall memory
usage,

```
psrecord "mpirun -np 8 cp2k.popt input.inp" --include-children --log log.dat
```


## Useful guides

* https://github.com/cp2k/cp2k/blob/master/INSTALL.md
* https://www.youtube.com/watch?v=TP7DRwtTuQE
* https://groups.google.com/forum/#!topic/cp2k/AZU1IoLvRd4
