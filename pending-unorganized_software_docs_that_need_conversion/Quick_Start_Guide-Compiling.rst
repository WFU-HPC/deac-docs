.. contents::
   :depth: 3
..

`Category:Compiling </Category:Compiling>`__\ `Category:Quick
Start </Category:Quick_Start>`__ Once you have `written your
code </Software:Text_Editors>`__, how do you run it? This article will
give an overview of every compiler available. For more details, please
see the dedicated article for each compiler.

Overview
========

Once you have picked a language, you pick one of several compilers for
that language. Regardless of compiler, you will probably have to specify
the following (there are defaults, but they may not do what you need):

#. optimization and other compilation option flags (static? threaded?
   strict IEEE arithmetic? Intel SSE extensions?)
#. links to libraries - this varies greatly
#. parallel computing - which version of MPI?
#. other environment variables - these may have to be set when the
   program is to be run, as well

A brief example -- compile a program consisting of a single source file:

| ``    $ which icc``
| ``    icc: Command not found.``
| ``    $ module load compilers/intel-2012-lp64``
| ``    $ which icc``
| ``    /deac/opt/intel/ics2012/composer_xe_2011_sp1.6.233/bin/intel64/icc``
| ``    $ icc -O3 -ipo hello.c -o hello ``
| ``    ipo: remark #11001: performing single-file optimizations``
| ``    ipo: remark #11006: generating object file /tmp/ipo_iccl60kWX.o``
| ``    ./hello ``
| ``    hello, world``

Here, we assume you understand common compilation options and flags:
``-I, -L, -l``.

Third-party Code
----------------

In general, compiling scientific software downloaded as source from
elsewhere is a complex task. No two packages are set up the same way, de
facto standards for structuring the build process are almost never
followed, and optimization options vary so much with hardware that the
softare authors' settings may not be applicable. In addition,
non-standard language features may be used. If you have some software
that needs to be compiled, please contact
`deac-help@wfu.edu <mailto:deac-help@wfu>`__ for assistance.

Defaults
========

By default, every user's environment is ready to use the GNU Compiler
Collection (GCC 4.4.6). Languages supported are:

-  C - gcc
-  C++ - g++
-  Fortran 90/95 - gfortran

Available Compilers
===================

These are the available compiler suites, listed by vendor -- links lead
to more detailed articles about using each compiler suite:

-  GNU Compiler Collection 4.4.6
-  `Intel Cluster Studio XE 2012 </Compiler:Intel_Cluster_Studio>`__
-  `Portland Group, Inc. 12.1 </Compiler:PGI_Cluster_Development_Kit>`__

Selecting A Compiler Suite
--------------------------

There is a way to manage all the environment variable settings that are
needed, including unsetting them when you are done. [1]_ This is via the
**modules** system. It provides a new command
```module`` </Quick_Start_Guide:Environment_Modules>`__ which loads the
appropriate environment.

These are the modules available for third-party compilers:

-  compilers/intel-2012-lp64 -- Intel Cluster Studio 2012 with 32-bit
   ints. N.B. this is the version you should usually use
-  compilers/intel-2012-ilp64 -- Intel Cluster Studio 2012 with 64-bit
   ints.
-  compilers/pgi-12.1 -- Portland Group
-  compilers/pgi-12.1-mpi -- Portland Group with MPI
-  compilers/pgi-12.1-mpi2 -- Portland Group with MPI2
-  compilers/pgi-12.1-mvapich -- Portland Group with MVAPICH, allowing
   use of InfiniBand

To use one of these compiler suites, type the following commandline:

``    $ ``\ ```module``\ ````\ ``load``\ ````\ ``modulename`` </Quick_Start_Guide:Environment_Modules>`__

E.g. to use Intel 2012 with 32-bit integers,
``module load compilers/intel-2012-lp64``

Selecting a Parallel Computing Library
--------------------------------------

RHEL6 comes with several MPI implementations. When compiling with GCC,
we recommend OpenMPI, which supports both Ethernet and Infiniband. To
use OpenMPI, load the appropriate module:

``    module load openmpi/1.6-gnu``

**NOTE:** This is a change as of May 22, 2012. We have had issues
getting the default openmpi from RedHat to work. So, we have built the
latest version from source. Do not use the openmpi-x86_64 module,
anymore. Also available is openmpi/1.5.5-gnu.

Note, however, that this does not set the CC or FC or F90 environment
variables. When compiling an MPI program, you should use the MPI-enabled
compilers: mpicc, mpif90. You may have to set the CC or F90 environment
variables to ``mpicc`` and ``mpif90`` manually. You may also have to do
this when compiling 3rd party software. OpenMPI should select the best
available network fabric at run time.

The Intel Cluster Studio comes with Intel's implementation of MPI, which
supports both Ethernet and `Infiniband </Infiniband>`__. Loading the
appropriate compiler suite module also sets up environment variables for
using Intel's MPI. However, you may still need to specify CC=mpicc or
F90=mpifort when compiling 3rd party software.

At this point in time (May 23, 2012), we recommend that you use Open
MPI. We have installed the latest version of Open MPI (1.6) compiled
with the installed version of Intel Cluster Studio. To use it, load the
appropriate module file:

``    module load openmpi/1.6-intel``

The Portland Group compiler suite comes with three different versions of
MPI. The cluster support staff have little experience with Portland
compilers, so please edit this article.

Recommendations
===============

We recommend the `Compiler:Intel Cluster
Studio </Compiler:Intel_Cluster_Studio>`__ with the Math Kernel Library
(MKL).

Additionally:

-  For serial multi-threaded code, use openmp (this has nothing to do
   with OpenMPI)
-  For parallel code, you **must** use `Quick Start Guide:GNU
   OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__. The MPI implementation
   bundled with the Intel Compiler Suite does not work in our
   environment.

Complication: Using the MKL means using an arcane set of compiler
options. You **must** use the `MKL Link Line
Advisor <http://software.intel.com/en-us/articles/intel-mkl-link-line-advisor>`__
to generate an appropriate set of compilation options. Please see the
`Compiler:Intel Cluster Studio </Compiler:Intel_Cluster_Studio>`__
article for details on what version of MKL to pick, etc.

Serial
------

#. Clean your environment (**important**): module purge
#. Load the Intel compiler module:
   ``module load compilers/intel-2012-lp64``

Single-node multithreaded
-------------------------

#. Use the **openmp** option when generating link line at the Link Line
   Advisor

Parallel
--------

#. Clean your environment (**important**): module purge
#. Load the OpenMPI module, which automatically loads the appropriate
   Intel Compiler module that it depends on:
   ``module load openmpi/1.6-intel``
#. DO NOT use openmp: our experience has shown that mixing MPI with
   openmp often results in programs which crash

Example
=======

Assume you have a single source file that uses FFTW3. The following may
be an example of a compilation invocation:

| ``   $ module load libs/fftw-3.3.1/gnu``
| ``   $ env | grep FFTW``
| ``   FFTW3DIR=/deac/opt/gnu-libs/fftw-3.3.1``
| ``   $ gcc -O3 -pthread -I${FFTW3DIR}/include mycode.c -L${FFTW3DIR}/lib -lfftw3_threads -lm``

Makefiles
=========

Compiling by manually typing in compile commands is inefficient. The
long commandline required for linking and including dependencies also
makes it prone to errors. Writing aliases or shell scripts to do this is
also not a good way to go.

The most maintainable way of managing the builds of your code is by
using Makefiles. [2]_ Makefiles specify objects which depend on other
objects, and rules for generating the dependents. Please see the article
in the reference for details.

References
==========

.. raw:: html

   <references/>

.. [1]
   `Quick Start Guide:Environment
   Modules </Quick_Start_Guide:Environment_Modules>`__

.. [2]
   `Quick Start Guide:Make </Quick_Start_Guide:Make>`__
