==================================
Software Management w/Spack
==================================

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

------------
Introduction
------------

Spack is a package manager for supercomputers, Linux, and macOS. It makes
installing scientific software easy. Spack isn't tied to a particular language;
you can build a software stack in Python or R, link to libraries written in C,
C++, or Fortran, and easily swap compilers or target specific
microarchitectures.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

----------
Motivation
----------

Researchers across all disciplines will often develop software to tackle their
specific research problems. Many of these packages will be re-used and modified
by other researchers, which leads to significant growth in both research scope
and quality. These applications increasingly leverage the substantial power of
modern HPC systems; in fact, many of them are developed with this in mind. Thus,
researchers have significant interest in their software being available and
functional on many different platforms.

Spack is a tool that is specifically designed for this task; complex
installation procedures and dependency requirements are codified in Python, for
easy replication on any available system. While Spack is primarily aimed at
scientific software *developers*, we will instead be using it to *manage*
scientific software stacks in the production, multi-user environment on the DEAC
cluster.

With this in mind, we will assume

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

--------
Tutorial
--------

Useful commands
===============

.. code-block:: console

    export TMPDIR=/scratch/$SLURM_JOBID
    spack config --scope=user edit config
    spack config --scope=user edit modules
    spack gc
    spack clean -a
    spack module tcl refresh --delete-tree -y

.. code-block:: console

    spack spec -I openmpi@4.0.3 %intel +cxx fabrics=auto schedulers=auto
    spack spec -I quantum-espresso %intel hdf5=parallel +epw +scalapack
    spack spec -I abinit %intel +hdf5 +scalapack

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

-----
To-Do
-----

* default opimizations on packages?
* using views for users, relevant to R/Python/Perl
* spack job submission
* audit build recipes
* catalog idea, but with databases obtained from spack or via Lmod spider JSON
* special 'bundle' modulefiles

    * SCC
    * Toolchains

* `Spack python scripting <https://spack-tutorial.readthedocs.io/en/latest/tutorial_spack_scripting.html>`_
* Spack stack installation via environments (python, R, dft, cuda, etc.)
