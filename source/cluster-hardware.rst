.. _sec.hardware

===========================
Resources: General Hardware
===========================

.. contents::
   :depth: 3
..


Cluster Architectural Features
==============================

Login Nodes
----------

*  Users connect to and interact with the cluster via **login nodes**.

*  These systems have the exact same software installations as the cluster **compute nodes** plus some additional interactive tools for end user environments.

Compute Nodes
-------------

*  Constructed of a blend of Penguin Computing and Cisco UCS Hardware, the compute nodes (where all the job processing takes place) are grouped into different categories by type.

*  All new nodes added to the DEAC Cluster will be provided by 'Penguin Computing'. They can be identified by their use of 'AMD' CPUs and 25G network connection. They are named 'cpu-amd-##'

*  All 'Cisco UCS' nodes are legacy hardware, and can be designated by their use of 'Intel' CPUs and 10G network connection. They are named 'cpu-intel-##'.

*  Penguin Computing nodes are logically seperated from Cisco UCS nodes. Meaning jobs will not run between cpu-amd-## and cpu-intel-## nodes by default.

* Parallel processing jobs are strongly encouraged to request that all nodes for a job belong to a single category or processor type.

*  See `SLURM:Quick Start Guide </SLURM:Quick_Start_Guide>`__ and `SLURM:Job Script Templates </SLURM:Job_Script_Templates>`__ for examples of how to do this.

SLURM Node Features
-------------------

*  All compute nodes have assigned features within SLURM. These features can be specified as constraints to limit node selection for jobs. They are:

   * login: These nodes are used to submit jobs and are not assigned to any partition to execute jobs.

   * amd : These nodes contain amd cores (64-core)

   * zen# : This designates the revision of amd core architecture (the higher the number, the newer the architecture).

   * intel : These nodes contain intel cores

   * skylake : These nodes have `Intel's Xeon E5 Skylake </Information:Intel_chip_architecture#Architectures>`__ based processors (44-core UCS nodes)

   * cascade : These nodes have `Intel's Xeon Gold Cascade Lake </Information:Intel_chip_architecture#Architectures>`__ based processors (44 and 48-core UCS nodes)

   * rocky9 : Designates the operating system installed on the node.

Physical Hardware Specifications
================================

Overall Information
---------------------

   *  All Nodes : 88 nodes
   *  Processors : 5,052 cores
   *  GPU cores : 192,512 CUDA cores
   *  Memory : 40.68TB
   *  Storage : 287 TB

.. _compute-nodes-1:

Compute Nodes
-------------

*  21 - **Penguin Altus Nodes - 1,344 cores, 16.50TB RAM total**:

   *  4 Zen4 Nodes with 64 cores, 2.3TB RAM

   *  17 Zen4 Nodes with 64 Cores, 678GB RAM

* 62 - **Cisco UCS B200M5 Nodes - 2,832 cores, 17TB RAM total**:
   
   *  36 Cascade Lake Blades with 44 cores -- 192GB RAM
   
   *  26 Cascade Lake Blades with 48 cores -- 192GB RAM

GPU Nodes
---------

For in-depth GPU information, see `Information:GPU_Computing </Information:GPU_Computing>`__

*  2 - Penguin Computing Altus (64 cores):
   * 4X ** A100 80GB** GPU Cards
   * 768GB RAM
   * 6190 CUDA cores each (24768 total)
*  2 - Penguin Computing Altus (64 cores):
   * 4X ** A100 40GB** GPU Cards
   * 1.1TB RAM
   * 6190 CUDA cores each (24768 total)
*  2 - Penguin Computing Altus (64 cores):
   * 4X ** V100 32GB** GPU Cards
   * 1TB RAM
   * 5120 CUDA cores each (20480 total)
   
*  1 - **UCS C480 Node (64 cores)**:
   *  6x **V100** GPU cards
   *  768 GB RAM
   *  5,120 CUDA cores per Tesla
   *  30,720 CUDA cores total!

*  1 - **UCS C480 Nodes (48 cores)**:
   *  6x **V100** GPU cards   
   *  188 GB RAM
   *  5,120 CUDA cores per Tesla
   *  30,720 CUDA cores total!

**Total GPU cores - 280,320!**


Storage
-------

**NetApp A300 Storage Array (287TB shared via NFS)**

   *  `Technical Specs <https://www.netapp.com/media/19747-storage-review-netapp-a300-print.pdf>`__
   
   *  `Hardware Datasheet <https://www.data-storage.uk/wp-content/uploads/NetApp_AFF.pdf>`__
   
   *  `NetApp YouTube Channel <https://www.youtube.com/channel/UCraITOUxo4l3oYQBH8fofyw>`__
   
* Disk Layout: 52 - 3.8TB SSD

   *  Storage Efficiency includes Dedupe, Compression, and Compaction
   
   *  Nightly and weekly snapshots for restore

   *  Cloud backup enabled
   

**Amazon Glacier Cloud Storage (unlimited)**

   *  Unlimited cloud storage with variable data expiration.
   *  *Host* of cluster archive storage


References
==========

.. raw:: html

   <references/>

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

All compute nodes on the DEAC cluster contain INTEL CPUs. Since the DEAC
Cluster adds hardware annually, it is important to know the difference
between chip architecture found on each node. Obviously, newer nodes
house the most recent architectures. Read below to learn more about
INTEL CPUs and their release schedule.

Process-Architecture-Optimization
=================================

*  In March 2016, Intel officially said it could no longer maintain it's "tick-tock" model

   *  Click [http://www.extremetech.com/extreme/225353-intel-formally-kills-its-tick-tock-approach-to-processor-development HERE] to read an article about the new model.

*  This was first apparent in mid 2015, when Intel said the cycle was turning from 2 years into 2.5 years (TICK-TOCK-TOCK)

   *  Click [http://arstechnica.com/gadgets/2015/07/intel-confirms-tick-tock-shattering-kaby-lake-processor-as-moores-law-falters/ HERE] for more information.

`600px|Process-Architecture-Optimization Model </File:Intel-PAO.png>`__

Tick-Tock Model
===============

*  Intel processor manufacturing operates on a "tick-tock" model that follows Moore's law
   
   *  Click [http://www.intel.com/content/www/us/en/silicon-innovations/intel-tick-tock-model-general.html HERE] to read an article about their general model.

   *  **TICK**: when die shrink occurs (ie, 22nm to 14nm)

   *  **TOCK**: new architecture on same die size

`600px|Tick-Tock Model </File:Intel-tick-tock-diagram.png>`__

Architectures
=============

A list of Intel's architecture models is as follows

*  5100 - Woodcrest (65nm Conroe) - 2-core

   ** 5300 - Clovertown (65nm Conroe) - 4-core that were 2x Woodcrest on
same die (no integration)

*  5400 - Harpertown (45nm Penryn)

*  5500 - Gainestown (45nm Nehalem)

   *  5600 - Westmere (32nm Nehalem)

*  E5-2600 - Sandy Bridge (32nm Sandy Bridge) - Supports up to dual socket systems

   *  E5-2600v2 - Ivy Bridge (22nm Sandy Bridge)

*  E5-2600v3 - Haswell (22nm Haswell)

   *  E5-2600v4 - Broadwell (14nm Haswell)
   
*  M3-6Y30 - Skylake (14nm Skylake)

   *  Gold-6240R - Cascade Lake (14nm Skylake)
   
   *  (TBD) - Icelake (10nm Skylake)

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

