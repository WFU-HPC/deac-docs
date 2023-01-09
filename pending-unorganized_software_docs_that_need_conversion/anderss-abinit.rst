.. #############################################################################
.. #############################################################################

-------------------------
ABINIT (Updated for 2023)
-------------------------

Website: https://www.abinit.org
Keywords: Electronic Structure, Ab Initio, Density Functional Theory

Introduction
============

ABINIT is a package whose main program allows one to find the total energy,
charge density and electronic structure of systems made of electrons and nuclei
(molecules and periodic solids) within Density Functional Theory (DFT), using
pseudopotentials and a planewave basis.

Method 
======

.. code-block:: bash

    ## Preamble
    module purge
    module load python/3.8.13 \
                compilers/gcc/10.2.0 \
                compilers/intel/2021.2 \
                mpi/intel/2021.2 \
                libs/intel/mkl/2021.2 
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

    ## HDF5 Static
    cd $SCRATCH
    wget https://hdf-wordpress-1.s3.amazonaws.com/wp-content/uploads/manual/HDF5/HDF5_1_12_2/source/hdf5-1.12.2.tar.bz2
    tar -xvf hdf5-1.12.2.tar.bz2
    cd hdf5-1.12.2
    ./configure --prefix="/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static" \
                --enable-unsupported \
                --enable-symbols=yes \
                --disable-threadsafe \
                --disable-cxx \
                --enable-hl \
                --disable-java \
                --without-szlib \
                --disable-shared \
                --enable-build-mode=production \
                --enable-parallel
    make
    make check
    make install && make clean

    ## NetCDF-C Static
    cd $SCRATCH
    wget https://downloads.unidata.ucar.edu/netcdf-c/4.9.0/netcdf-c-4.9.0.tar.gz
    tar -xvf netcdf-c-4.9.0.tar.gz
    cd netcdf-c-4.9.0
    export LD_LIBRARY_PATH="/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/lib:${LD_LIBRARY_PATH}"
    ./configure --prefix="/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static" --enable-v2 --enable-utilities --enable-static --enable-largefile --enable-netcdf-4 --enable-fsync --enable-dynamic-loading --disable-shared --enable-parallel4 --disable-dap --disable-jna --disable-pnetcdf --disable-hdf4 CPPFLAGS="-I/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/include" LDFLAGS="-L/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/lib"
    make
    make check
    make install && make clean

    ## NetCDF-FORTRAN Static
    cd $SCRATCH
    wget https://downloads.unidata.ucar.edu/netcdf-fortran/4.5.4/netcdf-fortran-4.5.4.tar.gz
    tar -xvf netcdf-fortran-4.5.4.tar.gz
    cd netcdf-fortran-4.5.4
    export LD_LIBRARY_PATH="/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static/lib:${LD_LIBRARY_PATH}"
    ./configure --prefix=/deac/opt/rhel7/netcdf-fortran/4.5.4-intel_impi_2021.2_static --disable-shared --enable-static --disable-doxygen CPPFLAGS="-I/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static/include -I/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/include" LDFLAGS="-L/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static -L/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/lib " LIBS="-L/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static/lib -lnetcdf -L/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/lib -lhdf5_hl -lhdf5 -lm -lz -lsz -lbz2 -lxml2 -lcurl"
    make
    make check
    make install && make clean

    ## LibXC Static
    cd $SCRATCH

    # wget https://www.tddft.org/programs/libxc/down/5.2.3/libxc-5.2.3.tar.gz --no-check-certificate
    # tar -xvf libxc-5.2.3.tar.gz
    # cd libxc-5.2.3
    # ./configure --prefix=/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static --disable-shared --enable-static CFLAGS='-g -O2 -march=cascadelake -mtune=cascadelake' FCFLAGS='-pipe -O3 -funroll-loops -ffast-math -ffree-line-length-none -march=cascadelake -mtune=cascadelake'

    wget https://www.tddft.org/programs/libxc/down/6.0.0/libxc-6.0.0.tar.gz --no-check-certificate
    tar -xvf libxc-6.0.0.tar.gz
    cd libxc-6.0.0
    ./configure --prefix=/deac/opt/rhel7/libxc/6.0.0-intel_impi_2021.2_static --disable-shared --enable-static CFLAGS='-g -O2 -march=cascadelake -mtune=cascadelake' FCFLAGS='-pipe -O3 -funroll-loops -ffast-math -ffree-line-length-none -march=cascadelake -mtune=cascadelake' --enable-kxc

    make -j4
    time make -j8 check
    cd testsuite/ && time ./xc-run_testsuite; cd .. # better output, but slower
    make install && make clean

    ## ABINIT w/static MKL, HDF5, NetCDF, and LibXC
    cd $SCRATCH

    # wget https://www.abinit.org/sites/default/files/packages/abinit-9.6.2.tar.gz
    # tar -xvf abinit-9.6.2.tar.gz
    # cd abinit-9.6.2
    # mkdir -p build && cd build
    # cp /deac/inf/adminGrp/anderss/repos/deac-config/abinit/abinit-9.6.2_impi_omp_static.ac9 ${HOSTNAME}.ac9
    # export LD_LIBRARY_PATH="/deac/opt/rhel7/libxc/5.2.3-intel_impi_2021.2_static/lib:/deac/opt/rhel7/netcdf-fortran/4.5.4-intel_impi_2021.2_static/lib:/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static/lib:/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/lib:${LD_LIBRARY_PATH}"
    
    wget https://www.abinit.org/sites/default/files/packages/abinit-9.8.1.tar.gz
    tar -xvf abinit-9.8.1.tar.gz
    cd abinit-9.8.1
    mkdir -p build && cd build
    cp /deac/inf/adminGrp/anderss/repos/deac-config/abinit/abinit-9.8.1_impi_omp_static.ac9 $(hostname -s).ac9
    export LD_LIBRARY_PATH="/deac/opt/rhel7/libxc/6.0.0-intel_impi_2021.2_static/lib:/deac/opt/rhel7/netcdf-fortran/4.5.4-intel_impi_2021.2_static/lib:/deac/opt/rhel7/netcdf-c/4.9.0-intel_impi_2021.2_static/lib:/deac/opt/rhel7/hdf5/1.12.2-intel_impi_2021.2_static/lib:${LD_LIBRARY_PATH}"
    
    ../configure
    make -j8

    # full round of tests including internal and python test suite. there are a
    # few failures, but nothing to be concerned about. NOTE: I have excluded the
    # tests for wannier90, bigdft, etc.
    export OMP_NUM_THREADS=1

    make check
    make test_fast
    make test_v1
    make test_v5
    make test_libxc

    ../tests/runtests.py etsf_io
    ../tests/runtests.py fast
    ../tests/runtests.py libxc
    ../tests/runtests.py tutomultibinit
    ../tests/runtests.py -j4 tutorial
    ../tests/runtests.py -j4 tutorespfn # 1 fail, but should be ok
    ../tests/runtests.py -j4 v1
    ../tests/runtests.py -j4 v2
    ../tests/runtests.py -j4 v3
    ../tests/runtests.py -j4 v4 # 1 fail, don't worry
    ../tests/runtests.py -j4 v5
    ../tests/runtests.py -j4 v6
    ../tests/runtests.py -j4 v67mbpt
    ../tests/runtests.py -j4 v7 # 2 fail, no problem
    ../tests/runtests.py -j4 v8
    ../tests/runtests.py -j4 v9
    ../tests/runtests.py -n4 tutoparal
    ../tests/runtests.py -n1  unitary
    ../tests/runtests.py -n2  unitary
    ../tests/runtests.py -n4  unitary
    ../tests/runtests.py -n10 unitary
    ../tests/runtests.py -n1  mpiio
    ../tests/runtests.py -n2  mpiio
    ../tests/runtests.py -n4  mpiio
    ../tests/runtests.py -n10 mpiio
    ../tests/runtests.py -n1  paral
    ../tests/runtests.py -n2  paral
    ../tests/runtests.py -n4  paral
    ../tests/runtests.py -n10 paral

    make install && make clean


Old Method (pre-2023)
=====================

This is the older way using Open MPI.

.. code-block:: bash
    
    module load python/3.8.13 \
                compilers/gcc/10.2.0 \
                compilers/intel/2021.2 \
                mpi/openmpi/4.1.1/intel/2021.2 \
                libs/hdf5/1.12.2/intel/2021.2 \
                libs/libxc/5.2.3/intel/2021.2 \
                libs/netcdf-c/4.9.0/intel/2021.2 \
                libs/netcdf-fortran/4.5.4/intel/2021.2 \
                libs/intel/mkl/2021.2
    
    CC="icc" CXX="icpc" FC="ifort" LINALG_LIBS="$MKL_SCALAPACK_MULTITHREAD" \
    ../configure \
        --prefix=/home/anderss/abinit_temp \
        --with-mpi="$MPIHOME" \
        --with-hdf5=$HDF5_PATH \
        --with-netcdf=$NETCDF_C_PATH \
        --with-netcdf-fortran=$NETCDF_FORTRAN_PATH \
        --enable-mpi-io="yes" \
        --with-fft-flavor="dfti" \
        --with-libxml2="/usr" \
        --with-mpi-flavor="auto" \
        --with-optim-flavor=standard \
        --with-libxc=$LIBXCHOME \
        --enable-openmp

.. #############################################################################
.. #############################################################################
