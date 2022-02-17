.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

General Purpose Software
========================

RHEL6 Built Software
--------------------

-  Scientific Packages

:\* ATLAS

:\* HDF, HDF5

:\* BLAS, LAPACK

:\* NetCDF

:\* BOOST

:\* OpenMPI

:\* MPICH

:\* MVAPICH

:\* GSL

:\* R

-  Developer Packages

:\* autoconf, automake, libtool, make, imake, patch, diff

:\* subversion/svn, git, mercurial

:\* jpackage, eclipse, Sun Java 1.6.0

:\* tcl, tclx, tk

:\* gcc, gdb, latrace, ltrace, lslk, memtest86, valgrind, crash

-  "Productivity" Packages

:\* TeX/LaTeX (via texlive distribution)

:\* docbook

:\* nedit

:\* `octave <http://www.gnu.org/software/octave/>`__

-  Database connectivity

:\* mysql, mysql-python, mysql-connector-odbc, libdbi-dbd-mysql,
perl-DBD-MySQL

:\* postgresql, pygresql, postgresql-odbc, python-psycopg2,
libdbi-dbd-pgsql, perl-DBD-Pg, postgresql-jdbc, tcl-pgtcl

WFU Licensed Software
---------------------

-  Restricted to Reynolda Campus users only

:\* `Mathematica </Software:Mathematica>`__

:\* `MAPLE </Software:Maple>`__

-  Two different installations to support both Reynolda Campus and
   Baptist Health users

:\* `MATLAB </Software:Matlab>`__

WFU DEAC Licensed Software
--------------------------

-  Restricted to Reynolda Campus users only

:\* `IDL </Software:IDL>`__

:\* `Gaussian </Software:Gaussian>`__

:\* `VASP </Software:VASP>`__

-  Restricted to Baptist Health users only

:\* `SAS </Software:SAS>`__

:\* `LS-Dyna </Software:LS-Dyna>`__

WFU DEAC Managed Software
-------------------------

-  `Fastest Fourier Transform in the West <http://www.fftw.org/>`__
   (`FFTW </Software:FFTW>`__)

:\* FFTW2 - v2.1.5

:\* FFTW3 - v3.3.1

-  CoCoA (v4.7.5) - `Computations in Commutative
   Algebra <http://cocoa.dima.unige.it/>`__ (free with attribution
   license)
-  ANTs (v1.9.x)
-  LAMMPS
-  XCRYSDEN (v1.5.53) - `X-window CRYstalline Structure and
   DENsities <http://www.xcrysden.org/>`__ visualization software, for
   `PWscf </PWscf>`__ and WEIN2k (GPL)
-  MEAD (v2.2.9) - `Macroscopic Electrostatics with Atomic
   Detail <http://stjuderesearch.org/site/lab/bashford>`__ (GPL)

The following software is free in cost but requires individuals to
obtain a (no cost) license from the authors (UIUC)

-  NAMD 2.8 (multiple compilers and network support)

Requires license (and fee) at the research group level from `CHARMM
authors <http://www.charmm.org/package/license.html>`__.

-  `CHARMM </Software:CHARMM>`__ (v35 b6) - `Chemistry at HARvard
   Macromolecular Mechanics <http://www.charmm.org/>`__

.. raw:: html

   </blockquote>

Compilers
=========

   .. rubric:: GCC Compiler Suite
      :name: gcc-compiler-suite

   See https://gcc.gnu.org/ for more detailed information

   -  RHEL6 comes with version 4.4.6 (with patches by Red Hat) of the
      GCC Compiler suite.
   -  We install the following GCC language compilers:

   :\* C (gcc)

   :\* C++ (gcc-c++)

   :\* Objective C (gcc-objc)

   :\* Fortran (gcc-gfortran)

   :\* Java (gcc-java)

   :\* Ada95 (gcc-gnat)

   -  Also, we provide the older GCC 3.4.6 compiler compatibility
      packages that Red Hat makes available. Those are provided as a
      convenience and we offer no assistance in using them as their use
      is primarily for power users.

   .. rubric:: Intel Compilers
      :name: intel-compilers

   See `Compiler:Intel Cluster
   Studio </Compiler:Intel_Cluster_Studio>`__ and
   [https://software.intel.com/en-us/search/gss/intel%20compiler\ \|
   https://software.intel.com/] for more detailed information

   -  We license and provide `Intel Cluster Studio XE
      2012 <http://software.intel.com/en-us/articles/intel-cluster-studio-xe/>`__

   :\* Yes, Intel has changed the way the name, bundle and version their
   cluster compiler suite (again).

   :\* Current **supported** software version is 2012.0.032.

   -  The following Intel products are included in the suite:

   :\* `Intel Composer
   XE <http://software.intel.com/en-us/articles/intel-composer-xe/>`__

   ::\* C, C++, and F95 compilers

   ::\* `Intel Performance Primitives
   (IPP) <http://software.intel.com/en-us/articles/intel-ipp/>`__

   ::\* `Threaded Building Blocks
   (TBB) <http://software.intel.com/en-us/articles/intel-tbb/>`__

   :\* `Intel MPI
   Library <http://software.intel.com/en-us/articles/intel-mpi-library/>`__

   :\* `Intel Trace
   Analyzer <http://software.intel.com/en-us/articles/intel-trace-analyzer/>`__
   (for MPI performance analysis)

   :\* `Intel VTune Amplifier
   XE <http://software.intel.com/en-us/articles/intel-vtune-amplifier-xe/>`__

   :\* `Intel Inspector
   XE <http://software.intel.com/en-us/articles/intel-inspector-xe/>`__

   -  We would like to point out that, while we don't endorse one
      compiler technology over another, the supplemental tools/libraries
      available from Intel are very powerful and provide a great deal of
      assistance to software developers in analyzing, tuning, and
      debugging their codes.

   -  Please note: The supported version mentioned above merely
      indicates the version of the compiler we use to build other
      software on the cluster. We will provide updated compiler versions
      as they are made available by Intel but will not rebuild the other
      software packages with the later versions of the compiler unless a
      known compiler issue requires us to do so.

   .. rubric:: Portland Compilers
      :name: portland-compilers

   See `Compiler:PGI Cluster Development
   Kit </Compiler:PGI_Cluster_Development_Kit>`__ and
   http://www.pgroup.com/ for more detailed information

   -  We license and provide `PGI CDK Cluster Development
      Kit <http://www.pgroup.com/products/pgicdk.htm>`__
   -  Current "supported" version is *12.1*
   -  The following products are included in the CDK:

   :\* `Portland C/C++ and Fortran
   Compilers <http://www.pgroup.com/products/pgiserver.htm>`__

   :\* `Portland Debugger <http://www.pgroup.com/products/pgdbg.htm>`__
   (OpenMP and MPI debugging support)

   :\* `Portland Profiler <http://www.pgroup.com/products/pgprof.htm>`__
   (OpenMP and MPI profiling support)

   :\* `PGI Accelerator <http://www.pgroup.com/resources/accel.htm>`__
   (Fortran support for GPUs)

   :\* MPICH

   :\* MVAPICH

   :\* Optimized BLAS/LAPACK

   -  Please note: The supported version mentioned above merely
      indicates the version of the compiler we use to build other
      software on the cluster. We will provide updated compiler versions
      as they are made available by Intel but will not rebuild the other
      software packages with the later versions of the compiler unless a
      known compiler issue requires us to do so.

Parallel Computing Support
==========================

   Each compiler provides their own support for MPI and OpenMP. You
   should use the MPI environment provided by the compiler you are using
   for your research software. This will minimize any difficulties you
   may experience when attempting to debug your software.

   | 
   | We have provided a general `Quick Start Guide:Intel
     MPI </Quick_Start_Guide:Intel_MPI>`__ as a starting place for users
     wishing to use MPI in their research.
   | We have also provided a general
     `Software:OpenMP </Software:OpenMP>`__ for users wishing to use
     OpenMP.

   .. rubric:: GNU Compilers
      :name: gnu-compilers

   There are three different MPI implementations provided by Red Hat
   Enterprise Linux. You should really choose either OpenMPI or the
   appropriate MPICH/MVAPICH implementation. We also provide OpenMPI
   1.5.5 compiled from source code since we have had issues with the
   RedHat-provided OpenMPI running on more than a single node.

   -  `OpenMPI <http://www.open-mpi.org/>`__ - Provides both Ethernet
      and Infiniband based communication support.
   -  `MPICH2 <http://www.mcs.anl.gov/research/projects/mpich2/>`__ -
      Provides Ethernet communication support.
   -  `MVAPICH2 <http://mvapich.cse.ohio-state.edu/>`__ - Based on
      MPICH2, provides Infiniband communication support.

   Power users may wish to go directly to the following quick start
   guides:

      `Quick Start Guide:GNU OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__
      `Quick Start Guide:GNU MPICH </Quick_Start_Guide:GNU_MPICH>`__

   .. rubric:: Intel Compilers
      :name: intel-compilers-1

   Intel ships their own MPI library with the compiler suite. It is
   based on ANL's
   `MPICH2 <http://www.mcs.anl.gov/research/projects/mpich2/>`__ and
   TOSU's `MVAPICH2 <http://mvapich.cse.ohio-state.edu/>`__. We have
   OpenMPI 1.5.5 built with the default Intel compilers.

   -  `Intel MPI
      Library <http://software.intel.com/en-us/articles/intel-mpi-library/>`__

   Power users may wish to go directly to the following quick start
   guides:

      `Quick Start Guide:Intel MPI </Quick_Start_Guide:Intel_MPI>`__

   .. rubric:: Portland Compilers
      :name: portland-compilers-1

   Portland ships their own build of the ANL MPICH/MPICH2 and MVAPICH
   software. We also do not currently have an OpenMPI build for PGI.

   -  There's little MPI specific information for the Portland
      Compilers. You may peruse their published documentation at
      http://www.pgroup.com/resources/docs.htm
