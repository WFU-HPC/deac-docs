# QE (Updated for 2023)

```sh
## Preamble
cd $SCRATCH
wget https://www.quantum-espresso.org/rdm-download/488/v7-1/b86f85dc3c269ef5cea9a524b83226d8/qe-7.1-ReleasePack.tar.gz --no-check-certificate
tar -xvf qe-7.1-ReleasePack.tar.gz

module purge
module load compilers/gcc/10.2.0 \
            compilers/intel/2021.2 \
            mpi/intel/2021.2 \
            libs/intel/mkl/2021.2 \
            utils/cmake/3.23.1 \
            utils/git/2.36.1
export CC=mpiicc
export CXX=mpiicpc
export FC=mpiifort
export F95=mpiifort
export F90=mpiifort
export F77=mpiifort
export MPICC=mpiicc
export MPICXX=mpiicpc
export MPIF90=mpiifort
export MPIF77=mpiifort
export CPP='icc -E'


## Using cmake # ONLY METHOD THAT I CAN GET TO WORK 100% BUT CANNOT DO STATIC MKL
cd ${SCRATCH}/qe-7.1 && mkdir -p build && cd build

cmake -DCMAKE_Fortran_COMPILER=$FC \
      -DCMAKE_C_COMPILER=$CC \
      -DQE_CPP=cpp \
      -DCMAKE_INSTALL_PREFIX="/deac/opt/rhel7/qe/7.1-intel_impi_2021.2_static" \
      -DQE_ENABLE_LIBXC=on \
      -DLIBXC_INCLUDE_DIR="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
      -DLIBXC_INCLUDE_DIR_F03="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
      -DLIBXC_INCLUDE_DIR_F90="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
      -DLIBXC_LIBRARIES="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib/libxc.a" \
      -DLIBXC_LIBRARIES_F03="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib/libxcf03.a" \
      -DLIBXC_LIBRARIES_F90="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib/libxcf90.a" \
      -DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -march=cascadelake -mtune=cascadelake" \
      -DCMAKE_Fortran_FLAGS_RELEASE="-O2 -DNDEBUG -march=cascadelake -mtune=cascadelake" \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DQE_ENABLE_SCALAPACK=on \
      -DBLA_STATIC=off \
      -DQE_FFTW_VENDOR=Intel_DFTI \
      -DQE_ENABLE_OPENMP=on \
      -DQE_ENABLE_STATIC_BUILD=off \
      ..
      # -DBLA_STATIC=on # doesnt work with scalapack (-l in wrong place)
      # -DQE_ENABLE_STATIC_BUILD=on # doesnt work with impi (infinite mpi loop)

make -j8 all


## Testing

ctest -j8 -L "system--pw" --output-on-failure

make install


## Using make.inc # COMPILES BUT BINARY DIES AT DIAGONALIZATION
cd ${SCRATCH}/qe-7.1
./configure --with-scalapack=intel --enable-debug
cp ${RESEARCHPATH}/repos/deac-config/quantum-espresso/make.inc . ; make -j8 pw # need to invoke make in some form
make -j8 all couple kcw gwl # epw


## Using configure-make # DOES NOT CONFIGURE MKL CORRECTLY
./configure --prefix="/home/anderss/software" \
            --enable-parallel \
            --with-libxc=yes \
            --with-libxc-prefix="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static" \
            --with-libxc-include="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
            --enable-static \
            --enable-openmp

LIBS="${MKLROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_cdft_core.a ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -liomp5 -lpthread -lm -ldl"
```


## OLD OLD OLD

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
