.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Quick
Start </Category:Quick_Start>`__ **LS-Dyna** is a finite element
modelling program produced by `Livermore Software Technology
Corp. <http://www.lstc.com/>`__ (LSTC) [1]_ We use the MPI-enabled
version, which is compiled with HP-MPI [2]_

Environment Setup
=================

LSTC License Control
--------------------

To run the license management utilities, the directory
``/deac/opt/LS-Dyna/lstc`` must be added to the path, according to your
login shell:

| ``    # bash -- ~/.bashrc``
| ``    export LSTC_DIR=/deac/opt/LS-Dyna/lstc``
| ``    export PATH=${LSTC_DIR}:${PATH}``

| ``    # tcsh -- ~/.cshrc``
| ``    setenv LSTC_DIR /deac/opt/LS-Dyna/lstc``
| ``    setenv PATH ${LSTC_DIR}:${PATH}``

-  And you must specify the license server in the LSTC_LICENSE_SERVER
   environment variable. This can take one of two values for the two
   separate servers we have:

   -  lansing.deac.wfu.edu
   -  lstclm.deac.wfu.edu

-  To view checked-out licenses:

| ``    $ lstc_qrun -s``
| ``                         Running Programs``
| ``    ``
| ``        User             Host          Program              Started       # procs``
| ``    -----------------------------------------------------------------------------``
| ``       user1    17166@bc02bl04.deac.wf MPPDYNA_971      Wed Apr 13 14:38    32``
| ``       user2    32456@bc11bl01.deac.wf MPPDYNA_971      Wed Apr 13 14:00    32``
| ``       user8     9484@bc12bl01.deac.wf MPPDYNA_971      Wed Apr 13 12:28    32``
| ``       user9    28827@bc12bl05.deac.wf MPPDYNA_971      Wed Apr 13 10:47    64``

-  To revoke licenses -- this does not terminate the job; a scancel must
   still be done to delete the job from the `SLURM </SLURM>`__ queue:

``    $ lstc_qkill 32456@bc11bl01.deac.wfu.edu``

Template SLURM Job Script
=========================

Please see `SLURM:LS-Dyna Script
Template </SLURM:LS-Dyna_Script_Template>`__

Benchmarks
==========

The following benchmarks were run with R4.2.1 compiled with Intel
compilers and HPMPI, with static library:
**mpp971_s_R4.2.1_Intel_linux86-64_hpmpi**

The model used was Caravan-V03c-2400k-main-shell16-120ms.k

For comparison, see `TopCrunch.org's database of
results <http://topcrunch.org/benchmark_results_search.sfe>`__. We use
the "car2car" model.

**NB:**

-  different runs may not have been on CPUs with the same clock speed.
-  all runs had exclusive use of the nodes they ran on.
-  the reason for the 4-hour difference between the slowest and fastest
   48-cpu Infiniband runs is that the fast run executed on BC12 blades.
   BC12 blades ("infiniband02") have different hardware configuration
   than the BC01/BC02 blades ("infiniband01").
-  runs with 8 or less CPUs are exclusively on a single node, i.e. they
   do not use any networking.

.. table:: Benchmark timing (runs may be repeated) - click on
double-triangle icon to sort

   ====== =================== =========== =================
   ============== ==================== ====================
   Run ID Server model no.    No. of CPUs Network fabric    Wallclock time Wallclock time (min) Wallclock time (sec)
   ====== =================== =========== =================
   ============== ==================== ====================
   488320 HS21 XM (Type 7995) 48          Infiniband        13h 11m        791                  47467
   488735 HS22 (Type 7870)    48          Infiniband        9h 14m         554                  33214
   488509 HS21 XM (Type 7995) 48          Ethernet          17h 40m        1060                 63627
   489494 HS22 (Type 7870)    24          Ethernet          17h 19m        1039                 62350
   488311 HS22 (Type 7870)    24          Infiniband        17h 08m        1028                 61700
   489000 HS21 XM (Type 7995) 64          Ethernet          14h 25m        865                  51887
   489656 HS22 (Type 7870)    72          Infiniband        6h 37m         397                  23833
   489709 HS21 XM (Type 7995) 56          Infiniband        11h 32m        692                  41491
   489674 HS21 XM (Type 7995) 96          Ethernet          12h 24m        744                  44649
   489942 HS22 (Type 7870)    72          Ethernet          9h 58m         598                  35891
   489929 HS22 (Type 7870)    96          Infiniband        5h 20m         320                  19203
   490381 HS22 (Type 7870)    64          Infiniband        7h 16m         436                  26149
   490382 HS22 (Type 7870)    96          Infiniband        5h 21m         321                  19233
   490417 HS21 XM (Type 7995) 48          Infiniband        13h 11m        791                  47465
   490445 HS22 (Type 7870)    8           Ethernet (unused) 42h 42m        2562                 153731
   489754 HS21 XM (Type 7995) 224         Ethernet          14h 35m        875                  52550
   491147 HS21 XM (Type 7995) 96          Infiniband        7h 30m         450                  27018
   490735 HS21 XM (Type 7995) 8           Ethernet (unused) 87h 18m        5238                 314290
   490731 HS22 (Type 7870)    2           Ethernet (unused) 144h 0m        8640                 518382
   490370 HS21 XM (Type 7995) 1           Ethernet (unused) 300h 9m        18009                1080564
   491321 HS22 (Type 7870)    112         Infiniband        4h 50m         290                  17397
   ====== =================== =========== =================
   ============== ==================== ====================

`center|LS-Dyna benchmark times </Image:Lsdyna_benchmarks.png>`__

References
==========

.. raw:: html

   <references/>

See Also
========

-  `SLURM:LS-Dyna Script Template </SLURM:LS-Dyna_Script_Template>`__

.. [1]
   `LSTC information page on LS-Dyna <http://www.lstc.com/lsdyna.htm>`__

.. [2]
   `HP-MPI User's
   Guide <http://docs.hp.com/en/B6060-96022/index.html>`__ (Local copy:
   File:HP-MPI_Users_Guide.pdf)
