.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Quick
Start </Category:Quick_Start>`__\ `Category:Compiling </Category:Compiling>`__
**MAKER** is a configurable genome annotation pipeline from the Yandell
Lab, Dept. of Human Genetics at Univ. of Utah. [1]_

Versions
========

Version installed on the cluster include:

-  **2.31.9** (Dec 16, 2016 version date)

Modules Used
============

-  module load openmpi/1.6-intel

Install of Perl Dependencies
============================

::

   1) Tried to use the Build installdeps script before manual installs, but failed!
   2) Did the manual installs first
   3) Then retried the script

**Manual Installs** with cpan

-  DBI
-  DBD::SQLite
-  forks
-  forks::shared
-  File::Which
-  Perl::Unsafe::Signals
-  Bit::Vector
-  IO::All
-  IO::Prompt
-  YAML
-  parent

Using the **src/Build installdeps**

-  Inline::C
-  Bio::Root::Version

References
==========

.. raw:: html

   <references/>

.. [1]
   `MAKER Official
   Page <http://www.yandell-lab.org/software/maker.html>`__
