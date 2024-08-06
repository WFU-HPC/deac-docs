=================
Software Packages
=================

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
OpenDX
------

Need to add how to set up the ``examples``, found in that same repo.

.. code-block:: bash

    git clone git@github.com:grifsf/opendx.git && cd opendx/dx-4.4.4
    ./configure --prefix=/home/anderss/opendx --enable-smp-linux
    make -j4 && make check && make install

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
