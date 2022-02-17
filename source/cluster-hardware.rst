===========================
Resources: General Hardware
===========================

.. contents::
   :depth: 3
..


Cluster Architectural Features
==============================

`thumb|400px|Center|Cisco UCS with
Blades </File:UCS_B200_Chassis.jpg>`__

Head Nodes
----------

-  Users connect to and interact with the cluster via **head nodes**.

:\* These systems have the exact same software installations as the
cluster **compute nodes** plus some additional interactive tools for end
user environments.

Compute Nodes
-------------

-  Constructed of Cisco UCS Hardware, the compute nodes (where all the
   job processing takes place) are grouped by into different categories
   by type.
-  'Cisco UCS' nodes are grouped and can be designated by their fabric
   connection (backend switch) listed below.

:\* All UCS blades are connected through a singular tengig fabric.

-  Nodes can also be grouped by their chassis designation, *ucs#-##*,
   denoting sets of 8 corresponding compute nodes contained within the
   same physical chassis..
-  Parallel processing jobs are strongly encouraged to request that all
   nodes for a job belong to a single category or processor type.

:\* See `SLURM:Quick Start Guide </SLURM:Quick_Start_Guide>`__ and
`SLURM:Job Script Templates </SLURM:Job_Script_Templates>`__ for
examples of how to do this.

SLURM Node Features
-------------------

-  All compute nodes have assigned features within SLURM. These features
   can be specified as constraints to limit node selection for jobs.
   They are:

:; head : These nodes are used to submit jobs to SLURM, and are not
assigned to any partition

:; gpu : These nodes have GPU's installed and available

:; ucs#-XX : These nodes belong to UCS-2 or UCS-3 Chassis XX, e.g.
ucs3-1, ucs2-14, etc. are node properties

:; scr50gb : These nodes have 40GB of local scratch disk space to use
for jobs

:; scr250gb : These nodes have 250GB of local scratch disk space to use
for jobs

:; scr425gb : These nodes have 400GB of local scratch disk space to use
for jobs

:; haswell: These nodes have `Intel's Xeon E5
Haswell </Information:Intel_chip_architecture#Architectures>`__ based
processors (32-core UCS nodes)

:; broadwell: These nodes have `Intel's Xeon E5
Broadwell </Information:Intel_chip_architecture#Architectures>`__ based
processors (44-core UCS nodes)

:; skylake : These nodes have `Intel's Xeon E5
Skylake </Information:Intel_chip_architecture#Architectures>`__ based
processors (44-core UCS nodes)

-  A complete list of a nodes attributes can be found with the `scontrol
   command listed here </SLURM:Quick_Start_Guide#Node_information>`__

Physical Hardware Specifications
================================

Aggregate Information
---------------------

   **Nodes** or **Blades** : 89 nodes
   **Processors** : 3820 cores
   **GPU cores**: 14,336 cores
   **Memory** : 19.30TB
   **Storage** : 197.86TB

.. _compute-nodes-1:

Compute Nodes
-------------

**89 - Cisco B-series Blades - 3,820 cores, 19.30TB total**:

      08 Haswell Blades with 32 cores -- 128GB RAM
      43 Broadwell Blades with 44 cores -- 256GB RAM
      26 Skylake Blades with 44 cores -- 188GB RAM
      12 Cascade Lake Blades with 44 cores -- 188GB RAM

GPU Nodes
---------

For in-depth GPU information, see
`Information:GPU_Computing </Information:GPU_Computing>`__

**1 - UCS C240 Nodes (44 cores)**:

      2x **P100** GPU cards
      256GB RA
      3,584 CUDA cores per card
      7168 CUDA cores total!

**1 - UCS C480 Node (64 cores)**:

      6x **V100** GPU cards
      768 GB RAM
      5,120 CUDA cores per Tesla
      30,720 CUDA cores total!

**1 - UCS C480 Nodes (48 cores)**:

      6x **V100** GPU cards
      188 GB RAM
      5,120 CUDA cores per Tesla
      30,720 CUDA cores total!

**Total GPU cores - 68,608!**

Storage
-------

`thumb|300px|NetApp FAS8040 Storage Array </File:Fas8040.jpg‎>`__

**NetApp FAS8040 Storage Array** (177.86TB shared via NFS)
   `Technical
   Specs <http://www.netapp.com/us/products/storage-systems/fas8000/fas8000-tech-specs.aspx>`__
   `Hardware Datasheet </:File:FAS8000-datasheet.pdf‎>`__
   `NetApp YouTube
   Channel <https://www.youtube.com/channel/UCraITOUxo4l3oYQBH8fofyw>`__

-  24 - 800GB SSD (flash pool for fast read/write)
-  120 - 2TB SATA 7.2K

**Amazon Glacier Cloud Storage** (unlimited)

-  Unlimited cloud storage with variable data expiration.
-  *Host* of cluster archive storage

References
==========

.. raw:: html

   <references/>

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

All
compute nodes on the DEAC cluster contain INTEL CPUs. Since the DEAC
Cluster adds hardware annually, it is important to know the difference
between chip architecture found on each node. Obviously, newer nodes
house the most recent architectures. Read below to learn more about
INTEL CPUs and their release schedule.

Process-Architecture-Optimization
=================================

-  In March 2016, Intel officially said it could no longer maintain it's
   "tick-tock" model

:\* Click
[http://www.extremetech.com/extreme/225353-intel-formally-kills-its-tick-tock-approach-to-processor-development\ \|
HERE] to read an article about the new model.

-  This was first apparent in mid 2015, when Intel said the cycle was
   turning from 2 years into 2.5 years (TICK-TOCK-TOCK)

:\* Click
[http://arstechnica.com/gadgets/2015/07/intel-confirms-tick-tock-shattering-kaby-lake-processor-as-moores-law-falters/\ \|
HERE] for more information.

`600px|Process-Architecture-Optimization Model </File:Intel-PAO.png>`__

Tick-Tock Model
===============

-  Intel processor manufacturing operates on a "tick-tock" model that
   follows Moore's law

:\* Click
[http://www.intel.com/content/www/us/en/silicon-innovations/intel-tick-tock-model-general.html\ \|
HERE] to read an article about their general model.

::\* **TICK**: when die shrink occurs (ie, 22nm to 14nm)

::\* **TOCK**: new architecture on same die size

`600px|Tick-Tock Model </File:Intel-tick-tock-diagram.png>`__

Architectures
=============

A list of Intel's architecture models is as follows

-  5100 - Woodcrest (65nm Conroe) - 2-core

:\* 5300 - Clovertown (65nm Conroe) - 4-core that were 2x Woodcrest on
same die (no integration)

-  5400 - Harpertown (45nm Penryn)
-  5500 - Gainestown (45nm Nehalem)

:\* 5600 - Westmere (32nm Nehalem)

-  E5-2600 - Sandy Bridge (32nm Sandy Bridge) - Supports up to dual
   socket systems

:\* E5-2600v2 - Ivy Bridge (22nm Sandy Bridge)

-  E5-2600v3 - Haswell (22nm Haswell)

:\* E5-2600v4 - Broadwell (14nm Haswell)

-  M3-6Y30 - Skylake (14nm Skylake)

:\* (TBD) - Kabylake (14nm Skylake)

:\* (TBD) - Cannonlake (10nm Skylake)

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

