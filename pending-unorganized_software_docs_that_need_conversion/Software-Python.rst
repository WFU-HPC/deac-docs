.. contents::
   :depth: 3
..

`Category:Languages </Category:Languages>`__\ `Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

**Python** is a general-purpose high-level object-oriented programming
language. It is an interpreted language, though it does have a
byte-compiler.

Version
=======

:\* **3.5.2**

:\* **2.7.2**

Libraries for Scientific Computing and Visualization
====================================================

-  NumPy
-  SciPy
-  matplotlib
-  `Software:MayaVi </Software:MayaVi>`__

Usage
=====

-  Load the desired `module </Quick_Start_Guide:Environment_Modules>`__:

``module load python 2.7.12``

``module load python 3.5.2``

Compiling
=========

This installs everything using the home directory as a "base", i.e.
prefix=$HOME

Setup Intel Compiler Environment
--------------------------------

-  Follow procedures listed in `Intel
   compiler </Compiler:Intel_Cluster_Studio#Intel_Compilers>`__

:\* This creates two shell scripts in ~/bin

:\* Set compiler environment

| ``   $ . ~/bin/use_intel_compilers.sh ict400``
| ``   $ export CC=icc``
| ``   $ export FC=ifort``
| ``   $ export F77=ifort``
| ``   $ export F90=ifort``
| ``   $ export CXX=icpc``

-  Edit and run bashrc

| ``   $ echo 'export PATH=${HOME}/bin:${PATH}' >> ~/.bashrc``
| ``   $ ``\ **``.``\ ````\ ``~/.bashrc``**\ ``:``

Python build
------------

-  Configure

| ``   $ cd ~/src/Python-2.7.2``
| ``   $ ./configure --prefix=$HOME --with-fpectl``

-  Modify the setup

:\* To start, this file should be empty except for one comment

``   $ echo 'readline readline.c -L/usr/lib64 -Wl,-rpath,/usr/lib64 -lreadline -ltermcap' >> ~/src/Python-2.7.2/Modules/Setup.local``

OPTIONAL: enable _ctypes module
--------------------------------

-  There is an issue with libffi not compiling with icc -- it's a long
   story involving an unsupported gcc extension for 128-bit integers
-  **This is optional. It enables the _ctypes module to build. If you
   don't need _ctypes, or don't know what it is, you can ignore this.**
-  Edit the file Python-2.7.2/Modules/_ctypes/libffi/src/x86/ffi64.c
-  Near the top of the file, line 40 or so, modify to look like this
   (changes in bold):

| ``#define MAX_GPR_REGS 6``
| ``#define MAX_SSE_REGS 8``
| **``typedef``\ ````\ ``struct``\ ````\ ``{``\ ````\ ``int64_t``\ ````\ ``m[2];``\ ````\ ``}``\ ````\ ``__int128_t;``**
| ``struct register_args``
| ``{``
| ``  /* Registers for argument passing */``
| ``  UINT64 gpr[MAX_GPR_REGS];``
| ``  __int128_t sse[MAX_SSE_REGS];``
| ``};``

-  Near line 475 or so, in the definition of the function ffi_call() --
   search for the string "sse[":

| ``case X86_64_SSE_CLASS:``
| ``case X86_64_SSEDF_CLASS:``
| ``  ``\ \ ``/* reg_args->sse[ssecount++] = *(UINT64 *) a; */``
| ``  reg_args->sse[ssecount].m[0] = *(UINT64 *) a;``
| ``  reg_args->sse[ssecount].m[1] = 0;``
| ``  ++ssecount;``\ 
| ``  break;``
| ``case X86_64_SSESF_CLASS:``
| ``  ``\ \ ``/* reg_args->sse[ssecount++] = *(UINT32 *) a; */``
| ``  reg_args->sse[ssecount].m[0] = *(UINT32 *) a;``
| ``  reg_args->sse[ssecount].m[1] = 0;``
| ``  ++ssecount;``\ 
| ``  break;``

Compile and install python
--------------------------

-  Compile

``  $ ``\ **``make``\ ````\ ``>&``\ ````\ ``Make.out``\ ````\ ``&``**

:\* You can watch the progress by doing **tail -f Make.out**

:\* Note "_ctypes" failure unless you followed optional steps.

-  Install

``  $ make install >& Make.install.out &``

Configure environment
---------------------

-  Set references to Intel library locations in your environment:

``  $ echo '. ~/bin/use_intel_compilers.sh ict400' >> ~/.bashrc``

Install easy_install
--------------------

`easy_install (part of
setuptools) <http://peak.telecommunity.com/DevCenter/EasyInstall>`__ is
a simple Python package manager that downloads, compiles, and installs
Python modules from `the Python Package Index
(PyPI) <http://pypi.python.org>`__

| ``  $wget ``\ ```http://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz#md5=7df2a529a074f613b509fb44feefe74e`` <http://pypi.python.org/packages/source/s/setuptools/setuptools-0.6c11.tar.gz#md5=7df2a529a074f613b509fb44feefe74e>`__
| ``  $ mv setuptools-0.6c11.tar.gz ~/src``
| ``  $ cd ~/src``
| ``  $ tar zxf setuptools-0.6c11.tar.gz``
| ``  $ cd setuptools-0.6c11``
| ``  $ python setup.py install``

Install the numpy package
-------------------------

-  Download source code from http://sourceforge.net/projects/numpy/
-  Move tarball into ~/src and expand
-  Create a file named **site.cfg** in untarred numpy source directory.

| ``    $ vim site.cfg``
| ``     [mkl] ``
| ``     include_dirs = /deac/opt/intel/ics2012/mkl/include``
| ``     library_dirs = /deac/opt/intel/ics2012/mkl/lib/intel64/``
| ``     lapack_libs = mkl_lapack``
| ``     mkl_libs = mkl_intel_lp64, mkl_core, iomp5, mkl_intel_thread``

:\* These paths should be derived the latest intel compiler environment
module.

-  Compile numpy

``  $ python setup.py config_fc --fcompiler=intelem install >& Setup.install.out &``

:\* Selecting the Intel compiler is done by specifying **intelem**

-  NB this uses the standard LAPACK rather than Intel's Math Kernel
   Library (MKL) -- there are some issues with getting numpy to work
   with MKL, so please watch for future developments
-  Observe the progress by doing **tail -f Setup.install.out**

Install the scipy package
-------------------------

-  Provides Python hooks into standard linear algebra libraries (BLAS,
   LAPACK)

| ``  $wget ``\ ```https://downloads.sourceforge.net/project/scipy/scipy/0.10.0/scipy-0.10.0.tar.gz`` <https://downloads.sourceforge.net/project/scipy/scipy/0.10.0/scipy-0.10.0.tar.gz>`__
| ``  $ mv scipy-0.10.0.tar.gz ~/src``
| ``  $ cd ~/src``
| ``  $ tar zxf scipy-0.10.0.tar.gz``
| ``  $ cd ~/src/scipy-0.10.0``
| ``  $ python setup.py config_fc --fcompiler=intelem install >& Setup.install.out &``

Install ipython
---------------

-  In conjunction with pylab, gives an interactive environment similar
   to Matlab

``  $ easy_install ipython``

Install matplotlib
------------------

``  $ easy_install matplotlib``

Example
=======

-  numpy example

:\* A more in depth example can be found in the NumPy User Note from
Intel's application support group.  [1]_

| ``    $ python``
| ``    Python 2.7.2 (default, Dec 21 2011, 14:54:05)``
| ``    [GCC Intel(R) C++ gcc 3.4 mode] on linux2``
| ``    Type "help", "copyright", "credits" or "license" for more information.``
| ``    >>> import numpy as np``
| ``    >>> a = np.array([1,2,3,4,5,6])``
| ``    >>> a.mean() ``
| ``    3.5``

-  Interactive Python example

| ``    $ ipython``
| ``    Python 2.7.2 (default, Dec 21 2011, 14:54:05)``
| ``    Type "copyright", "credits" or "license" for more information.``
| ``    ``
| ``    IPython 0.12 -- An enhanced Interactive Python.``
| ``    ?         -> Introduction and overview of IPython's features.``
| ``    %quickref -> Quick reference.``
| ``    help      -> Python's own help system.``
| ``    object?   -> Details about 'object', use 'object??' for extra details.``
| ``    ``
| ``    In [1]: a = {'this': 126, 'that': 492, 'other': 42}``
| ``    ``
| ``    In [2]: a??``
| ``    Type:       dict``
| ``    Base Class: <type 'dict'>``
| ``    String Form:{'this': 126, 'other': 42, 'that': 492}``
| ``    Namespace:  Interactive``
| ``    Length:     3``
| ``    Docstring:``
| ``    dict() -> new empty dictionary``
| ``    dict(mapping) -> new dictionary initialized from a mapping object's``
| ``        (key, value) pairs``
| ``    dict(iterable) -> new dictionary initialized as if via:``
| ``        d = {}``
| ``        for k, v in iterable:``
| ``            d[k] = v``
| ``    dict(**kwargs) -> new dictionary initialized with the name=value pairs``
| ``        in the keyword argument list.  For example:  dict(one=1, two=2)``

-  Matplotlib example, where N.B. pylab automatically imports numpy as
   np):

| ``    $ ipython --pylab``
| ``    Python 2.7.2 (default, Dec 21 2011, 14:54:05)``
| ``    Type "copyright", "credits" or "license" for more information.``
| ``    ``
| ``    IPython 0.12 -- An enhanced Interactive Python.``
| ``    ?         -> Introduction and overview of IPython's features.``
| ``    %quickref -> Quick reference.``
| ``    help      -> Python's own help system.``
| ``    object?   -> Details about 'object', use 'object??' for extra details.``
| ``    ``
| ``    Welcome to pylab, a matplotlib-based Python environment [backend: TkAgg].``
| ``    For more information, type 'help(pylab)'.``
| ``    ``
| ``    In [1]: a = np.arange(100) * 2 * pi / 100``
| ``    ``
| ``    In [2]: plot(a, cos(a))``
| ``    Out[2]: [<matplotlib.lines.Line2D at 0x2a9ea92d90>]``
| ``    ``
| ``    In [3]: import scipy as sp``
| ``    ``
| ``    In [4]: a = sp.zeros(1000)``
| ``    ``
| ``    In [5]: a[:100] = 1``
| ``    ``
| ``    In [6]: b = sp.fft(a)``
| ``    ``
| ``    In [7]: plot(abs(b))``
| ``    Out[7]: [<matplotlib.lines.Line2D at 0x2aa34eb710>]``

`frameless|480px </File:Example_pylab_plot.png>`__
`frameless|480px </File:Example_pylab_scipy_plot.png>`__

External Links
==============

-  ipython - http://ipython.org/ - a powerful Python interactive shell;
   try it out here: http://www.pythonanywhere.com/try-ipython/
-  NumPy - http://numpy.scipy.org/ - the de facto standard numerical
   computing package for Python
-  SciPy - http://www.scipy.org/SciPy - scientific computing package for
   Python which uses NumPy
-  matplotlib - http://matplotlib.sourceforge.net/ - 2D plotting for
   Python, producing publication-quality files (EPS, PDF)
-  `Forum post about getting numpy to work with
   MKL <http://software.intel.com/en-us/forums/showthread.php?t=60460>`__
-  `Official Python site <http://www.python.org/>`__
-  `Think
   Python <http://www.greenteapress.com/thinkpython/thinkpython.html>`__
   - an introduction to programming with Python. PDF copy mirrored here:
   File:ThinkPython.pdf
-  `Dive into Python <http://diveintopython.org/>`__ - a free, online
   Python book for programmers. PDF copy mirrored here:
   File:DiveIntoPython.pdf

References
==========

.. raw:: html

   <references/>

.. [1]
   `NumPy Indepth
   Example <http://software.intel.com/en-us/articles/numpy-user-note/>`__
