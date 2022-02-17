.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__ GPAW is a module for ASE
which depends on SCALAPACK... both SCALAPACK and ASE must be downloaded
first.

SCALAPACK
=========

ScaLAPACK is a library of high-performance linear algebra routines for
parallel distributed memory machines. ScaLAPACK solves dense and banded
linear systems, least squares problems, eigenvalue problems, and
singular value problems. It can be downloaded from:
http://www.netlib.org/scalapack/

| ``    $ module load openmpi/1.6-gnu``
| ``    $ mkdir ~/src``
| ``    $ cd ~/src``
| ``    $ wget ``\ ```http://www.netlib.org/scalapack/scalapack_installer.tgz`` <http://www.netlib.org/scalapack/scalapack_installer.tgz>`__
| ``    $ tar zxf scalapack_installer.tgz``
| ``    $ cd scalapack_install_1.0.2``
| ``    $ ./setup.py --prefix=$HOME --downall --ldflags_c="-L/usr/lib64 -llapack -lblas" --ldflags_fc="-L/usr/lib64 -llapack -lblas" --blaslib=/usr/lib64/libblas.a --lapacklib=/usr/lib64/liblapack.a``
| ``    ``\ **``When``\ ````\ ``asked``\ ````\ ``"Which``\ ````\ ``BLAS``\ ````\ ``library``\ ````\ ``do``\ ````\ ``you``\ ````\ ``want``\ ````\ ``to``\ ````\ ``use?"``\ ````\ ``hit``\ ````\ ``"b"``**
| ``    ``

This installs Scalapack into $HOME/lib -- you should see
$HOME/lib/libscalapack.a after it completes

ASE
===

The Atomic Simulation Environment (ASE) is a set of tools and Python
modules for setting up, manipulating, running, visualizing and analyzing
atomistic simulations. The code is freely available under the GNU LGPL
license. It can be downloaded from: http://svn.fysik.dtu.dk/

| ``    $ cd ~/src``
| ``    $ wget ``\ ```https://svn.fysik.dtu.dk/projects/ase/tags/3.6.0`` <https://svn.fysik.dtu.dk/projects/ase/tags/3.6.0>`__
| ``    $ cd 3.6.0``
| ``    $ ./setup.py build``
| ``    $ ./setup.py install --user``

This installs the ASE Python module into $HOME/.local

Edit your login file ~/.cshrc to add the following:

``    setenv PATH $HOME/.local/bin:$PATH``

Check that ASE was actually installed:

``    $ ls -l ~/.local/bin``

GPAW
====

GPAW is a density-functional theory (DFT) Python code based on the
projector-augmented wave (PAW) method and the atomic simulation
environment (ASE). It can be downlaoded from:
https://wiki.fysik.dtu.dk/gpaw/

| ``    $ cd ~/src``
| ``    $ wget ``\ ```https://wiki.fysik.dtu.dk/gpaw-files/gpaw-0.9.0.8965.tar.gz`` <https://wiki.fysik.dtu.dk/gpaw-files/gpaw-0.9.0.8965.tar.gz>`__
| ``    $ tar zxf gpaw-0.9.0.8965.tar.gz``
| ``    $ cd gpaw-0.9.0.8965``
| ``    $ python setup.py build_ext``
| ``    $ python setup.py install --user``

This succeeds in building only the serial version of GPAW.

Check that gpaw was installed:

``    $ ls -l ~/.local/bin``

Make sure that your environment is updated:

``    $ source ~/.cshrc``
