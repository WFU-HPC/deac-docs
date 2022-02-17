.. contents::
   :depth: 3
..

`category:Compiling </category:Compiling>`__
`category:Software </category:Software>`__

About
=====

SOAPdenovo is a novel short-read assembly method that can build a de
novo draft assembly for the human-sized genomes. The program is
specially designed to assemble Illumina GA short reads. It creates new
opportunities for building reference sequences and carrying out accurate
analyses of unexplored genomes in a cost effective way. Now the new
version is available. SOAPdenovo2, which has the advantage of a new
algorithm design that reduces memory consumption in graph construction,
resolves more repeat regions in contig assembly, increases coverage and
length in scaffold construction, improves gap closing, and optimizes for
large genome.

Version
=======

R240 with Intel-2017 compiler

Compiling
=========

-  Configuration

In the SOAPdenovo home dir:

| `` module load compilers/intel-2017-lp64``
| `` vim Makefile     //edit the Makefile to set compiler``

Edit the Makefile, change CC to icpc

`` CC = icpc``

Now, compile:

`` make``

Two executables named SOAPdenovo-127mer and SOAPdenovo-63mer now are
generated in the SOAPdenovo home dir.
