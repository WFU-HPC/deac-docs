.. DEAC Docs documentation master file, created by
   sphinx-quickstart on Tue Apr  6 12:24:24 2021.
   You can adapt this file completely to your liking, but it should at least
   contain the root `toctree` directive.

=====================================================
DEAC Docs: The Official Docs for the DEAC cluster
=====================================================

.. code-block:: none

    ******************************************************************************
    *  Wake Forest University -- Distributed Environment for Academic Computing  *
    *                                                                            *
    * __/\\\\\\\\\\\_____/\\\\\\\\\\\\\____/\\\\\\\\___________/\\\\\\\_________ *
    * __\/\\\///////\\\__\/\\\/////////___/\\\\\\\\\\\\______/\\\//////_________ *
    * ___\/\\\_____\//\\\_\/\\\___________/\\\////////\\\___/\\\/_______________ *
    * ____\/\\\______\/\\\_\/\\\\\\\\\____\/\\\______\/\\\__/\\\________________ *
    * _____\/\\\______\/\\\_\/\\\/////_____\/\\\\\\\\\\\\\\_\/\\\_______________ *
    * ______\/\\\______\/\\\_\/\\\__________\/\\\////////\\\_\//\\\_____________ *
    * _______\/\\\______/\\\__\/\\\__________\/\\\______\/\\\__\///\\\__________ *
    * ________\/\\\\\\\\\\\/___\/\\\\\\\\\\\\\\/\\\______\/\\\____\////\\\\\\\__ *
    * _________\///////////_____\/////////////_\///_______\///________\///////__ *
    *                                                                            *
    *  Unauthorized use is STRICTLY PROHIBITED and WFU maintains all rights to   *
    *  University related or legal actions associated with such access. Refer    *
    *  to https://go.wfu.edu/deac-sla for detailed documentation and policies.   *
    *                                                                            *
    *  For questions and support, email deac-help@wfu.edu. You must acknowledge  *
    *  the WFU HPC Facility in publications: https://go.wfu.edu/deac-doi         *
    *                                                                            *
    ******************************************************************************

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

The DEAC Cluster is a centralized service provided by Information systems. Baseline usage of the DEAC Cluster for research and instructional activities is provided at no additional to faculty, students, and staff within any department that receive support by Information System. These departments include the School of Law, Divinity, Business, Graduate School of Arts and Sciences, and WFU Undergraduate College. The School of Medicine is allowed to use the DEAC Cluster in a PAID USAGE format only. The DEAC Cluster is supported by The HPC Team, who are available to provide training, troubleshooting, data management, software installation, server configuraiton, and hardware maintenance.

This wiki is intended to be a community resource for information sharing.
	* The HPC Team will aim to make entries as up-to-date as possible; however, the cluster is a constantly evolving tool. Contact the HPC Team if you discover any noticable differences or misinformation.
	* The HPC Team encourages users to share this wiki amongst team members to held advance knowledge. 
	* Users should utilize the side bar to navigate the wiki from high to low-level information as needed.


Important Links
===============

* `DEAC Help Email (deac-help@wfu.edu) <mailto:deac-help@wfu.edu>`_: Your direct line to the HPC Team for support.
* `Main website <https://hpc.wfu.edu>`_: General information about the cluster, highlighting its capabilities and publicizing some interesting results.
* `DEAC Login <https://login.deac.wfu.edu>`_: Login portal to the DEAC Cluster for existing users.
* `DEAC Cluster Documentation <https://deac-wiki.readthedocs.io>`_: Public content that provides useful information (such as this article) for cluster users new and old.
* `DEAC Cluster YouTube channel <https://youtube.com/WakeHPC>`_: Video content featuring tutorials/training and user research.


Getting Started
===============

.. _sec.index:request_access:

New Users
---------

* Request an Account: https://help.wfu.edu/support/catalog/items/123

	* No user has access to the DEAC Cluster and it's resources without submitting an account request.
	* New faculty user requests should expect a member of the HPC Team to schedule a meeting to review cluster resources, HPC Team services, and research requirements.
        * New student user requests *require* research advisor approval before an account is created and associated with a research group. Faculty who submit student account requests to join their own group imply automatic approval.

* Review the :ref:`Service Level Agreement<sec.sla>` for usage guidelines.

	* This living document contains all acceptable usage guidelines and general rules that should be followed by cluster users
	* Standard baseline usage is covered, as well as how to gain priority access on the cluster via contributions.

* Review the :ref:`General Overview<sec.cluster_overview>` for general terminology and workflow.
	
	* This will give you a better understand of cluster basics.
	* Knowing terms will help you better understand communications from the HPC Team.

* Review the :ref:`Frequently Asked Questions<sec.faq>` and review answers.

	* This is where answers to commonly asked questions are stored. 
	* Quick references can also be found here if you forgot where important links are located.

.. _sec.index:getting_access:

Accessing the Cluster
---------------------

There are three primary methods in which users connect to the cluster:

#. **User Interface** via HTTPS - 

	* Users can connect through a web User Interface via `DEAC Login <https://login.deac.wfu.edu>`_
	* This user interface allows terminal connectivity, interactive sessions, and file transfer capability.
	* **This method is strongly recommended as the preffered method of accessing the DEAC Cluster.**

#. **Shell Access** via SSH -

	* Users can connect using the SSH protocol via any number of freely available clients (VS Code, OpenSSH, MobaXterm, PuTTY, etc.).
	* SSH is the only protocol supported for direct command line access to DEAC Cluster Login nodes.
	* If you are unfamiliar with the SSH protocol, we strongly encourage you to utilize the User Interface above.

#. **File Transfer** via SCP/SFTP -

	* Users can migrate data onto and off of the cluster using secure file transfer protocols, also based on the underlying SSH protocol suite.
	* Several utilities are also freely available (VS Code, OpenSSH, WinSCP, etc.) to securely authenticate and transfer files to/from DEAC Cluster Login Nodes.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################
..
    The following documents have content, but need to be converted to reStructuredText:
    * cluster-general_overview
    * cluster-hardware
    * cluster-gpu_resources
    * cluster-performance
    * research-archiving
    * research-starting_new
    * software-packages
    * software-building
    * software-licensing
    * reference-slurm_torque

=================
Table of Contents
=================

.. toctree::
   :maxdepth: 1
   :caption: About the Cluster

   cluster-faq
   cluster-sla
   cluster-hardware
   cluster-general_overview
   cluster-gpu_resources
   cluster-performance
   cluster-stats


.. toctree::
   :maxdepth: 1
   :caption: Research on DEAC

   research-grant_writing
   research-acknowledging_deac
   research-archiving
   research-featured_research


.. toctree::
   :maxdepth: 1
   :caption: Software

   software-packages
   software-python
   software-building
   software-licensing


.. toctree::
   :maxdepth: 1
   :caption: Reference Documentation

   beginner-linux_commands
   beginner-videos
   reference-slurm_torque
   reference-repcom_meetings


.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Indices and tables
==================

* :ref:`genindex`
* :ref:`modindex`
* :ref:`search`
