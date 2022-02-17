.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

About
=====

BWA is a software package for mapping low-divergent sequences against a
large reference genome, such as the human genome. It consists of three
algorithms: BWA-backtrack, BWA-SW and BWA-MEM. The first algorithm is
designed for Illumina sequence reads up to 100bp, while the rest two for
longer sequences ranged from 70bp to 1Mbp. BWA-MEM and BWA-SW share
similar features such as long-read support and split alignment, but
BWA-MEM, which is the latest, is generally recommended for high-quality
queries as it is faster and more accurate. BWA-MEM also has better
performance than BWA-backtrack for 70-100bp Illumina reads. BWA also has
an parallel version called pBWA

Version
=======

-  BWA Version = 0.7.15 with Intel-2017-lp64 compiler
-  pBWA version = 0.5.9-1.21009 with openmpi/2.1.0-intel-2017

Compiling
=========

BWA
---

| Find the source file at
  https://sourceforge.net/projects/bio-bwa/files/
| In the home dir of bwa

| `` module load module load compilers/intel-2017-lp64``
| `` vim Makefile     //edit the makefile, change compiler to icc``

In Makefile:

`` CC  =   icc``

Now, compile:

`` make  //now a executable file ‘bwa’ is created in current directory``

pBWA
----

| Find the source file at https://sourceforge.net/projects/pbwa/files/
| In the home dir of pBWA

| `` module load openmpi/2.1.0-intel-2017``
| `` make       //now a executable file ‘pBWA’’ is created in current directory``
