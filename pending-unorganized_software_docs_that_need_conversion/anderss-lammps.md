# LAMMPS (Updated for 2023)

```sh
module purge && module load python/3.8.13 \
                            compilers/gcc/10.2.0 \
                            compilers/intel/2021.2 \
                            mpi/intel/2021.2 \
                            libs/intel/mkl/2021.2 \
                            libs/intel/tbb/2021.2 \
                            libs/fftw/3.3.10/intel/2021.2_impi \
                            utils/cmake/3.23.1 \
                            utils/git/2.36.1 \
                            utils/ffmpeg/6.0.0
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

cd $SCRATCH
wget --no-check-certificate https://download.lammps.org/tars/lammps.tar.gz
tar -xvf lammps.tar.gz
rm -rf ${SCRATCH}/lammps-15Jun2023/build; mkdir -p ${SCRATCH}/lammps-15Jun2023/build; cd ${SCRATCH}/lammps-15Jun2023/build

cmake   -C ../cmake/presets/intel.cmake \
        -C ../cmake/presets/most.cmake \
        -DFFTW3_LIBRARY:FILEPATH="/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2/lib/libfftw3.a" \
        -DFFTW3_OMP_LIBRARY:FILEPATH="/deac/opt/rhel7/fftw/3.3.10-intel_impi_2021.2/lib/libfftw3_omp.a" \
        -DHDF5_C_COMPILER_EXECUTABLE:FILEPATH="/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/bin/h5pcc" \
        -DNETCDF_LIBRARY:FILEPATH="/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static/lib/libnetcdf.a" \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=/deac/opt/rhel7/lammps/15Jun2023 \
        ../cmake

make -j4 && make install
```
