.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

About
=====

SAM Tools provide various utilities for manipulating alignments in the
SAM format, including sorting, merging, indexing and generating
alignments in a per-position format.

Version
=======

1.5 with intel-2017-lp64 compiler

Compiling
=========

Compile SAMTOOLS
----------------

Find source file at https://github.com/samtools/samtools/releases/

-  Configure

`` module load compilers/intel-2017-lp64``

HTSLib has to be built first since Samtools uses it internally.

| ``./configure CC=icc --prefix=/your/installation/location``
| ``make all all-htslib``
| ``make install install-htslib``

Now install samtools

| `` make``
| `` make install``

Excusable files are now placed under , you can add this location into
your PATH.

Compile BCFTOOLS
----------------

SAMTOOLS requires that BCFTOOLS be installed at the same version number.

Find source file at https://github.com/samtools/bcftools/releases/

-  Configure

`` module load compilers/intel-2017-lp64``

HTSLib has to be built first since bcftools uses it internally.

| ``./configure CC=icc --prefix=/your/installation/location``
| ``make all all-htslib``
| ``make install install-htslib``

Now install bcftools

`` make install``

Excusable files are now placed under , you can add this location into
your PATH.
