.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

Version
=======

Versions installed on the cluster:

-  lammps/latest-intel-2012 (LAMMPS code checkout around March 2012)
-  lammps/20130813/gnu (LAMMPS code checkout on 2013 Aug 13)

Environment
===========

-  MPI : Unless otherwise noted, the MPI implementation used for all the
   LAMMPS builds will be OpenMPI 1.6.
-  FFTW : The FFTW2 libraries on the cluster will be used for all FFT
   support in LAMMPS

-  To prepare your environment, load the environment
   `module </Quick_Start_Guide:Environment_Modules>`__:

.. raw:: html

   </blockquote>

   ::

       module load lammps/20130813/gnu

Documentation
=============

:; Authors Website : http://lammps.sandia.gov/

:; Users Manual : http://lammps.sandia.gov/doc/Manual.html

:; Tutorials :
https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials

Example Job
===========

   With this build you can test your build with the input files and
   SLURM job script found on the cluster at:

      /deac/opt/lammps/20130813/gcc-4.4/test/icme-tutorial-1

      -  Don't forget to customize the job script for your fairshare
         group!
      -  This example is for the GNU build!

   A second test job, which exercises the JPEG library, can be found in
   the following directories. SLURM scripts are not provided but should
   easily be adapted from the ICME Tutorial above.

      /deac/opt/lammps/20130813/intel-2012/test/jpeg

         ::

             bash test-script.sh 

      /deac/opt/lammps/20130813/gcc-4.4/test/jpeg

         ::

             bash test-script.sh 

      -  Don't forget to copy these directories to your own directory
         first!

General Information
===================

   Main Web Page : http://lammps.sandia.gov/

   Downloading the software
      ::

         svn co svn://svn.icms.temple.edu/lammps-ro/trunk mylammps

      -  Note: Versioning is by date based timestamp. There is no 1.x or
         2.x release number.
      -  Rolling patches and updates are released constantly.

   Building software
      http://lammps.sandia.gov/doc/Section_start.html

   Documentation on building LAMMPS packages
      http://lammps.sandia.gov/doc/Section_start.html#start_3

   Documentation on the actual LAMMPS packages
      http://lammps.sandia.gov/doc/Section_packages.html

   Tutorials
      https://icme.hpc.msstate.edu/mediawiki/index.php/LAMMPS_tutorials

GNU gcc/g++ Build Guidelines
============================

Build Note : Please be aware that the GNU based build is probably the simplest to work through. Please try this build first before attempting more complicated compilers and library combinations.

..

   Ensure you have a clean shell environment:

      ::

         $ module list
         No Modulefiles Currently Loaded.

   Load the OpenMPI and FFTW modules:

      ::

         module load openmpi/1.6-gnu; module load libs/fftw-2.1.5/gnu

   Note: This build will leverage the BLAS and LAPACK libraries provided
   by Red Hat (likely, unoptimized) found in the RPMs:

      ::

         blas-3.2.1-4.el6.x86_64
         blas-devel-3.2.1-4.el6.x86_64
         lapack-3.2.1-4.el6.x86_64
         lapack-devel-3.2.1-4.el6.x86_64

   Download the software (20130813 is the date and the directory the
   files are copied to):

      ::

         svn co svn://svn.icms.temple.edu/lammps-ro/trunk 20130813; cd 20130813

   Create a custom Makefile for the WFU DEAC Cluster and the modules
   loaded above:

      ::

         cd src/MAKE; cp Makefile.g++ Makefile.deac_g++

   The important things to note when editing the Makefile:

   #. Since you are building an MPI version, you must use the **mpicxx**
      "compiler" and not the native **g++** system compiler. This will
      use g++ under the covers but also include all the MPI include and
      library paths.
   #. Because we use the environment modules to dynamically load your
      needed include, library, and binary paths, the full paths do not
      need to be specified in the Makefile.
   #. LAMMPS requires modifying the very first line of the Makefile
      (which is a comment) as part of its Make system.

   Below, is the "patch" file listing the changes I made to the custom
   'deac_g++' build:

      ::

         --- ../../src/MAKE/Makefile.g++ 2013-04-02 14:32:30.000000000 -0400
         +++ ../../src/MAKE/Makefile.deac_g++    2013-08-13 12:10:21.659748000 -0400
         @@ -1,4 +1,4 @@
         -# g++ = RedHat Linux box, g++4, MPICH2, FFTW
         +# deac_g++ = RedHat Linux box, g++4, OpenMPI, FFTW
          
          SHELL = /bin/sh
          
         @@ -6,12 +6,12 @@
          # compiler/linker settings
          # specify flags and libraries needed for your compiler
          
         -CC =       g++
         +CC =       mpicxx
          CCFLAGS =  -g -O # -Wunused
          SHFLAGS =  -fPIC
          DEPFLAGS = -M
          
         -LINK =     g++
         +LINK =     mpicxx
          LINKFLAGS =    -g -O
          LIB = 
          SIZE =     size
         @@ -37,9 +37,10 @@
          # PATH = path for MPI library
          # LIB = name of MPI library
          
         -MPI_INC =       -DMPICH_SKIP_MPICXX
         +# Left blank because of mpicxx usage
         +MPI_INC = 
          MPI_PATH = 
         -MPI_LIB =  -lmpich -lmpl -lpthread
         +MPI_LIB = 
          
          # FFT library, OPTIONAL
          # see discussion in doc/Section_start.html#2_2 (step 6)

   :\* The full Makefile.deac_g++ can be found on the cluster at:
   /deac/opt/lammps/20130813/gcc-4.4/build/src/MAKE/Makefile.deac_g++

   The next step is to test the core software build. If this does not
   build without errors, something is wrong with your environment:

      ::

         cd 20130813/src; make deac_g++

   Once the environment is right and the core builds without error, you
   can proceed with the standard and/or user packages that you need to
   build. The version on the cluster currently used the following
   instructions:

      ::

         cd 20130813/src
         make clean-all
         make yes-meam
         make yes-reax
         make yes-manybody
         make yes-misc

         cd ../lib/meam; make -f Makefile.gfortran
         cd ../reax; make -f Makefile.gfortran

         cd ../../src; make deac_g++

   The binary that is created for your use is 'lmp_deac_g++' located in
   the *src* directory from which you ran 'make deac_g++'.

Intel icc/ifort Build Guidelines
================================

   Ensure you have a clean shell environment:

      ::

         $ module list
         No Modulefiles Currently Loaded.

   Load the OpenMPI and FFTW modules: (note, with Intel-2017 compiler,
   refer to:
   `Software:LAMMPS#Intel-2017_icc.2Fifort_build_guidline </Software:LAMMPS#Intel-2017_icc.2Fifort_build_guidline>`__)

      ::

         module load compilers/intel-2012-lp64
         module load libs/fftw-2.1.5/intel-2012
         module load openmpi/1.6-intel

   At this point, your shell environment is configured to use the
   following software:

   #. Intel C/C++ Compiler
   #. Intel Fortran Compiler
   #. FFTW2 2.1.5 libraries build with Intel compilers
   #. OpenMPI 1.6 built with Intel compilers

   The order of the module loads is very important! If done incorrectly,
   your environment will use the Intel MPI implementation which has
   known issues with our cluster.

   Download the software (20130813 is the date and the directory the
   files are copied to):

      ::

         svn co svn://svn.icms.temple.edu/lammps-ro/trunk 20130813; cd 20130813

   Create a custom Makefile for the WFU DEAC Cluster and the modules
   loaded above:

      ::

         cd src/MAKE; cp Makefile.linux Makefile.deac_icc

   The important things to note when editing the Makefile:

   #. Since you are building an MPI version, you must use the **mpicxx**
      "compiler" and not the **icc** compiler. This will use **icc**
      under the covers but also include all the MPI include and library
      paths.
   #. Because we use the environment modules to dynamically load your
      needed include, library, and binary paths, the full paths do not
      need to be specified in the Makefile.
   #. LAMMPS requires modifying the very first line of the Makefile
      (which is a comment) as part of its Make system.
   #. The **-mkl** compiler and linker options are very important as
      that builds in the Math Kernel Library support for optimized
      BLAS/LAPACK routines.

   Below, is the "patch" file listing the changes I made to the custom
   'deac_linux' build:

      ::

         --- Makefile.linux      2013-04-02 14:32:30.000000000 -0400
         +++ Makefile.deac_linux 2013-08-28 11:40:02.684669000 -0400
         @@ -1,4 +1,4 @@
         -# linux = RedHat Linux box, Intel icc, MPICH2, FFTW
         +# deac_icc = RedHat Linux box, Intel icc, OpenMPI 1.6, FFTW2

          SHELL = /bin/sh

         @@ -6,14 +6,14 @@
          # compiler/linker settings
          # specify flags and libraries needed for your compiler

         -CC =           icc
         -CCFLAGS =      -O
         +CC =           mpicxx
         +CCFLAGS =      -O -mkl
          SHFLAGS =      -fPIC
          DEPFLAGS =     -M

         -LINK =         icc
         +LINK =         mpicxx
          LINKFLAGS =    -O
         -LIB =           -lstdc++
         +LIB =           -lstdc++ -mkl
          SIZE =         size

          ARCHIVE =      ar
         @@ -37,9 +37,9 @@
          # PATH = path for MPI library
          # LIB = name of MPI library

         -MPI_INC =       -DMPICH_SKIP_MPICXX
         +MPI_INC =
          MPI_PATH =
         -MPI_LIB =      -lmpich -lmpl -lpthread
         +MPI_LIB =

          # FFT library, OPTIONAL
          # see discussion in doc/Section_start.html#2_2 (step 6)

   :\* The full Makefile.deac_linux can be found on the cluster at:
   /deac/opt/lammps/20130813/intel-2012/build/src/MAKE/Makefile.deac_linux

   The next step is to test the core software build. If this does not
   build without errors, something is wrong with your environment:

      ::

         cd 20130813/src; make deac_linux

   Once the environment is right and the core builds without error, you
   can proceed with the standard and/or user packages that you need to
   build. For the Intel compilers, the MEAM and REAX modules required
   some changes to support the Intel compiler linking phases:

   src/lib/meam/Makefile.lammps.ifort

   ..

      ::

         --- Makefile.lammps.ifort.orig  2013-08-28 12:15:28.006089000 -0400
         +++ Makefile.lammps.ifort       2013-08-28 12:15:42.123797000 -0400
         @@ -1,5 +1,5 @@
          # Settings that the LAMMPS build will import when this package library is used

          meam_SYSINC =
         -meam_SYSLIB = -lifcore -lsvml -lompstub -limf
         -meam_SYSPATH = -L/opt/intel/fce/10.0.023/lib
         +meam_SYSLIB = -lifcore -lsvml -limf
         +meam_SYSPATH =

         *(The short, short version: don't provide a SYSPATH value and
         remove the -lompstub linker option)*

   src/lib/reax/Makefile.lammps.ifort

   ..

      ::

         --- Makefile.lammps.ifort.orig  2013-08-28 12:15:28.006089000 -0400
         +++ Makefile.lammps.ifort       2013-08-28 12:15:42.123797000 -0400
         @@ -1,5 +1,5 @@
          # Settings that the LAMMPS build will import when this package library is used

          reax_SYSINC =
         -reax_SYSLIB = -lifcore -lsvml -lompstub -limf
         -reax_SYSPATH = -L/opt/intel/fce/10.0.023/lib
         +reax_SYSLIB = -lifcore -lsvml -limf
         +reax_SYSPATH =

         *(The short, short version: don't provide a SYSPATH value and
         remove the -lompstub linker option)*

   Once the MEAM and REAX modules are patched, the version on the
   cluster currently used the following instructions:

      ::

         cd 20130813/src
         make clean-all
         make yes-meam
         make yes-reax
         make yes-manybody
         make yes-misc

         cd ../lib/meam; make -f Makefile.ifort
         cd ../reax; make -f Makefile.ifort

         cd ../../src; make deac_icc

   The binary that is created for your use is 'lmp_deac_icc' located in
   the *src* directory from which you ran 'make deac_icc'.

Intel-2017 icc/ifort build guidline
-----------------------------------

With Intel-2017 compiler all above procedures are still valid. However,
since we'll be using fftw lib compiled by intel-2012 compiler, the
preparation of modules is different.

| ``  module load libs/fftw-3.3.1/intel-2012``
| ``  module unload compilers/intel-2012-lp64``
| ``  module load openmpi/2.1.0-intel-2017``
| ``  module list``
| ``  Currently Loaded Modulefiles:``
| ``    1) libs/fftw-3.3.1/intel-2012   3) libfabric-1.4.1``
| ``    2) compilers/intel-2017-lp64    4) openmpi/2.1.0-intel-2017``
