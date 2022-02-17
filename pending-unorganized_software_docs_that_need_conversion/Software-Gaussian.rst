.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Quick
Start </Category:Quick_Start>`__

Overview
========

Gaussian 09 is an electronic structure software program, originally
developed by Nobel laureate John Pople, which is widely used by the
chemistry and biophysics research groups. [1]_

Version Supported
=================

For the Red Hat Enterprise Linux 6 (RHEL6) system image, we have
Gaussian 09, Build C.01. Users can check the exact version by
referencing the installation directory for RHEL6 software (/deac/opt),
where the Gaussian software is installed in a directory of the format
*gaussian09-version* (e.g. gaussian09-c.01).

The current directory for the software is /deac/opt/gaussian09-c.01

Usage Restrictions
==================

Access to the software is restricted to faculty, staff, and students of
the Reynolda Campus of Wake Forest University. Users requesting access
to the software **MUST** request that access via the Request Tracker
system by sending email to deac-help@wfu.edu.

**NOTE:** You will be required to read and agree to the license terms
for Gaussian found in the `License:Gaussian </License:Gaussian>`__
article.

Software Location
=================

Generic Link : /deac/opt/gaussian
Version Specific Link : /deac/opt/gaussian09-c.01

Build Information
=================

The Gaussian 09 software contains optimizations for two classes of Intel
processors that exist in the cluster:

:; EM64T : For Intel processor series 5100, 5300, and 5400.

:; Nehalem : For Intel processor series 5500 and 5600.

By far, the easiest (Gaussian) way to dynamically determine which node
is the following:

   **/deac/opt/gaussian09-c.01/em64t/g09/bsd/x86type**

There are two possible outputs for our current cluster:

:; intel : indicates *em64t*

:; intel-1 : indicates *nehalem*

Use the strings **em64t** or **nehalem** (all lower case) to substitute
for CLASS in the next section.

Using Gaussian 09
=================

Gaussian prefers (possibly even strongly recommends) the use of the TCSH
login shell. So, if you are a BASH user, you'll need to invoke the TCSH
shell prior to using Gaussian 09. While it is possible to use BASH with
Gaussian 09, WFU DEAC Cluster does not support its use.

Gaussian 09 requires the set up of one environment variable
(**g09root**) and the execution of the login script that sets up all the
required environment variables (**g09.login**). Using CLASS for the
process class determined by the commands listed in `Build
Information </#Build_Information>`__, the set up process is as follows:

   ::

      setenv g09root /deac/opt/gaussian/CLASS  # "CLASS" must be replaced by one of "em64t" or "nehalem"
      source $g09root/g09/bsd/g09.login

Command execution after this set up process depends entirely on your use
of Gaussian 09.

Convenience Script to Set CPU Type
----------------------------------

To avoid having to manually pick "em64t" or "nehalem" every time, you
can use a script to do it. Here is a tcsh script that will return the
appropriate string "em64t" or "nehalem" that you can use to set the
"g09root" environment variable.

   ::

      #!/bin/tcsh
      # Name this script "g09class" and put it in your PATH:
      # ~/bin/ is a good place for it.

      set class=`/deac/opt/gaussian/em64t/g09/bsd/x86type`
      if ( x$class == "xintel" ) then
          echo "em64t"
      else if ( x$class == "xintel-1" ) then
          echo "nehalem"
      else
          echo "unknown"
      endif

To install:

   ::

      $ mkdir ~/bin
      $ [edit g09class and copy into ~/bin]
      $ chmod +x ~/bin/g09class

Then, to use this, you can put this in your ~/.cshrc file:

   ::

      setenv g09root /deac/opt/gaussian/`~/bin/g09class`
      source $g09root/g09/bsd/g09.login

Setting LD_LIBRARY_PATH
-----------------------

With Gaussian, you do not have a choice about using ``LD_LIBRARY_PATH``
because the setup for using Gaussian requires ``LD_LIBRARY_PATH`` to be
defined.

Overwrite, do not prepend/append
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

To avoid accreting possibly conflicting library directories in your
``LD_LIBRARY_PATH``, it is best to explicit set it rather than appending
or prepending paths to it.

Gaussian requires PGI
~~~~~~~~~~~~~~~~~~~~~

First, you have to pick a version of the PGI compilers. The default on
the cluster is version 7.0. There are two environment variables which
help:

-  **``PGIDIR``**\ ``- /opt/pgi``
-  **``PGIVERS``**\ ``- 7.0``

Then, you will set ``LD_LIBRARY_PATH`` to (according to your shell) :

| ``  ``\ **``tcsh``**\ ``: setenv LD_LIBRARY_PATH ${PGIDIR}/linux86-64/${PGIVERS}/libso``
| ``  ``\ **``bash``**\ ``: export LD_LIBRARY_PATH=${PGIDIR}/linux86-64/${PGIVERS}/libso``

Where $PGIVERS is the version of PGI used

Program Test Outputs
====================

Gaussian provides a set of test jobs that can be run to determine if the
compilation produces acceptable results to known "good" builds. These
reference test results can be found in:

:; /deac/opt/gaussian09-c.01/CLASS/g09/tests/ia64 The test results for
the local WFU DEAC build for the process family **CLASS** (em64t or
nehalem) are found in:

:; /deac/opt/gaussian09-c.01/CLASS/g09/tests/amd64

Using Gaussview
===============

As of 2012-Dec-07, GaussView 5 works on very specific combinations of
local computer + remote node.

#. Using an Ubuntu machine (or virtual machine) to log into a head node,
   GaussView 5 works as expected. Since you will already be logged into
   a RHEL6 node, you won't have to start a separate ssh session to run
   the g09_s.pbs script.
#. Using a `Windows machine running
   XMing </Cluster:Using_from_Windows>`__, use PuTTY to login to a
   cluster headnode. Make sure PuTTY has "X11 Forwarding" checked on.

After the environment has been set up to run Gaussian 09, GaussView may
be run by doing:

   ::

          gv

References
==========

.. raw:: html

   <references/>

.. [1]
   `Official Gaussian Website <http://www.gaussian.com/>`__
