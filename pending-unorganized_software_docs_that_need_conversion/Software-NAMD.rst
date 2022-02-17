.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Quick
Start </Category:Quick_Start>`__\ `Category:Compiling </Category:Compiling>`__
**NAMD** is molecular dynamics code from the Theoretical and
Computational Biophysics Group at UIUC. [1]_

Versions
========

Versions installed on the cluster include:

:\* **2.8**

:\* **2.9**

:\* **2.10**

:\* **2.12**

Running NAMD 2.10
=================

To run NAMD, select one of the two versions available and load the
`module file </Quick_Start_Guide:Environment_Modules>`__

-  **namd/2.10-icc-serial** -- NAMD 2.10 64-bit Serial execution with
   Intel Compilers
-  **namd/2.10-inf-icc-openmpi** -- NAMD 2.10 Infiniband with Intel
   Compilers (No MPI needed)

Below is an example of running the Infiniband version without MPI (even
though it is loaded)

::

   #!/bin/bash
   #SBATCH --partition=debug
   #SBATCH --job-name="NameofJobHere"
   #SBATCH --constraint="infiniband"
   #SBATCH --switches=1
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=8
   #SBATCH --cpus-per-task=1
   #SBATCH --time=0-00:60:00
   #SBATCH --output="NameofJobHere-%j.o"
   #SBATCH --error="NameofJobHere-%j.e"
   #SBATCH --mail-type=BEGIN,END,FAIL
   #SBATCH --account="yourFairShareGrp"
   #SBATCH --mem=512mb
   ############### set variables for directories
   HOMEDIR=/path/to/your/working/directory
   ############### loading modules
   module load namd/2.10-inf-icc-openmpi
   module load mpiexec/0.84-intel-2012
   cd $HOMEDIR
   # run NAMD scripts 
   mpirun --mca btl ^tcp namd2 $HOMEDIR/myinput.inp > $HOMEDIR/myoutputfile.out

Few notes from the example above:

-  As it can be seen, the Infiniband parameters are not necessary like
   in the previous versions (2.8 & 2.9)
-  Name your job to anything that makes sense to YOU!
-  The number of nodes above, it can be any number > 0
-  To correctly use Infiniband for the job,use the infiniband partition
   and define "switches=1"
-  You would need to setup your own memory values
-  Set your FairShare group correctly
-  Set your walltime and cpu time correctly

Running NAMD 2.8 & 2.9
======================

To run NAMD, select one of the four (2.8) or two (2.9) versions
available and load the `module
file </Using_modules_to_configure_your_environment>`__

-  namd/2.8-tcp -- NAMD 2.8 TCP (uses Ethernet)
-  namd/2.8-ibverbs -- NAMD 2.8 with Infiniband
-  namd/2.8-icc-openmpi -- NAMD 2.8 compiled with Intel compilers and
   OpenMPI
-  namd/2.9-icc-openmpi -- NAMD 2.9 compiled with Intel compilers and
   OpenMPI

We recommend one of these two for ease of use: namd/2.8-icc-openmpi, and
namd/2.9-icc-openmpi

The Intel-compiled version supports both ethernet and Infiniband. Users
will need to do their own benchmarking to see the exact performance
differences between the different versions. Do:

``   module load namd/2.9-icc-openmpi``

and all the NAMD programs will be on your path.

We have compiled NAMD with MPI and integration with `SLURM </SLURM>`__,
the resource manager. That means that you do not have to use charmrun,
nor do you have to generate a nodelist file. To run:

``   mpirun namd2 configfile >& outputfile``

If you want to run using `Infiniband </Infiniband>`__, in addition to
specifying the "Infiniband" partition and "switches=1":

``   mpirun --mca btl ^tcp namd2 configfile >& outputfile``

Please see `Quick Start Guide:GNU
OpenMPI </Quick_Start_Guide:GNU_OpenMPI>`__ for more information on
using OpenMPI.

Compiling
=========

NAMD & Charm++ 2.12
-------------------

These are instructions for compiling NAMD from the source distribution
using Intel compilers.

#. Read notes.txt in the source distribution.
#. Build Charm++
#. Build NAMD, which depends on Charm++

The modules created for this version

| ``    namd/2.12-icc-serial``
| ``    namd/2.12-openmpi-cuda``

-  The module for the serial & cuda were obtained by the pre-built TAR
   file from the NAMD website

-  The MPI-Intel/Infiniband version has to be build from source.

Build Charm++ 2.12
~~~~~~~~~~~~~~~~~~

The first line (module load ...) sets up the environment to use the
Intel compilers.

| ``    module load openmpi/3.1.1-intel-2018``
| ``    tar -xzvf NAMD_2.12_Source.tar.gz``
| ``    cd NAMD_2.12_Source``
| ``    tar xvf charm-6.7.1.tar ``
| ``    cd charm-6.7.1``
| ``    ./build charm++ mpi-linux-x86_64 mpicxx ifort -j12 --with-production``

This builds in a directory named **``mpi-linux-x86_64-ifort-mpicxx``**
The output should look like:

| ``    -------------------------------------------------``
| ``    charm++ built successfully.``
| ``    Next, try out a sample program like mpi-linux-x86_64-ifort-mpicxx/tests/charm++/simplearrayhello``

Test CHARM
~~~~~~~~~~

Instead of their suggested example, try this one instead

| ``    cd mpi-linux-x86_64-ifort-mpicxx/tests/charm++/megatest``
| ``    make pgm``
| ``    (wait for a bit)``
| ``    (you should have no errors)``
| ``    mpirun -n 4 ./pgm``

Expected output:

| ``    ...``
| ``    Starting test``
| ``    Created detector, starting first detection``
| ``    test 52: completed (0.00 sec)``
| ``    test 53: initiated [all-at-once]``
| ``    Started first test``
| ``    Finished second test``
| ``    Started third test``
| ``    test 53: completed (0.02 sec)``
| ``    All tests completed, exiting``
| ``    [Partition 0][Node 0] End of program``

All done with test.

Build NAMD 2.12
~~~~~~~~~~~~~~~

| ``    module load gcc/6.2.0``
| ``    module load libs/fftw-3.3.8/intel-2018-float``
| ``    module load openmpi/3.1.1-intel-2018``

| ``    cd NAMD_2.12_Source``
| ``    ``\ *``Edit``\ ````\ ``Make.charm``\ ````\ ``--``\ ````\ ``set``\ ````\ ``CHARMBASE``\ ````\ ``CHARMBASE``\ ````\ ``=``\ ````\ ``/deac/opt/src/NAMD/NAMD_2.12_Source/charm-6.7.1``*
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64-g++.arch``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.fftw``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.tcl``*\ ``  ``\ **``See``\ ````\ ``below``**
| ``    ./config Linux-x86_64-g++ --charm-arch mpi-linux-x86_64-ifort-mpicxx``
| ``    cd Linux-x86_64-g++``
| ``    make >& Make.out &``

Here are the contents of the three files that need to be edited above:

-  the "-static-intel" flag is optional -- it directs the compiler to
   link against static versions of the Intel libraries
-  In this case, the "-static-intel" flag was failing...so, **DON'T USE
   IT**

| ``# '''arch/Linux-x86_64-g++.arch``
| ``NAMD_ARCH = Linux-x86_64``
| ``CHARMARCH = mpi-linux-x86_64-ifort-mpicxx``
| ``CXX = g++ -O3``
| ``CXXOPTS =``
| ``CC = gcc -O3``
| ``COPTS =``

| ``# ``\ **``arch/Linux-x86_64.fftw``**
| ``FFTDIR=$(FFTW3DIR)``
| ``FFTINCL=-I$(FFTDIR)/include``
| ``FFTLIB=-L$(FFTDIR)/lib -Wl,-rpath,$(FFTDIR)/lib -lsrfftw -lsfftw``
| ``FFTFLAGS=-DNAMD_FFTW``
| ``FFT=$(FFTINCL) $(FFTFLAGS)``

| ``# ``\ **``arch/Linux-x86_64.tcl``**\ `` ``
| ``TCLDIR=/usr``
| ``TCLINCL=-I$(TCLDIR)/include``
| ``TCLLIB=-L$(TCLDIR)/lib64 -ltcl8.5 -ldl``
| ``TCLFLAGS=-DNAMD_TCL``
| ``TCL=$(TCLINCL) $(TCLFLAGS)``

Test
~~~~

Simple test:

| ``    mpirun -np 2 ./namd2 ../src/alanin``
| ``    ``\ *``Expect``\ ````\ ``no``\ ````\ ``error``\ ````\ ``messages``\ ````\ ``and``\ ````\ ``a``\ ````\ ``fast``\ ````\ ``test``\ ````\ ``too``*

More complex test (only on single node):

| ``    wget ``\ ```http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz`` <http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz>`__
| ``    tar xzf apoa1.tar.gz``

Test CHARM++ with APOA1

``    ./charmrun +p4 ./namd2 apoa1/apoa1.namd ``

Test NAMD with APOA1

``    mpirun -np 2 ./namd2 apoa1/apoa1.namd >& apoa1.out &``

Install
~~~~~~~

| ``    mkdir ``\ *``DESTINATION_DIR``*
| ``    mv scp charmrun flipbinpdb flipdcd sortreplicas psfgen namd2 ``\ *``DESTINATION_DIR``*\ ``     ``\ **``#``\ ````\ ``Select``\ ````\ ``your``\ ````\ ``own``\ ````\ ``destination``**
| ``    cd ..``
| ``    scp -r lib ``\ *``DESTINATION_DIR``*
| ``    scp announce.txt license.txt notes.txt README.txt ``\ *``DESTINATION_DIR``*\ `` (optional I suppose)``

NAMD & Charm++ 2.11
-------------------

The modules created for this version

| ``    namd/2.11-icc-serial``
| ``    namd/2.11-IB-openmpi``
| ``    namd/2.11-openmpi-cuda``

-  The module for the serial & CUDA binaries were obtained by the
   pre-built TAR file from the NAMD website

-  The MPI-Intel/Infiniband version has to be build from source.

Build Charm++ 2.11
~~~~~~~~~~~~~~~~~~

The first two lines (module load ...) set up the environment to use the
Intel compilers and the FFTW3 single-precision libraries.

| ``    module load openmpi/1.6-intel``
| ``    module load libs/fftw-3.3.2/intel-2012-single``
| ``    tar -xzvf NAMD_2.11_Source.tar.gz``
| ``    cd NAMD_2.11_Source``
| ``    tar xvf charm-6.7.0.tar ``
| ``    cd charm-6.7.0``
| ``    export MPICXX=mpicxx   # This is for bash. For tcsh, use "setenv MPICXX mpicxx"``
| ``    ./build charm++ mpi-linux-x86_64 mpicxx  ifort -j4  --with-production --enable-tracing``

This builds in a directory named **``mpi-linux-x86_64-ifort-mpicxx``**
The output should look like:

| ``    -------------------------------------------------``
| ``    charm++ built successfully.``
| ``    Next, try out a sample program like mpi-linux-x86_64-ifort-mpicxx/tests/charm++/simplearrayhello``

.. _test-charm-1:

Test CHARM
~~~~~~~~~~

Instead of their suggested example, try this one instead

| ``    cd mpi-linux-x86_64-ifort-mpicxx/tests/charm++/megatest``
| ``    make pgm``
| ``    (wait for a bit)``
| ``    (you should have no errors)``
| ``    mpirun -n 4 ./pgm``

Expected output:

| ``    ...``
| ``    Starting test``
| ``    Created detector, starting first detection``
| ``    test 52: completed (0.00 sec)``
| ``    test 53: initiated [all-at-once]``
| ``    Started first test``
| ``    Finished second test``
| ``    Started third test``
| ``    test 53: completed (0.02 sec)``
| ``    All tests completed, exiting``
| ``    [Partition 0][Node 0] End of program``

All done with test.

Build NAMD 2.11
~~~~~~~~~~~~~~~

| ``    module load libs/fftw-3.3.2/intel-2012-single``
| ``    module load openmpi/1.6-intel``

| ``    cd NAMD_2.11_Source``
| ``    ``\ *``Edit``\ ````\ ``Make.charm``\ ````\ ``--``\ ````\ ``set``\ ````\ ``CHARMBASE``\ ````\ ``CHARMBASE``\ ````\ ``=``\ ````\ ``/deac/opt/src/NAMD/NAMD_2.11_Source``*
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64-icc.arch``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.fftw``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.tcl``*\ ``  ``\ **``See``\ ````\ ``below``**
| ``    ./config Linux-x86_64-icc --charm-arch mpi-linux-x86_64-ifort-mpicxx``
| ``    cd Linux-x86_64-icc``
| ``    make >& Make.out &``

Here are the contents of the three files that need to be edited above:

-  the "-static-intel" flag is optional -- it directs the compiler to
   link against static versions of the Intel libraries
-  In this case, the "-static-intel" flag was failing...so, **DON'T USE
   IT**

| ``# '''arch/Linux-x86_64-icc.arch``
| ``NAMD_ARCH = Linux-x86_64``
| ``CHARMARCH = mpi-linux-x86_64-ifort-mpicxx``
| ``FLOATOPTS = -ip -fno-rtti -no-vec``
| ``CXX = icpc``
| ``CXXOPTS = -O3 -xSSE2 $(FLOATOPTS)``
| ``CXXNOALIASOPTS = -O3 -fno-alias $(FLOATOPTS)``
| ``CC = icc``
| ``COPTS = -O3 -xSSE2 $(FLOATOPTS)``

| ``# ``\ **``arch/Linux-x86_64.fftw``**\ `` -- n.b. FFTW3DIR is set when you do "module load libs/fftw-3.3.2/intel-2012-single"``
| ``FFTDIR=$(FFTW3DIR)``
| ``FFTINCL=-I$(FFTDIR)/include``
| ``FFTLIB=-L$(FFTDIR)/lib -Wl,-rpath,$(FFTDIR)/lib -lsrfftw -lsfftw``
| ``FFTFLAGS=-DNAMD_FFTW``
| ``FFT=$(FFTINCL) $(FFTFLAGS)``

| ``# ``\ **``arch/Linux-x86_64.tcl``**\ `` ``
| ``TCLDIR=/usr``
| ``TCLINCL=-I$(TCLDIR)/include``
| ``TCLLIB=-L$(TCLDIR)/lib64 -ltcl8.5 -ldl``
| ``TCLFLAGS=-DNAMD_TCL``
| ``TCL=$(TCLINCL) $(TCLFLAGS)``

.. _test-1:

Test
~~~~

Simple test:

| ``    mpirun -np 2 ./namd2 ../src/alanin``
| ``    ``\ *``Expect``\ ````\ ``no``\ ````\ ``error``\ ````\ ``messages``\ ````\ ``and``\ ````\ ``a``\ ````\ ``fast``\ ````\ ``test``\ ````\ ``too``*

More complex test (only on single node):

| ``    wget ``\ ```http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz`` <http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz>`__
| ``    tar xzf apoa1.tar.gz``

Test CHARM++ with APOA1

``    ./charmrun +p4 ./namd2 apoa1/apoa1.namd ``

Test NAMD with APOA1

``    mpirun -np 2 ./namd2 apoa1/apoa1.namd >& apoa1.out &``

Run this twice -- the first one will do some FFTW work that is written
to files, which a later run will read in.

.. _install-1:

Install
~~~~~~~

| ``    mkdir ``\ *``DESTINATION_DIR``*
| ``    mv scp charmrun flipbinpdb flipdcd sortreplicas psfgen namd2 ``\ *``DESTINATION_DIR``*\ ``     ``\ **``#``\ ````\ ``Select``\ ````\ ``your``\ ````\ ``own``\ ````\ ``destination``**
| ``    cd ..``
| ``    scp -r lib ``\ *``DESTINATION_DIR``*
| ``    scp announce.txt license.txt notes.txt README.txt ``\ *``DESTINATION_DIR``*\ `` (optional I suppose)``

Compiling NAMD & Charm++ 2.11
-----------------------------

Build Charm++ 2.10
~~~~~~~~~~~~~~~~~~

The first two lines (module load ...) set up the environment to use the
Intel compilers and the FFTW3 single-precision libraries.

| ``    module load openmpi/1.6-intel``
| ``    module load libs/fftw-3.3.2/intel-2012-single``
| ``    tar -xzvf NAMD_2.10_Source.tar.gz``
| ``    cd NAMD_2.10_Source``
| ``    tar xvf charm-6.6.1.tar ``
| ``    cd charm-6.6.1``
| ``    export MPICXX=mpicxx   # This is for bash. For tcsh, use "setenv MPICXX mpicxx"``
| ``    ./build charm++ mpi-linux-x86_64 mpicxx  ifort -j4  --with-production --enable-tracing``

This builds in a directory named **``mpi-linux-x86_64-ifort-mpicxx``**
The output should look like:

| ``    -------------------------------------------------``
| ``    charm++ built successfully.``
| ``    Next, try out a sample program like mpi-linux-x86_64-ifort-mpicxx/tests/charm++/simplearrayhello``

.. _test-charm-2:

Test CHARM
~~~~~~~~~~

Instead of their suggested example, try this one instead

| ``    cd mpi-linux-x86_64-ifort-mpicxx/tests/charm++/megatest``
| ``    make pgm``
| ``    (wait for a bit)``
| ``    (you should have no errors)``
| ``    mpirun -n 4 ./pgm``

Expected output:

| ``    ...``
| ``    Starting test``
| ``    Created detector, starting first detection``
| ``    test 52: completed (0.00 sec)``
| ``    test 53: initiated [all-at-once]``
| ``    Started first test``
| ``    Finished second test``
| ``    Started third test``
| ``    test 53: completed (0.02 sec)``
| ``    All tests completed, exiting``
| ``    [Partition 0][Node 0] End of program``

All done with test.

Build NAMD 2.10
~~~~~~~~~~~~~~~

| ``    module load libs/fftw-2.1.5/intel-2012-float``
| ``    module load openmpi/1.6-intel``

| ``    cd NAMD_2.10_Source``
| ``    ``\ *``Edit``\ ````\ ``Make.charm``\ ````\ ``--``\ ````\ ``set``\ ````\ ``CHARMBASE``\ ````\ ``CHARMBASE``\ ````\ ``=``\ ````\ ``/rhel6/opt/src/NAMD/NAMD_2.10_Source``*
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64-icc.arch``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.fftw``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.tcl``*\ ``  ``\ **``See``\ ````\ ``below``**
| ``    ./config Linux-x86_64-icc --charm-arch mpi-linux-x86_64-ifort-mpicxx``
| ``    cd Linux-x86_64-icc``
| ``    make >& Make.out &``

Here are the contents of the three files that need to be edited above:

-  the "-static-intel" flag is optional -- it directs the compiler to
   link against static versions of the Intel libraries
-  In this case, the "-static-intel" flag was failing...so, **DON'T USE
   IT**

| ``# '''arch/Linux-x86_64-icc.arch``
| ``NAMD_ARCH = Linux-x86_64``
| ``CHARMARCH = mpi-linux-x86_64-ifort-mpicxx``
| ``FLOATOPTS = -ip -fno-rtti -no-vec``
| ``CXX = icpc``
| ``CXXOPTS = -O3 -xSSE2 $(FLOATOPTS)``
| ``CXXNOALIASOPTS = -O3 -fno-alias $(FLOATOPTS)``
| ``CC = icc``
| ``COPTS = -O3 -xSSE2 $(FLOATOPTS)``

| ``# ``\ **``arch/Linux-x86_64.fftw``**\ `` -- n.b. FFTW2DIR is set when you do "module load libs/fftw-2.1.5/intel-2012-float"``
| ``FFTDIR=$(FFTW2DIR)``
| ``FFTINCL=-I$(FFTDIR)/include``
| ``FFTLIB=-L$(FFTDIR)/lib -Wl,-rpath,$(FFTDIR)/lib -lsrfftw -lsfftw``
| ``FFTFLAGS=-DNAMD_FFTW``
| ``FFT=$(FFTINCL) $(FFTFLAGS)``

| ``# ``\ **``arch/Linux-x86_64.tcl``**\ `` ``
| ``TCLDIR=/usr``
| ``TCLINCL=-I$(TCLDIR)/include``
| ``TCLLIB=-L$(TCLDIR)/lib64 -ltcl8.5 -ldl``
| ``TCLFLAGS=-DNAMD_TCL``
| ``TCL=$(TCLINCL) $(TCLFLAGS)``

.. _test-2:

Test
~~~~

Simple test:

| ``    mpirun -np 2 ./namd2 ../src/alanin``
| ``    ``\ *``Expect``\ ````\ ``no``\ ````\ ``error``\ ````\ ``messages``\ ````\ ``and``\ ````\ ``a``\ ````\ ``fast``\ ````\ ``test``\ ````\ ``too``*

More complex test (only on single node):

| ``    wget ``\ ```http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz`` <http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz>`__
| ``    tar xzf apoa1.tar.gz``

Test CHARM++ with APOA1

``    ./charmrun +p4 ./namd2 apoa1/apoa1.namd ``

Test NAMD with APOA1

``    mpirun -np 2 ./namd2 apoa1/apoa1.namd >& apoa1.out &``

Run this twice -- the first one will do some FFTW work that is written
to files, which a later run will read in.

.. _install-2:

Install
~~~~~~~

| ``    mkdir ``\ *``DESTINATION_DIR``*
| ``    mv scp charmrun flipbinpdb flipdcd sortreplicas psfgen namd2 ``\ *``DESTINATION_DIR``*\ ``     ``\ **``#``\ ````\ ``Select``\ ````\ ``your``\ ````\ ``own``\ ````\ ``destination``**
| ``    cd ..``
| ``    scp -r lib ``\ *``DESTINATION_DIR``*
| ``    scp announce.txt license.txt notes.txt README.txt ``\ *``DESTINATION_DIR``*

Compiling NAMD & Charm++ 2.8
----------------------------

The available modules are

| ``    namd/2.8-g++``
| ``    namd/2.8-ibverbs``
| ``    namd/2.8-ibverbs-smp``
| ``    namd/2.8-icc-openmpi``
| ``    namd/2.8-tcp``

Build Charm++ 2.8
~~~~~~~~~~~~~~~~~

The first two lines (module load ...) set up the environment to use the
Intel compilers and the FFTW2 single-precision libraries.

| ``    module load openmpi/1.6-intel``
| ``    module load libs/fftw-2.1.5/intel-2012-float``
| ``    cd NAMD_2.8_Source``
| ``    tar xf charm-6.3.2.tar``
| ``    cd charm-6.3.2``
| ``    export MPICXX=mpicxx   # This is for bash. For tcsh, use "setenv MPICXX mpicxx"``
| ``    ./build charm++ mpi-linux-x86_64 mpicxx  ifort   -j4  --with-production --enable-tracing``

This builds in a directory named ``mpi-linux-x86_64-ifort-mpicxx``

Simple test:

| ``    cd mpi-linux-x86_64-ifort-mpicxx/tests/charm++/megatest``
| ``    make pgm``
| ``    mpirun -n 2 ./pgm``
| ``    ``\ *``Expect``\ ````\ ``no``\ ````\ ``error``\ ````\ ``messages``*

Build NAMD 2.8
~~~~~~~~~~~~~~

| ``    cd NAMD_2.8_Source``
| ``    ``\ *``Edit``\ ````\ ``Make.charm``\ ````\ ``--``\ ````\ ``set``\ ````\ ``CHARMBASE``\ ````\ ``to``\ ````\ ``absolute``\ ````\ ``path``\ ````\ ``to``\ ````\ ``charm``\ ````\ ``source``\ ````\ ``directory``\ ````\ ``(inside``\ ````\ ``the``\ ````\ ``NAMD_2.8_Source``\ ````\ ``directory)``*
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64-icc.arch``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.fftw``*\ `` ``\ **``See``\ ````\ ``below``**
| ``    ``\ *``Edit``\ ````\ ``arch/Linux-x86_64.tcl``*\ ``  ``\ **``See``\ ````\ ``below``**
| ``    ./config Linux-x86_64-icc --charm-arch mpi-linux-x86_64-ifort-mpicxx``
| ``    cd Linux-x86_64-icc``
| ``    make >& Make.out &``

Here are the contents of the three files that need to be edited above:

-  the "-static-intel" flag is optional -- it directs the compiler to
   link against static versions of the Intel libraries

| ``# '''arch/Linux-x86_64-icc.arch``
| ``NAMD_ARCH = Linux-x86_64``
| ``CHARMARCH = mpi-linux-x86_64-ifort-mpicxx``
| ``FLOATOPTS = -ip -fno-rtti -no-vec``
| ``CXX = icpc``
| ``CXXOPTS = -static-intel -O3 -xSSE2 $(FLOATOPTS)``
| ``CXXNOALIASOPTS = -O3 -fno-alias $(FLOATOPTS)``
| ``CC = icc``
| ``COPTS = -static-intel -O3 -xSSE2 $(FLOATOPTS)``

| ``# ``\ **``arch/Linux-x86_64.fftw``**\ `` -- n.b. FFTW2DIR is set when you do "module load libs/fftw-2.1.5/intel-2012-float"``
| ``FFTDIR=$(FFTW2DIR)``
| ``FFTINCL=-I$(FFTDIR)/include``
| ``FFTLIB=-L$(FFTDIR)/lib -Wl,-rpath,$(FFTDIR)/lib -lsrfftw -lsfftw``
| ``FFTFLAGS=-DNAMD_FFTW``
| ``FFT=$(FFTINCL) $(FFTFLAGS)``

| ``# ``\ **``arch/Linux-x86_64.tcl``**\ `` ``
| ``TCLDIR=/usr``
| ``TCLINCL=-I$(TCLDIR)/include``
| ``TCLLIB=-L$(TCLDIR)/lib64 -ltcl8.5 -ldl``
| ``TCLFLAGS=-DNAMD_TCL``
| ``TCL=$(TCLINCL) $(TCLFLAGS)``

.. _test-3:

Test
~~~~

Simple test:

| ``    mpirun -np 2 ./namd2 ../src/alanin``
| ``    ``\ *``Expect``\ ````\ ``no``\ ````\ ``error``\ ````\ ``messages``*

More complex test (only on single node):

| ``    wget ``\ ```http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz`` <http://www.ks.uiuc.edu/Research/namd/utilities/apoa1.tar.gz>`__
| ``    tar xzf apoa1.tar.gz``
| ``    mpirun -np 2 ./namd2 apoa1/apoa1.namd >& apoa1.out &``

Run this twice -- the first one will do some FFTW work that is written
to files, which a later run will read in.

.. _install-3:

Install
~~~~~~~

| ``    mkdir ``\ *``DESTINATION_DIR``*
| ``    mv charmrun flipbinpdb flipdcd namd2 psfgen ``\ *``DESTINATION_DIR``*\ ``     ``\ **``#``\ ````\ ``Select``\ ````\ ``your``\ ````\ ``own``\ ````\ ``destination``**
| ``    cd ..``
| ``    cp -R lib ``\ *``DESTINATION_DIR``*

References
==========

.. raw:: html

   <references/>

.. [1]
   `NAMD - Scalable Molecular Dynamics web page at
   UIUC <http://www.ks.uiuc.edu/Research/namd/>`__
