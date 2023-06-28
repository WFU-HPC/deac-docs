# QE (Updated for 2023)

Switching over to OMPI (4.1.1) + MKL SCALPACK works fine and does not hang at the aforementioned diagonalization. Normally, I would be OK using this build, but I cannot get OpenMP threading to work when using this combination. Multi-threading is disabled even though the compiler flag and MKL libs seem to be correct.


```sh
## Preamble
cd $SCRATCH
wget --no-check-certificate https://www.quantum-espresso.org/rdm-download/488/v7-2/a4f9009cdc1f006951914e4566c7623a/qe-7.2-ReleasePack.tar.gz
tar -xvf qe-7.2-ReleasePack.tar.gz

module purge
module load compilers/gcc/10.2.0 \
            compilers/intel/2021.2 \
            mpi/openmpi/4.1.1/intel/2021.2 \
            libs/intel/mkl/2021.2 \
            libs/libxc/5.2.3/intel/2021.2 \
            utils/cmake/3.23.1 \
            utils/git/2.36.1

# module load compilers/gcc/10.2.0 \
#             compilers/intel/2021.2 \
#             mpi/intel/2021.2 \
#             libs/intel/mkl/2021.2 \
#             libs/libxc/5.2.3/intel/2021.2 \
#             utils/cmake/3.23.1 \
#             utils/git/2.36.1
# export CC=icc
# export CXX=icpc
# export FC=ifort
# export F95=ifort
# export F90=ifort
# export F77=ifort
# export MPICC=mpiicc
# export MPICXX=mpiicpc
# export MPIF90=mpiifort
# export MPIF77=mpiifort
unset CPP
# export CPP='icc -E'

## Using cmake # ONLY METHOD THAT I CAN GET TO WORK 100% BUT CANNOT DO STATIC MKL
cd ${SCRATCH}/qe-7.2 && mkdir -p build && cd build

cmake -DCMAKE_INSTALL_PREFIX="/deac/opt/rhel7/qe/7.2" \
      -DCMAKE_C_COMPILER=mpiicc \
      -DCMAKE_Fortran_COMPILER=mpiifort \
      -DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -march=cascadelake -mtune=cascadelake" \
      -DCMAKE_Fortran_FLAGS_RELEASE="-O2 -DNDEBUG -march=cascadelake -mtune=cascadelake" \
      -DCMAKE_BUILD_TYPE=RelWithDebInfo \
      -DQE_ENABLE_MPI=on \
      -DQE_ENABLE_SCALAPACK=on \
      -DENABLE_SCALAPACK_MPI=on \
      -DQE_ENABLE_LIBXC=on \
      ..

      # -DQE_ENABLE_STATIC_BUILD=on \
      # -DQE_ENABLE_OPENMP=on \
      # -DBLA_STATIC=on \
      # -DLIBXC_INCLUDE_DIR="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
      # -DLIBXC_INCLUDE_DIR_F03="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
      # -DLIBXC_INCLUDE_DIR_F90="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \
      # -DLIBXC_LIBRARIES="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib/libxc.a" \
      # -DLIBXC_LIBRARIES_F03="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib/libxcf03.a" \
      # -DLIBXC_LIBRARIES_F90="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib/libxcf90.a" \
      # -DBLA_STATIC=on # doesnt work with scalapack (-l in wrong place)
      # -DQE_ENABLE_STATIC_BUILD=on # doesnt work with impi (infinite mpi loop)

make -j8 all

# Only pw and cp results from ctest are reliable, we are working on making the
# rest tests work reliably with ctest. To run non-pw/cp tests, make a softlink
# of the bin directory to the root of QE source tree and run tests in the
# test-suite directory under that root.

ctest -j8 -L "system--pw" --output-on-failure     # pass: all
ctest -j8 -L "system--cp" --output-on-failure     # pass: all
# ctest -j8 -L "system--hp" --output-on-failure     # fail: all
# ctest -j8 -L "system--ph" --output-on-failure     # fail: all
# ctest -j8 -L "system--epw" --output-on-failure    # fail: all
# ctest -j8 -L "system--tddfpt" --output-on-failure # fail: all

cd ${SCRATCH}/qe-7.2
rm -rf ${SCRATCH}/qe-7.2/bin && ln -sf ${SCRATCH}/qe-7.2/build/bin/ ${SCRATCH}/qe-7.2/bin
cd ${SCRATCH}/qe-7.2/test-suite
make run-tests-pw           NPROCS=8 # pass: all
make run-tests-cp           NPROCS=8 # fail: 2
make run-tests-ph           NPROCS=8 # fail: 1
make run-tests-epw          NPROCS=8 # fail: 2
make run-tests-hp           NPROCS=8 # fail: 1
make run-tests-tddfpt       NPROCS=8 # 
make run-tests-kcw          NPROCS=8 # 
make run-tests-all_currents NPROCS=8 # 
make run-tests-pp           NPROCS=8 # 
make run-tests-zg           NPROCS=8 # 
make run-tests-xsd-pw       NPROCS=8 # 
# make -j8 run-tests

make install













## Using configure-make # DOES NOT CONFIGURE MKL CORRECTLY
cd ${SCRATCH}/qe-7.2
./configure --prefix="/home/anderss/software" \
            --enable-parallel \
            --with-scalapack=intel \
            --enable-openmp

make -j8 

            --enable-static \
            --with-libxc=yes \
            --with-libxc-prefix="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static" \
            --with-libxc-include="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/include" \

LIBS="${MKLROOT}/lib/intel64/libmkl_scalapack_lp64.a -Wl,--start-group ${MKLROOT}/lib/intel64/libmkl_cdft_core.a ${MKLROOT}/lib/intel64/libmkl_intel_lp64.a ${MKLROOT}/lib/intel64/libmkl_intel_thread.a ${MKLROOT}/lib/intel64/libmkl_core.a ${MKLROOT}/lib/intel64/libmkl_blacs_intelmpi_lp64.a -Wl,--end-group -liomp5 -lpthread -lm -ldl"

## Using make.inc # COMPILES BUT BINARY DIES AT DIAGONALIZATION
cd ${SCRATCH}/qe-7.2
./configure --with-scalapack=intel --enable-debug
cp ${RESEARCHPATH}/repos/deac-config/quantum-espresso/make.inc . ; make -j8 pw # need to invoke make in some form
make -j8 all couple kcw gwl # epw
```



## To Run interactively yo

```sh
srun -p small -n 1 --mem=32G --time=01:00:00 --pty /bin/bash
cd /scratch/${SLURM_JOB_ID}
cp $RESEARCHPATH/scratch/natalie/qe/PSI.in .
module purge && module load /deac/inf/adminGrp/anderss/scratch/natalie/modules/anderss
gdb --args pw.x -in PSI.in
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
