=================
Software Packages
=================

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

------
ABINIT
------

Website: https://www.abinit.org
Keywords: Electronic Structure, Ab Initio, Density Functional Theory

Introduction
============

ABINIT is a package whose main program allows one to find the total energy,
charge density and electronic structure of systems made of electrons and nuclei
(molecules and periodic solids) within Density Functional Theory (DFT), using
pseudopotentials and a planewave basis.

Method (Updated for 2022)
=========================

.. code-block:: bash

    
    CC="icc" CXX="icpc" FC="ifort" \
    ./configure \
        --prefix=$PREFIX \
        --with-mpi="$MPIHOME" \
        --with-hdf5=$HDF5_PATH \
        --with-netcdf=$NETCDF_C_PATH \
        --with-netcdf-fortran=$NETCDF_FORTRAN_PATH \
        --enable-mpi-io="yes" \
        --with-fft-flavor="dfti" \
        --with-libxml2="/usr" \
        --with-linalg-flavor="mkl" \
        --with-linalg-incs=-I${MKLROOT}/include \
        --with-linalg-libs="$MKL_SCALAPACK_SEQUENTIAL
        --with-mpi-flavor="auto" \
        --with-optim-flavor=standard \
        --with-libxc=$LIBXCHOME

Old Method
==========

Compiling completely from scratch using Intel tools:

.. code-block:: bash

    sed -i -e 's/vec-report0/qopt-report=0/g' configure

    ./configure --enable-mpi --with-mpi-prefix=$I_MPI_ROOT \
                --with-linalg-flavor=mkl+scalapack \
                --with-linalg-incs=-I${MKLROOT}/include \
                --with-linalg-libs="$MKL_SCALAPACK_SEQUENTIAL"

However, we encourage the use of the ABINIT configuration file; for v9, this
file has a ``.ac9`` extension. With that file in place, the entire build and
testing process can be carried out like this:

.. code-block:: bash

    # load tools
    module load rhel7/gcc/10.1.0 \
                rhel7/compilers/intel-2018-lp64 \
                rhel7/openmpi/4.0.2-intel-2018 \
                rhel7/hdf5/1.10.6-intel \
                rhel7/libxc/4.3.4-intel \
                rhel7/netcdf/4.7.4-intel \
                rhel7/netcdf-fortran/4.5.3-intel \
                libs/intel/mkl/2018.5

    # configure and make, verify that all dependencies were detected correctly
    ../configure && make -j8

    # Cheaty McCheaty
    module unload libs/intel/mkl/2018.5

    # full round of tests including internal and python test suite. there are a
    # few failures, but nothing to be concerned about. NOTE: I have excluded the
    # tests for wannier90, bigdft, etc.
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

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

--------
RAXML-NG
--------

From the GitHub repo:

.. code-block:: bash

    module load rhel7/gcc/10.1.0 rhel7/openmpi/4.0.2-gcc-4.8 rhel7/cmake/3.14
    git clone --recursive https://github.com/amkozlov/raxml-ng
    cd raxml-ng && mkdir -p build-mpi && mkdir -p build-pthreads
    cd build-mpi
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/deac/opt/rhel7/raxml-ng/0.9.0 -DUSE_MPI=ON .. && make && make install
    cd ../build-pthreads
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/deac/opt/rhel7/raxml-ng/0.9.0 .. && make && make install

For specific GitHub releases:

.. code-block:: bash

    module load rhel7/gcc/10.1.0 rhel7/openmpi/4.0.2-gcc-4.8 rhel7/cmake/3.14
    wget https://github.com/amkozlov/raxml-ng/releases/download/1.0.0/raxml-ng_v1.0.0_source.zip
    mkdir -p raxml-ng && cd raxml-ng && unzip ../raxml-ng_v1.0.0_source.zip
    mkdir -p build-mpi && mkdir -p build-pthreads
    cd build-mpi
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/deac/opt/rhel7/raxml-ng/1.0.0 -DUSE_MPI=ON .. && make && make install
    cd ../build-pthreads
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/deac/opt/rhel7/raxml-ng/1.0.0 .. && make && make install

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

-------
IQ-TREE
-------

.. code-block:: bash

    module load rhel7/cmake/3.14 rhel7/gcc/10.1.0 rhel7/openmpi/4.0.2-gcc-4.8 rhel7/eigen/3.3.7

    git clone https://github.com/Cibiv/IQ-TREE.git # or specific release 
    cd IQ-TREE
    mkdir -p build && cd build
    cmake -DCMAKE_INSTALL_PREFIX:PATH=/deac/opt/rhel7/iq-tree/2.0.7 -DIQTREE_FLAGS=omp-mpi ..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

------
Siesta
------

.. code-block:: bash

    module load rhel7/gcc/6.2.0 \
                rhel7/gcc/6.2.0-libs \
                rhel7/compilers/intel-2018-lp64 \
                rhel7/openmpi/4.0.2-intel-2018

    PREFIX="/target/siesta/dir"
    SIESTA_ROOT="/siesta/source/dir"
    MKLLIBS=""${MKLROOT}/lib/intel64""

    mkdir -p ${SIESTA_ROOT}/Obj ${SIESTA_ROOT}/Obj_trans

    ## Siesta
    cd ${SIESTA_ROOT}/Obj
    ../Src/obj_setup.sh
    ../Src/configure --enable-mpi \
                     --with-blas="${MKLLIBS}/libmkl_intel_lp64.so ${MKLLIBS}/libmkl_sequential.so ${MKLLIBS}/libmkl_core.so /lib64/libpthread.so /lib64/libm.so /lib64/libdl.so" \
                     --with-lapack="${MKLLIBS}/libmkl_intel_lp64.so ${MKLLIBS}/libmkl_sequential.so ${MKLLIBS}/libmkl_core.so /lib64/libpthread.so /lib64/libm.so /lib64/libdl.so" \
                     --with-blacs="${MKLLIBS}/libmkl_scalapack_lp64.so ${MKLLIBS}/libmkl_blacs_openmpi_lp64.so ${MKLLIBS}/libmkl_intel_lp64.so ${MKLLIBS}/libmkl_sequential.so ${MKLLIBS}/libmkl_core.so /lib64/libpthread.so /lib64/libm.so /lib64/libdl.so" \
                     --with-scalapack="${MKLLIBS}/libmkl_scalapack_lp64.so ${MKLLIBS}/libmkl_blacs_openmpi_lp64.so" \
                     MPIFC="/deac/opt/rhel7/openmpi/4.0.2-intel-2018/bin/mpif90"
    make
    install siesta $PREFIX

    ## Transiesta
    cd ${SIESTA_ROOT}/Obj_trans
    ../Src/obj_setup.sh
    ../Src/configure --enable-mpi \
                     --with-blas="${MKLLIBS}/libmkl_intel_lp64.so ${MKLLIBS}/libmkl_sequential.so ${MKLLIBS}/libmkl_core.so /lib64/libpthread.so /lib64/libm.so /lib64/libdl.so" \
                     --with-lapack="${MKLLIBS}/libmkl_intel_lp64.so ${MKLLIBS}/libmkl_sequential.so ${MKLLIBS}/libmkl_core.so /lib64/libpthread.so /lib64/libm.so /lib64/libdl.so" \
                     --with-blacs="${MKLLIBS}/libmkl_scalapack_lp64.so ${MKLLIBS}/libmkl_blacs_openmpi_lp64.so ${MKLLIBS}/libmkl_intel_lp64.so ${MKLLIBS}/libmkl_sequential.so ${MKLLIBS}/libmkl_core.so /lib64/libpthread.so /lib64/libm.so /lib64/libdl.so" \
                     --with-scalapack="${MKLLIBS}/libmkl_scalapack_lp64.so ${MKLLIBS}/libmkl_blacs_openmpi_lp64.so" \
                     MPIFC="/deac/opt/rhel7/openmpi/4.0.2-intel-2018/bin/mpif90"
    make transiesta
    install transiesta $PREFIX

    ## Utils (Optional)
    cd ${SIESTA_ROOT}/Util
    ./build_all.sh
    for FILE in $(find . -type f -perm /u=x,g=x,o=x -exec ls {} \;); do cp $FILE $PREFIX; done
    cp TBTrans/MPI/int_explorer     $PREFIX
    cp TBTrans/tbtrans              $PREFIX
    cp TBTrans_rep/MPI/int_explorer ${PREFIX}/int_explorer_rep
    cp TBTrans_rep/tbtrans          ${PREFIX}/tbtrans_rep

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

------
NWChem
------

.. code-block:: bash

    module load rhel7/python/3.8.5 \
           rhel7/gcc/7.5.0 \
           rhel7/compilers/intel-2018-lp64 \
           rhel7/openmpi/4.0.2-intel-2018 \
           rhel7/elpa/2020.05.001-intel

    export NWCHEM_TOP="$RESEARCHPATH/src/nwchem-7.0.0"
    export NWCHEM_TARGET=LINUX64
    export NWCHEM_MODULES="all python"
    export USE_MPI=y
    export USE_MPIF=y
    export USE_MPIF4=y
    export USE_SCALAPACK=y
    export BLAS_SIZE=8
    export SCALAPACK_SIZE=8
    export BLASOPT="-L$MKLROOT/lib/intel64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lpthread -lm -ldl"
    export LAPACK_LIB=$BLASOPT
    export SCALAPACK="-L$MKLROOT/lib/intel64 -lmkl_scalapack_ilp64 -lmkl_intel_ilp64 -lmkl_sequential -lmkl_core -lmkl_blacs_openmpi_ilp64 -lpthread -lm -ldl"
    export ELPAROOT="/deac/opt/rhel7/spack-temp/intel-18.0.1/elpa/2020.05.001-rknichg"
    export ELPA="-I$ELPAROOT/include -L$ELPAROOT/lib -lelpa"
    export USE_OPENMP=1
    export CCSDTQ=TRUE

    ## The following two options help if only shared storage is available. Since
    ## our users can run on the local /scratch directory of each node, these are
    ## not necessary.
    # export USE_NOFSCHECK=TRUE
    # export USE_NOIO=TRUE

    ## Build, takes a VERY long time (almost 10 hours!!)
    sed -i 's/CPP=fpp -P//g' $NWCHEM_TOP/src/config/makefile.h
    cd $NWCHEM_TOP/src && make nwchem_config && make

    ## Site installation, just copying several things
    export INSTALL_DIR="/deac/opt/rhel7/NWChem/7.0.0/"
    mkdir $INSTALL_DIR
    mkdir $INSTALL_DIR/bin
    mkdir $INSTALL_DIR/data
    cp    $NWCHEM_TOP/bin/${NWCHEM_TARGET}/nwchem   $INSTALL_DIR/bin
    cp -r $NWCHEM_TOP/src/basis/libraries           $INSTALL_DIR/data
    cp -r $NWCHEM_TOP/src/data                      $INSTALL_DIR
    cp -r $NWCHEM_TOP/src/nwpw/libraryps            $INSTALL_DIR/data
    cp -r $NWCHEM_TOP/examples                      $INSTALL_DIR
    chmod 755 $INSTALL_DIR/bin/nwchem

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

------
OpenDX
------

Need to add how to set up the ``examples``, found in that same repo.

.. code-block:: bash

    git clone git@github.com:grifsf/opendx.git && cd opendx/dx-4.4.4
    ./configure --prefix=/deac/opt/rhel7/opendx --enable-smp-linux
    make -j4 && make check && make install

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

-------
FPLO 18
-------

.. code-block:: bash

    module load compilers/gcc/6.5.0 compilers/intel/2018.5 libs/intel/mkl/2018.5

    cd $TMPDIR
    unzip FPLO-18-20210225T134536Z-001.zip
    cd $TMPDIR/FPLO-18 && echo y | sh ftreeinst.sh
    cd $TMPDIR/FPLO-18/FPLO/FPLO18.00-52/install && printf "ifort\ngcc\ng++\ny\n" | ./MMakefile
    cd $TMPDIR/FPLO-18/FPLO/FPLO18.00-52 && make && make install
    cd $TMPDIR/FPLO-18/FPLO/FPLO18.00-52/PYTHON && printf "3\n\n\n\n\n" | make
    cd $TMPDIR/FPLO-18/FPLO/FPLO18.00-52/XFBP_rel/XFBP && make -f makefile clean && make -f makefile && make -f makefile install
    cd $TMPDIR/FPLO-18/FPLO/FPLO18.00-52/XFPLO_rel/XFPLO && make -f makefile && make -f makefile install

There may be an issue with MKL that is solved with this (per the official documentation), but honestly seems a bit dangerous:

.. code-block:: bash

    export LD_PRELOAD=$MKLROOT/lib/intel64/libmkl_sequential.so:$MKLROOT/lib/intel64/libmkl_core.so

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

-----------------------------
Apache Spark for R and Python
-----------------------------

Step 1: Installing Spark + R with ``sparklyr``
==============================================

First, load the R module, ``module load rhel7/R/4.0.2``, run ``R``, and execute
the following commands:

.. code-block:: R

    library(sparklyr)
    spark_install(version = "3.0.1")

This will install version 3.0.1 of Spark in your local account at
``$HOME/spark``. You can access your installation from within R by issuing the
following within the R console:

.. code-block:: R

    library(sparklyr)
    sc <- spark_connect(master = "local")

You can refer to the many online tutorials for using Spark with R.


Step 2: Using Spark + Python with PySpark
=========================================

We will use the same local installation of Spark for Python, so it is convenient
to set up the following environment variables:

.. code-block:: bash

    export SPARK_HOME="${HOME}/spark/spark-3.0.1-bin-hadoop3.2"
    export PYSPARK_PYTHON=python3
    export PYTHONPATH="${SPARK_HOME}/python:${SPARK_HOME}/python/lib/py4j-0.10.9-src.zip:$PYTHONPATH"
    export PATH="$SPARK_HOME/python:${HOME}/spark/spark-3.0.1-bin-hadoop3.2/bin:$PATH"

These can be set when opening a new session on the cluster (non-persistent), or
can be placed in your ``~/.bashrc`` file so they will be persistent across all
subsequent sessions.

Load the Python module with ``module load rhel7/python/3.7.0``, and you are
done. You can now execute ``pyspark`` to open the PySpark python console
directly. It can also be integrated within conventional python scripts via the
normal ``import pyspark`` type statements.

You can refer to the many online tutorials for using Spark with Python.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

--------
Rosetta3
--------

The Rosetta software suite includes algorithms for computational modeling and
analysis of protein structures. You will need to obtain a license and download
the software from https://www.rosettacommons.org/.

.. code-block:: bash

    module load compilers/gcc/10.2.0

    export VERSION="2021.07.61567"
    tar -xvf $RESEARCHPATH/tarballs/rosetta_src_${VERSION}_bundle.tgz -C $TMPDIR

    # Check the deac-config repo for a site.settings.deac file. Move this to
    # $TMPDIR/rosetta_src_${VERSION}_bundle/main/source/tools/build/site.settings

    cd $TMPDIR/rosetta_src_2021.07.61567_bundle/main/source/
    time ./scons.py -j8 mode=release extras=static bin

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

----------------
ParallelIO (PIO)
----------------

The Parallel IO libraries (PIO) are high-level parallel I/O C and Fortran
libraries for applications that need to do netCDF I/O from large numbers of
processors on a HPC system. PIO provides a netCDF-like API, and allows users to
designate some subset of processors to perform IO. Computational code calls
netCDF-like functions to read and write data, and PIO uses the IO processors to
perform all necessary IO.

.. code-block:: bash

    module load rhel7/gcc/10.1.0 \
                rhel7/compilers/intel-2018-lp64 \
                rhel7/openmpi/4.0.2-intel-2018 \
                rhel7/netcdf/4.7.4-intel \
                rhel7/netcdf-fortran/4.5.3-intel \
                rhel7/pnetcdf/1.12.1-intel

    mkdir -p build && cd build
    CC=mpicc FC=mpifort \
    /deac/opt/rhel7/cmake/3.14/bin/cmake \
        -DCMAKE_INSTALL_PREFIX=/deac/opt/rhel7/pio/2.5.4-intel-2018 \
        -DNetCDF_C_PATH=${NETCDF_C_PATH} \
        -DNetCDF_Fortran_PATH=${NETCDF_FORTRAN_PATH} \
        -DPnetCDF_PATH=${PNETCDF_PATH} \
        -DPIO_ENABLE_EXAMPLES=OFF ..
    make && make check && make install

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

----------------------------------
Portable Hardware Locality (hwloc)
----------------------------------

.. code-block:: bash

    module load compilers/gcc/10.2.0

    ./configure --prefix=/deac/opt/rhel7/hwloc/2.4.1 \
                --enable-shared \
                --enable-static
    make && make install

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

-------------------------------
Quantum Espresso (with Environ)
-------------------------------

.. code-block:: bash

    module load compilers/gcc/10.1.0 compilers/intel/2020.0 mpi/openmpi/4.0.3/intel/2020.0 libs/intel/mkl/2020.0

    wget -P $TMPDIR https://github.com/QEF/q-e/releases/download/qe-6.4.1/backports-6.4.1.diff
    wget -P $TMPDIR https://github.com/QEF/q-e/releases/download/qe-6.4.1/qe-6.4.1_release_pack.tgz
    wget -P $TMPDIR https://github.com/environ-developers/Environ/releases/download/v1.1/Environ-v1.1-QE-6.4.tar.gz

    tar -xvf ${TMPDIR}/qe-6.4.1_release_pack.tgz -C ${TMPDIR} && cd ${TMPDIR}/qe-6.4.1

    patch -p1 --merge < ${TMPDIR}/backports-6.4.1.diff

    ./configure --prefix=/deac/opt/rhel7/qe/6.4.1-environ && make -j8 pw

    tar -xvf ${TMPDIR}/Environ-v1.1-QE-6.4.tar.gz

    ./install/addsonpatch.sh Environ Environ/src Modules -patch
    ./Environ/patches/environpatch.sh -patch
    ./install/makedeps.sh

    make -j8 pw && make install
