# FFTW

```sh
cd $SCRATCH
wget https://www.fftw.org/fftw-3.3.10.tar.gz --no-check-certificate
tar -xvf fftw-3.3.10.tar.gz

cd $SCRATCH/fftw-3.3.10

################################################################################
# GCC+IMPI start
################################################################################

## Double start
################################################################################
module purge && module load compilers/gcc/10.2.0
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-threads --enable-openmp \

make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 mpi/intel/2021.2 && export MPICC=mpicc
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-mpi \

make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 && unset MPICC
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \


make -j4 && make check && make install && make clean
################################################################################
## Double end

## Single start
################################################################################
module purge && module load compilers/gcc/10.2.0
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-threads --enable-openmp \
            --enable-float
make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 mpi/intel/2021.2 && export MPICC=mpicc
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-mpi \
            --enable-float
make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 && unset MPICC
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-gcc_impi_10.2.0 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            \
            --enable-float
make -j4 && make check && make install && make clean
################################################################################
## Single end

################################################################################
# GCC+IMPI end
################################################################################



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

make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/intel/2021.2 && export MPICC=mpiicc
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-mpi \

make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 && unset MPICC
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \


make -j4 && make check && make install && make clean
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
make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 mpi/intel/2021.2 && export MPICC=mpiicc
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            --enable-mpi \
            --enable-float
make -j4 && make check && make install && make clean
################################################################################
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2 && unset MPICC
./configure --prefix=/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2 \
            --enable-sse2 --enable-avx --enable-avx2 --enable-avx512 \
            --enable-shared --enable-static \
            \
            --enable-float
make -j4 && make check && make install && make clean
################################################################################
## Single end

################################################################################
# Intel+IMPI end
################################################################################
```
