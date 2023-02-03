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
software, and support user needs.

* These docs are the starting point reference for all cluster users.
* They are intended to be a community resource for information sharing:

    * All entries should aim to make the cluster user experience easier.
    * We encourage all users to frequently consult these docs as content is
      always being updated.

* The side bar index is categorized and is roughly structured to be followed
  from top to bottom:

    * Newer, less experienced cluster users should carefully review the topmost
      sections in the side bar.
    * Experienced/expert users will find various in-depth guides in subsequent
      sections.

For help, send email to `deac-help@wfu.edu <mailto:deac-help@wfu.edu>`_.

Note: Users must be on a WFU network or connected via VPN in order to access and
login to the head nodes!

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

.. toctree::
   :maxdepth: 2
   :caption: First Steps

   beginner-quickstart_00_connect
   beginner-quickstart_01_linux
   beginner-quickstart_02_using
   beginner-quickstart_03_jobs
   beginner-linux_commands
   beginner-faq
   beginner-videos


.. toctree::
   :maxdepth: 2
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
   :maxdepth: 2
   :caption: Research on DEAC

   research-starting_new
   research-acknowledging_deac
   research-grant_writing
   research-archiving
   research-featured_research


.. toctree::
   :maxdepth: 2
   :caption: Software

   software-packages
   software-python
   software-building
   software-licensing


.. toctree::
   :maxdepth: 2
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
