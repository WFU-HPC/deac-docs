.. contents::
   :depth: 3
..

`Category:Quick
Start </Category:Quick_Start>`__\ `Category:Compiling </Category:Compiling>`__
This quick start guide aims to provide enough information to get started
compiling with Intel MPI Library 4.0. [1]_ Compilation must be done with
Intel's compilers.

Users are recommended to use OpenMPI. Please see `Quick Start Guide:GNU
OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__.

Environment Setup
=================

There are various environment variables which need to be unset and set
based on the compiler you are using. This can be done by loading the
following `module </Quick_Start_Guide:Environment_Modules>`__:

`` $ module load compilers/intel-2012-lp64``

Running the Program
===================

Basically, to run an mpi program, you need to specify the number of
processors, which can be done by adding the following to your basic
SLURM script:

| ``   # bash``
| ``   cd $SLURM_SUBMIT_DIR``
| ``   np=$( cat $SLURM_JOB_NODELIST | wc -l )``
| ``   mpirun -n $np ./hello_world``

or

| ``   # tcsh``
| ``   cd $SLURM_SUBMIT_DIR``
| :literal:`   set np=`cat $SLURM_JOB_NODELIST | wc -l\``
| ``   mpirun -n $np ./hello_world``

Selecting Network Fabric
------------------------

Infiniband
~~~~~~~~~~

If you want to use the `InfiniBand </InfiniBand>`__ network, you will
have to

#. request nodes from one of the InfiniBand pools
#. specify the fabric to use in mpirun

The SLURM script would have something like this:

| ``   #SBATCH --nodes=4``
| ``   #SBATCH --tasks-per-node=8``
| ``   #SBATCH --cpus-per-task=1``
| ``   #SBATCH --partition=1``
| ``   #SBATCH --switches=1``
| ``   ...``
| ``   cd $SLURM_SUBMIT_DIR``
| ``   np=$( cat $SLURM_JOB_NODELIST | wc -l )``
| ``   mpirun -genv I_MPI_FABRICS shm:ofa -n $np ./hello_world``

The "-genv I_MPI_FABRICS shm:ofa" option says:

-  use **shm** (shared memory) for intra-node communications
-  use **ofa** (Open Fabrics Alliance -- InfiniBand) for inter-node
   communications

Ethernet
~~~~~~~~

To use Ethernet, specify "**tcp**" instead of "**ofa**", or you can just
use the plain invocation as in the prior example and mpirun will figure
out the appropriate fabric to use. If the plain invocation without a
fabric specification fails, add an explicit fabric specification.

| ``   #SBATCH --nodes=4``
| ``   #SBATCH --tasks-per-node=8``
| ``   #SBATCH --cpus-per-task=1``
| ``   #SBATCH --constraints="ethernet"``
| ``   ...``
| ``   cd $SLURM_SUBMIT_DIR``
| ``   np=$( cat $SLURM_JOB_NODELIST | wc -l )``
| ``    mpirun -genv I_MPI_FABRICS shm:tcp -n $np ./hello_world``

Further Reading
===============

-  `Intel MPI for Linux Getting Started
   Guide </File:Intel_MPI_for_Linux_Getting_Started.pdf>`__ (PDF)
-  `Intel MPI for Linux Reference
   Manual </File:Intel_MPI_Reference_Manual.pdf>`__ (PDF)

See Also
========

-  `Quick Start Guide:GNU OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__
-  `Quick Start Guide:GNU MPICH </Quick_Start_Guide:GNU_MPICH>`__

References
==========

.. raw:: html

   <references/>

.. [1]
   `Intel MPI Library
   website <http://software.intel.com/en-us/articles/intel-mpi-library/>`__
