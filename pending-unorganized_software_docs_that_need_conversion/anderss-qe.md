cd $QE_SRC
mkdir -p build && cd build

module load compilers/gcc/10.2.0 \
            compilers/intel/2021.2 \
            mpi/openmpi/4.1.1/intel/2021.2 \
            libs/oneapi/mkl/2021.2 \
            libs/libxc/5.1.7/intel/2021.2 \
            utils/cmake/3.23.1 \
            utils/git/2.36.1

cmake -DCMAKE_Fortran_COMPILER=mpifort \
      -DCMAKE_C_COMPILER=mpicc \
      -DCMAKE_INSTALL_PREFIX="$QE7_PREFIX" \
      -DQE_ENABLE_SCALAPACK=on \
      -DQE_ENABLE_LIBXC=on \
      -DCMAKE_C_FLAGS_RELEASE="-O2 -DNDEBUG -march=cascadelake -mtune=cascadelake" \
      -DCMAKE_Fortran_FLAGS_RELEASE="-O2 -DNDEBUG -march=cascadelake -mtune=cascadelake" \
      -DQE_CPP=icpc ..

make -j8

ctest -j8 -L "system--pw" --output-on-failure

make install
