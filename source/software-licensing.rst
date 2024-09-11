.. _sec.software-licensing

=================
Licensed Software
=================

.. contents::
   :depth: 3
..


----------------
Hosting Licenses
----------------

* The DEAC Cluster has the ability to host licensed software at a network, group, and user level; licenses may be perpetual or updated annually.
* Most network licenses are hosted on a Wake Forest University License Server via FlexLM
	* The HPC Team also runs several non-FlexLM License Manager services.
* To add or update a license, contact the HPC Team at deac-help@wfu.edu to explore options


---------------------------
Available Licensed Software
---------------------------

Matlab
======

Mathematica
===========

Maple
=====

LS-Dyna
=======

Stata
=====

SAS
===

COMSOL
======

Gaussian and GaussView
======================

* Because of the inseparability of the Gaussian 09 and GaussView 5 software, you
  must agree to both agreements in order to gain access to either software
  package even if you have no intentions of using one of them.
* The "License:GaussView 5" page redirects here. Every reference to "Gaussian
  09" shall be conferred to mean both products.

Important Highlights
--------------------

**PLEASE NOTE:** These summary highlights are provided for reference and are not
to be construed as the complete licensing terms NOR should they be considered
authoritative interpretations of the license. The actual license (linked above)
is the sole authoritative source of terms governing the use of the software. If
you feel any of the below statements misrepresents the license above, please
contact us at deac-help@wfu.edu immediately to discuss the discrepancy.

Citation Requirements
---------------------

* Publishing results that rely on calculations obtained by use of the Gaussian
  09 software must cite its use. See
  http://www.gaussian.com/g_tech/g_ur/m_citation.htm for details.

Usage Restrictions
------------------

* Educational and non-commercial research use only. See license for detailed
  definition of "non-commercial research use".

WFU DEAC HPC Acceptable Use
---------------------------

In addition to the license restrictions above, users agree to be bound by the
following operational/local restrictions necessary in order for the WFU DEAC HPC
systems administration team to adequately ensure compliance:

* Users shall not copy the software (source, binaries, text files) outside of
  the access controlled directory for Gaussian 09, **even if** you have placed
  or intend to place sufficient access controls on the software to attempt to
  maintain compliance with the terms of the software license.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

VASP
====

Important Highlights
--------------------

**PLEASE NOTE:** These summary highlights are provided for reference and are not
to be construed as the complete licensing terms NOR should they be considered
authoritative interpretations of the license. The actual license (linked above)
is the sole authoritative source of terms governing the use of the software. If
you feel any of the below statements misrepresents the license above, please
contact us at deac-help@wfu.edu immediately to discuss the discrepancy.

Citation Requirements
---------------------

See the license for the proper 'umlaut's and bold typefacing:

.. code-block:: none

    "The calculations have been performed using the ab-initio total-energy and
    molecular-dynamics program VASP (Vienna ab-initio simulation program)
    developed at the Institut fuer Materialphysik of the Universitaet Wien
    [1,2]."

        [1] G. Kresse and J. Furthmueller, Phys. Rev. B 54, 11 169 (1996).

    If the PAW-version is used, reference will be made to:

        [2] G. Kresse and D. Joubert, Phys. Rev. 59, 1758 (1999).

If special features implemented in VASP will have been used, reference should be
made to the relevant publications as listed on the VASP home-page.

Usage Restrictions
------------------

* Only **SIX** users are allowed access to the software at any given time (see
  page 1, section 1)

    * Users must be in the "Condensed Matter Group of WFU Physics Department"
    * No external collaborators are permitted to use the software

* The source code, executables and databases are to be copy-protected and
  restricted to licensed users only.

    * See "WFU DEAC HPC Regulations" below regarding proper cluster behavior
      when using this software

Development and Results
-----------------------

* Benchmark results of the software **CAN NOT** be given to third-parties (i.e.
  anyone outside the licensed users at WFU) without obtaining permission from
  University of Vienna
* Any WFU developed extensions to VASP must be made available to University of
  Vienna and you must permit them to be included in future VASP releases.

WFU DEAC HPC Acceptable Use
---------------------------

In addition to the license restrictions above, users agree to be bound by the
following operational/local restrictions necessary in order for the WFU DEAC HPC
systems administration team to adequately ensure compliance:

* Users shall not copy the software (source, binaries) outside of the access
  controlled directory for VASP (currently, ``/deac/opt/vasp-X.Y.Z``, where
  ``X.Y.Z`` represents the software version), **even if** you have placed or
  intend to place sufficient access controls on the software to attempt to
  maintain compliance with the terms of the software license.

    * As part of the useful operation of the software, it is required to create
      a potential file (POTCAR) that is a custom combination of the relevant
      potentials files for your job. In these cases, you must ensure that the
      file has the following access controls so that the possibility of
      inadvertent access to the potentials is minimized:

.. code-block:: console

    chown ${USER}:vaspUsr ${PATH_TO_FILE}/POTCAR
    chmod g=,o= ${PATH_TO_FILE}/POTCAR
