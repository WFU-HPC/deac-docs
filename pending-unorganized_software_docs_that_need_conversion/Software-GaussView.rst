.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

Overview
========

`GaussView 5 <http://www.gaussian.com/g_prod/gv5b.htm>`__ is a molecular
and reaction visualization tool available from the
`Gaussian <http://www.gaussian.com/>`__ corporation.

Version
=======

Versions on the cluster include:

:\* **5.0.9** For the Red Hat Enterprise Linux 6 (RHEL6) system image,
we have upgraded the GaussView version to GaussView 5.0.9. The software
is installed along side the Gaussian 09 software underneath the
/deac/opt/gaussian directory on the cluster. Please refer to the
`Software:Gaussian </Software:Gaussian>`__ web page for more information
about the location of the specific Gaussian builds in use on the
cluster.

Usage Restrictions
==================

Access to the software is restricted to faculty, staff, and students of
the Reynolda Campus of Wake Forest University. Users requesting access
to the software **MUST** request that access via the Request Tracker
system by sending email to deac-help@wfu.edu.

**NOTE:** You will be required to read and agree to the license terms
for Gaussian found in the `License:Gaussian </License:Gaussian>`__
article.

Using GaussView 5
=================

Setup is similar to that for `Gaussian
09 </Software:Gaussian#Using_Gaussian_09>`__. Especially, see the setup
for the "CLASS", i.e. CPU class.

Once you have the g09class script installed, make sure you have these
lines in your ~/.cshrc (or ~/.tcshrc) file:

| :literal:`   setenv g09root /deac/opt/gaussian/`~/bin/g09class\``
| ``   source $g09root/g09/bsd/g09.login``

These should set the GV_DIR directory correctly, and sets the alias "gv"
to run GaussView.

Software Location
=================

Generic Link : /deac/opt/gaussian/CLASS/gv
Version Specific Link : /deac/opt/gaussian09-c.01/CLASS/gv

*(see below for CLASS information)*

Build Information
=================

The Gaussian 09 software contains optimizations for two classes of Intel
processors that exist in the cluster:

:; EM64T : For Intel processor series 5100, 5300, and 5400.

:; Nehalem : For Intel processor series 5500 and 5600.

By far, the easiest (Gaussian) way to dynamically determine which node
is the following:

   **/deac/opt/gaussian/em64t/g09/bsd/x86type**

There are two possible outputs for our current cluster:

:; intel : indicates *em64t*

:; intel-1 : indicates *nehalem*
