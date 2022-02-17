.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

About
=====

**AutoDock** is a suite of automated docking tools. It is designed to
predict how small molecules, such as substrates or drug candidates, bind
to a receptor of known 3D structure.  [1]_ Current distributions of
AutoDock consist of two generations of software: AutoDock 4 and
`AutoDock Vina </Software:Autodock_Vina>`__.

Versions
========

Current versions installed on the cluster:

:\***4.2.5.1**

Compiling
=========

Download from source reference below:

| ``    $ module purge``
| ``    $ module load compilers/intel-2012-lp64``
| ``    $ cd ~/src``
| ``    $ mv ../autodocksuite-x.y.z.a-src.tar.gz .``
| ``    $ tar zxf autodocksuite-x.y.z.a-src.tar.gz``
| ``    $ cd src/autodock``
| ``    $ mkdir x86_64Linux2``
| ``    $ cd x86_64Linux2``
| ``    $ export CXXFLAGS="-O3 -xSSE4.1 -ipo"``
| ``    $ ../configure --prefix=$HOME``
| ``    $ make >& Make.out``
| ``    $ make check >& Make.check.out``
| ``    $ make install``

Usage
=====

``    module load autodock/4.2.5.1-intel-2012``

The executable is **autodock4**

References
==========

.. raw:: html

   <references/>

.. [1]
   [http://autodock.scripps.edu/ AutoDock Web Site
