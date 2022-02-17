.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__
**Boost** provides free peer-reviewed portable C++ source
libraries. [1]_

Version
=======

Current versions installed on the cluster:

:\* **1.54.0**

Usage
=====

To set up environment, do:

``    module load boost/1.54.0-intel-2012``

Defines these environment variables:

-  BOOST_DIR - base Boost installation directory
-  BOOST_INCDIR = BOOST_INCLUDE - Boost includes directory
-  BOOST_LIBDIR - Boost lib directory
-  BOOST_VERSION = BOOST_LIB_VERSION = 1.54.0

Compiling
=========

With Intel-2012
---------------

| ``    $ ./bootstrap.sh --prefix=$HOME --with-toolset=intel-linux cflags="-O3 -xSSE4.1" cxxflags="-O3 -xSSE4.1"``
| ``    ###$ ./b2 --build-type=complete --layout=versioned --without-mpi --prefix=$HOME toolset=intel-linux variant=release threading=multi runtime-link=shared link=shared install``
| ``    $ ./b2 --without-mpi --prefix=$HOME toolset=intel-linux variant=release threading=multi runtime-link=shared link=shared install``

With Intel-2017
---------------

| `` ./bootstrap.sh --prefix=/your/installation/path --with-toolset=intel-linux``
| `` ./b2 --prefix=/your/installation/path toolset=intel-linux``

References
==========

.. raw:: html

   <references/>

.. [1]
   `Boost C++ Libraries website <http://www.boost.org/>`__
