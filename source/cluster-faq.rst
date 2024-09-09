.. _sec.faq:

################################
Frequently Asked Questions (FAQ)
################################
.. contents::
   :depth: 3
..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.faq.general:

*******
General
*******

* What is a High Performance Computing (HPC) Cluster?

	* General information about HPC can be found :ref:`here<sec.cluster_overview>`.

* How is using a HPC Cluster different from a workstation?

	* Work does not run locally on your workstation, but rather remotely on servers, called "compute nodes" in a Data Center.
	* Users do not need to be present while your work is running on compute nodes.
	* Work is packaged into "jobs" that are submitted to run on compute nodes remotely.
	* The cluster runs those jobs on your behalf, as you, but you have no direct access to the job while it is running.

* What is a Core Hour?

	* A core hour hour can be defined as the use of a single CPU Core for one hour.
	* The total number of Core Hours on a cluster can be determined by multiplying the number of CPU cores by the hours in a year.

.. _sec.faq.new_users:

******************
DEAC Cluster Usage
******************

* Who can use the DEAC Cluster?

	* Any faculty, student, or staff member within any department who receives support by Information Systems.
	* These departments include the School of Law, Divinity, Business, Graduate School of Arts and Sciences, and WFU Undergraduate College.
	* External collaborators and users from the School of Medicine are allowed to use the DEAC Cluster with certain caveats and additional rules.
	* More information can be found under the :ref:<sec.sla.ua.account_eligibility> section of our Service Level Agreement.

* What can the DEAC Cluster be used for?

	* Research and classroom instructional activity only.
	* More detailed information can be found under the :ref:`acceptable use<sec.sla.ua.acceptable_use>` section of our Service Level Agreement.

* How much does it cost to use the DEAC Cluster?

	* Baseline usage of the DEAC Cluster is provided at no additional cost to faculty, students, and staff as part of the centralized services provided by Information Systems.
	* Users from the School of Medicine using the DEAC Cluster outside of a collaboration must pay to use the DEAC Cluster in a PAID format only, either :ref:`pre<sec.sla.su.contributions>` or :ref:`post<sec.sla.su.chargebacks>` usage.

* What does "baseline" usage mean?

	* Baseline usage is defined as the total number available Core Hours on the DEAC Cluster, divided by the total number of active departmental research groups.
	* As of 2024, Baseline usage for research groups is **26,046 Core Hours**
	* More detailed information can be found under the :ref:<sec.sla.util.utilization_calculation> section of our Service Level Agreement.

* How much data storage do users have?

	* Research groups are provided a 2TB "baseline" quota when joining the DEAC Cluster at no cost.
	* This amount may be increased up to 10TB, provided the research group's department total footprint is less than 20TB.
	* More detailed information can be found under the :ref:<sec.sla.sdm.storage_quotas> section of our Service Level Agreement.

* What if you need more than "baseline" usage?

	* Users are allowed to consumed more than expected baseline usage on the DEAC Cluster
	* HOWEVER, there is no guarantee resources will be available during periods of high utilization.
	* Furthermore, as researcher groups exceed "baseline" usage, their department's priority will be lowered by the Scheduler's fairshare algorithm, meaning other research groups working within "baseline" may receive higher priority during periods of high utilization.

******************
New User Questions
******************

* How do I get a DEAC Cluster account?

	* Submit an account request here: https://help.wfu.edu/support/catalog/items/123

* How do I log in?

	* Users can only connect to our login nodes while on a WFU Network, 'eduroam' wireless, or VPN.

* What password do I use?

	* Users can login with the password they use to access their WFU email or an SSH Key.
	* There are no standalone passwords to access the DEAC Cluster.

* What kind of hardware is in the cluster?

	* The DEAC Cluster is known as a heterogeneous cluster, meaning it is comprised of several different hardware configurations and node types.
	* See :ref:`Cluster Hardware<sec.hardware>` for an indepth overview of hardware.

* How do I open graphical applications from the cluster?

	* The recommend method is to utilize graphical applications via our `DEAC Login Portal <https://login.deac.wfu.edu>`_ with Interactive Applications or Virtual Desktop.
	* Or configure your laptop SSH session with X-Windows (no longer recommended).

* What scheduler does the DEAC cluster use?

	* The scheduler used on the DEAC Cluster is `SLURM <https://slurm.schedmd.com/>`_!
	* Slurm also acts as the resource manager, meaning it has knowledge of all available resources upon which to schedule jobs.


.. _sec.faq.using:

*****************
Using the Cluster
*****************

* How do I submit jobs to the cluster?

    * Use **sbatch** to submit to the job queue. See the
      `SLURM:Quick Start Guide </SLURM:Quick_Start_Guide>`__.

* What software is installed on the cluster?

    * `:Category:Software </:Category:Software>`__

* What SLURM attributes does the cluster use?

    * `Cluster:Hardware Configuration#SLURM Node Features </Cluster:Hardware_Configuration#SLURM_Node_Features>`__

* How many jobs can I submit?

    * Please refer to the `Cluster:User Agreement </Cluster:User_Agreement>`__

* How does information get added to the wiki?

    * This wiki is intended to be updated with information from users... send the HPC Team
      an email with info to deac-help@wfu.edu


.. _sec.faq.grants:

***********************
Grants and Publications
***********************

* I'm writing a grant. Do you have a facility description?

    * We do! Find the most up to date description :ref:`here<sec.grant_writing>`

* I'm writing a paper using data from the cluster. Are there any special acknowledgements that are required?

    * Yes. Users *must* :ref:`acknowledge the DEAC Cluster<sec.acknowledging>` for any finds contributing toward publications, journal articles, etc.
    * `Information:Regarding Publications </Information:Regarding_Publications>`__

* My paper has been accepted for publication. Is there anything else I need to do?

    * `Information:Regarding Publications </Information:Regarding_Publications>`__
