.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__ **Quantum Espresso** is a
suite of codes for electronic structure calculation and materials
modeling. [1]_

Installed Version
=================

Version installed on the cluster:

:\* **5.0.3**

It is a basic installation consisting of the *espresso* and *PHonon*
modules.

Running Quantum Espresso
========================

To run QE, load the module to set up the environment:

``     module load espresso/5.0.3-intel-2012``

The entire set of pseudopotential UPF files are also installed. They are
in the directory given by the environment variable ``UPF_FILES``.

PWgui is also available in a separate module:

``     module load espresso/pwgui-5.0.2``

Compiling
=========

**Quantum Espresso** is from http://www.quantum-espresso.org/

-  Installation documentation:
   http://www.quantum-espresso.org/wp-content/uploads/Doc/user_guide/node7.html
-  Download: http://qe-forge.org/frs/?group_id=10
-  Make sure to read the article on the `Compiler:Intel Cluster
   Studio </Compiler:Intel_Cluster_Studio>`__

Download and Patch to Latest Version
------------------------------------

As of 2013-06-10, the latest source code bundle version is 5.0.2 with a
patch file distributed to bring it up to 5.0.3. [2]_

-  Go to the `download
   page <http://www.qe-forge.org/gf/project/q-e/frs/?action=FrsReleaseBrowse&frs_package_id=18>`__
   and download appropriate packages. A minimal set is

   -  espresso-5.0.2.tar.gz
   -  PHonon-5.0.2.tar.gz

-  Download the patch for 5.0.2 -> 5.0.3:

   -  espresso-5.0.2-5.0.3.diff

-  Expand the archives for 5.0.2:

| ``    [myname@headnode ~/src]$ tar zxf espresso-5.0.2.tar.gz``
| ``    [myname@headnode ~/src]$ cd espresso-5.0.2``
| ``    [myname@headnode ~/src/espresso-5.0.2]$ tar zxf ../PHonon-5.0.2.tar.gz``

-  Patch the distribution:

``    [myname@headnode ~/src/espresso-5.0.2]$ patch -p1 < ../espresso-5.0.2-5.0.3.diff``

-  For consistency, you may want to rename the directory:

| ``    [myname@headnode ~/src/espresso-5.0.2]$ cd ..``
| ``    [myname@headnode ~/src]$ mv espresso-5.0.2 espresso-5.0.3``

Compiling Espresso
------------------

Espresso 5.1
~~~~~~~~~~~~

**N.B.** Shell commands are for bash. Translate accordingly for
csh/tcsh.

-  Summary:

   -  Intel compiler
   -  OpenMPI
   -  *NO* OpenMP
   -  Static link to MKL
   -  No external or bundled FFTW - use MKL

-  Download Packages:

| ``    atomic-5.1.tar.gz``
| ``    GWW-5.1.tar.gz``
| ``    pwcond-5.1.tar.gz``
| ``    neb-5.1.tar.gz``
| ``    PWgui-5.1.tar.gz``
| ``    tddfpt-5.1.tar.gz``
| ``    espresso-5.1.tar.gz``
| ``    PHonon-5.1.tar.gz``

-  Compiler setup:

``    [myname@rhel6head3]$ module load openmpi/1.6-intel``

-  Environment variables - from the Intel Link Line Advisor - NO OpenMP,
   static explicit linking ("\" indicates line continues):

| ``    [myname@rhel6head3]$ export CPPFLAGS="-I${MKLROOT}/include/intel64/lp64 -I${MKLROOT}/include"``
| ``    [myname@rhel6head3]$ export CFLAGS="-O3 -xSSE4.1 -ipo"``
| ``    [myname@rhel6head3]$ export LDFLAGS="$MKLROOT/lib/intel64/libmkl_blas95_lp64.a \``
| ``        $MKLROOT/lib/intel64/libmkl_lapack95_lp64.a $MKLROOT/lib/intel64/libmkl_scalapack_lp64.a \``
| ``        -Wl,--start-group  $MKLROOT/lib/intel64/libmkl_intel_lp64.a \``
| ``        $MKLROOT/lib/intel64/libmkl_sequential.a $MKLROOT/lib/intel64/libmkl_core.a \``
| ``        $MKLROOT/lib/intel64/libmkl_blacs_openmpi_lp64.a -Wl,--end-group -lpthread -lm"``

-  Configure:

``    [myname@rhel6head3]$ ./configure --prefix=$HOME/espresso-5.1 --enable-parallel --enable-shared=no``

-  Edit make.sys to set FFLAGS:

``    ``\ **``line``\ ````\ ``82:``**\ `` FFLAGS         = -O2 -ipo -xSSE4.1 -assume byterecl -traceback -par-report0 -vec-report0``

-  Edit make.sys to not use bundled FFTW (use MKL's, instead):

| ``    ``\ **``line``\ ````\ ``42:``**\ `` DFLAGS         =  -D__INTEL -D__FFTW3 -D__MPI -D__PARA -D__SCALAPACK $(MANUAL_DFLAGS)``
| ``    ``\ **``line``\ ````\ ``125:``**\ `` FFT_LIBS       =``

-  Compile:

| ``    [myname@rhel6head3]$ make pwall >& Make.pwall.out &``
| ``    [myname@rhel6head3]$ tail -f Make.pwall.out``

-  Go to lunch. This will take over an hour.

Espresso 5.0.3
~~~~~~~~~~~~~~

**N.B.** Shell commands are for bash. Translate accordingly for
csh/tcsh.

-  Summary:

   -  Intel compiler
   -  OpenMPI
   -  *NO* OpenMP
   -  Static link to MKL
   -  No external or bundled FFTW - use MKL

-  Compiler setup:

``    [myname@rhel6head3]$ module load openmpi/1.6-intel``

-  Environment variables - from the Intel Link Line Advisor - NO OpenMP,
   static explicit linking ("\" indicates line continues):

| ``    [myname@rhel6head3]$ export CPPFLAGS="-I${MKLROOT}/include/intel64/lp64 -I${MKLROOT}/include"``
| ``    [myname@rhel6head3]$ export CFLAGS="-O3 -xSSE4.1 -ipo"``
| ``    [myname@rhel6head3]$ export LDFLAGS="$MKLROOT/lib/intel64/libmkl_blas95_lp64.a \``
| ``        $MKLROOT/lib/intel64/libmkl_lapack95_lp64.a $MKLROOT/lib/intel64/libmkl_scalapack_lp64.a \``
| ``        -Wl,--start-group  $MKLROOT/lib/intel64/libmkl_intel_lp64.a \``
| ``        $MKLROOT/lib/intel64/libmkl_sequential.a $MKLROOT/lib/intel64/libmkl_core.a \``
| ``        $MKLROOT/lib/intel64/libmkl_blacs_openmpi_lp64.a -Wl,--end-group -lpthread -lm"``

-  Configure:

``    [myname@rhel6head3]$ ./configure --prefix=$HOME/espresso-5.0.3 --enable-parallel --disable-shared``

-  Edit make.sys to set FFLAGS:

``    ``\ **``line``\ ````\ ``75:``**\ `` FFLAGS         = -O3 -ipo -xSSE4.1 -assume byterecl -traceback -par-report0 -vec-report0``

-  Edit make.sys to not use bundled FFTW (use MKL's, instead):

| ``    ``\ **``line``\ ````\ ``35:``**\ `` DFLAGS         =  -D__INTEL -D__FFTW3 -D__MPI -D__PARA -D__SCALAPACK $(MANUAL_DFLAGS)``
| ``    ``\ **``line``\ ````\ ``118:``**\ `` FFT_LIBS       =``

-  Compile:

| ``    [myname@rhel6head3]$ make pwall >& Make.pwall.out &``
| ``    [myname@rhel6head3]$ tail -f Make.pwall.out``

-  Go to lunch. This will take over an hour.

Espresso 4.x
~~~~~~~~~~~~

NOTES:

-  only need to load openmpi/1.6-intel -- this automatically loads the
   matching Intel compiler module
-  no need to load an FFTW library module -- Intel's Math Kernel Library
   (MKL) contains an FFTW3-compatible interface (see also QE
   documentation to this effect)

| ``   export APPDIR=$HOME/applications``
| ``   module load openmpi/1.6-intel``
| ``   ./configure --prefix=$APPDIR ``

Edit make.sys according to
http://software.intel.com/en-us/articles/intel-mkl-link-line-advisor/ --
select multithreaded, static linking, Open MPI (only available under
static linking). See article on the `Intel Compiler
Suite </Intel_Compiler_Suite>`__.:

``   IFLAGS         = -I../include -I$(MKLROOT)/include/intel64/lp64  -I$(MKLROOT)/include``

``   BLAS_LIBS      =   ``

| ``   SCALAPACK_LIBS =  $(MKLROOT)/lib/intel64/libmkl_blas95_lp64.a  \``
| ``        $(MKLROOT)/lib/intel64/libmkl_lapack95_lp64.a \``
| ``        $(MKLROOT)/lib/intel64/libmkl_scalapack_lp64.a  \``
| ``        -Wl,--start-group  $(MKLROOT)/lib/intel64/libmkl_intel_lp64.a \``
| ``        $(MKLROOT)/lib/intel64/libmkl_intel_thread.a \``
| ``        $(MKLROOT)/lib/intel64/libmkl_core.a \``
| ``        $(MKLROOT)/lib/intel64/libmkl_blacs_openmpi_lp64.a \``
| ``        -Wl,--end-group -openmp -lpthread -lm``

QE-GPU
------

First, see `Information:GPU Computing </Information:GPU_Computing>`__.

This seems to be the only version that reliably works:

-  Download the source package:
   http://www.qe-forge.org/gf/download/frsrelease/119/397/espresso-5.0.1-GPU-build2.tar.gz
-  Then, on one of the GPU nodes:

| ``    $ module purge``
| ``    $ module load compilers/intel-2012-lp64``
| ``    $ module load cuda-5.0``
| ``    $ tar zxf espresso-5.0.1-GPU-build2.tar.gz``
| ``    $ cd espresso-5.0.1-GPU``

-  Read the file ``README.GPU``
-  Configure:

| ``    $ ./configure --disable-parallel --enable-openmp --enable-cuda --with-cuda-dir=$CUDADIR \``
| ``        --with-gpu-arch=20 --enable-magma --enable-phigemm --without-scalapack``

-  Edit resulting ``make.sys`` file:

| ``    ``\ **``line``\ ````\ ``39:``**\ `` DFLAGS         =  -D__INTEL -D__FFTW3 -D__CUDA -D__GPU_NVIDIA_20 -D__PHIGEMM -D__MAGMA -D__CUDA_QE_TIMING -D__OPENMP $(MANUAL_DFLAGS)``
| ``    ``\ **``line``\ ````\ ``77:``**\ `` CFLAGS         = -O3 -xSSE4.1 $(DFLAGS) $(IFLAGS) -openmp``
| ``    ``\ **``line``\ ````\ ``79:``**\ `` FFLAGS         = -O3 -xSSE4.1 -assume byterecl -g -traceback -par-report0 -vec-report0 -openmp``

-  Edit ``install/make_mag.inc``:

| ``    ``\ **``line``\ ````\ ``17:``**\ `` CC        = icc``
| ``    ``\ **``line``\ ````\ ``19:``**\ `` FORT      = ifort``
| ``    ``\ **``line``\ ````\ ``25:``**\ `` OPTS      = -O3 -xSSE4.1 -openmp -static -DADD_``
| ``    ``\ **``line``\ ````\ ``26:``**\ `` FOPTS     = -O3 -xSSE4.1 -openmp -static -DADD_``
| ``    ``\ **``line``\ ````\ ``28:``**\ `` LDOPTS    = -fPIC -Xlinker -zmuldefs -openmp``

-  Edit ``install/make_phiGEMM.inc``:

| ``    ``\ **``line``\ ````\ ``25:``**\ `` CFLAGS      = -O3 -xSSE4.1 -openmp -fPIC``
| ``    ``\ **``line``\ ````\ ``28:``**\ `` FFLAGS      = -O3 -xSSE4.1 -openmp -module ../include/``
| ``    ``\ **``line``\ ````\ ``31:``**\ `` LD_FLAGS        = -O3 -openmp -fPIC``
| ``    ``\ **``line``\ ````\ ``38:``**\ `` NVCC_FLAGS  = -ccbin icc -O3 --compiler-options '-fPIC -openmp'``

-  Build:

``    $ make pwall >& Make.pwall.out &``

Testing
-------

-  See
   http://www.quantum-espresso.org/wp-content/uploads/Doc/user_guide/node13.html
-  Modify the **environment_variables** file at the top of the
   distribution, i.e. espresso-X.Y.Z/environment_variables:

| ``    ``\ **``line``\ ````\ ``58:``**\ `` PARA_PREFIX="mpirun -np 4"``
| ``    ``\ **``line``\ ````\ ``72:``**\ `` PARA_POSTFIX=" "``
| ``    ``\ **``line``\ ````\ ``80:``**\ `` PARA_IMAGE_PREFIX="mpirun -np 8"``
| ``    ``\ **``line``\ ````\ ``81:``**\ `` PARA_IMAGE_POSTFIX="-nimage 2 $PARA_POSTFIX"``
| ``    ``

-  Some of the tests require old pseudopotential files which are no
   longer distributed by the Quantum Espresso project: O_US.van,
   H_US.van. You may find them at this repository forked some years ago:
   https://github.com/NNemec/quantum-espresso/tree/master/pseudo

Installing
==========

There is no "install" target.

.. _espresso-5.0.3-1:

Espresso 5.0.3
--------------

-  Say the source directory is ${HOME}/src/espresso-5.0.3
-  Copy the executables to the final destination bin directory -- say
   it's ${HOME}/espresso-5.0.3/bin

| ``    [myname@headnode]$ mkdir -p ${HOME}/espresso-5.0.3/bin``
| ``    [myname@headnoe]$ cd ${HOME}/src/espresso-5.0.3/bin``
| :literal:`    [myname@headnode]$ /bin/cp -f `/bin/ls -l  | awk '{print $11}' | xargs ` ${HOME}/espresso-5.0.3/bin`

-  Strip executables:

| ``    [myname@headnode]$ cd ${HOME}/espresso-5.0.3/bin ``
| ``    [myname@headnode]$ strip *.x``

Pseudopotentials
================

-  Available from http://www.quantum-espresso.org/pseudopotentials
-  Currently installed on cluster in:
   ``/deac/opt/espresso-5.0.3/pseudopotentials/``

References
==========

.. raw:: html

   <references/>

.. [1]
   `Quantum Espresso Project
   website <http://www.quantum-espresso.org/>`__

.. [2]
   `Patches for Quantum Espresso
   v.5.0.2 <http://www.quantum-espresso.org/blog/patches-for-quantum-espresso-v-5-0-2>`__
