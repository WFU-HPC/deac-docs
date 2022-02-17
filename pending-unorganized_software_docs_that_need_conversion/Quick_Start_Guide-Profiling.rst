.. contents::
   :depth: 3
..

`Category:Quick Start </Category:Quick_Start>`__ **Profiling** is a form
of dynamic program analysis (as opposed to static code analysis). It is
the investigation of a program's behavior using information gathered as
the program executes. The usual purpose of this analysis is to determine
which sections of a program to optimize - to increase its overall speed,
decrease its memory requirement or sometimes both. [1]_

GCC and gprof
=============

GCC and gprof are GNU tools. Here is a contrived example: [2]_ please
download a copy of the source.

First, you will need to compile with the "-pg" option. Here is an
example Makefile:

| ``   CC=gcc``
| ``   CFLAGS=-pg -g``
| ``   ``
| ``   # Unset the next three because Intel compiler installation``
| ``   # sets them and they interfere``
| ``   INCLUDE=``
| ``   LD_LIBRARY_PATH=``
| ``   CPATH=``
| ``   ``
| ``   .PHONY: clean``
| ``   ``
| ``   sieve: sieve.c``
| ``       $(CC) $(CFLAGS) -o $@ $^ -lm``
| ``   ``
| ``   clean:``
| ``       /bin/rm -f sieve gmon.out``

Then, run make to build. Run the program as usual: the program will
generate profiling data in a file named **``gmon.out``**. To see the
profiling information, do:

| ``   ``\ **``[username@headnode``\ ````\ ``GprofExample]>``**\ `` ./sieve 20000``
| ``   ``\ *``output``\ ````\ ``removed``*
| ``   ``\ **``[username@headnode``\ ````\ ``GprofExample]>``**\ `` gprof sieve gmon.out``
| ``   Flat profile:``
| ``   ``
| ``   Each sample counts as 0.01 seconds.``
| ``    no time accumulated``
| ``   ``
| ``     %   cumulative   self              self     total           ``
| ``    time   seconds   seconds    calls  Ts/call  Ts/call  name    ``
| ``    62.09      0.21     0.21     2263     0.09     0.09  factorial``
| ``    35.48      0.33     0.12        1   120.63   341.80  sieve``
| ``     2.96      0.34     0.01     2263     0.00     0.00  foo``
| ``     0.00      0.34     0.00        1     0.00     0.00  init``
| ``     0.00      0.34     0.00        1     0.00     0.00  xcalloc``
| ``     [``\ *``truncated``*\ ``]``

You will notice that there are two functions which have been called the
most number of times: ``factorial``, and ``sieve``. Of these two, about
62% of the total running time was used by the ``factorial`` function,
and 35% by the ``sieve`` function.

Read the online gprof manual [3]_ for more information.

See Also
========

-  `HPCToolkit <http://hpctoolkit.org/>`__ - an integrated suite of
   tools for measurement and analysis of program performance on
   computers ranging from multicore desktop systems to the nation's
   largest supercomputers.
-  `GprofQuickStart <http://vmlinux.org/foswiki/bin/view/Main/GprofQuickStart>`__
   -- profiling with GNU's gprof and GCC

References
==========

.. raw:: html

   <references/>

.. [1]
   `Profiling (computer programming) article at
   Wikipedia <http://en.wikipedia.org/wiki/Profiling_(computer_programming)>`__

.. [2]
   `GprofExample.tar.gz <http://www.wfu.edu/~chindw/DEAC/Examples/GprofExample.tar.gz>`__
   -- downloadable example of using gprof

.. [3]
   gprof info pages -- type "info gprof" at the command line; also `on
   the
   web <http://sourceware.org/binutils/docs-2.20/gprof/index.html>`__
