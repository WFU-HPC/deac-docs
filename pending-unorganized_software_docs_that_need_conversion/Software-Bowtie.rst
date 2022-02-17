.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__
Bowtie[http://sourceforge.net/projects/bowtie-bio/files/bowtie2/2.2.4/

``Bowtie source download]``\ \ `` is an ultrafast, memory-efficient short read aligner. It aligns short DNA sequences (reads) to the human genome at a rate of over 25 million 35-bp reads per hour. Bowtie indexes the genome with a Burrows-Wheeler index to keep its memory footprint small: typically about 2.2 GB for the human genome (2.9 GB for paired-end)``\  [1]_\ ``.``

Version
=======

Current version installed on the cluster is

:\* **2.2.4**

Installation
============

Bowtie is installed as a part of the trinity package to:

:\* /deac/opt/trinity/bowtie2-2.2.4

It comes with it's own built-in binaries.

Using Bowtie
============

Load the module:

``    module load trinity/2.0.3-icc``

The executables are:

-  bowtie2
-  bowtie2-align
-  bowtie2-build
-  bowtie2-inspect

-s, -l, and -debug variants exist for all executables, ie
bowtie2-align-l-debug or bowtie2-inspect-s

References
==========

.. raw:: html

   <references/>

.. [1]
   ``[``\ \ \ ```http://bowtie-bio.sourceforge.net/index.shtml`` <http://bowtie-bio.sourceforge.net/index.shtml>`__
   ``]``
