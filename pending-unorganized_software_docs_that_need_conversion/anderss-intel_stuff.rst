========================
Intel Parallel Studio XE (REPLACE WITH ONEAPI for 2023+)
========================

Introduction
============

The Intel Parallel Studio XE (PSXE) is a software development product developed
by Intel that facilitates native code development on Windows, macOS and Linux in
C++ and Fortran for parallel computing. Parallel programming enables software
programs to take advantage of multi-core processors from Intel and other
processor vendors. The Cluster Edition consists of the following components:

* Build

    * Intel C/C++ Compiler
    * Intel Fortran Compiler
    * Intel Distribution for Python
    * Intel Math Kernel Library (MKL)
    * Intel Data Analytics Acceleration Library (DAAL)
    * Intel Integrated Performance Primitives (IPP)
    * Intel Threading Building Blocks (TBB)
    * Intel Parallel STL (PSTL)

* Analyze

    * Intel Debugger
    * Intel Advisor
    * Intel Inspector
    * Intel VTune Profiler

* Scale

    * Intel MPI Library
    * Intel Trace Analyzer and Collector (ITAC)
    * Intel Cluster Checker

General Usage
-------------

Generally speaking, scientific applications obtain enhanced performance using
the Intel toolset when running on Intel hardware. The DEAC cluster compute nodes
use several models of Intel Xeon processors, making this toolset a valuable tool
for all researchers and software developers who make use of the DEAC cluster.

For most activities, only three components of the Intel PSXE are needed:

* The Intel C and FORTRAN compilers (``icc`` and ``ifort``)
* The Intel MKL (as an alternative for SCALAPACK, FFTW, BLAS, LAPACK, etc.)
* The Intel MPI libraries and compilers (``mpiicc`` and ``mpiifort``)

The Intel MKL offers a variety of high performance library interfaces that can
be used even when using other compilers, such as the GNU C and FORTRAN
compilers. The Intel MPI library and compilers can be used to build applications
that rely on MPI parallelization, which is extremely popular in HPC
environments. However, we suggest using Open MPI over Intel MPI due to the Open
MPI's ability to access the low latency Cisco usNIC hardware that is available
on the compute nodes. In most other areas either MPI library should yield
similar performance under most conditions.


The DEAC cluster has several versions of the PSXE available to you via standard
modules; we will use the PSXE 2020 as our working example in this guide.
Individual components have been separated into standalone modules:

.. code-block:: console

    compilers/intel/2020
    libs/intel/daal/2020
    libs/intel/ipp/2020
    libs/intel/mkl/2020
    libs/intel/pstl/2020
    libs/intel/tbb/2020
    mpi/intel/2020
    utils/intel/advisor/2020
    utils/intel/clck/2020
    utils/intel/debugger/2020
    utils/intel/inspector/2020
    utils/intel/itac/2020
    utils/intel/vtune/2020

Each module will automatically set up your environment to have access to the
relevant software and libraries.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Advanced Usage: Sourcing Directly from Installation
---------------------------------------------------

The PSXE is installed cluster-wide, and is divided into a variety of
subdirectories that contain the various components and necessary scripts that
load the appropriate environment variables; these are broken down as follows.
There are two main scripts that load the majority of the PSXE components. First,

.. code-block:: console

    source $PSXE/compilers_and_libraries_2020.0.166/linux/bin/compilervars.sh intel64

which will load the compilers (C, FORTRAN, MPI), libraries (MPI, MKL, TBB, IPP,
DAAL, PSTL), and the Intel Debugger; and

.. code-block:: console

    source $PSXE/parallel_studio_xe_2020/bin/psxevars.sh

which will load everything listed at the beginning of this document. ``$PSXE`` is
assumed to be the path to the PSXE root installation directory. Only load one
file in given session; for compiling software and running with MPI, the latter
will suffice. These scripts actually load individual scripts for each component.
These can be manually loaded in order to fine-tune your shell environment as
follows,

.. code-block:: console

    # From compilervars.sh
    . $PSXE/compilers_and_libraries_2020/linux/bin/compilervars_arch.sh intel64 linux # Compilers only
    . $PSXE/compilers_and_libraries_2020/linux/mpi/intel64/bin/mpivars.sh             # MPI compilers and libs
    . $PSXE/compilers_and_libraries_2020/linux/mkl/bin/mklvars.sh intel64             # MKL
    . $PSXE/compilers_and_libraries_2020/linux/tbb/bin/tbbvars.sh intel64 linux       # TBB Library
    . $PSXE/compilers_and_libraries_2020/linux/pstl/bin/pstlvars.sh intel64           # PSTL
    . $PSXE/compilers_and_libraries_2020/linux/ipp/bin/ippvars.sh intel64 linux       # IPP Library
    . $PSXE/compilers_and_libraries_2020/linux/daal/bin/daalvars.sh intel64           # DAAL
    . $PSXE/debugger_2020/bin/debuggervars.sh intel64                                 # Debugger

    # Extra stuff from psxevars.sh
    . $PSXE/parallel_studio_xe_2020/clck_2019/bin/clckvars.sh                         # Cluster Checker
    . $PSXE/parallel_studio_xe_2020/itac_2020/bin/itacvars.sh                         # ITAC
    . $PSXE/parallel_studio_xe_2020/inspector_2020/inspxe-vars.sh quiet               # Inspector
    . $PSXE/parallel_studio_xe_2020/vtune_profiler_2020/vtune-vars.sh quiet           # VTune
    . $PSXE/parallel_studio_xe_2020/advisor_2020/advixe-vars.sh quiet                 # Advisor
    . $PSXE/intelpython3/bin/activate                                                 # Intel Python

Advanced Usage: Creating Modulefiles
------------------------------------

Modulefiles can be created directly from the above scripts using the
``createmodule.sh`` tool that comes bundled with the Environment Module package.
Run this tool on each of the above scripts (including positional arguments, if
any). The resulting outputs can be formatted to taste; see the DEAC Modulefiles
repository for examples.
