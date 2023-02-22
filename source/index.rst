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
    *  to https://go.wfu.edu/deac-sla for detailed documenation and policies.    *
    *                                                                            *
    *  For questions and support, email deac-help@wfu.edu. You must acknowledge  *
    *  the WFU HPC Facility in publications: https://go.wfu.edu/deac-doi         *
    *                                                                            *
    ******************************************************************************

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

The WFU DEAC HPC Cluster is a centrally funded resource, meaning it is a free
tool for all Wake Forest University Reynolda Campus researchers and students.
The HPC Team is here to train users, troubleshoot scripts, upgrade hardware and
software, and support user needs. This documentation is a starting point and
reference for all DEAC Cluster users. They are intended to be a community
resource for information sharing.

    .. * All entries should aim to make the cluster user experience easier.
    .. * We encourage all users to frequently consult these docs as content is
    ..   always being updated.
    .. * The side bar index is categorized and is roughly structured to be followed
    ..   from top to bottom:

    ..     * Newer, less experienced cluster users should carefully review the
    ..       topmost sections in the side bar.
    ..     * Experienced/expert users will find various in-depth guides in
    ..       subsequent sections.

Note: Users must be on a WFU network or connected via VPN in order to access and login to the head nodes!

Important Links
===============

* `DEAC-Help Email (deac-help@wfu.edu) <mailto:deac-help@wfu.edu>`_: Your direct
  line to the HPC Team.
* `Main website <https://hpc.wfu.edu>`_: General information about the cluster,
  highlighting its capabilities and publicizing some interesting results.
* `DEAC Cluster Documentation <https://deac-wiki.readthedocs.io>`_: Public
  content that provides useful information (such as this article) for cluster
  users new and old.
* `DEAC Cluster YouTube channel <https://youtube.com/WakeHPC>`_: Video content
  featuring tutorials/training and user research.
* `DEAC Cluster Twitter page <https://twitter.com/WakeHPC>`_: Public
  announcements and updates regarding the Cluster.


First Steps
===========

.. _sec.index:request_access:

Account Requests
----------------

If you're reading this page, you almost certainly have it by now. So, this
section will focus mainly on being a central location for existing users to
reference in helping potential new users get access.

* Request an Account: https://help.wfu.edu/support/catalog/items/123
* Review the :ref:`sec.policies`.

.. * Request access to licensed software: Certain licensed software requires electronic acceptance of the licenses. To determine if the software you wish to use requires these extra measures, please view https://wiki.deac.wfu.edu/index.php/Category:License for a list of software with special requirements.

.. _sec.index:getting_access:

Accessing the Cluster
---------------------

There are two primary entry points in which users connect to the
cluster for various resources:

#. **Shell Access** via SSH - Users connect to the interactive login nodes, aka
   :ref:`sec.qs0:cluster_headnodes`, using the SSH protocol, provided by any
   number of freely available clients (VS Code, OpenSSH, MobaXterm, putty,
   etc.). This is the only protocol supported for command line access (i.e.
   interactive logins) to the cluster and is available from the general Internet
   without restriction. The :ref:`SSH Section <sec.qs0:ssh>` is a good place to
   start.   
#. **File Transfer** via SCP/SFTP - Users can migrate data onto and off of the
   cluster using secure file transfer protocols, also based on the underlying
   SSH protocol suite. The utilities, which are also freely available (VS Code,
   OpenSSH, WinSCP, etc.) work similar to historical FTP clients but securely
   authenticate and transfer the files between destination.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################
..
    The following documents have content, but need to be converted to reStructuredText:
    * beginner-quickstart_00_connect
    * beginner-quickstart_02_using
    * beginner-quickstart_03_jobs
    * beginner-faq
    * cluster-policies
    * cluster-general_overview
    * cluster-hardware
    * cluster-gpu_resources
    * cluster-usnic
    * cluster-performance
    * research-starting_new
    * research-archiving
    * software-packages
    * software-building
    * software-licensing
    * reference-slurm_torque

=================
Table of Contents
=================

.. toctree::
   :maxdepth: 1
   :caption: Getting Started

   beginner-quickstart_00_connect
   beginner-quickstart_01_linux
   beginner-quickstart_02_using
   beginner-quickstart_03_jobs
   beginner-linux_commands
   beginner-faq
   beginner-videos


.. toctree::
   :maxdepth: 1
   :caption: About the Cluster

   cluster-sla
   cluster-policies
   cluster-general_overview
   cluster-hardware
   cluster-gpu_resources
   cluster-usnic
   cluster-performance
   cluster-stats


.. toctree::
   :maxdepth: 1
   :caption: Research on DEAC

   research-starting_new
   research-acknowledging_deac
   research-grant_writing
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
