.. _sec.slurm:

==========
Slurm Help
==========

.. contents::
   :depth: 3
..

.. _sec.slurm.documentation:

Slurm Documentation
===================

The HPC Team cannot possibly keep up with the constant slew of updates to Slurm and it's documentation. All general information about commands, operation, and use of Slurm can be found from the list of relevant pages below. Remember, always defer to SchedMD's website first for the most up to date and relevant documentation.

Official Documentation
----------------------
* The Slurm_homepage_.
* Quick_Start_User_Guide_.
* Command_Summary_ (2-page sheet).
* Slurm_docs_.
* Slurm_FAQ_.
* Slurm NEWS_ (changes in recent versions of Slurm)
* Subscribe to Slurm_mailing_lists_.
* The slurm_devel_archive_.
* Slurm_publications_ and presentations.
* Youtube `videos about Slurm <https://www.youtube.com/c/SchedMDSlurm/videos>`_.
* Slurm_tutorials_.
* Slurm_man_pages_ overview of man-pages, configuration files, and daemons.
* Slurm_bugs_ tracking system.
* Slurm_Quick_Start_ admin guide.
* `Large Cluster Administration Guide <https://slurm.schedmd.com/big_sys.html>`_ (clusters containing 1024 nodes or more).
* `Slurm Troubleshooting Guide <https://slurm.schedmd.com/troubleshoot.html>`_.
* `Slurm Elastic Computing (Cloud Bursting) <https://slurm.schedmd.com/elastic_computing.html>`_ (Google Cloud, Amazon EC2 etc.)
* `Slurm containers guide <https://slurm.schedmd.com/containers.html>`_.
* `Support for Multi-core/Multi-thread Architectures <https://slurm.schedmd.com/mc_support.html>`_.

Non-official Documentation
--------------------------
* `LLNL Slurm User Manual <https://hpc.llnl.gov/banks-jobs/running-jobs/slurm-user-manual>`_.
* `CECI Slurm FAQ <https://www.ceci-hpc.be/slurm_faq.html>`_.
* `CECI Slurm Quick Start Tutorial <https://www.ceci-hpc.be/slurm_tutorial.html>`_.
* `Comparison between SLURM and Torque (PBS) commands <https://www.sdsc.edu/~hocks/FG/PBS.slurm.html>`_ `(cached copy) <https://ftp.fysik.dtu.dk/Slurm/PBS.slurm.html>`_.
* HPC @ NIH `Building pipelines using slurm dependencies <https://hpc.nih.gov/docs/job_dependencies.html>`_.

.. _Slurm_Quick_Start: https://slurm.schedmd.com/quickstart_admin.html
.. _Quick_Start_User_Guide: https://slurm.schedmd.com/quickstart.html
.. _Slurm_homepage: https://www.schedmd.com/
.. _SchedMD: https://www.schedmd.com/
.. _Slurm_docs: https://slurm.schedmd.com/
.. _Command_Summary: https://slurm.schedmd.com/pdfs/summary.pdf
.. _Slurm_FAQ: https://slurm.schedmd.com/faq.html
.. _Slurm_download: https://slurm.schedmd.com/download.html
.. _Slurm_mailing_lists: https://lists.schedmd.com/mailman3/postorius/lists/
.. _slurm_devel_archive: https://groups.google.com/forum/#!forum/slurm-devel
.. _Slurm_publications: https://slurm.schedmd.com/publications.html
.. _Slurm_tutorials: https://slurm.schedmd.com/tutorials.html
.. _Slurm_bugs: https://bugs.schedmd.com
.. _Slurm_man_pages: https://slurm.schedmd.com/man_index.html
.. _NEWS: https://github.com/SchedMD/slurm/blob/master/NEWS
.. _Slurm_git_repo: https://github.com/SchedMD/slurm
.. _Slurm_git_commits: https://github.com/SchedMD/slurm/commits/
.. _Slurm_constraints: https://slurm.schedmd.com/sbatch.html#OPT_constraint
.. _Slurm_accounts: https://slurm.schedmd.com/sbatch.html#OPT_account



.. _sec.slurm.commands:

Most Popular User Commands
==========================

SLURM commands have many different parameters and options. The SchedMD provdied Command_Summary_ (2-page sheet) is a great sheet to reference most commands and their options. 
Below is a list commands The HPC Team believes are most relevant to DEAC Cluster users:

.. parsed-literal::

 - Queue List:       `squeue <http://slurm.schedmd.com/squeue.html>`__ [-u ]
 - Job Submission:   `sbatch <http://slurm.schedmd.com/sbatch.html>`__
 - Cluster Status:   `sinfo <_Slurm_docs/sinfo.html#OPT_node>`__ [-Nel]
 - Job deletion:     `scancel <http://slurm.schedmd.com/scancel.html>`__
 - Job status:       `squeue <http://slurm.schedmd.com/squeue.html>`__
 - Job information:  `scontrol <http://slurm.schedmd.com/scontrol.html#OPT_show>`__ show job
 - Temp job info:    `sstat <http://slurm.schedmd.com/sstat.html#OPT_jobs>`__ -j .batch
 - Job Completion:   `sacct <http://slurm.schedmd.com/sacct.html#OPT_jobs>`__ -j -l
 - Node List:        `sinfo <http://slurm.schedmd.com/sinfo.html#OPT_node>`__ -N
 - Show Reservation: `scontrol <http://slurm.schedmd.com/scontrol.html#OPT_show>`__ show reservation=
 - Fairshare Info:   `sshare <http://slurm.schedmd.com/sshare.html#OPT_accounts=>`__ [-A ] [-u ]
 - Queue Priority:   `sprio <http://slurm.schedmd.com/sprio.html>`__



.. _sec.slurm.deac:

DEAC Cluster Slurm Specifics
============================

The DEAC Cluster has a few configuration specifics that make it unique from a defacto Slurm install. They are listed below. 

.. _sec.slurm.deac.accounts:

Accounts
--------

Each research group corresponds to a shared Slurm account for tracking utilization. IE, Engineering Professor Adam Carlson would have a "carlsonGrp" Slurm account for which he and all of his sponsored researchers would utilize when submitting jobs to Slurm. The account is specified using the Slurm_accounts_ directive (**\-\-accounts=**) in a batch job submission. 

Each Slurm Account inherits it's priority from the parent department. So in this case, carlsonGrp would inherit their priority from the "egr" Slurm parent account. This is important to know because all Slurm child accounts to egr affect the overall priority for each other. Same goes for all corresponding departments

.. _sec.slurm.deac.partitions:

Partitions
----------

The DEAC Cluster has 4 primary partitions

* **large** - Jobs > 1 node, <180 days; the default partition.
* **small** - Jobs = 1 node, <1 day; receives double partition priority as large.
* **gpu** - Jobs <= 2 nodes, <28 days; only partition with GPU resources.
* **interactive** - Jobs = 1 node, <1 day; all interactive jobs run here.


.. _sec.slurm.deac.features:

Node Features
-------------

Because the DEAC Cluster is heterogeneous, we use node Features to identify differences between node types. Features can be referenced using the Slurm_constraints_ directive (**\-\-constraints=**) in a batch job submission. Valid features and constraint options are as follows:

* login: These nodes are used to submit jobs and are not assigned to any partition to execute jobs.
* amd : These nodes contain amd cores (64-core)
* zen# : This designates the revision of amd core architecture (the higher the number, the newer the architecture).
* intel : These nodes contain intel cores
* skylake : These nodes have Intel's Xeon E5 Skylake based processors (44-core UCS nodes)
* cascade : These nodes have Intel's Xeon Gold Cascade Lake based processors (44 and 48-core UCS nodes)
* rocky9 : Designates the operating system installed on the node.
* 44cores : Designates 44-cores available on the node.
* 48cores : Designates 48-cores available on the node.
* 64cores : Designates 64-cores available on the node.
* highmem : Designates high memory limit (currently 2.3TB) on the node
* gpu : Designates GPU available (suboption is: a100_80, a100_40, v100_32).


.. _sec.slurm.deac.priority:

Priority Calculation
--------------------

The Priority Calculation equation used by the DEAC Cluster for each job is as follows:

.. math::
 Priority_{\mathrm{Job}} = & ( PriorityWeight_{\mathrm{Fairshare}} * 1000 ) + \\
    & ( PriorityWeight_{\mathrm{Age}} * 3000 ) + \\
    & ( PriorityWeight_{\mathrm{Partition}} * 500 ) + \\
    & ( PriorityWeight_{\mathrm{QOS}} * 3000 ) - Factor_{\mathrm{Nice}}

The following Priority Weights are determined as follows:

* Fairshare = Based upon a leveled Department Fairshare (:math:`\mathbf{F_{\mathrm{Dept}}}`) starting value, and `adjusted by Slurm <https://slurm.schedmd.com/fair_tree.html>`_ based on monthly utilization compared to expected baseline.
* Age = Slurm assigned value based on wait time (up to 7 day max; up to 100 jobs per group simultaneously)
* Partition = DEAC partition values as follows: small=20; large=10; gpu=40; (all all others=10)
* QOS = 0 for normal QOS (default), and 10 for any high QOS (only available for :ref:`contributors<sec.sla.ul.contributing_research_groups>`).
* Nice_Factor = A way to manually adjust job importance by weight of +/-2147483645 (via --nice directive). A positive value lowers priority; only admins can assign a negative value to increase priority.

The higher the overall calculated value, the higher the priority. The most complicated aspect of this calculation is called "`leveled fairshare <https://slurm.schedmd.com/fair_tree.html>`_", where Slurm takes the standard assigned integer value and levels it on a scale of 0 to 1. In the following example, we'll use a new user example (leveld fairshare of 1). If a user submits a job via their normal QOS to the large partition, the calculation is as follows:

.. math::
  Priority_{\mathrm{Job}} =  & ( 1 * 1000 ) + \\
     & ( 0 * 3000 ) + \\
     & ( 10 * 500 ) + \\
     & ( 0 * 3000 ) - 0 \\
     =  & 1500

If the user has made a contribution, and submits a job via their high QOS to the large partition, the calculation is as follows:

.. math::
  Priority_{\mathrm{Job}} = & ( 1 * 1000 ) + \\
     & ( 0 * 3000 ) + \\
     & ( 10 * 500 ) + \\
     & ( 10 * 3000 ) - 0 \\
   = & 4500

This highlights how a contributing group receives a ``three times`` increase in priority via their high QOS from the same starting point for a job submission.

If a non-contributing user has waited 7 days for their job to start (the maximum time factor), then their fairshare will have increased to the same priority as the high QOS:

.. math::
  Priority_{\mathrm{Job}} = & ( 1 * 1000 ) + \\
     & ( 1 * 3000 ) + \\
     & ( 10 * 500 ) + \\
     & ( 0 * 3000 ) - 0 \\
   = & 4500

This time-based increase helps ensure a level of balance so that non-contributing users can still have jobs run after a certain amount of wait time.

