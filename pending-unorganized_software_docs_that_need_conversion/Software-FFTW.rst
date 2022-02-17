.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

**FFTW** is "the Fastest Fourier Transform in the West". [1]_

Available Versions
==================

Installed on the cluster are the following versions, compiled with
various compilers except Intel, which includes their own prebuilt
versions.

-  2.1.5 - a.k.a. fftw2
-  3.1.2 - a.k.a. fftw3
-  3.2.2 - a.k.a. fftw3 (only for Intel Compilers 11.1-072)
-  3.3.1 - only for Intel Compilers 11.1-072

The `Intel Compilers </Compiler:Intel_Cluster_Studio>`__ include FFTW in
their Math Kernel Library [2]_

Locations
=========

The default FFTW installations are in
**``/opt/``\ \ ``${COMPILERVERS}``\ \ ``-libs/fftw2``** and
**``/opt/``\ \ ``${COMPILERVERS}``\ \ ``-libs/fftw3``**. Specific
versions will have the full version number, e.g.
**/opt/intel111-libs/fftw-3.3.1**. Below, we will just list the
appropriate value for ``COMPILERVERS``. Also see the `Quick Start
Guide:Compiling </Quick_Start_Guide:Compiling>`__.

Absoft
------

-  **10.0** - ``absoft10``
-  **10.1** - ``absoft101``

GCC
---

-  ``gnu``

PGI
---

-  **7.0** - ``pgi70``
-  **7.1** - ``pgi71``
-  **8.0** - ``pgi80``
-  **9.0** - ``pgi90``

Intel
-----

-  **9.1** - ``intel91``
-  **11.1** - ``intel111``

Intel Math Kernel Library (MKL) FFTW Interfaces
===============================================

The MKL contains interfaces compatible with FFTW2 and FFTW3. However,
these will have to be compiled. Copy the appropriate directory structure
into your own directory, and run make with appropriate arguments.

We have three versions of the MKL installed. Each has the their FFT
sources in the following places (which also include BLAS and LAPACK
interfaces). The source is in these directories --
**``/opt/intel/mkl/``\ \ ``${MKL_VERSION}``\ \ ``/interfaces``**:

-  **10.1.2.024**
-  **10.1.3.027**
-  **10.2.5.035**

See the `Quick Start Guide:Compiling </Quick_Start_Guide:Compiling>`__
for details on setting up your environment to compile with the Intel
compilers.

Compiling
=========

Version 3.3.6 with Intel-2017
-----------------------------

`` module load openmpi/2.1.0-intel-2017``

| `` ./configure --prefix=/your/installation/location CC=icc CFLAGS=’-g -O3’ --enable-mpi --enable-openmp``
| `` make``
| `` make install``

| --enable-mpi: Enables compilation and installation of the FFTW MPI
  library which provides parallel transforms for distributed-memory
  systems with MPI. (By default, the MPI routines are not compiled.)
| --enable-openmp: using OpenMP compiler directives in order to induce
  parallelism rather than spawning its own threads directly, and
  installing an ‘fftw3_omp’ library rather than an ‘fftw3_threads’
  library
| More compiling options can be fund at
  http://www.fftw.org/fftw3_doc/Installation-on-Unix.html#Installation-on-Unix

Version 3.3.6 with GCC-6.2.0
----------------------------

The GCC-6.2.0 and GCC-4.7.0 modules on cluster have issue with compiling
FFTW, in order to make it work, you have to load the GCC compiler AFTER
running configuration.

| `` module purge``
| `` ./configure --prefix=/your/installation/path        ##the barebones config, you may add other options as needed. ``
| ``                                                       load OpenMPI modules prior to this step if <--enable-openmp> option is needed``
| `` ``
| `` module load gcc/6.2.0``
| `` gmake``
| `` gmake install``

References
==========

.. raw:: html

   <references/>

.. [1]
   `FFTW website <http://www.fftw.org/>`__

.. [2]
   `Intel® Math Kernel Library (Intel®
   MKL) <http://software.intel.com/en-us/intel-mkl/>`__
