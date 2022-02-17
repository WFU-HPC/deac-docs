.. contents::
   :depth: 3
..

.. raw:: mediawiki

   {{DISPLAYTITLE:Quick Start Guide:make}}

`Category:Quick
Start </Category:Quick_Start>`__\ `Category:Software </Category:Software>`__

What is Make?
=============

**Make** is a tool which controls the generation of executables and
other non-source files of a program from the program's source
files. [1]_ [2]_ It is typically used in compilation, but it is also
useful in generating TeX/LaTeX documents. In general, it manages
dependencies: which "target" or "product" depends on which "source"
files.

A Simple Makefile
=================

Makefiles are commonly named ``Makefile``. [3]_ [4]_. The basic element
of a makefile is the rule block:

| ``   TARGET: PREREQUISITES ... ``
| ``   [tab character]COMMAND``
| ``                  ...``
| ``                  ...``

Note that **all lines for the commands must start with a Tab
character**. Beware that some editors may insert multiple spaces instead
of an actual Tab.

Here is a basic Makefile for compiling the program BigProgram from
several source files:

| ``   # Everything on the same line after a # character is a comment``
| ``   # The following statements define variables which may be``
| ``   # used later on in the makefile``
| ``   CC=gcc``
| ``   CFLAGS=-O2 -Wall -g``
| ``   LIBS=-lm``
| ``           ``
| ``   # .PHONY declares targets which are not actual products``
| ``   .PHONY: clean``
| ``   ``
| ``   BIGSOURCES = BigProgram.c first.c second.c third.c``
| ``   ``
| ``   # BigProgram is a "target". It depends on BigProgram.c, first.c, ``
| ``   # second.c, and third.c.``
| ``   # If the timestamp on any of the files in $(BIGSOURCES) is newer than ``
| ``   # the timestamp on BigProgram, the commands "$(CC)..." will be executed. ``
| ``   # This compiles BigProgram.``
| ``   # Note that the "$(CC) ..." line starts with a Tab character``
| ``   # $@ and $^ are pre-defined variables:``
| ``   #     $@ is the file name of the target of the rule.``
| ``   #     $^ is the names of all the prerequisites, with spaces between them.``
| ``   BigProgram: $(BIGSOURCES)``
| ``           $(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $^ $(LIBS)``
| ``   ``
| ``   clean:``
| ``           /bin/rm -f BigProgram``

You compile BigProgram by typing:

| ``   ``\ **``[username@headnode``\ ````\ ``~]>``**\ `` make BigProgram``
| ``   gcc -O2 -Wall -g  -o BigProgram BigProgram.c first.c second.c third.c -lm``

You could also type "make" without specifying BigProgram: make will find
the first rule in the makefile. You can remove the compiled program by
doing:

| ``   ``\ **``[username@headnode``\ ````\ ``~]>``**\ `` make clean``
| ``   /bin/rm -f BigProgram``

A More Complex Example
======================

You may have noted that the above makefile is rather inefficient: it
recompiles every single source file every time BigProgram is built. If
your code is complex, the compilation may take a long time.

The fix for this is to create a library [5]_. The library file can be
updated only with a single changed .o object file. There are two types
of libraries:

-  *static*, with a .a extension
-  *dynamic*, or *shared*, with a .so or .so.\ *N* extension

Our example will create static library for simplicity's sake.

The makefile:

| ``   CC=gcc``
| ``   CFLAGS=-O2 -Wall -g``
| ``   LD_LIBRARY_PATH=``
| ``   ``
| ``   # specify directories in which to look for .h files``
| ``   CPPFLAGS=-I.``
| ``   ``
| ``   # specify directories in which to look for library files (.a, .so.*)``
| ``   LDFLAGS=-L.``
| ``   ``
| ``   # specify libraries to link to``
| ``   LIBS=-lsmall -lm``
| ``   ``
| ``   LIBSMALL_OBJS = fourth.o fifth.o sixth.o``
| ``   ``
| ``   # .PHONY declares targets which are not actual products``
| ``   .PHONY: clean all``
| ``   ``
| ``   programs = SmallProgram``
| ``   all: libsmall.a $(programs)``
| ``   ``
| ``   clean:``
| ``       /bin/rm -f *.o *.a *.so *.so.* $(programs)``
| ``   ``
| ``   libsmall.a: $(LIBSMALL_OBJS)``
| ``       ar -ruv $@ $?``
| ``       ranlib $@``
| ``   ``
| ``   SmallProgram: SmallProgram.o``
| ``       $(CC) $(CFLAGS) $(CPPFLAGS) -o $@ $< $(LDFLAGS) $(LIBS)``
| ``   ``
| ``   # Make already knows that .o files depend on .c files``
| ``   # so these rules just specify small.h as an additional``
| ``   # prerequisite``
| ``   fourth.o: small.h``
| ``   fifth.o: small.h``
| ``   sixth.o: small.h``

Run make:

| ``   ``\ **``[username@headnode``\ ````\ ``Libsmall]>``**\ `` make``
| ``   gcc -O2 -Wall -g -I.  -c -o fourth.o fourth.c``
| ``   gcc -O2 -Wall -g -I.  -c -o fifth.o fifth.c``
| ``   gcc -O2 -Wall -g -I.  -c -o sixth.o sixth.c``
| ``   ar -ruv libsmall.a fourth.o fifth.o sixth.o small.h``
| ``   ar: creating libsmall.a``
| ``   a - fourth.o``
| ``   a - fifth.o``
| ``   a - sixth.o``
| ``   a - small.h``
| ``   ranlib libsmall.a``
| ``   gcc -O2 -Wall -g -I.  -c -o SmallProgram.o SmallProgram.c ``
| ``   gcc -O2 -Wall -g -I. -o SmallProgram SmallProgram.o -L. -lsmall -lm``

An Example with MPICH2 Using the Intel Compiler v.11
====================================================

RHEL6
-----

With `modules </Quick_Start_Guide:Environment_Modules>`__, the process
is simplified. Before starting, load the module for the Intel Compiler:

``    ``\ **``[username@headnode``\ ````\ ``~]>``**\ `` module load compilers/intel-2012-lp64``

The makefile now looks like:

| ``    CC=mpicc``
| ``    CFLAGS=-O3 -ipo -no-prec-div -xHOST -I$(MKLROOT)/include``
| ``    ``
| ``    # Use the Intel MKL Link Line Advisor``
| ``    # The "\" character indicates a continuation on the``
| ``    # succeeding line.``
| ``    LDFLAGS=-L$(MKLROOT)/lib/intel64 -lmkl_scalapack_lp64 \``
| ``        -lmkl_cdft_core -lmkl_intel_lp64 -lmkl_intel_thread \``
| ``        -lmkl_core  -lmkl_blacs_intelmpi_lp64 -openmp \``
| ``        -lpthread -lm``
| ``    ``
| ``    .PHONY: clean``
| ``    ``
| ``    all: hello_mpi``
| ``    ``
| ``    clean:``
| ``        /bin/rm -f hello_mpi hello_mpi-*.slurm.e hello_mpi-*.slurm.o``
| ``    ``
| ``    hello_mpi: hello_mpi.c``
| ``        $(CC) -o $@ $^ $(LDFLAGS)``

A sample SLURM script is as follows:

::

   #!/bin/tcsh -f
   #SBATCH --partition=debug
   #SBATCH --time=0-0:20:00
   #SBATCH --constraint="ethernet"
   #SBATCH --nodes=4
   #SBATCH --ntasks-per-node=4
   #SBATCH --cpus-per-task=1
   #SBATCH --output="hello_mpi-%j.slurm.o"
   #SBATCH --error="hello_mpi-%j.slurm.e"
   # CHANGE these two parameters to your own group and email address
   #SBATCH --account="researcherGrp"
   #SBATCH --mail-user=username@wfu.edu

   setenv MPIEXEC_RSH /usr/bin/ssh
   set MPI_HOME=/opt/intel110-libs/mpich2
   set MPI_BINDIR=${MPI_HOME}/bin

   #NOTE:SLURM defaults to running jobs in the directory where submitted;
   #NOTE:Consider --workdir directive instead; and check functionality!
   cd ${SLURM_SUBMIT_DIR}
   ${MPI_BINDIR}/mpiexec ./hello_mpi

See Also
========

-  `Managing Projects with GNU Make,
   3/e <http://oreilly.com/catalog/9780596006105/>`__, by Robert
   Mecklenburg (2004)

References
==========

.. raw:: html

   <references/>

.. [1]
   `GNU Make <http://www.gnu.org/software/make/>`__

.. [2]
   `make
   (software) <http://en.wikipedia.org/wiki/Make_%28software%29>`__ at
   Wikipedia

.. [3]
   make info page (type "info make" at the commandline)

.. [4]
   `GNU Make Manual <http://www.gnu.org/software/make/manual/>`__

.. [5]
   `Library
   (computing) <http://en.wikipedia.org/wiki/Library_%28computing%29>`__,
   at Wikipedia
