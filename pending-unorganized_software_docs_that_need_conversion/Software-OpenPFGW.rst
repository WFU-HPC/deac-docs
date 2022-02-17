.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__
**OpenPFGW** is software that is designed to perform PRP and primality
tests on numbers of specific forms. It must be downloaded, compiled, and
run from user home directories.

Compilation Instructions
========================

Setup
-----

First, create a directory for the downloads and compilations:

``    mkdir ~/Src/``

and cd into that directory

``    cd ~/Src/``

Move all downloads described below into this directory.

Downloads
---------

-  openpfgw.tar.gz
-  gmp
-  gwnum

GMP
---

-  Download the source package from http://gmplib.org/ - example uses:
   gmp-5.0.2.tar.bz2
-  Expand the package:

``    tar jxf gmp-5.0.2.tar.bz2``

-  This creates the directory gmp-5.0.2 -- cd into it:

``    cd gmp-5.0.2``

-  Do a standard configure and make, setting the installation to your
   home directory:

| ``    ./configure --prefix=$HOME --enable-cxx``
| ``    make >& Make.out ``

-  Wait for the make to complete, and then run the provided tests and
   make sure all are passed:

``    make check >& Make.check.out ``

-  View the file Make.check.out and look for lines which say something
   like "All 30 tests passed".
-  Install the package:

``    make install``

GWNUM
-----

GWNUM is part of the GIMPS package.

-  Create a subdirectory under Src for the GIMPS package:

``    mkdir ~/Src/gimps``

-  Download version 2.65 from http://www.mersenneforum.org/gimps/ --
   package is source265.zip and move it into the gimps directory

| ``    mv source265.zip ~/Src/gimps``
| ``    cd ~/Src/gimps``

-  Expand the archive, and cd into the gwnum directory:

| ``    unzip source265.zip``
| ``    cd gwnum``

-  Modify the gwnum makefile **~/Src/gimps/gwnum/make64** so that the
   CFLAGS and CPPFLAGS lines look like the following:

| ``    CFLAGS = -I.. -DX86_64 -O2 -m64 -march=k8 -mtune=k8``
| ``    CPPFLAGS = -I.. -I../qd -DX86_64 -O2 -m64 -march=k8 -mtune=k8``

-  Build the package:

``    make -f make64``

OpenPFGW
--------

-  Download the source code:

| ``    cd ~/Src/``
| ``    svn co https://openpfgw.svn.sourceforge.net/svnroot/openpfgw openpfgw``

-  Copy the appropriate files from GMP and GWNUM into the appropriate
   directories in openpfgw
-  GMP:

| ``    cp ~/lib/libgmp*.a ~/Src/openpfgw/packages/gmp/64bit``
| ``    cp ~/include/gmp*.h ~/Src/openpfgw/packages/gmp/64bit``

-  GWNUM:

| ``    cp ~/Src/gimps/gwnum/gwnum.a ~/Src/openpfgw/packages/gwnum/64bit``
| ``    cp ~/Src/gimps/gwnum/*.h ~/Src/openpfgw/packages/gwnum/64bit``

-  Edit the file **~/Src/openpfgw/make.inc** to add a PFGWSRC line, and
   so that the CFLAGS and CXXFLAGS lines look like this:

| ``    IS64 = 1``
| ``    PFGWSRC=${HOME}/Src/openpfgw``
| ``    ifeq ($(IS64),1)``
| ``    CFLAGS = -O2 -m64 -march=k8 -mtune=k8 -DX86_64 -D_64BIT -I../../packages/gmp/64bit -I${PFGWSRC}/pfconfig/headers``
| ``    CXXFLAGS = -O2 -m64 -march=k8 -mtune=k8 -DX86_64 -D_64BIT  -I../../packages/gmp/64bit -I${PFGWSRC}/pfconfig/headers``
| ``    endif``
| ``    ``
| ``    ifeq ($(IS64),0)``
| ``    CFLAGS  = -O2 -malign-double -m32 -I../../packages/gmp/32bit``
| ``    CXXFLAGS    = -O2 -malign-double -m32 -I../../packages/gmp/32bit``
| ``    endif``

-  **cd** into the openpfgw directory:

``    cd ~/Src/openpfgw``

-  Edit all the following **pform** makefiles, and remove the line that
   says "include deps.d" (this is usually the last line in the files):

| ``    ~/Src/openpfgw/pform/pflib/makefile``
| ``                         pfmath/makefile``
| ``                         pfgwlib/makefile``
| ``                         pfglue/makefile``
| ``                         pfoo/makefile``
| ``                         pfio/makefile``
| ``                         pfgw/makefile``

-  Create all the submakefiles for the prmsieve subproject. For each of
   the following MODULEs -- **erat**, **atkins**, **compress**,
   **tables**, **arith** -- do:

| ``    cd pform/prmsieve/``\ *``MODULE``*
| ``    sh configure``
| ``    cd ../..``

-  Edit the main pfgw makefile, and add "**-lpthread -lstdc++**" to the
   pfgw64 rule (the bits in bold below):

| ``    pfgw64: baselib integer fft glue pfoo io entrypoint prmsieve``
| ``        ${CXX} ${CXXFLAGS}  \``
| ``            pform/pfgw/.libs/pfgw_main.a  pform/pfio/.libs/pfio.a pform/pfoo/.libs/pfoo.a pform/pfglue/.libs/pfglue.a pform/pfgwlib/.libs/pfgwlib.a \``
| ``            pform/pfmath/.libs/pfmath.a pform/pflib/.libs/pflib.a pform/prmsieve/.libs/prmsieve.a packages/gmp/64bit/libgmp.a \``
| ``            packages/gwnum/64bit/gwnum.a  -o pfgw64 ``\ **``-lpthread``\ ````\ ``-lstdc++``**

-  Build pfgw64:

``    make pfgw64``

That process creates the executable **pfgw64**.

External Links
==============

-  `OpenPFGW project page <http://sourceforge.net/projects/openpfgw/>`__
-  `Mersenne Forum GIMPS download
   page <http://www.mersenneforum.org/gimps/>`__
-  `GNU Multiple Precision Arithmetic Library
   (GMP) <http://gmplib.org/>`__
