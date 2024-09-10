.. _sec.hardware:

===========================
Cluster Resource Overview
===========================

.. contents::
   :depth: 3
..

.. _sec.hardware.physical:

Physical Hardware Specifications
================================

.. _sec.hardware.physical.all:

Overall Information
-------------------

*  :ref:`Compute Nodes<sec.hardware.physical.compute>`: 83 - 4176 Cores, 33.5TB RAM
*  :ref:`GPU Nodes<sec.hardware.physical.gpu>`: 7 - 32 GPU Cards, 192,512 CUDA cores, 448 Cores, 5.3TB RAM
*  :ref:`Persistent Storage<sec.hardware.physical.storage>`: 287 TB
*  :ref:`Login Nodes<sec.hardware.physical.login>`: 3 - 144 Cores, 1.6TB RAM

.. _sec.hardware.physical.compute:

Compute Nodes
-------------

*  21 - **Penguin Computing Altus Nodes** - 1,344 cores, 16.50TB RAM total:

	* 4 - Zen4 Nodes with 64 cores, 2.3TB RAM, 1.8TB Scratch
	* 17 - Zen4 Nodes with 64 Cores, 678GB RAM, 1.8TB Scratch

*  62 - **Cisco UCS B200M5 Nodes**  - 2,832 cores, 17TB RAM total:
   
	* 36 - Cascade Lake Blades with 44 cores -- 192GB RAM, 425GB Scratch
	* 26 - Cascade Lake Blades with 48 cores -- 192GB RAM, 425GB Scratch

.. _sec.hardware.physical.gpu:

GPU Nodes
---------

For more in-depth GPU information, see the :ref:`Cluster GPU Overview<sec.cluster-gpu>` page, or feel free to contact the HPC Team.

*  2 - Penguin Computing Altus (64 cores):
	*  4 -  ** A100 80GB** GPU Cards
	*  6,190 CUDA cores per card (24,768 per node)
	*  768GB RAM
	*  1.8TB Scratch 
*  2 - Penguin Computing Altus (64 cores):
	*  4 - ** A100 40GB** GPU Cards
	*  6,190 CUDA cores per card (24,768 per node)
	*  1TB RAM
	*  1.8TB Scratch 
*  1 - Penguin Computing Altus (64 cores):
	*  4 - ** V100 32GB** GPU Cards
	*  5,120 CUDA cores per card (20,480 per node)
	*  1TB RAM
	*  1.8TB Scratch 
*  1 - **UCS C480 Node (64 cores)**:
	*  6 - **V100** GPU cards
	*  5,120 CUDA cores per card (30,720 per node)
	*  768 GB RAM
        *  932GB Scratch
*  1 - **UCS C480 Nodes (48 cores)**:
	*  6 - **V100** GPU cards   
	*  5,120 CUDA cores per card (30,720 per node)
	*  188 GB RAM
        *  1.8TB Scratch

.. _sec.hardware.physical.storage:

Persistent Storage
------------------

*  **NetApp** A300 Storage Array (287TB shared via NFS):

	* `Technical Specs <https://www.netapp.com/media/19747-storage-review-netapp-a300-print.pdf>`__
	* `Hardware Datasheet <https://www.data-storage.uk/wp-content/uploads/NetApp_AFF.pdf>`__
	* `NetApp YouTube Channel <https://www.youtube.com/channel/UCraITOUxo4l3oYQBH8fofyw>`__

* Disk Layout: 52 - 3.8TB SSD

   *  Storage Efficiency includes Dedupe, Compression, and Compaction
   *  Nightly and weekly snapshots for restore
   *  Cloud backup enabled

* **Amazon** Glacier Cloud Storage (unlimited)

   *  Unlimited cloud storage with variable data expiration.
   *  *Host* of cluster archive storage

.. _sec.hardware.physical.login:

Login Nodes
-----------

   *  2 - **Penguin Computing** Altus Nodes (Newer AMD Architecture):

	* AMD Zen4 CPUs with 64 cores
	* 768GB RAM 
	* 1.8TB Scratch

   *  1 - **Cisco UCS** B200M5 Nodes (Legacy Intel Architecture):

	* Intel Cascade Lake with 16 cores
	* 120GB RAM total
        * 415GB Scratch

.. _sec.hardware.arch:

Cluster Architectural Features
==============================

.. _sec.hardware.arch.login:

Login Node Features
-------------------

*  Users connect to and interact with the cluster via **login nodes**.
*  The login nodes have the exact same software installations as the cluster **compute nodes** plus some additional interactive tools for end user environments.
*  There are three login nodes are available, 2 matching newer Penguin Computing AND Compute Nodes, and 1 matching the old Cisco UCS Intel Compute Nodes.

.. _sec.hardware.arch.compute:

Compute Nodes Features
----------------------

*  Because the DEAC Cluster is **not homogenous**, there are multiple compute nodes grouped into different categories by type.

	*  All new nodes added to the DEAC Cluster will be provided by **'Penguin Computing'**.

		*  They can be identified by their use of 'AMD' CPUs and 25G network connection.
		*  They are named 'cpu-amd-##'

	*  All 'Cisco UCS' nodes are legacy hardware, some portion of which will remain on DEAC until 2027.

		*  They can be designated by their use of 'Intel' CPUs and 10G network connection.
		*  They are named 'cpu-intel-##'.

*  Penguin Computing nodes are logically seperated from Cisco UCS nodes.

	*  Jobs will not run between cpu-amd-## and cpu-intel-## nodes by default.

*  Parallel processing jobs are strongly encouraged to request that all nodes for a job belong to a single category or processor type.

*  See `SLURM:Quick Start Guide </SLURM:Quick_Start_Guide>`__ and `SLURM:Job Script Templates </SLURM:Job_Script_Templates>`__ for examples of how to do this.

.. _sec.hardware.arch.slurm:

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

