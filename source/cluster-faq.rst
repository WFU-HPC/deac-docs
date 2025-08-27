.. _sec.faq:

################################
Frequently Asked Questions (FAQ)
################################

.. _DEAC Docs AI Chat: https://notebooklm.google.com/notebook/7f5b7f16-36a1-4595-a4c1-bc3d3e7d04d0
.. |DEAC Docs AI Chat| replace:: **DEAC Docs AI Chat**

.. tip:: 

  |DEAC Docs AI Chat|_ is the *fastest* way to lookup information about the DEAC Cluster!

  This AI tool is powered by Google's NotebookLM and is only accessible to approved DEAC Cluster users. It is trained on material provided by the HPC Team and cites source link(s) with every response. Feel free to send feedback to the HPC Team at deac-help@wfu.edu!

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

	* General information about HPC can be found :ref:`here<sec.cluster-general_overview>`.

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
Should I Use DEAC?
******************

* Who can use the DEAC Cluster?

	* Any faculty, student, or staff member within any department who receives support by Information Systems.
	* These departments include the School of Law, Divinity, Business, Graduate School of Arts and Sciences, and WFU Undergraduate College.
	* External collaborators and users from the School of Medicine are allowed to use the DEAC Cluster with certain caveats and additional rules.
	* More information can be found under the :ref:`Account Eligibility<sec.sla.ua.account_eligibility>` section of our Service Level Agreement.

* What can the DEAC Cluster be used for?

	* Research and classroom instructional activity only.
	* More detailed information can be found under the :ref:`acceptable use<sec.sla.ua.acceptable_use>` section of our Service Level Agreement.

* When should someone consider using the DEAC Cluster?

	The three most common scenarios that usually require the use of HPC are:

	#. You have to run an application/script/simulation too many times.
	#. Your application/script/simulation takes too long to run.
	#. Your data source and/or results are too big to store locally.

* How much does it cost to use the DEAC Cluster?

	* "Baseline" usage of the DEAC Cluster is provided at no additional cost to faculty, students, and staff as part of the centralized services provided by Information Systems.
	* Users from the School of Medicine using the DEAC Cluster outside of a collaboration must pay to use the DEAC Cluster in a PAID format only, either :ref:`pre<sec.sla.su.contributions>` or :ref:`post<sec.sla.su.chargebacks>` usage.

* How much data storage do users have?

	* Research groups are provided a 2TB "baseline" quota, at no additional cost, only to be used for research conducted on the DEAC Cluster.
	* More detailed information can be found under the :ref:`Storage Quotas<sec.sla.sdm.storage_quotas>` section of our Service Level Agreement.


***********************
What Is Baseline Usage?
***********************

* What does "baseline" usage mean?

	* Baseline usage is defined as the equitable, evenly distributed use of the DEAC Cluster's centralized resources across all active research groups.
        * Baseline usage is calculated by taking the total monthly number available Core Hours on the DEAC Cluster, divided by the total number of active departmental research groups.
	* As of 2025, Baseline usage for research groups is **21,214 Core Hours per month**.
        * All users should be expect to be able to utilize the DEAC Cluster per month without contention.
	* More detailed information can be found under the :ref:`Utilization Calculation<sec.sla.util.utilization_calculation>` section of our Service Level Agreement.

* What if you need more than "baseline" usage?

	* Users are allowed to consumed more than expected baseline usage on the DEAC Cluster.
	* HOWEVER, there is no guarantee resources will be available during periods of high utilization.
	* Furthermore, as researcher groups exceed "baseline" usage, their department's priority will be lowered by the Scheduler's fairshare algorithm, meaning other research groups working within "baseline" may receive higher priority during periods of high utilization.
	* To guarantee High Priority access to DEAC Resources and reduce potential wait times for resources, researchers can contribute funds toward the DEAC Cluster at an amount commensurate to their expected usage.
	* More detailed information can be found under the :ref:`Contributions<sec.sla.su.contributions>` section of our Service Level Agreement.

* What if you need more than "baseline" storage?

	* Research storage amounts may be increased up to 10TB per research group, provided the research group's department total footprint is less than 20TB.
	* If either of those limits are exceeded, additional storage may be allocated via :ref:`Contribution<sec.sla.su.contributions>`, for up to Five-year terms.
	* More detailed information can be found under the :ref:`Storage Quotas<sec.sla.sdm.storage_quotas>` section of our Service Level Agreement.

* Should I allocate grant or start-up funds to the DEAC Cluster?

	* It is not necessary to allocate funds to the DEAC Cluster; as stated above, baseline usage is allowed at no additional cost and you can also exceed that baseline amount.
	* If you expect to need more than the provided baseline storage, or believe you will greatly exceed baseline usage, then contributing funds may help ensure that the DEAC Cluster can fully suite your research needs.
	* If you aren't sure what your usage will be, are unsure of timeline, and/or aren't sure if it makes sense to contribute funds, do not hesitate to contact the HPC Team at deac-help@wfu.edu to start a conversation.



***************
How Do I Login?
***************

* Okay, how do I sign up for a DEAC Cluster account?

	* Submit an account request here: https://help.wfu.edu/support/catalog/items/123

* How do I log in?

	* Users can only connect to our login nodes while on a WFU Network, 'eduroam' wireless, or VPN.

* What password do I use?

	* Users can login with the password they use to access their WFU email or an SSH Key.
	* There are no standalone passwords to access the DEAC Cluster.

* What kind of hardware resources are in the DEAC Cluster?

	* The DEAC Cluster is known as a heterogeneous cluster, meaning it is comprised of several different hardware configurations and node types.
	* See :ref:`Cluster Resource Overview<sec.hardware>` for an indepth overview of hardware.

* How do I open graphical applications from the cluster?

	* The recommend method is to utilize graphical applications via our `DEAC Login Portal <https://login.deac.wfu.edu>`_ with Interactive Applications or Virtual Desktop.
	* Or configure your laptop SSH session with X-Windows (no longer recommended).



.. _sec.faq.using:

*********************
Tell me more about...
*********************

* What scheduler does the DEAC cluster use?

	* The scheduler used on the DEAC Cluster is `SLURM <https://slurm.schedmd.com/>`_!
	* Slurm also acts as the resource manager, meaning it has knowledge of all available resources upon which to schedule jobs.

* How do I submit jobs to the cluster?

	* Use **sbatch** to submit to the job queue. 
	* Please see :ref:`Slurm Help<sec.slurm>` for documentation references, command info, and examples.

* What software is installed on the cluster?

	* Please visit the :ref:`Packages`<sec.software-packages>` page for more information.

* Are there specific SLURM settings configured on DEAC?

        * YES! See :ref:`DEAC Cluster Slurm Specifics <sec.slurm.deac>` for more information.
 
* What SLURM attributes does the cluster use?

	* Jobs are allocated based upon the `CR_Core_Type Consumable Resources Setting in Slurm <https://slurm.schedmd.com/slurm.conf.html#OPT_CR_Core_Memory>`_.
	* Please see the current :ref:`Slurm Job Constraints<sec.slurm.deac.features>` for list of current constraints that can be used for job selection.

* How many jobs can I submit?

	* Please see the current job submission limit under the :ref:`general limitations`<sec.sla.ul.general_limitations>` section of our Service Level Agreement.

* How does information get added to the wiki?

	* This wiki is intended to be updated with information from users... send the HPC Team an email with info to deac-help@wfu.edu


.. _sec.faq.funding:

*******************
How is DEAC Funded?
*******************

* Who pays for the DEAC Cluster?

	* The DEAC Cluster is a centrally funded services. Funding is allocated annually as part of the `Information Systems <https://is.wfu.edu>`_ (IS) budget that goes toward operations and annual hardware refreshes.
	* Annual expenses are offset by researcher :ref:`Contributions<sec.sla.su.contributions>` or :ref:`Chargebacks<sec.sla.su.chargebacks>` in exchange for above baseline resource utilization (storage, core/memory requirements) with high priority access.
	* The `Office of Research and Sponsored Programs <https://research.wfu.edu/funding/internal-funding/>`_ (under ORSP) provides 1:1 matching on external grant based Contributions up to $75,000 per fiscal year, which IS receives to help offset annual expenses.

* Who pays for the HPC Team?

	* The HPC Team is comprised of full-time, non-exempt staff within the Information Systems department.

.. _sec.faq.grants:

**************************
Grants and Publications...
**************************

* I'm writing a grant. Do you have a facility description?

	* We do have a template description, however, we recommend contacting the HPC Team at deac-help@wfu.edu for a tailored description to best fit your grant needs.
	* Find the most up to date description :ref:`here<sec.grant_writing>`

* Should I include a contribution to the DEAC Cluster in my grant?

	* If you plan to use the DEAC Cluster for grant related-work, it may be helpful to allocated funds to the DEAC Cluster in the form of a :ref:`contribution<sec.sla.su.contributions>`.
	* This contribution can be to add necessary storage, and/or add high priority access, especially if expected to be above "baseline" usage.
	* The `Office of Research and Sponsored Programs <https://research.wfu.edu/funding/internal-funding/>`_ (under ORSP) provides 1:1 matching up to $75,000 per fiscal year for all outside grant contributions that benefit general DEAC Cluster usage.

* I'm writing a paper using data from the cluster. Are there any special acknowledgements that are required?

	* Yes. Users *must* :ref:`acknowledge the DEAC Cluster<sec.acknowledging>` for any finds contributing toward publications, journal articles, etc.

* My paper has been accepted for publication. Is there anything else I need to do?

	* Yes. Once your publication has been accepted, please send us the DOI and other relevant information to deac-help@wfu.edu.

