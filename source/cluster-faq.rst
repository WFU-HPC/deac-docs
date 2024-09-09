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

* What is a High Performance Computing Cluster?
	* General cluster information can be found :ref:`here<sec.cluster_overview>`.

* Who can use the DEAC Cluster?
	* Baseline usage of the DEAC Cluster for research and instructional activities is provided at no additional to faculty, students, and staff within any department that receive support by Information System.
	* These departments include the School of Law, Divinity, Business, Graduate School of Arts and Sciences, and WFU Undergraduate College.
	* The School of Medicine is allowed to use the DEAC Cluster in a PAID format only, either :ref:`pre<sec.sla.su.contributions>` or :ref:`post<sec.sla.su.chargebacks>` usage.

* How do I get a DEAC Cluster account?
	* Submit an account request here: https://help.wfu.edu/support/catalog/items/123

* How is the cluster different from a workstation?
	*  Users do not need to be present while majority of tasks are running.
	*  You use the computational nodes by packaging your work into "jobs".
	*  The cluster runs those jobs on your behalf, as you, but you have no direct access to the job while it is running.

.. _sec.faq.new_users:

******************
New User Questions
******************

* How do I log in?

	* Users can only connect to our login nodes while on a WFU Network, 'eduroam' wireless, or VPN.

* What password do I use?

	* Users will login with the password they use to access their WFU email.
	* There are no standalone passwords to access the DEAC Cluster.

* How do I open graphical applications from the cluster?

	* The recommend method is to utilize graphical applications via our `DEAC Login Portal <https://login.deac.wfu.edu>`_ with Interactive Applications or Virtual Desktop.
	* Or configure your laptop SSH session with X-Windows (no longer recommended).

* What kind of hardware is in the cluster?

	* See :ref:`Cluster Hardware<sec.hardware>` for an indepth overview of hardware.

* How many nodes does the cluster have?

	* See :ref:`Cluster Hardware<sec.hardware>` for most up to date node information

* What scheduler does the DEAC cluster use?

    * The resource manager scheduler we use is `SLURM <https://slurm.schedmd.com/>`_!


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
