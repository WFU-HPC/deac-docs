.. contents::
   :depth: 3
..

`category:Software </category:Software>`__
`category:Compiling </category:Compiling>`__

About
=====

Matrix Algebra on GPU and Multicore Architectures (MAGMA) is a dense
linear algebra library similar to LAPACK but for heterogeneous/hybrid
architectures, starting with current "Multicore+GPU" systems.

Compiling
=========

Find link to source file at
http://icl.cs.utk.edu/magma/software/index.html

-  Configuration

| `` module purge``
| `` module load openmpi/2.1.0-intel-2017``
| `` module load cuda-8.0``

Prepare makefile by creating make.inc under the root directory of magma.
There are several templates locate under <make.inc-examples> dicrectory,
we can utilize make.inc.mkl-icc-ilp64 without modification:

| `` cp ./make.inc-examples/make.inc.mkl-icc-ilp64 make.inc``
| `` make share``
| `` make install prefix=/your/installation/path``
