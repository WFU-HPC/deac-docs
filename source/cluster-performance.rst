==========================
Benchmarks and Performance
==========================

.. contents::
   :depth: 3
..


* Performance measurements of the DEAC-Cluster system are displayed on this page.
* Several benchmark numbers were obtained from different applications from different research groups and from the HPL Top500 benchmark.

High Performance Linpack
========================

**General Notes of this benchmark:**

:\* HPL is the `Top500 <http://www.top500.org>`__ benchmark for all
clusters.

:\* The program was utilized to benchmark the Peak Performance for the
DEAC cluster.

:\* For the Basic Linear Algebra Subroutine libraries,
`ATLAS <http://math-atlas.sourceforge.net/>`__ was built to be tuned for
the BladeCenter and UCS blades.

:\* The module openmpi/1.6-intel was used for spawning multi-processes

**UCS on HPL**

:\* HPL was launched to utilize all available UCS blades (448 cores)

::\* Chassis 2, 8 blades

::\* Chassis 3, 7 blades (1 bad blade)

::\* Chassis 4, 8 blades

::\* Chassis 5, 5 blades

:\* Plot below shows peak performance in GFLOPs as the Matrix of size N
increases.

:\* Top peak performance reached = **3.32 Tera-FLOPS**

   File:UCS_HPL.png

::

    Note: At N=300K, HPL was launched to only 27 UCS blades, 1 blade went down during Shutdown week. 

**IBM on HPL**

:\* IBM was launched to utilize all BladeCenter Chassis types:

::\* 96GB, Ethernet, 14 Blades (BC03, BC04, BC05)

::\* 96GB, Infiniband, 14 Blades (BC06, BC07, BC08)

::\* 48GB, Infiniband, 14 Blades (BC12, BC13)

::\* 16GB, Ethernet, 14 Blades (BC09, BC10, BC11

::\* 16GB, Infiniband, 14 Blades (BC01, BC02, BC14)

:\* Plot below shows peak performance in GFLOPs as the Matrix of size N
increases.

   File:IBM_HPL.png

UCS CISCO vs BC IBM
===================

:\* Data obtained from Pre-Production month period

:\* UCS blades are from FY13

:\* Users submitted identical jobs launched on UCS and BC blades

:\* Chassis 2 application benchmark

:\* Eighth-Core allocations for each blade

   File:UCS2_vs_IBM.png

::

   UCS Chassis 2 data was submitted by the Thonhauser-Group in the cluster

:\* Chassis 3 application benchmark

:\* Single-Core allocations for each blade

:\* Memory allocations displayed in read figures

   File:UCS3_vs_IBM.png

::

   UCS Chassis 3 data was submitted by the Langefeld-Group in the cluster

:\* Chassis 5 application benchmark

:\* Eight-Core allocations for each blade

   File:UCS5_vs_IBM.png

::

   UCS Chassis 5 data was submitted by the Natalie-Group in the cluster

Classification of Tweets
------------------------

:\* Plots below show results when the number of tweets to 50,000

:\* Limitations of tweets reached at the middle of 52,000

:\* The test covered performance from reading a single random file

:\* Serial runs show:

   File:UCSvsIBM_class_time_single.png
   File:UCSvsIBM_class_mem_single.png

:*The following plots demonstrate the effects of the increase of Number
of Files being read for the tweet sample size of 10,000.

:*Plots show Time of Execution and Memory Utilization.

   File:UCSvsIBM_class_10K_time_multiple.png
   File:UCSvsIBM_class_10K_mem_multiple.png

:*The following plots demonstrate the effects of the increase of Number
of Files being read for the tweet sample size of 50,000.

:*Plots show Time of Execution and Memory Utilization.

   File:UCSvsIBM_class_50K_time_multiple.png
   File:UCSvsIBM_class_50K_mem_multiple.png

UCS Chassis 2
=============

Time of Execution and Memory Allocation UCS CISCO Chassis 2 blades.

:\* Different applications used for benchmark time of execution & memory
allocations

:\* Data obtained from the Thonhauser-Group

:\* Plots below show an 8-core allocation on a single core

   File:UCS2_Perf_Apps.png
   File:UCS2_Mem_Apps.png

UCS Chassis 4
=============

:\* N/A

UCS Chassis 5
=============

Time of Execution and Memory Allocation UCS CISCO Chassis 5 blades.

:\* Different applications used for benchmark time of execution & memory
allocations

:\* Data obtained from the Natalie-Group

:\* Plots below show an 8-core allocation on a single core

   File:UCS5_Perf_Mem_Apps8.png

   -  Plots below show an 16-core allocation on a single core

   File:UCS5_Perf_Mem_Apps16.png
