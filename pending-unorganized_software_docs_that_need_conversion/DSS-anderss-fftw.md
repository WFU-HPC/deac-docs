# FFTW (CONVERTED TO DSS)

```sh

./configure --prefix="$target" --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-shared --enable-static --enable-mpi  --disable-threads --disable-openmp --disable-float
make -j$CORES && make check && make install && make clean
./configure --prefix="$target" --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-shared --enable-static --enable-mpi  --disable-threads --disable-openmp --enable-float
make -j$CORES && make check && make install && make clean

unset CC && unset F77
./configure --prefix="$target" --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-shared --enable-static --disable-mpi --enable-threads  --enable-openmp --disable-float
make -j$CORES && make check && make install && make clean
./configure --prefix="$target" --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-shared --enable-static --disable-mpi --enable-threads  --enable-openmp --enable-float
make -j$CORES && make check && make install && make clean

unset CC && unset F77
./configure --prefix="$target" --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-shared --enable-static --disable-mpi --disable-threads --disable-openmp --disable-float
make -j$CORES && make check && make install && make clean
./configure --prefix="$target" --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 --enable-shared --enable-static --disable-mpi --enable-threads  --enable-openmp --enable-float
make -j$CORES && make check && make install && make clean

################################################################################
# Intel+IMPI start
################################################################################

## Double start
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-threads --enable-openmp \

make -j$CORES && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/intel/2021.2 && export MPICC=mpiicc
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-mpi \

make -j$CORES && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 && unset MPICC
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \


make -j$CORES && make check && make install && make clean
################################################################################
## Double end

## Single start
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-threads --enable-openmp \
            --enable-float
make -j$CORES && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/intel/2021.2 && export MPICC=mpiicc
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-mpi \
            --enable-float
make -j$CORES && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 && unset MPICC
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            \
            --enable-float
make -j$CORES && make check && make install && make clean
################################################################################
## Single end

################################################################################
# Intel+IMPI end
################################################################################
```
