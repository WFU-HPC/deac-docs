# NetCDF Stack (CONVERTED TO DSS)

## GCC

```sh
module purge && module load compilers/gcc/10.2.0 mpi/openmpi/4.1.1/gcc/10.2.0

# HDF5
cd $TMPDIR
wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_2/source/hdf5-1.12.2.tar.bz2
tar -xvf hdf5-1.12.2.tar.bz2
cd hdf5-1.12.2
./configure --prefix=/deac/opt/rhel7/hdf5/1.12.2-gcc_10.2.0 --enable-unsupported --enable-symbols=yes --disable-threadsafe --disable-cxx --enable-hl --disable-java --without-szlib --enable-build-mode=production --enable-shared --enable-parallel
make
make check
make install

# NetCDF-C
cd $TMPDIR
wget https://downloads.unidata.ucar.edu/netcdf-c/4.9.0/netcdf-c-4.9.0.tar.gz
tar -xvf netcdf-c-4.9.0.tar.gz
cd netcdf-c-4.9.0
export LD_LIBRARY_PATH="/deac/opt/rhel7/hdf5/1.12.2-gcc_10.2.0/lib:${LD_LIBRARY_PATH}"
CPPFLAGS=-I/deac/opt/rhel7/hdf5/1.12.2-gcc_10.2.0/include LDFLAGS=-L/deac/opt/rhel7/hdf5/1.12.2-gcc_10.2.0/lib ./configure --prefix=/deac/opt/rhel7/netcdf-c/4.9.0-gcc_10.2.0 --enable-v2 --enable-utilities --enable-static --enable-largefile --enable-netcdf-4 --enable-fsync --enable-dynamic-loading --enable-shared --enable-parallel4 --disable-dap --disable-jna --disable-pnetcdf --disable-hdf4
make
make check
make install

# NetCDF-FORTRAN
cd $TMPDIR
wget https://downloads.unidata.ucar.edu/netcdf-fortran/4.5.4/netcdf-fortran-4.5.4.tar.gz
tar -xvf netcdf-fortran-4.5.4.tar.gz
cd netcdf-fortran-4.5.4
export LD_LIBRARY_PATH="/deac/opt/rhel7/netcdf-c/4.9.0-gcc_10.2.0/lib:${LD_LIBRARY_PATH}"
CPPFLAGS="-I/deac/opt/rhel7/hdf5/1.12.2-gcc_10.2.0/include -I/deac/opt/rhel7/netcdf-c/4.9.0-gcc_10.2.0/include" LDFLAGS="-L/deac/opt/rhel7/hdf5/1.12.2-gcc_10.2.0/lib -L/deac/opt/rhel7/netcdf-c/4.9.0-gcc_10.2.0/lib" ./configure --prefix=/deac/opt/rhel7/netcdf-fortran/4.5.4-gcc_10.2.0 --enable-shared --enable-static --disable-doxygen
make
make check
make install
```


## Intel

```sh
module purge && module load compilers/gcc/10.2.0 compilers/intel/2021.2

# HDF5
cd $TMPDIR
wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_2/source/hdf5-1.12.2.tar.bz2
tar -xvf hdf5-1.12.2.tar.bz2
cd hdf5-1.12.2
./configure --prefix=/deac/opt/rhel7/hdf5/1.12.2-intel_2021.2 --enable-unsupported --enable-symbols=yes --disable-threadsafe --disable-cxx --enable-hl --disable-java --without-szlib --enable-build-mode=production --enable-shared --enable-parallel
make
make check
make install

# NetCDF-C
cd $TMPDIR
wget https://downloads.unidata.ucar.edu/netcdf-c/4.9.0/netcdf-c-4.9.0.tar.gz
tar -xvf netcdf-c-4.9.0.tar.gz
cd netcdf-c-4.9.0
export LD_LIBRARY_PATH="/deac/opt/rhel7/hdf5/1.12.2-intel_2021.2/lib:${LD_LIBRARY_PATH}"
CPPFLAGS=-I/deac/opt/rhel7/hdf5/1.12.2-intel_2021.2/include LDFLAGS=-L/deac/opt/rhel7/hdf5/1.12.2-intel_2021.2/lib ./configure --prefix=/deac/opt/rhel7/netcdf-c/4.9.0-intel_2021.2 --enable-v2 --enable-utilities --enable-static --enable-largefile --enable-netcdf-4 --enable-fsync --enable-dynamic-loading --enable-shared --enable-parallel4 --disable-dap --disable-jna --disable-pnetcdf --disable-hdf4
make
make check
make install

# NetCDF-FORTRAN
cd $TMPDIR
wget https://downloads.unidata.ucar.edu/netcdf-fortran/4.5.4/netcdf-fortran-4.5.4.tar.gz
tar -xvf netcdf-fortran-4.5.4.tar.gz
cd netcdf-fortran-4.5.4
export LD_LIBRARY_PATH="/deac/opt/rhel7/netcdf-c/4.9.0-intel_2021.2/lib:${LD_LIBRARY_PATH}"
CPPFLAGS="-I/deac/opt/rhel7/hdf5/1.12.2-intel_2021.2/include -I/deac/opt/rhel7/netcdf-c/4.9.0-intel_2021.2/include" LDFLAGS="-L/deac/opt/rhel7/hdf5/1.12.2-intel_2021.2/lib -L/deac/opt/rhel7/netcdf-c/4.9.0-intel_2021.2/lib" ./configure --prefix=/deac/opt/rhel7/netcdf-fortran/4.5.4-intel_2021.2 --enable-shared --enable-static --disable-doxygen
make
make check
make install
```
