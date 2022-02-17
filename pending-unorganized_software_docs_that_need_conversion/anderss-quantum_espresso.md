# QE (WIP)


## To-Do

* LibXC, other libs
* https://github.com/spack/spack/blob/develop/var/spack/repos/builtin/packages/quantum-espresso/package.py


# Compile with my Intel Compilers and Open MPI

```
source /deac/generalGrp/usershare/anderss/intel/psxe-18.04/bin/compilervars.sh -arch intel64 -platform linux
#module load rhel7/openmpi/4.0.2-intel-2018
#module unload rhel7/compilers/intel-2018-lp64
```

```
./configure CC=icc F77=ifort F90=ifort MPIF90=mpiifort --prefix=/deac/generalGrp/usershare/anderss/bin/qe-6.5 --enable-shared --enable-parallel --with-scalapack=intel

./configure CC=icc F77=ifort F90=ifort MPIF90=mpiifort --prefix=/deac/generalGrp/usershare/anderss/bin/qe-6.5 --enable-shared --enable-parallel --with-scalapack=intel --with-libxc --with-libxc-prefix=/deac/generalGrp/usershare/anderss/bin/libxc/ LD_LIBS="-L/deac/generalGrp/usershare/anderss/bin/libxc/lib/ -lxcf90 -lxcf03 -lxc"
```

```
make -j16 all
```

These tests run just fine:

```
make run-tests-pw-parallel
make run-tests-ph-parallel
make run-tests-hp-parallel
```

Running these automated tests fail, but they run just fine if you run them directory by directory, so meh. Instead of:

```make run-tests-cp-parallel```

do:

```
make run-custom-test-parallel testdir=cp_h2o
make run-custom-test-parallel testdir=cp_o2
make run-custom-test-parallel testdir=cp_si
make run-custom-test-parallel testdir=cp_sio2
```

For some reason, the epw tests fail, but I think it has to do solely with the automated test system...

```make run-tests-epw-parallel```
