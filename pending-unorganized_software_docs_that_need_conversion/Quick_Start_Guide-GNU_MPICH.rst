.. contents::
   :depth: 3
..

`Category:Quick
Start </Category:Quick_Start>`__\ `Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__
NOTE: It is recommended that the OpenMPI version of mpiexec is used.
Please see
`Quick_Start_Guide:GNU_OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__.

This quick start guide aims to provide enough information to get started
compiling with the MPICH2 [1]_ and MVAPICH2 [2]_ implementations of MPI.
MPICH2 provides support for ethernet. MVAPICH2 provides support for
`InfiniBand </InfiniBand>`__.

For compiling with Intel compilers and Intel MPI, see the
`Quick_Start_Guide:Intel MPI </Quick_Start_Guide:Intel_MPI>`__.

Environment Setup
=================

The default user environment is set up for compiling and running with
**MPICH2**. *mpiexec* can be made available by loading the following
environment `Quick Start Guide:Environment
Modules </Quick_Start_Guide:Environment_Modules>`__:

`` $ module load mpich-x86_64``

OR to use the high-speed `Infiniband </Infiniband>`__ network
connection, you will need to use **MVAPICH2** and set up your
environment with the following environment `Quick Start
Guide:Environment Modules </Quick_Start_Guide:Environment_Modules>`__:

`` $ module load mvapich2-x86_64``

Running the Program
===================

Basically, run it by specifying the number of processors which you
extract from the SLURM environment:

| ``   # bash``
| ``   np=$( cat $SLURM_JOB_NODELIST | wc -l )``
| ``   mpiexec -n $np ./hello_world``

or

| ``   # tcsh``
| :literal:`   set np=`cat $SLURM_JOB_NODELIST | wc -l\``
| ``   mpiexec -n $np ./hello_world``

N.B. These use **mpiexec** rather than mpirun (as in the Intel case).

Compiling
=========

The following is an example Makefile is you need to compile a program:

::

    # MPICHDIR may already be set in the environment, but
    # set it here, anyway.
    MPICHDIR=/opt/gnu-libs/mvapich2
    MPI_HOME=$(MPICHDIR)
    CC=$(MPI_HOME)/bin/mpicc    # note the compiler is mpicc
    CXX=$(MPI_HOME)/bin/mpicxx
    FC=$(MPI_HOME)/bin/mpif77
    OPTFLAGS=-O3
    
    .PHONY: clean
    
    PROGRAMS = hello_world aloha_world
    all: $(PROGRAMS)
    
    clean:
        /bin/rm -f $(PROGRAMS)
        /bin/rm -f *.o*
    
    hello_world: hello_world.c
        $(CC) $(OPTFLAGS) -o $@ $^
        strip $@
    
    aloha_world: aloha_world.f
        $(FC) $(OPTFLAGS) -o $@ $^
        strip $@

To compile, just type:

``   $ make``

See Also
========

-  `Quick Start Guide:GNU OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__
-  `Quick Start Guide:Intel MPI </Quick_Start_Guide:Intel_MPI>`__

References
==========

.. raw:: html

   <references/>

.. [1]
   `MPICH2 website <http://www.mcs.anl.gov/research/projects/mpich2/>`__

.. [2]
   `MVAPICH2: MPI over InfiniBand, 10GigE/iWARP and RoCE
   website <http://mvapich.cse.ohio-state.edu/overview/mvapich2/>`__
