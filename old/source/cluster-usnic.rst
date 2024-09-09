============================
Resources: usNIC and Network
============================

.. contents::
   :depth: 3
..


**InfiniBand** is a switched fabric communications link used in
high-performance computing and enterprise data centers. Its features
include high throughput, low latency, quality of service and failover,
and it is designed to be scalable. The InfiniBand architecture
specification defines a connection between processor nodes and high
performance I/O nodes such as storage devices. [1]_ The specification is
maintained by the InfiniBand Trade Association. [2]_

Cluster Installation
====================

The cluster has eight separate pools of InfiniBand nodes, present within
**clan01**, **clan02**, **clan06**, **clan07**, **clan08**, **clan12**,
**clan13**, and **clan14**. All pools are independent of each other; see
`Cluster:Hardware_Configuration#Networking </Cluster:Hardware_Configuration#Networking>`__
for details of the hardware and capabilities.

Compiling MPI to Use Infiniband
===============================

This, as is always the case in compiling, depends on the compiler you
use.

GNU
---

-  We recommend compiling using OpenMPI, which supports both Ethernet
   and InfiniBand.

:\* To set up your environment for compiling against OpenMPI, do
``module load openmpi-x86_64``. [3]_

-  Also see `Quick Start Guide:GNU
   OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__

Intel MPI
---------

Programs compiled with Intel compilers and Intel MPI support multiple
fabrics. No separate library version needs to be used.

-  To use the Intel compiler suite, load the module for the compiler
   ``module load compilers/intel-2012-lp64``. [4]_
-  See also `Quick Start Guide:Intel
   MPI </Quick_Start_Guide:Intel_MPI>`__

Running MPI Programs on usNIC
=============================

Requesting usNIC nodes
----------------------

To request using the Infiniband (IB) connectivity in clans where
available, one must specify using the "infiniband" partition in their
`SLURM </SLURM>`__ job scripts.

``   #SBATCH --partition=usNIC``

Another important thing to note is that the separate usNIC nodes are
best used within the same fabric (ie, ucs3-##, or ucs2-##). This is to
reduce latency between nodes: one node in another fabric will add an
additional hop, increasing latency. So, in order for your job to
actually use usNIC most efficiently, you must make sure all the
processes in your job run on nodes only within the same fabric. The way
to do this is to use the constraints in your `SLURM </SLURM>`__ job
script.

For example:

| ``   #SBATCH --nodes=14``
| ``   #SBATCH --tasks-per-node=8``
| ``   #SBATCH --cpus-per-task=1``
| ``   #SBATCH --constraints=[ucs-a1a-3]``

This says that the job requires 14 nodes, 8 cores per node, and all of
the nodes must be connected by a single fabric (switches as far as SLURM
are concerned are defined within SLURM's topology configuration). A
single switch correlates as far as the job is concerned means that all
nodes are contained within the same chassis.

GNU with MVAPICH2
-----------------

-  See `Quick Start Guide:GNU
   OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__
-  The OpenMPI version of mpiexec must be used.

| ``   # bash example``
| ``   module load openmpi-x86_64``
| ``   cd $SLURM_SUBMITDIR``
| ``   np=$( cat $SLURM_JOB_NODELIST | wc -l )``
| ``   mpiexec -n $np ./my_program``

OpenMPI
-------

OpenMPI has a simple execution procedure. It will determine number of
nodes, and number of processors per node from the SLURM environment, so
you should not specify that. To run on Infiniband:

``    mpirun --mca btl ^tcp my_program --my-arguments foo bar ``

N.B. there are two hyphens in "--mca". "--mca btl ^tcp" says not to use
the tcp (ethernet) BTL component. Technically, this is not required as
OpenMPI should default to the fastest interface available (usNIC). [5]_

This execution procedure is independent of what underlying compiler is
used.

You can also specify the *usNIC* **partition**, which is temporary while
usNIC is being deployed across the cluster.

``   #SBATCH --partition=usNIC``

References
==========

.. raw:: html

   <references/>

.. [1]
   `Wikipedia article on
   InfiniBand <http://en.wikipedia.org/wiki/InfiniBand>`__

.. [2]
   `InfiniBand Trade Association (IBTA) web
   site <http://www.infinibandta.org/>`__

.. [3]

.. [4]
   `Quick Start Guide:Environment
   Modules </Quick_Start_Guide:Environment_Modules>`__

.. [5]
   `OpenMPI FAQ: TCP
   auto-disable <http://www.open-mpi.org/faq/?category=tcp#tcp-auto-disable>`__
