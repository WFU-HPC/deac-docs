.. contents::
   :depth: 3
..

`Category:Quick
Start </Category:Quick_Start>`__\ `Category:Compiling </Category:Compiling>`__\ `Category:Software </Category:Software>`__

Warning
=======

-  VASP has strict licensing requirements and you must follow the terms
   documented in `License:VASP </License:VASP>`__. These terms are the
   ones you agreed to in order to access the software.

Environment
===========

We currently "support" the following builds of VASP on the RHEL6
Cluster:

-  vasp/5.2.12/parallel_gamma/intel-2012
-  vasp/5.2.12/parallel_kpoints/intel-2012
-  vasp/5.2.12/serial_kpoints/intel-2012
-  vasp/5.3.3/parallel_gamma/intel-2012
-  vasp/5.3.3/parallel_kpoints/intel-2012
-  vasp/5.3.3/serial_kpoints/intel-2012

As the environment modules suggest, all builds were made with the Intel
2012 compiler suite. There are three VASP build types for each version:

-  parallel_gamma
-  parallel_kpoints
-  serial_kpoints

**PLEASE NOTE:** these builds were handled by a cluster research group
and "support" by the WFU DEAC Cluster is merely restricted to license
control and availability of the software.

Custom Build Requirements
-------------------------

-  If you need a custom build of VASP, you **MUST** contact the cluster
   team to request a special directory get created.
-  You **CAN NOT** under any circumstance create your own personal
   directory in any arbitrary directory.

:\* You are violating your acceptance of the license terms in doing so.

Preparing your environment
==========================

Example using version 5.3.3, parallel_kpoints type build

   ::

       module load vasp/5.3.3/parallel_kpoints/intel-2012

At this point, you are ready to use it!

Documentation
=============

-  `License:VASP </License:VASP>`__
-  `VASP Website Documentation
   Page <https://www.vasp.at/index.php/documentation>`__

Compiling
=========

-  `VASP Manual <http://cms.mpi.univie.ac.at/vasp/vasp/vasp.html>`__
   includes build instructions

Intel Cluster Studio XE 2012 + OpenMPI 1.6
------------------------------------------

-  Architecture: -xSSE4.1 (All Nehalem nodes support SSE4.1; only some
   Nehalem nodes support SSE4.2)
-  GotoBLAS

   -  Edit Makefile.rule

      -  TARGET = NEHALEM
      -  CC = icc
      -  FC = ifort
      -  BINARY = 64

-  MKL - use the `Link Line Advisor (MKL version
   10.3) <http://software.intel.com/sites/products/mkl/>`__:

   -  Link with Intel® MKL libraries explicitly

-  **IMPORTANT NOTE ON MEMORY ALLOCATION** -- by default, the Intel
   Fortran compiler will allocate static arrays on the stack. The usual
   trick to set the stacksize limit to "unlimited" in the running shell
   won't work for MPI jobs as the remote jobs are launched by
   mpiexec/mpirun. The trick is to write a C module definining a
   function stacksize_() [note the underscore at the end of the name],
   and then calling it in the main VASP program before any work is
   done. [1]_

PGI 12.5 + OpenMPI 1.6
----------------------

-  PGI's compilation notes:

   -  GotoBLAS -
      http://www.pgroup.com/resources/gotoblas/gotoblas_pgi2012.htm
   -  VASP - http://www.pgroup.com/resources/vasp/vasp_pgi2010.htm

-  GotoBLAS must use same compilation options as VASP, so must modify
   the default makefile for Nehalem

   -  remove "-i8" option everywhere applicable
   -  Edit Makefile.rule to change compilation options

      -  TARGET = NEHALEM (**NB** "NEHALEM" must be all caps)
      -  CC = pgcc
      -  FC = pgfortran
      -  BINARY = 64
      -  NUM_THREADS = 4 (this must be less than the number of cores;
         all Nehalem nodes have 8 cores)
      -  COMMON_OPT += -O1 -Kieee (-Kieee forces IEEE-compliant
         division) [2]_

   -  Edit Makefile.system to update the PGI compiler option specifying
      Nehalem architecture:

::

   --- Makefile.system     2010-01-28 15:11:08.000000000 -0500
   +++ Makefile.system.deac        2013-01-14 11:09:56.280298528 -0500
   @@ -278,9 +278,9 @@

    ifeq ($(C_COMPILER), PGI)
    ifdef BINARY64
   -CCOMMON_OPT += -tp p7-64
   +CCOMMON_OPT += -tp nehalem-64
    else
   -CCOMMON_OPT += -tp p7
   +CCOMMON_OPT += -tp nehalem
    endif
    endif

   @@ -384,11 +384,11 @@
    COMMON_PROF +=  -DPGICOMPILER
    ifdef BINARY64
    ifdef INTERFACE64
   -FCOMMON_OPT += -i8
   +FCOMMON_OPT += -i4
    endif
   -FCOMMON_OPT += -tp p7-64
   +FCOMMON_OPT += -tp nehalem-64
    else
   -FCOMMON_OPT += -tp p7
   +FCOMMON_OPT += -tp nehalem
    endif
    ifdef USE_OPENMP
    FCOMMON_OPT += -mp

-  VASP

   -  remove "-i8" option everywhere
   -  cannot use -O2 in main vasp;
   -  There are warning messages from GotoBLAS2 tests: "Warning:
      ieee_inexact signalling". These are due to the use of the FORTRAN
      STOP statements. See
      http://www.pgroup.com/userforum/viewtopic.php?p=9571&sid=965eae24c055f3272a3167a8e0b13ab8
      `The
      fix <http://www.pgroup.com/userforum/viewtopic.php?t=2971&sid=b52789b7de53e224d5db0ab0e35aa2a5>`__
      is to set an environment variable at run time: NO_STOP_MESSAGE=1

References
==========

.. raw:: html

   <references/>

.. [1]
   `VASP Support Forum - stack size
   issue <http://cms.mpi.univie.ac.at/vasp-forum/forum_viewtopic.php?3.12119>`__

.. [2]
   `IEEE Standard for Floating-Point Arithmetic (IEEE
   754) <http://en.wikipedia.org/wiki/IEEE_floating_point>`__
