.. sec.cluster_overview:

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

In general, according to the opinion of this author, Linux-based,
Beowulf style clusters generally have the following characteristics:

:; Login Nodes ("`head nodes </Cluster:Headnodes>`__") : Server(s) that
users interactively log in to in order to use the system

:; Computational Nodes : Any number of servers that will handle the
majority of the computations

:; Pervasive storage : Common set of home and research directories that
are available on all login and computational nodes.

:; Common system image : The Linux operating system installation on the
login and computational nodes are nearly identical.

:; Parallel Programming Middleware : OpenMP multi-threading capable
compilers and Message Passing Interface (MPI) library support.

:; Resource Manager and Job Scheduler : Software that tracks resources
(processors, memory, node attributes), their availability, and schedules
computational jobs on those resources based on pre-established policies
and cluster usage.

Clusters versus Workstations
============================

Generally, the login nodes of the cluster behave identically to any
Linux workstation that you would log in to remotely using an SSH client.

-  Typical login shells, Linux commands, filesystem layout
-  Standard Red Hat Enterprise Linux software available
-  Additional software repositories available (EPEL from Fedora Project,
   for example)

Some pretty significant differences do exist:

-  Most, if not all, of your computational work is not done
   interactively on the login nodes
-  You use the computational nodes by packaging your work into "jobs".
-  Jobs are submitted to the resource manager and job scheduler.
-  The cluster runs those jobs on your behalf, as you, but you have no
   direct access to the job while it is running.

Graphical interfaces
====================

Unfortunately, most Linux Beowulf clusters don't have a graphical
desktop front-end that you can navigate. Even when they do, those
interfaces would only present you with a graphical view of the login
nodes. This limitation does not typically pose significant issues as
graphical software on clusters support the X Windowing protocol. For
clients that supports it, you can open (most) graphical software from
the login nodes on your local client. For example, you can open a
Firefox web browser that is running on the login node but displayed on
your laptop.

References
==========

.. raw:: html

   <references/>

.. [1]
   http://en.wikipedia.org/wiki/Beowulf_cluster
