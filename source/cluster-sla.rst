.. _sec.sla:

====================================
DEAC Cluster Service Level Agreement
====================================

The Wake Forest University (WFU) Distributed Environment for Academic Computing (DEAC) Cluster is a continually evolving resource, undergoing constant changes and including hardware and software upgrades annually. To help keep pace with that evolution, the HPC Team has written several guidelines that will help users stay informed of operational standards while utilizing the DEAC Cluster. These guidelines will be updated annually, and form the "DEAC Cluster Service Level Agreement (SLA);" which supersedes any legacy rules and/or guidelines concerning the DEAC Cluster that may have been previously published and are not contained within. 

This SLA seeks to further enhance and support the mission of the DEAC Cluster, which is to provide stable, robust, and accessible computational resources that allow the education and research communities to focus on their primary missions. All students and faculty in the WFU Undergraduate School and Graduate School of Arts and Sciences will continue to have free baseline access to the DEAC Cluster. This SLA defines how the Information Systems (IS) HPC Team makes allocation of those resources as fair as possible for an ever evolving, and growing, user base. Relevant to fair access, this SLA seeks to clearly define the method for which users can contribute funds in support of larger anticipated workloads; as well as most how those contributions, and their benefits, are weighed alongside total monetary investment into the DEAC Cluster.

.. contents::
   :depth: 4
..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.ua:
User Agreement
==============

.. _sec.sla.ua.account_eligibility:
Account Eligibility and Sponsorhip
----------------------------------
**Usage of the DEAC Cluster for research and instructional activities is provided at NO COST to WFU Undergraduate College and Graduate School of Arts and Sciences (WFU UC/GSAS) as part of the centralized services provided by Information Systems.**

* To access the DEAC Cluster, students, faculty and staff must formally request access from the HPC Team, either via email to `deac-help@wfu.edu <mailto:deac-help@wfu.edu>`_ or ticket submission to the HPC Team from `help.wfu.edu <https://help.wfu.edu>`_.
* Students must have a Faculty sponsor who approves their account request. This sponsorship is required for research and instructional usage of the DEAC Cluster. Faculty sponsors take responsibility for their approved users’ actions on the cluster. 
* Classroom instructors are asked to submit all student account requests one week in advance of required use; requests should be made in a singular email to `deac-help@wfu.edu <mailto:deac-help@wfu.edu>`_, containing the full names and email addresses of all students that will require login.
* It is assumed that instructional usage of the DEAC Cluster is limited for that semester only. Any granted classroom access, created files, or related content may be removed 1-year after the semester ends.
* Non-WFU parties are allowed access to the DEAC Cluster for research collaborations. The sponsoring research must request creation of a `guest account <https://help.wfu.edu/support/catalog/items/64>`_ for their collaborator and complete the guest account request process accordingly. If access is required beyond the original request’s term, a guest account `extension <https://help.wfu.edu/support/catalog/items/63>`_ must be requested.
* `Students <https://help.wfu.edu/support/catalog/items/127>`_, `faculty or staff <https://help.wfu.edu/support/catalog/items/60>`_ may have their WFU account extended after leaving the University in order to continue research as an external collaborator with a currently employed researcher on the DEAC Cluster. The research sponsor must make a formal request via help.wfu.edu for an account extension for the external collaborator’s account. Account extensions may be requested for up to one year. If the collaboration continues beyond that year, the request must be made again before the term ends.

**Usage of the DEAC Cluster by WFU affiliated parties outside of the WFU UC/GSAS, such as the School of Medicine, is provided only in a PAID USAGE format. See :ref:`sec.su.chargebacks` for more information on how usage payments are calculated and made.**

.. _sec.sla.ua.acceptable_use:
Acceptable Use
--------------
Access to and use of DEAC Cluster resources is permitted for academic research and instructional activity only. The list of usage regulations below is not all encompassing; it is provided in an effort to promote awareness of acceptable use of the DEAC Cluster, and to ensure that the DEAC Cluster is used in an efficient, ethical, and lawful manner. If any user is unsure whether their usage, discovered actions, or observed behavior is acceptable on the DEAC Cluster, they should contact the HPC Team without hesitation. 

Violation of any of the following usage regulations below may result in a variety of actions including, but not limited to: Suspension of DEAC Cluster account, investigation by Information Systems Information Security (InfoSec), and appropriate legal action where warranted. Relevant Federal law, North Carolina state laws, and Wake Forest University rules and regulations supersede any potential action in cases of conflict. 

#. Users must :ref:`acknowledge the DEAC Cluster<acknowledging>` for all findings, publications, manuscripts, posters, and/or oral presentations that result directly or indirectly from the use of its resources.
#. All users should adhere to the Information Systems `Policy on Responsible and Ethical Use of Computing Resources <https://docs.google.com/document/d/1ERgJ0aIBqTr9UQr6Vy6dNvb0nsKyGOZi2p1_MTZl9YA/edit?usp=sharing>`_ while operating on the DEAC Cluster. Students are also governed by the Wake Forest University `Code of Conduct <https://studentconduct.wfu.edu/undergraduate-student-handbook/>`_ while using the DEAC Cluster.
#. Use of DEAC Cluster resources for unauthorized commercial activities, for personal gain, cryptocurrency mining, or any illegal activities is prohibited.
#. DEAC Cluster accounts are to be used only for the purpose for which they are authorized and are not to be used for non-DEAC Cluster related activities. 
#. DEAC Cluster users should adhere to the defined usage limitations as provided in the :ref:`Fairshare<sec.sla.fs>` and :ref:`Limitations<sec.sla.ul>`.
#. Users must adhere to the terms provided in the :ref:`Storage and Data Management Section<sec.sla.sdm>`.
#. Electronic mail notifications sent from the DEAC Cluster are for authorized use only. Notifications sent to recipients other than themselves or users within their research group should only be done so with written consent. Fraudulent, harassing, or obscene messages and/or materials shall not be sent from or stored on the DEAC Cluster.
#. The DEAC Cluster is not intended for classified projects or data. The processing and storage of classified information is strictly prohibited.
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
------------------------
Access to the DEAC Cluster is provided via Head Nodes. These head nodes are not designed nor intended to bear full computational workloads. Users must be cognizant that Head Nodes are shared resources in which user access is required to utilize DEAC Cluster resources. User resource consumption is **limited to 2 cores and 16GB of memory** while operating on the Head Nodes; if more resources are needed, those operations should be conducted via an interactive job through the DEAC Cluster’s scheduler. In addition to following guidelines of :ref:`Acceptable Use<sec.sla.ua.acceptable_use>`, the following list of acceptable Head Node usage below is intended to be all encompassing; any activity occurring from a Head Node not listed below is subject to termination by the HPC Team without prior notification. 

#. *Editing Files* - As the primary access point to all research data, scripts, and results, it is expected that users will commonly view, edit, and manipulate their files from the Head Nodes. Use of built-in editing tools like vim, nano, emacs, nedit, as well as use of third party tools such as Visual Studio Code are recommended.
#. *Data Transfer* - The Head Nodes can be used to migrate data to and from DEAC Cluster storage. Whenever possible, data should be directly downloaded to head nodes from the internet via built-in commands like sftp, wget, or curl; if not possible, use of approved third party tools such as Visual Studio Code, WinSCP, and FileZilla can be used to move data to a user’s appropriate research storage path. 
#. *Monitoring Jobs* - Users can monitor scheduler queues, their running processes, and job results from the head nodes. While users can monitor other users within the scheduler queue, regular monitoring of any user beyond their research group is not recommended. 
#. *Compiling Software* - Users can use head nodes to compile software within the above stated resource limits, so long as it completes in under 8 hours.
#. *Job Testing* - Prior to submitting jobs to the DEAC Cluster’s scheduler queue, it is assumed that all jobs are tested to ensure they run as expected. Processes under the above stated resource limits can be run via command-line directly on the Head Node for a maximum of 30 minutes. 
#. *Job Submission* - All jobs submitted to the DEAC Cluster’s scheduler are done so from the Head Nodes.

.. _sec.sla.ua.job_cancellation:
Job Cancellation
----------------
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
Storage and Data Management
===========================

.. _sec.sla.sdm.storage_access:
Storage Access
--------------
Only approved DEAC Cluster users can store data on DEAC Cluster storage; specifically, this includes active research paths, user home directories, and cloud archives.
* Researchers eligible to access the DEAC Cluster at no cost as defined in the :ref:`Account Eligibility Section<_ua.account_eligibility>` are provided access to DEAC Cluster research storage by default.
* Researchers eligible to use the DEAC Cluster through chargeback-based access are not provided storage beyond a simple home directory (for usage as defined in :ref:`Permitted Data<sec.sla.sdm.permitted_data-homedir>`).
    * Some researchers may have access to storage that is not maintained by the HPC Team, but configured for access through a special administrative agreement. 
    * Those researchers are expected to follow storage and data guidelines as defined in both this document AND the 3rd party administrators of their storage system. 
    * Access to 3rd party storage is not guaranteed by the HPC Team; availability and performance are fully under 3rd party administrator control.
    * Chargeback-based researchers may be allowed to purchase research storage in order house data on the DEAC Cluster. See :ref:`Storage Sub Service-Units<su.ssu_types.storage>` for details.
* Collaborators and researchers from outside of Wake Forest University will have their storage access, requests and requirements reviewed on a case-by-case basis.

Network and system firewalls will prevent unauthorized user access to DEAC Cluster research storage, while file system settings and permissions will limit research groups to only accessing their group’s data. These settings are managed and maintained by the HPC Team. By default, only the research groups working on the DEAC Cluster will have access to their relevant data. Research groups may include PIs, Co-PIs, Senior Personnel, Collaborators, post docs, graduate students, undergraduate students, staff, and approved sponsored guest accounts. 

.. _sec.sla.sdm.storage_quotas:
Storage Quotas
--------------
Storage quotas are utilized on DEAC Cluster research storage paths to prevent unexpected and accidental growth of filesystems. The following quotas are defined, configured, and implemented by the HPC Team:

* Reynolda Campus researchers and departments are provided quotas for research paths starting at 1TB. 
    * These quotas can be increased after an explicit request for additional space is made, and the need identified by the HPC Team. 
* **Expansion of data quotas are allowed at no cost up to 2TB per researcher, 10TB per research group, or 20TB per department, so long as sum totals fit within these limits.**
* Any research group, department use, or funded projects requiring an increase above these default quota limits must be paid for through a Service Unit purchase as outlined in the :ref:`Service Unit Section<su>`.

.. _sec.sla.sdm.data_ownership:
Data Ownership
--------------
All users of The DEAC Cluster will be responsible for abiding to these data management guidelines as it relates to their own research. All users must agree to these guidelines before being granted access to the DEAC Cluster as part of the account creation process. Any users found in violation of these guidelines, or repeatedly attempting to access data that is not relevant to their research, will be considered acting in violation of the :ref:`User Agreement Section's terms for Acceptable Use<sec.sla.ua.acceptable_use>`.

Researchers should be good stewards of their data – this includes keeping only that which is actively relevant on DEAC Cluster research storage. Research group advisors are ultimately responsible for the oversight of their research storage path. In the event of a departure, the following ownership changes will occur:

* Should any researcher leave WFU with data still residing on the DEAC Cluster, the associated research group advisor will take ownership of the data and can work with the HPC Team to maintain the data appropriately. 
* If a research group advisor leaves WFU and data ownership/lifecycle is not pre-determined during the exit process, the responsibility will be deferred solely to the HPC Team who will work with departments and/or collaborators to determine data retention.
As researchers leave the University, it does NOT trigger automatic archival of research data. Data is left in place for new data owners and research groups to continue using unless direction otherwise is explicitly provided during the exit process.

.. _sec.sla.sdm.permitted_data:
Permitted Data
--------------
The expected data and metadata to be collected or produced on the DEAC Cluster includes software, execution code, and the electronic data produced. Electronic data will be stored on the DEAC Cluster, following Information Systems (IS) and High Performance Computing (HPC) Team best practices and `security policies <https://docs.google.com/document/d/12aIqNnLtFac-ZUeagpYxnTmGNJsJQCxHLow8n8kcntI/edit?usp=sharing>`_. 

DEAC Cluster storage is located on high performance, enterprise hardware that is capable of supporting HPC workloads; therefore, it is very expensive and extremely limited. For these reasons, researchers are expected to adhere strictly to permitted data guidance for the following data paths: 

.. _sec.sla.sdm.permitted_data-homedir:
#. Home Directories
Home directories are not intended to be intensely used storage locations. This is because the /home path is a vital storage location for functionality on the DEAC Cluster. If /home runs out of space, no user will be able to login to the DEAC Cluster and job executions will fail. Any user seeking to use /home for purposes other than listed below, MUST contact the HPC Team before doing so:

* Software configuration files
* User settings and SSH Keys
* Simple scripts and project notes, 
* Pre-approved special binary compilations. 

.. _sec.sla.sdm.permitted_data-researchdir:
#. Research Paths
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
#. Scratch Paths
A temporary file system location is created for every job submitted to the DEAC Cluster’s scheduler, located at /scratch/$jobid. This path is not shared between compute nodes and is intended for local copies of active data in order to reduce network traffic during computational cycles. This path should always be used when a job generates lots of I/O, and/or when lots of temporary data is generated for a job (up to 480GB). When this path is used, any relevant data wishing to be kept *must* be moved out by the data owner prior to job completion or it will be deleted automatically. If a job fails and data cannot be moved out as a result, that data will still be deleted automatically.

.. _sec.sla.sdm.non_permitted_data:
Non-Permitted Data
------------------
**Under no circumstances are the following data types allowed on the DEAC Cluster:**

* Classified and compartmentalized data
    * DEAC is not accredited to support classified data or projects.
* Data requiring HIPAA compliance
    * DEAC is not a HIPAA compliant system.
* Non-DEAC Research data
    * DEAC Cluster storage is intended for support of research conducted on the DEAC Cluster ONLY
* Secondary copies
    * Do not create unnecessary, secondary “backup” copies of data.
* Personal data

Any user found to not be following these guidelines will be warned and made to have that data removed within one week. After this initial warning, further incidents will be found in violation of the ref:`User Agreement Section's terms for Acceptable Use<sec.sla.ua.acceptable_use>`.

.. _sec.sla.sdm.data_backup:
Data Backup
-----------
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
----------------------------
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
-------------------------
Generally speaking, all users of the DEAC Cluster should comply with the NSF Proposal and Award Policy and Procedures Guide (PAPPG) `policy <https://www.nsf.gov/pubs/policydocs/pappg20_1/pappg_11.jsp#XID4>`_ on the dissemination and sharing of research results. Researcher advisors shall publish the findings from their research group projects as soon and as widely as possible. Additionally, research advisors, PIs, and Co-PIs should be encouraged to publish their findings in peer-reviewed journals and, if travel allows, present results at relevant conferences. Findings on the DEAC Cluster are not expected to be proprietary so no limits on dissemination should be expected. If data that supports disseminated findings must also be shared, coordination must occur with the HPC Team to make data accessible to individuals in the scientific community. 

All dissemination and shared findings should reference the DEAC Cluster in accordance with the :ref:`User Agreement Section's first term for Acceptable Use<sec.sla.ua.acceptable_use>`.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.su:
Service Unit
============

.. _sec.sla.su.purpose_applicability:
Purpose and Applicability
-------------------------

.. _sec.sla.su.contributions:
SU Contributions
----------------

.. _sec.sla.su.chargebacks:
SU Chargebacks
--------------

.. _sec.sla.su.ssu_types:
Service Sub-Unit Types
----------------------

.. _sec.sla.su.ssu_types.compute:
#. Compute Service Sub-Unit

.. _sec.sla.su.ssu_types.gpu:
#. GPU Service Sub-Unit

.. _sec.sla.su.ssu_types.storage:
#. Storage Service Sub-Unit

.. _sec.sla.su.example_purchase:
Example SU Purchase
-------------------

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.fc:
Fairshare Calculation
=====================

.. _sec.sla.fc.investment_types:
Investment Types
----------------

.. _sec.sla.fc.investment_types.i_is:
#. Information Systems Investment (I<sub>IS</sub>)

.. _sec.sla.fc.investment_types.i_wfu:
#. WFU Provost Office Investment (I<sub>WFU</sub>)

.. _sec.sla.fc.investment_types.i_contrib:
#. Researcher of Departmental Contribution Investments (I<sub>contrib</sub>)

.. _sec.sla.fc.assigned_fairshare_value:
Assigned Fairshare Value
------------------------
aka (F<sub>final</sub>)

.. _sec.sla.fc.expected_utilization:
Expected Utilization
--------------------
aka U<sub>final</sub>

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.sla.ul:
Usage Limitations
=================

.. _sec.sla.ul.baseline_research_groups:
Baseline Research Groups
------------------------

.. _sec.sla.ul.contributing_research_groups:
Contributing Research Groups
----------------------------

.. _sec.sla.ul.class_groups:
Class Groups
------------

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

