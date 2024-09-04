.. _sec.cluster_overview:

================
General Overview
================

.. contents::
   :depth: 3
..


Overview
========

There is a great deal of history that can be told about how Linux-based,
Beowulf style clusters originated and evolved over the years (starting
from 1994 [1]_ until the present). For those interested in the history
and a somewhat technical view, you can visit the historical "HOWTO"
document at:
http://ibiblio.org/pub/Linux/docs/HOWTO/archive/Beowulf-HOWTO.html

The goal of this article is simply to familiarize you with Beowulf
clusters, the relevant terminology, and to help ease you into
understanding how they work.

The Basics
==========

High Performance Computing, or HPC, is a technology that allows people to process huge amounts of data and solve large, complex, and parallel problems at very high speeds. The technology upon which HPC operates is referred to as a Cluster, or Supercomputer, which is a series of commercially available hardware, configured to efficiently work together as a singular system.

The components often found in an HPC Cluster are:
* Node : Generic term used to describe a system or server that is configured as part of a Cluster.
* Login Nodes : Server(s) that users interacte with directly in order to use the system.
* Compute Nodes : Any number of servers where the majority of computations are executed and majority of resources (CPU, RAM) are found
* GPU Nodes : Any number of servers where specific computations requiring GPU resources are executed.
* Persistent Storage : Common set of home and research directories that are available on all Cluster Nodes.
* Common system image : The operating system installed on cluster nodes, almost always Linux.
* Resource Manager : Software that tracks resources (processors, memory, node attributes) availability
* Job Scheduler : Software that allocates user's computational tasks (a "job") to be executed on requested resources based on pre-established policies
and cluster usage.
* Parallel Programming Middleware : OpenMP multi-threading capable compilers and Message Passing Interface (MPI) library support.


Clusters versus Workstations
============================

Generally, the login nodes of the cluster behave identically to any Linux workstation that you would log in to remotely using an SSH client.

*  Typical login shells, Linux commands, filesystem layout
*  Standard Red Hat Enterprise Linux compatible software available
*  Additional software repositories available (EPEL from Fedora Project, for example)

Some pretty significant differences do exist:

#.  Most, if not all, of your computational work is not done interactively on the login nodes.
#.  Users do not need to be present while majority of tasks are running.
#.  You use the computational nodes by packaging your work into "jobs".
#.  Jobs are submitted to the resource manager and job scheduler.
#.  The cluster runs those jobs on your behalf, as you, but you have no direct access to the job while it is running.


References
==========

.. raw:: html

   <references/>

.. [1]
   http://en.wikipedia.org/wiki/Beowulf_cluster
