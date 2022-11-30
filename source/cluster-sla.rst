.. _sec.sla:

####################################
DEAC Cluster Service Level Agreement
####################################

*DRAFT Last Updated: November 11, 2022*

The Wake Forest University (WFU) Distributed Environment for Academic Computing (DEAC) Cluster is a continually evolving resource, undergoing constant changes and including hardware and software upgrades annually. To help keep pace with that evolution, the HPC Team has written several guidelines that will help users stay informed of operational standards while utilizing the DEAC Cluster. These guidelines will be updated annually, and form the "DEAC Cluster Service Level Agreement (SLA);" which supersedes any legacy rules and/or guidelines concerning the DEAC Cluster that may have been previously published and are not contained within. 

This SLA seeks to further enhance and support the mission of the DEAC Cluster, which is to provide stable, robust, and accessible computational resources that allow the education and research communities to focus on their primary missions. All students and faculty in the WFU Undergraduate School and Graduate School of Arts and Sciences will continue to have free baseline access to the DEAC Cluster. This SLA defines how the Information Systems (IS) HPC Team makes allocation of those resources as fair as possible for an ever evolving, and growing, user base. Relevant to fair access, this SLA seeks to clearly define the method for which users can contribute funds in support of larger anticipated workloads; as well as how those contributions, and their benefits, are weighed alongside total monetary investment into the DEAC Cluster.

.. contents::
   :depth: 2
..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.ua:

**************
User Agreement
**************

.. _sec.sla.ua.account_eligibility:

Account Eligibility and Sponsorhip
==================================

**Usage of the DEAC Cluster for research and instructional activities is provided at NO COST to WFU Undergraduate College and Graduate School of Arts and Sciences (WFU UC/GSAS) as part of the centralized services provided by Information Systems.**

* To access the DEAC Cluster, students, faculty and staff must formally request access from the HPC Team, either via email to `deac-help@wfu.edu <mailto:deac-help@wfu.edu>`_ or ticket submission to the HPC Team from `help.wfu.edu <https://help.wfu.edu>`_.
* Students must have a Faculty sponsor who approves their account request. This sponsorship is required for research and instructional usage of the DEAC Cluster. Faculty sponsors take responsibility for their approved users’ actions on the cluster. 
* Classroom instructors are asked to submit all student account requests one week in advance of required use; requests should be made in a singular email to `deac-help@wfu.edu <mailto:deac-help@wfu.edu>`_, containing the full names and email addresses of all students that will require login.
* It is assumed that instructional usage of the DEAC Cluster is limited for that semester only. Any granted classroom access, created files, or related content may be removed 1-year after the semester ends.
* Non-WFU parties are allowed access to the DEAC Cluster for research collaborations. The sponsoring research must request creation of a `guest account <https://help.wfu.edu/support/catalog/items/64>`_ for their collaborator and complete the guest account request process accordingly. If access is required beyond the original request’s term, a guest account `extension <https://help.wfu.edu/support/catalog/items/63>`_ must be requested.
* `Students <https://help.wfu.edu/support/catalog/items/127>`_, `faculty or staff <https://help.wfu.edu/support/catalog/items/60>`_ may have their WFU account extended after leaving the University in order to continue research as an external collaborator with a currently employed researcher on the DEAC Cluster. The research sponsor must make a formal request via help.wfu.edu for an account extension for the external collaborator’s account. Account extensions may be requested for up to one year. If the collaboration continues beyond that year, the request must be made again before the term ends.

**Usage of the DEAC Cluster by WFU affiliated parties outside of the WFU UC/GSAS, such as the School of Medicine, is provided only in a PAID USAGE format. See** :ref:`sec.sla.su.chargebacks` **for more information on how usage payments are calculated and made.**

.. _sec.sla.ua.acceptable_use:

Acceptable Use
==============

Access to and use of DEAC Cluster resources is permitted for academic research and instructional activity only. The list of usage regulations below is not all encompassing; it is provided in an effort to promote awareness of acceptable use of the DEAC Cluster, and to ensure that the DEAC Cluster is used in an efficient, ethical, and lawful manner. If any user is unsure whether their usage, discovered actions, or observed behavior is acceptable on the DEAC Cluster, they should contact the HPC Team without hesitation. 

Violation of any of the following usage regulations below may result in a variety of actions including, but not limited to: Suspension of DEAC Cluster account, investigation by Information Systems Information Security (InfoSec), and appropriate legal action where warranted. Relevant Federal law, North Carolina state laws, and Wake Forest University rules and regulations supersede any potential action in cases of conflict. 

#. Users must :ref:`acknowledge the DEAC Cluster<sec.acknowledging>` for all findings, publications, manuscripts, posters, and/or oral presentations that result directly or indirectly from the use of its resources.
#. All users should adhere to the Information Systems `Policy on Responsible and Ethical Use of Computing Resources <https://docs.google.com/document/d/1ERgJ0aIBqTr9UQr6Vy6dNvb0nsKyGOZi2p1_MTZl9YA/edit?usp=sharing>`_ while operating on the DEAC Cluster. Students are also governed by the Wake Forest University `Code of Conduct <https://studentconduct.wfu.edu/undergraduate-student-handbook/>`_ while using the DEAC Cluster.
#. Use of DEAC Cluster resources for unauthorized commercial activities, for personal gain, cryptocurrency mining, or any illegal activities is prohibited.
#. DEAC Cluster accounts are to be used only for the purpose for which they are authorized and are not to be used for non-DEAC Cluster related activities. 
#. DEAC Cluster users should adhere to the defined usage limitations as provided in the :ref:`sec.sla.fs` and :ref:`sec.sla.ul`.
#. Users must adhere to the terms provided in the :ref:`Storage and Data Management Section<sec.sla.sdm>`.
#. Electronic mail notifications sent from the DEAC Cluster are for authorized use only. Notifications sent to recipients other than themselves or users within their research group should only be done so with written consent. Fraudulent, harassing, or obscene messages and/or materials shall not be sent from or stored on the DEAC Cluster.
#. The DEAC Cluster is not intended for classified government projects or data (ie, Secret, Top-Secret, FOUO, etc). The processing and storage of classified information is strictly prohibited.
#. Any activity that violates the export control laws of the United States is prohibited.
#. If using copyrighted and/or proprietary files or resources, users should provide the HPC Team proof of proper authorization. Access restriction to any such files or resources can be implemented upon request.
#. Users shall not share credentials to use their account(s) with anyone.
#. Users shall not attempt to access any research paths, data, or programs on the DEAC Cluster for which they do not have authorized access or explicit owner consent.
#. Users shall not make copies of system configuration files (e.g., /etc/passwd) for unauthorized personal use or to provide to other people/users for unauthorized uses.
#. Users shall not download, install, or run security programs or system utilities which reveal weaknesses in the security of a system, or seek detailed information about the architecture of the DEAC Cluster network configuration.
#. Users shall not intentionally engage in activities to: degrade the performance of the DEAC Cluster or any Wake Forest system; obtain resources beyond those requested and allocated; circumvent computer security measures or gain unauthorized access to systems, accounts, or resources; misuse batch queues or other resources in ways not authorized or intended; deprive an authorized user access to a resource.
#. Any discovered security vulnerabilities, misuse of resources, or violation of this agreement should be reported to the HPC Team immediately.

.. _sec.sla.ua.acceptable_head_node_use:

Acceptable Head Node Use
========================

Access to the DEAC Cluster is provided via Head Nodes. These head nodes are not designed nor intended to bear full computational workloads. Users must be cognizant that Head Nodes are shared resources in which user access is required to utilize DEAC Cluster resources. User resource consumption is **limited to 2 cores and 16GB of memory** while operating on the Head Nodes; if more resources are needed, those operations should be conducted via an interactive job through the DEAC Cluster’s scheduler. In addition to following guidelines of :ref:`Acceptable Use<sec.sla.ua.acceptable_use>`, the following list of acceptable Head Node usage below is intended to be all encompassing; any activity occurring from a Head Node not listed below is subject to termination by the HPC Team without prior notification. 

#. *Editing Files* - As the primary access point to all research data, scripts, and results, it is expected that users will commonly view, edit, and manipulate their files from the Head Nodes. Use of built-in editing tools like vim, nano, emacs, nedit, as well as use of third party tools such as Visual Studio Code are recommended.
#. *Data Transfer* - The Head Nodes can be used to migrate data to and from DEAC Cluster storage. Whenever possible, data should be directly downloaded to head nodes from the internet via built-in commands like sftp, wget, or curl; if not possible, use of approved third party tools such as Visual Studio Code, WinSCP, and FileZilla can be used to move data to a user’s appropriate research storage path. 
#. *Monitoring Jobs* - Users can monitor scheduler queues, their running processes, and job results from the head nodes. While users can monitor other users within the scheduler queue, regular monitoring of any user beyond their research group is not recommended. 
#. *Compiling Software* - Users can use head nodes to compile software within the above stated resource limits, so long as it completes in under 8 hours.
#. *Job Testing* - Prior to submitting jobs to the DEAC Cluster’s scheduler queue, it is assumed that all jobs are tested to ensure they run as expected. Processes under the above stated resource limits can be run via command-line directly on the Head Node for a maximum of 30 minutes. 
#. *Job Submission* - All jobs submitted to the DEAC Cluster’s scheduler are done so from the Head Nodes.

.. _sec.sla.ua.job_cancellation:

Job Cancellation
================

The HPC Team reserves the right to terminate running jobs, head node processes, and other operations on the DEAC Cluster without notification for the following reasons:

* Emergency node maintenance.
* Suspected unacceptable usage of resources.
* Exceeding usage limits guidelines.
* Writing data to incorrect data paths, e.g. user home directories.
* Running from incorrect working directories, e.g. user home directories.
* Observed errors, warnings, or issues.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.sdm:

***************************
Storage and Data Management
***************************

.. _sec.sla.sdm.storage_access:

Storage Access
==============

Only approved DEAC Cluster users can store data on DEAC Cluster storage; specifically, this includes active research paths, user home directories, and cloud archives.

* Researchers eligible to access the DEAC Cluster at no cost as defined in the :ref:`Account Eligibility Section<sec.sla.ua.account_eligibility>` are provided access to DEAC Cluster research storage by default.
* Researchers eligible to use the DEAC Cluster through chargeback-based access are not provided storage beyond a simple home directory (for usage as defined in :ref:`Permitted Data<sec.sla.sdm.permitted_data-homedir>`).

    * Some researchers may have access to storage that is not maintained by the HPC Team, but configured for access through a special administrative agreement. 
    * Those researchers are expected to follow storage and data guidelines as defined in both this document AND the 3rd party administrators of their storage system. 
    * Access to 3rd party storage is not guaranteed by the HPC Team; availability and performance are fully under 3rd party administrator control.
    * Chargeback-based researchers may be allowed to purchase research storage in order house data on the DEAC Cluster. See :ref:`Storage Sub Service-Units<sec.sla.su.ssu_types.storage>` for details.
* Collaborators and researchers from outside of Wake Forest University will have their storage access, requests and requirements reviewed on a case-by-case basis.

Network and system firewalls will prevent unauthorized user access to DEAC Cluster research storage, while file system settings and permissions will limit research groups to only accessing their group’s data. These settings are managed and maintained by the HPC Team. By default, only the research groups working on the DEAC Cluster will have access to their relevant data. Research groups may include PIs, Co-PIs, Senior Personnel, Collaborators, post docs, graduate students, undergraduate students, staff, and approved sponsored guest accounts. 

.. _sec.sla.sdm.storage_quotas:

Storage Quotas
==============

Storage quotas are utilized on DEAC Cluster research storage paths to prevent unexpected and accidental growth of filesystems. The following quotas are defined, configured, and implemented by the HPC Team:

* Reynolda Campus researchers and departments are provided quotas for research paths starting at 1TB. 

    * These quotas can be increased after an explicit request for additional space is made, and the need identified by the HPC Team. 

* **Expansion of data quotas are allowed at no cost up to 2TB per researcher, 10TB per research group, or 20TB per department, so long as sum totals fit within these limits.**
* Any research group, department use, or funded projects requiring an increase above these default quota limits must be paid for through a Service Unit purchase as outlined in the :ref:`Service Unit Section<sec.sla.su>`.

.. _sec.sla.sdm.data_ownership:

Data Ownership
==============

All users of The DEAC Cluster will be responsible for abiding to these data management guidelines as it relates to their own research. All users must agree to these guidelines before being granted access to the DEAC Cluster as part of the account creation process. Any users found in violation of these guidelines, or repeatedly attempting to access data that is not relevant to their research, will be considered acting in violation of the :ref:`User Agreement Section's terms for Acceptable Use<sec.sla.ua.acceptable_use>`.

Researchers should be good stewards of their data – this includes keeping only that which is actively relevant on DEAC Cluster research storage. Research group advisors are ultimately responsible for the oversight of their research storage path. In the event of a departure, the following ownership changes will occur:

* Should any researcher leave WFU with data still residing on the DEAC Cluster, the associated research group advisor will take ownership of the data and can work with the HPC Team to maintain the data appropriately. 
* If a research group advisor leaves WFU and data ownership/lifecycle is not pre-determined during the exit process, the responsibility will be deferred solely to the HPC Team who will work with departments and/or collaborators to determine data retention.

As researchers leave the University, it does NOT trigger automatic archival of research data. Data is left in place for new data owners and research groups to continue using unless direction otherwise is explicitly provided during the exit process.

.. _sec.sla.sdm.permitted_data:

Permitted Data
==============

The expected data and metadata to be collected or produced on the DEAC Cluster includes software, execution code, and the electronic data produced. Electronic data will be stored on the DEAC Cluster, following Information Systems (IS) and High Performance Computing (HPC) Team best practices and `security policies <https://docs.google.com/document/d/12aIqNnLtFac-ZUeagpYxnTmGNJsJQCxHLow8n8kcntI/edit?usp=sharing>`_. 

DEAC Cluster storage is located on high performance, enterprise hardware that is capable of supporting HPC workloads; therefore, it is very expensive and extremely limited. For these reasons, researchers are expected to adhere strictly to permitted data guidance for the following data paths: 

.. _sec.sla.sdm.permitted_data-homedir:

Home Directories
----------------

Home directories are not intended to be intensely used storage locations. This is because the /home path is a vital storage location for functionality on the DEAC Cluster. If /home runs out of space, no user will be able to login to the DEAC Cluster and job executions will fail. Any user seeking to use /home for purposes other than listed below, MUST contact the HPC Team before doing so:

* Software configuration files
* User settings and SSH Keys
* Simple scripts and project notes, 
* Pre-approved special binary compilations. 

.. _sec.sla.sdm.permitted_data-researchdir:

Research Paths
--------------

Research storage path’s are intended to be the ONLY storage location used for research related data and executed research tasks to the DEAC Cluster’s scheduler. This path while less restrictive to encourage use, should still only be used for the following:

* Source and input data that it related to and used in order to conduct research.
* Output and original data that is generated as a result of executed computations
* Compiled code and executable files that are run for research.
* Other files directly relevant to successful execution of research, including, but not limited to, the following types:

    * Source code
    * Object files
    * User libraries
    * Include files
    * Make files

.. _sec.sla.sdm.permitted_data-scratchdir:

Scratch Paths
-------------

A temporary file system location is created for every job submitted to the DEAC Cluster’s scheduler, located at /scratch/$jobid. This path is not shared between compute nodes and is intended for local copies of active data in order to reduce network traffic during computational cycles. This path should always be used when a job generates lots of I/O, and/or when lots of temporary data is generated for a job (up to 480GB). When this path is used, any relevant data wishing to be kept *must* be moved out by the data owner prior to job completion or it will be deleted automatically. If a job fails and data cannot be moved out as a result, that data will still be deleted automatically.

.. _sec.sla.sdm.non_permitted_data:

Non-Permitted Data
==================

**Under no circumstances are the following data types allowed on the DEAC Cluster:**

* **Classified and compartmentalized data**
    * DEAC is not accredited to support classified government data or projects (ie, Secret, Top-Secret, FOUO, etc).
* **Data requiring HIPAA compliance**
    * DEAC is not a HIPAA compliant system.
* **Non-DEAC Research data**
    * DEAC Cluster storage is intended for support of research conducted on the DEAC Cluster ONLY
* **Secondary copies**
    * Do not create unnecessary, secondary “backup” copies of data.
* **Personal data**

Any user found to not be following these guidelines will be warned and made to have that data removed within one week. After this initial warning, further incidents will be found in violation of the :ref:`User Agreement Section's terms for Acceptable Use<sec.sla.ua.acceptable_use>`.

.. _sec.sla.sdm.data_backup:

Data Backup
===========

In addition to a robust enterprise storage solution that is configured to prevent data loss due to hardware failure, the DEAC Cluster also employs two types of backups on research storage to prevent data loss due to human error and malicious intent:

* Snapshots
    * These nightly tasks utilize differential backups to capture data that changes day to day on research paths. 
    * Two nightly snapshots are kept for all research paths. 
    * Any file that is present and available after midnight will be captured in a snapshot and available to restore to the version present at that time.
    * A file that has been deleted or changed can be restored to a previous version up to two nights prior.
    * Research advisors can request these snapshots be turned off at their own risk.

* Offsite backups
    * Offsite backups are not available by default on DEAC Cluster research storage paths, but can be considered upon special requests made to the HPC Team.

.. _sec.sla.sdm.data_retention_archival:

Data Retentional and Archival
=============================

All relevant project data will be retained for a minimum of three years after the project conclusion or three years after public release, whichever is later. Relevant data will remain on the DEAC Cluster’s storage or be migrated off to a connected secure cloud archive. Both locations are maintained by IS, and require dual factor authentication behind a secure network firewall to prevent unauthorized access. The following process is followed for data archival:

* The HPC Team will copy data identified by the requestor to the archive where it will reside on Cloud storage. 
* Life span options for archived data are for 3 or 10 years. Exceptions can be made upon request when needed (due to grant rules, publication requirements, etc).

    * In the event of a publication, data will be retained for the period of time on a project by project basis 
    * Any research resulting in a patent will result in the data retention being extended to the life of the patent. 

* To reduce storage space, data may be compressed prior to archival.

    * A filelist of the archived data can be made viewable upon request in the parent research path to what is being archived. 
    * Descriptive file names and/or paths are recommended.

* If/When a restore is requested, the file(s) being restored may not be available for access for up to 7 days after request is made.
* As archive retention time periods near expiration, users will be contacted and data life spans will be extended as necessary. 

.. _sec.sla.sdm.dissemination_sharing:

Dissemination and Sharing
=========================

Generally speaking, all users of the DEAC Cluster should comply with the NSF Proposal and Award Policy and Procedures Guide (PAPPG) `policy <https://www.nsf.gov/pubs/policydocs/pappg20_1/pappg_11.jsp#XID4>`_ on the dissemination and sharing of research results. Researcher advisors shall publish the findings from their research group projects as soon and as widely as possible. Additionally, research advisors, PIs, and Co-PIs should be encouraged to publish their findings in peer-reviewed journals and, if travel allows, present results at relevant conferences. Findings on the DEAC Cluster are not expected to be proprietary so no limits on dissemination should be expected. If data that supports disseminated findings must also be shared, coordination must occur with the HPC Team to make data accessible to individuals in the scientific community. 

*All dissemination and shared findings* should reference the DEAC Cluster in accordance with the :ref:`first term for Acceptable Use<sec.sla.ua.acceptable_use>`.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.su:

************
Service Unit
************

.. _sec.sla.su.purpose_applicability:

Purpose and Applicability
=========================

The DEAC Cluster offers baseline services and resources in support of research carried out by members of the WFU Undergraduate College and Graduate School of Arts and Sciences. **Baseline usage of the DEAC Cluster is provided at NO COST to these members as part of the centralized services provided by Information Systems.** See the :ref:`sec.sla.fs` and :ref:`sec.sla.ul` sections for more information on baseline expected usage.

There are two scenarios where payment should be made for the use of DEAC Cluster compute resources:

#. Members of the aforementioned colleges should consider :ref:`contributing to the DEAC Cluster<sec.sla.su.contributions>` via grant or start-up funds if they plan to use compute resources for their research above baseline expectations.
#. Researchers outside of the aforementioned colleges do not have free access to the DEAC Cluster by default, and must pay for all utilized compute resources in the form of :ref:`Service Unit Chargebacks<sec.sla.su.chargebacks>`.

Contributions and/or chargebacks are made in the form of Service Units (SUs). **SUs are a DEAC Cluster service usage charge and do NOT tie specifically to hardware or software, so there are no follow-up asset tracking requirements.** SU purchases also:

* Go towards the continued maintenance, operation, and improvement of the DEAC Cluster.
* Help forecast utilization of the DEAC Cluster and prioritize support provided by the HPC Team.
* Track funding history and funding agency investments to help reinforce grant applications.

.. _sec.sla.su.contributions:

SU Contributions
================

Researchers that are planning on conducting a significant amount of their work on the DEAC Cluster should purchase Service Units (SUs) as the preferred form of contribution. Purchasing SUs offers guaranteed, high priority, and expanded utilization of DEAC Cluster compute resources; increased research job allocation priority is applied for a duration of five years, adjusted annually based on total monetary investment. See the :ref:`sec.sla.fs` and :ref:`sec.sla.ul` sections for details on the benefits of contributions.

* The HPC Team will work with any researcher, research group, department or party on a case-by-case basis to determine compute resource needs. This will determine the number of SUs to be purchased, if any.
* The most common use case for the purchase of SUs would be for budgeting within grant applications. When applying for grants, the HPC Team can work with PIs to come up with cost estimates based on forecasted research needs.
* Although not required, newly-hired faculty are encouraged to utilize start-up funds to purchase SUs if they intend to utilize significant DEAC Cluster resources for their research. The HPC Team is available to help forecast research needs and determine potential SU purchases.
* The HPC Team quantifies estimated resource usage via Service Sub-Units (SSUs) that correlate with different types of consumable compute resources on the DEAC Cluster.

    * The :ref:`sec.sla.su.ssu_types` section  provides the definition of these SSUs and how total SU numbers and costs are derived and calculated.

* A non-standard, hardware-specific contribution can be made to purchase a Research-Node.

    * A Research-Node is essentially a dedicated Head Node to be used only by the purchasing research group.
    * This hardware-based contribution method is *only offered as a last resort*, limited only to those groups who cannot conduct their work on current DEAC resources and/or setup.

.. _sec.sla.su.chargebacks:

SU Chargebacks
==============

Any researcher, research group, department or party conducting research that is not directly sponsored by members of the WFU Undergraduate College and Graduate School of Arts and Sciences (i.e. via collaboration, consortium, class, etc.) must pay for their usage of the DEAC Cluster in the form of an annual Service Unit (SU) Chargeback.

* The SU Chargeback totals will be determined by consumed DEAC Cluster compute resources.
* At the beginning of each calendar year, an invoice for total resource usage from the previous calendar year will be calculated and delivered to researchers, research group advisors, and/or department representatives.
* Payment for this invoice will be due within 60 days of receipt. If a payment is not made within this time period, DEAC Cluster access may be denied until a payment is received or a payment timeline agreement is established.
* Researchers may request SU Chargeback estimates up to once a month, based on current resource consumption rates.
* The HPC Team tracks resource consumption through a variety of tools and techniques that determine the invoiced SU Chargeback total. SUs are subdivided into Service Sub-Units (SSUs) that correlate with different types of consumable compute resources on the DEAC Cluster.

    * The :ref:`sec.sla.su.ssu_types` section  provides the definition of these SSUs and how total SU numbers and costs are derived and calculated.

.. _sec.sla.su.ssu_types:

Service Sub-Unit Types
======================

Service Units (SUs) are derived from consumption of various types of resources on the DEAC Cluster. Each usage type is tracked with a correlating Service Sub-Unit (SSU). Currently, there are three defined and tracked types: Compute, GPU, and Storage. These SSUs are defined in the subsections below, and have the following characteristics:

* Each SSU type has a base rate used to determine the corresponding requested or charged amount; see subsections below for calculations.
* Base rates per SSU type are adjusted annually based on hardware and overhead costs.
* Each SSU type is converted from a common Service Unit in order to normalize the purchase/payment process. The smallest base rate from all SSU types and the most essential SSU, the Compute Rate, is used for this conversion:

    * 1 Compute SSU = **1** Service Unit
    * 1 GPU SSU = **90** Service Units
    * 1 Storage SSU = **2250** Service Units

* The sum of all converted SSUs is used to create the overall SU request or invoice.

.. _sec.sla.su.ssu_types.compute:

Compute Service Sub-Unit
------------------------

**A Compute SSU is defined as the cost of using one (1) CPU core for one (1) hour of wall time (also referred to as 1 core-hour) with a maximum utilization of four (4) GB of RAM per core for the duration of the work task.**

* *The Base Compute Rate used to convert Compute SSUs to SUs is derived from the sum total cost of compute servers, divided by server lifespan, divided by the maximum number of core-hours in a year; plus the sum total cost of HPC Team support time available in a year, divided by number of cores-hours; plus the sum total cost of racks, PDUs, home storage and network devices divided by total core-hours in a year; plus University F&A (45.5%).*
* If a work task requests greater than 4GB of memory per core requested, then Compute Service Sub-Units will be determined by memory consumption. This is done by taking a work task's time duration (in hours), multiplying it by the amount of memory (GB) consumed, and dividing by four (4). Whichever equation yields a higher Compute SSU amount will be selected as the consumed total for the work task. The DEAC Cluster's Scheduler automatically determines if this conversion as necessary for every work task.

    * The average memory per core on the DEAC Cluster is currently 4GB; if/when it changes, so too will the memory-based Compute SSU conversion.
    * High memory utilization can create resource contention the same as CPU utilization does. If a work task requests one (1) core and all memory on a node, then it prevents other users from using that node the same as a work task that consumes all available cores would.

* See :ref:`sec.sla.su.example.compute`.

.. _sec.sla.su.ssu_types.gpu:

GPU Service Sub-Unit
--------------------

**A GPU SSU is defined as the cost of using one (1) GPU Card for one (1) hour of wall time (also referred to as 1 GPU-hour) for a work task. A GPU Card is defined as a complete, encapsulated graphics processing unit containing all relevant hardware components.**

* *The Base GPU Rate used to convert GPU SSUs to SUs is derived from the sum total cost of GPU servers and GPU cards plus University F&A (45.5%), divided by the number of usable GPU-hours (GPU cards x days x hours available) possible in a year.*
* See :ref:`sec.sla.su.example.gpu`.

.. _sec.sla.su.ssu_types.storage:

Storage Service Sub-Unit
------------------------

**A Storage Service Sub-Unit (SSU) is defined as having one (1) terabyte (TB) of dedicated DEAC Storage for one (1) month. DEAC Storage is defined as any dedicated network storage device hosting data used for research on the DEAC Cluster.**

* *The Base Storage Rate used to convert Storage SSUs to SUs is derived from the cost of a DEAC Storage disk, divided by the Terabytes per disk, divided by the 5-year disk lifespan, divided by a 1.1 data reduction ratio, plus University F&A (45.5%).*
* **Storage SSU purchases do NOT exist in perpetuity.**
* *Storage SSU purchases can be made in 12 month calendar year increments, starting every January, for a minimum of 12 months to a maximum of 60 months.*

    * If a Storage purchase occurs mid-year, purchasers will be fractionally charged for the partial year at the end of their first full annual cycle.
    * Storage purchases can be paid all up front, or annually over the course of the agreed upon time period. 

* Upon the end of the initial purchase period, the HPC Team will review usage of DEAC Storage with the purchasing party and determine next steps.

    * If a Storage purchase is not renewed, quotas will be reset to their default amount and excess data will require migration, deletion, or archival.

* See :ref:`sec.sla.su.example.storage`.

.. _sec.sla.su.example:

Example SU Purchase
===================

Below are four examples of Service Unit requests and/or chargebacks.

.. _sec.sla.su.example.compute:

Compute Request Example
-----------------------

A researcher wishes to submit a grant application and factor in the increased computational workload on DEAC. They are expected to submit 1,250 simulations over three years, and each simulation will require up to 32 cores and run for approximately 100 hours each.

* The total amount required to cover the increased computational workload is 4 million SUs.

    * 1,250 simulations x 32 cores x 100 hrs = 4 million Storage SSUs
    * 4 million Compute SSUs x 1 Compute SUs/SSU = 4 million SUs

* The total amount that should be requested within the grant application is $87,500, which can be paid up front, or annually based upon the grant timeline.

    * 4 million SUs x $0.0218/SU = $87,500

.. _sec.sla.su.example.gpu:

GPU Chargeback Example
----------------------

A non-Reynolda Campus researcher used 4 GPUs for a total of 232 hours last year on the DEAC Cluster.

* The total amount required to cover the increased computational workload is 83,520 SUs.

    * 4 GPUs x 232 hours = 928 GPU SSUs
    * 928 GPU SSUs x 90 GPU SSUs/SSU = 83,520 SUs

* The total amount that will be charged back to cover usage will be $1,820.74 which should be paid within 60 days of receiving the usage invoice.

    * 83,520 SUs x $0.0218/SU = $1,820.74

.. _sec.sla.su.example.storage:

Storage Purchase Example
------------------------

An established researcher wishes to request a 4 TB quota increase for 36 months. Because the purchase occurs mid-year, the increased storage quota would be valid for 39 months from 09/2022 - 12/2025.

* The required total purchase to meet this request is 351,000 SUs.

    * 4TB x 39 Months = 156 Storage SSUs
    * 156 Storage SSUs x 2250 Storage SSUs/SSU = 351,000 SUs

* Total cost is $7,651.80, which can be paid up front:

    * 351,000 SUs x $0.0218/SU = $7,651.80

* Alternatively the total cost can be paid annually:

    * First invoice on January 2024 is for 15-months:	$2,943.00
    * Second invoice on January 2025 is for 12-months:	$2,354.40
    * Third invoice on January 2026 is for 12-months:	$2,354.40


.. _sec.sla.su.example.multi:

Multi-type Contribution Example
-------------------------------

A newly hired researcher in the Engineering Department wishes to heavily utilize the DEAC Cluster in their 2nd year at Wake Forest. While the School of Engineering is part of the WFU Undergraduate College, and default level access to DEAC resources and the HPC Team is free; they wish to contribute to DEAC knowing their storage footprint will increase, and they also desire a higher priority for an increased workload after their second year. Starting their 2nd year, they expect to consume 1 million core hours over the next three years, and require 5TB of storage.

* The amount required to cover this request is 1,405,000 SUs.

    * 1 million Compute SSUs x 1 Compute SUs/SSU = 1M SUs
    * 180 Storage SSUs x 2250 Storage SSUs/SSU = 405,000 SUs

* Total cost is $30,629.00, which can be paid up front using available start-up funds:

    * 1,239,400 SUs x $0.0218/SU = $30,629.00



.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.fs:

*********************
Fairshare Calculation
*********************

Expected utilization of the DEAC Cluster by a research group is controlled by their **Fairshare** value. Fairshare is only a consideration that is enforced when the DEAC Cluster is *overutilized*. When overutilized, the DEAC Cluster’s scheduler tracks pending user tasks, or jobs, in a queue; the scheduler uses an assigned fairshare value from each user to assign priority to these queued jobs. In an *underutilized* cluster environment, jobs run as the resources are available (which, in most cases, is immediately). 

* Fairshare values are assigned based upon a researcher’s representative investment into the DEAC Cluster compared to the total monetary investment (Itot) over the past 5 years. 
* Contributions, investments, fairshare and expected usage are recalculated at the end of the fiscal year (June 30) and deployed to the DEAC Cluster scheduler configuration within one month of final calculations.
* There are three investment types factored into the calculation of Fairshare values:

.. math::

  I_{tot} = I_{\mathrm{IS}} + I_{\mathrm{WFU}} + I_{\mathrm{contrib}}

.. _sec.sla.fs.investment_types:

Investment Types
================

.. _sec.sla.fs.investment_types.i_is:

Information Systems Investment (:math:`\mathbf{I_{\mathrm{IS}}}`)
-----------------------------------------------------------------

As a centralized resource, the Information System department budgets annual hardware refreshes to remove/replace DEAC Cluster resources greater than 5 years old based on overall utilization. This 5-year expected lifespan of investments is why the total investment period is equal to 5 years.

* The total Information Systems investment (:math:`I_{\mathrm{IS}}`), divided by the number of all active departments utilizing the DEAC Cluster (:math:`D_{\mathrm{active}}`), is equal to the equivalent baseline contribution amount (:math:`A_{\mathrm{base}}`):

.. math::

  A_{\mathrm{base}} = \frac{\mathrm{IS}}{D_{\mathrm{active}}}

* The ratio of :math:`A_{\mathrm{base}}` to the DEAC Cluster’s total monetary investment (:math:`I_{{tot}}`) represents the baseline Fairshare (:math:`F_{\mathrm{base}}`) assigned to all researcher groups and/or departments by default.
* The :math:`F_{\mathrm{base}}` value assigned to all research groups by default is currently: **.0579.**
* **By default, a research group inherits this** :math:`F_{\mathrm{base}}` **value from their parent department and shares expected utilization with all researchers within that same department.**

.. math::

  F_{\mathrm{base}} = \frac{A_{\mathrm{base}}}{I_{tot}}

* Chargebacks from non-WFU Undergraduate College and Graduate School of Arts and Sciences (WFU UC/GSAS) departments are factored into the DEAC Cluster as an Information Systems Investment (:math:`I_{\mathrm{IS}}`) and thus the baseline Fairshare (:math:`F_{\mathrm{base}}`).

    * The DEAC Cluster is accessible to non-WFU UC/GSAS researchers if, and only if, those researchers are willing and able to pay for their consumed usage of resources in the form of a chargeback. See the :ref:`Service Unit Chargeback Section<sec.sla.su.chargebacks>` for more information on how chargebacks are calculated.

.. _sec.sla.fs.investment_types.i_wfu:

WFU Provost Office Investment (:math:`\mathbf{I_{\mathrm{WFU}}}`)
-----------------------------------------------------------------

The WFU Provost’s Office has several funding opportunities available to researchers. One such opportunity includes the Office of Research and Sponsored Programs (ORSP); which *annually matches up to $75,000 in grant fund contributions* made to the DEAC Cluster.

* The total investment provided by the WFU Provost office (:math:`I_{\mathrm{WFU}}`), divided by the number of WFU Provost supported departments utilizing the DEAC Cluster (:math:`D_{\mathrm{WFU}}`), equals an additional baseline contribution amount (:math:`A_{\mathrm{WFU}}`) for WFU Provost supported departments ONLY:

.. math::

  A_{\mathrm{WFU}} = 
  \begin{cases}
  \dfrac{I_{\mathrm{WFU}}}{D_{\mathrm{WFU}}} & \text{for WFU UC/GSAS members}, \\\\
  0 & \text{for all others}.
  \end{cases}

* The ratio of :math:`A_{\mathrm{WFU}}` to the DEAC Cluster’s total Investment (:math:`I_{{tot}}`) represents an additional fairshare increase (:math:`F_{\mathrm{WFU}}`) added only to WFU Provost supported researchers or departments:

.. math::

  F_{\mathrm{WFU}} = \frac{A_{\mathrm{WFU}}}{I_{tot}}

.. _sec.sla.fs.investment_types.i_contrib:

Researcher Contribution Investments (:math:`\mathbf{I_{\mathrm{contrib}}}`)
---------------------------------------------------------------------------

See the :ref:`Service Unit Contributions Section<sec.sla.su.contributions>` for more information on how contributed amounts (:math:`A_{\mathrm{contrib}}`) are calculated and why they are made.

* The sum total of all SU-based contributions (:math:`I_{\mathrm{contrib}}`) is factored into the total monetary investment (:math:`I_{{tot}}`) which influences the baseline fairshare (:math:`F_{\mathrm{base}}`) and additional fairshare increase (:math:`F_{\mathrm{WFU}}`) values:

.. math::

  I_{\mathrm{contrib}} = \sum{A_{\mathrm{contrib}}}

* SU Contributions (:math:`A_{\mathrm{contrib}}`) are counted solely toward the contributing research group or department’s final fairshare value (:math:`F_{\mathrm{final}}`). 

    * Department based contributions are applied on a case-by-case basis, but most commonly, would be split amongst all associated research groups in that department, in a similar manner to how :math:`A_{\mathrm{WFU}}` and :math:`F_{\mathrm{WFU}}` are calculated.
    * Research-Node purchases are NOT counted toward :math:`I_{\mathrm{contrib}}` nor :math:`A_{\mathrm{contrib}}`, as they are 1) not SU-based contributions, and 2) only benefit a specific research group rather than the entire DEAC Cluster user base. Matching ORSP funds may be counted toward :math:`I_{\mathrm{WFU}}` depending on cluster impact and benefit.

* All contributing research groups will have their final fairshare value (:math:`F_{\mathrm{final}}`) assigned independently of their parent department; granting them an expected utilization independent from that of their department’s fairshare.

    * This counts each contributing research group’s usage separately from their department, and sets their fairshare above the baseline of an entire department’s non-contributing researchers as well, vastly increasing a research group’s priority overall on the cluster.

.. _sec.sla.fs.assigned_fairshare_value:

Assigned Fairshare Value (:math:`\mathbf{F_{\mathrm{final}}}`)
==============================================================

The final Fairshare value (:math:`F_{\mathrm{final}}`) that is applied to a research group is extrapolated from the ratio sum of :math:`A_{\mathrm{base}}`, :math:`A_{\mathrm{WFU}}`, and :math:`A_{\mathrm{contrib}}`, over :math:`A_{\mathrm{base}}`; multiplied by their default applied Fairshare value (:math:`F_{\mathrm{base}}` plus :math:`F_{\mathrm{WFU}}`); this evaluation fairly multiplies default baseline fairshare values by the ratio of a research group’s investment amount to the baseline. For example, if a research group has contributed amounts double to that of the applicable baseline amount, their :math:`F_{\mathrm{final}}` should be double that of another group who has not contributed to the DEAC Cluster:

.. math::
  F_{\mathrm{final}} = \frac{ A_{\mathrm{base}} + A_{\mathrm{WFU}} + {A_{\mathrm{contrib}} }}{A_{\mathrm{base}}} \times (F_{\mathrm{base}} + F_{\mathrm{WFU}})

.. _sec.sla.fs.expected_utilization:

Expected Utilization (:math:`\mathbf{U_{\mathrm{final}}}`)
==========================================================

Expected utilization (:math:`U_{\mathrm{final}}`) percentage of DEAC Cluster resources is derived by normalizing all non-classroom assigned Fairshare values (:math:`F_{\mathrm{final}}`) to a scale of 1. By dividing a research group or department’s :math:`F_{\mathrm{final}}` by the sum total of all assigned research group and/or department Fairshare values (:math:`F_{{tot}}`), one can arrive at an expected utilization percentage (:math:`U_{\mathrm{final}}`):

.. math::

  F_{tot} = \sum{F_\mathrm{final}}

* The value of :math:`F_{tot}` is currently **1.6379**; therefore, the expected baseline usage percentage (:math:`U_{\mathrm{base}}`) of default :math:`F_{\mathrm{base}}` is equal to **3.53%** of DEAC Cluster resources (or *102,521 core hours per month*).

    * :math:`F_{tot}` is not equal to 1 due to how Abase is factored into all contributing research group’s :math:`F_{\mathrm{final}}`. Essentially, Abase is counted one extra time for every additional contributing group’s :math:`F_{\mathrm{final}}`, moving :math:`F_{tot}` further from 1 for every researcher contribution. 
    * The DEAC Cluster’s scheduler will fairly assign priority regardless of whether or not Ftot is equal to 1; normalizing fairshare to calculate Ufinal is only to help researchers understand their expected utilization and limits.

* The *higher* the assigned :math:`F_{\mathrm{final}}`, the higher the expected utilization (:math:`U_{\mathrm{final}}`); conversely, the higher the value of :math:`F_{tot}`, the lower the :math:`U_{\mathrm{final}}`.

    * As more researchers contribute, and more departments start using the DEAC Cluster, a lower overall usage percentage would be expected. Ideally, as more researchers use the DEAC cluster and usage increases, the number of overall resources available should increase to share. 

.. math:

  U_{\mathrm{final}} = \frac{F_{\mathrm{final}}}{F_{tot}}


.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.ul:

*****************
Usage Limitations
*****************

If a research group exceeds their expected utilization (Ufinal) of cluster resources, then the DEAC Cluster scheduler will temporarily adjust their assigned Fairshare Value (:math:`F_{\mathrm{final}}`) and priority in an attempt to make usage more “fair” for other research groups when overutilized. The time period that tracks resource consumption is reset on the first of each month.

Regardless of calculated :math:`U_{\mathrm{final}}` values, the DEAC Cluster exists to be utilized. Users should submit their jobs to the DEAC Cluster without hesitation if they have research to do! The nature of research means certain periods of the year are busier than others, and it is expected that researchers will exceed their Ufinal at some point. That being said, the DEAC Cluster is a shared resource and several guidelines on usage limitations should be followed by different group types when utilizing its resources. Failing to operate within these limits can result in termination of processes and be found in violation of :ref:`sec.sla.ua.acceptable_use` as outlined in the :ref:`sec.sla.ua`.

.. _sec.sla.ul.baseline_research_groups:

Baseline Research Groups
========================

Any group that is using the DEAC Cluster without contribution, or under the requirement of chargebacks for usage, are described as Baseline Research Groups. These groups are expected to adhere to the following usage limits:

* No Baseline Research Group usage of cluster resources should exceed **three times the value of** :math:`\mathbf{U_{\mathrm{base}}}` at any point during a usage period.

    * *Exceptions:* During periods of extremely low cluster utilization (e.g. <25%), a research group may exceed this limit. It is requested that groups contact the HPC Team before doing so; and, if exceeding this limit, the HPC Team reserves the right to cancel jobs if other researcher jobs are queued for greater than two hours as a result.

* No single researcher from a Baseline Research Group should exceed **three times the value of** :math:`\mathbf{U_{\mathrm{base}}}` at any point during a usage period.

    * *Exceptions:* None; a single researcher shall not consume this many DEAC cluster resources on behalf of a Baseline Research Group.
    * Note: The researcher should investigate use of job arrays to limit simultaneous running job submissions; or they can investigate making a contribution for priority limits.

* Baseline Research Groups can request reservation of resources, but **reservations must be made one week in advance and are limited to 4 compute nodes and 7 days. GPU nodes cannot be reserved.**

    * Exception: None.

.. _sec.sla.ul.contributing_research_groups:

Contributing Research Groups
============================

Research Groups who have made monetary contributions  to the DEAC Cluster should already benefit from higher priority, resulting in lower wait times when the cluster is overutilized. In addition to higher fairshare, contributing research groups are also granted the following higher usage limits:

* Contributing research groups, and individual researchers within shall not exceed **six times the value of** :math:`\mathbf{U_{\mathrm{final}}}` within a usage period.

    * *Exceptions:* During periods of extremely low cluster utilization (e.g. 10-25%), usage may exceed this limit to meet research needs. 
    * Note: Unlike Baseline Research Groups, a single researcher may consume the entirety of this usage on behalf of a contributing research group.
    * Note: If exceeding this limit, the HPC Team will ensure parallelization and best practices are utilized for such large workloads, and ensures the right to lower the priority and/or cancel queued jobs if absolutely necessary.

* Contributors can request reservation of resources when the need arises without notice. When requested, **reservations are limited to a maximum of 8 nodes and 1 month.**

    * Note: Reservations without prior notice cannot be guaranteed to have requested resources available immediately, depending on utilization.

.. _sec.sla.ul.class_groups:

Class Groups
============

By default, all classes that fall under a WFU UC/GSAS department will have nearly unrestricted access to the DEAC cluster for instructional use. Utilization by classes is considered wholly separate from that of researchers, and is the only percentage not based on the calculations provided in :ref:`sec.sla.fs`. While instructional learning with classes is a top priority, the DEAC Cluster is still a shared and regularly utilized resource by researchers. Instructors are asked to consider the following:

* **The allowed expected utilization** (:math:`\mathbf{U_{\mathrm{final}}}`) **for classes is 100%**; meaning classes are allowed to utilize 100% of DEAC Cluster resources for instruction and assignments, *only if needed.* 

    * *Exceptions:* Assignments and tasks related to instruction should run for *less than one week.*
    * Note: Historically, classroom workloads are very small, have short deadlines, and impose a non-impactful, temporary workload on DEAC Cluster resources; therefore, a high :math:`F_{\mathrm{final}}` is assigned to help ensure assignment related tasks can run as soon as possible.

* Class groups can request reservation of resources without prior notice. When requested, **class reservations are limited to a maximum of 1 week.**
 
    * Note: Depending on DEAC Cluster utilization, reservations requests made without prior notice cannot be guaranteed to have requested resources available immediately, only as they become available. 

* The HPC Team will not cancel running research tasks to help make resources available to meet classroom deadlines.

    * *Exceptions:* None; prior planning and coordination should prevent any issues making deadlines.

* Follow terms provided within the :ref:`sec.sla.ua` on how and when to make classroom account requests for instructional use.

    * *Exceptions:* The HPC Team will make every effort to enable accounts on time if requests are not made within these defined terms before usage is required.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################



