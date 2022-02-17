.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

About
=====

The MMTSB Tool Set is a collection of perl-based user-level utilities as
well as programming libraries for multiscale protein structure modeling.
Intended applications include protein structure prediction, loop
modeling, structure refinement, and structure evaluation/scoring.

Install
=======

Find download link from http://www.mmtsb.org/software/mmtsbtoolset.html,
you need to register first.

-  Configure

| `` module load compilers/intel-2017-lp64``
| `` ./install.sh INTEL``

After installation, executables are placed in mmtsb/perl and mmtsb/bin,
then you need to set environment variables:

| `` export MMTSBDIR=/root/directory/of/mmtsb``
| `` export PATH=$PATH:$MMTSBDIR/perl``
| `` export PATH=$PATH:$MMTSBDIR/bin``
