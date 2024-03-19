.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__
**VMD** is Visual Molecular Dynamics from the Theoretical and
Computational Biophysics Group at UIUC.. [1]_ It is made by the same
people who make `NAMD </Software:NAMD>`__.

It's a long and fairly complicated process, [2]_ involving multiple
edits of makefiles, and some edits of source code. We will use the Intel
compilers. We will *not* use CUDA or any GPU acceleration.

Source Code
===========

Currently installed on the cluster is version 1.9.1. The source code is
`available at the VMD
website <http://www.ks.uiuc.edu/Development/Download/download.cgi?PackageName=VMD>`__.
Download version 1.9.1 (2012-02-04).

Prerequisites
=============

VMD is a visualization tool. It requires 3D graphics libraries (OpenGL,
MESA) to function. If an NVIDIA graphics card is installed, and if the
`CUDA GPU programming software development
kit <http://www.nvidia.com/object/cuda_home_new.html>`__ is installed,
it can take advantage of both. Neither is required but will greatly
speed up execution.

Here is a non-exhaustive list of prerequisite packages (as provided by
RedHat):

-  netcdf
-  netcdf-devel
-  netcdf-static
-  libXinerama
-  libXinerama-devel
-  libXi-devel
-  python-devel
-  glibc-static
-  fltk-devel

Step-by-step
============

First, read the official compilation guide. [3]_

Set up your environment to use the Intel compilers:

``    module load compilers/intel-2012-lp64``

Decide on an installation location:

``    export VMDHOME ~/Applications/vmd-1.9.1    # tcsh: setenv VMDHOME ~/Applications/vmd-1.9.1``

Create a directory to contain all the VMD-related source code:

| ``    export VMDSRCDIR=~/src/vmd       # this is for bash; for tcsh/csh, do "setenv VMDSRCDIR ~src/vmd"``
| ``    mkdir -p $VMDSRCDIR``
| ``    cd $VMDSRCDIR``

Download and expand the source code in that directory:

``    tar zxf vmd-1.9.1.tar.gz     ``

This creates two directories: ``vmd-1.9.1`` and ``plugins``.

In general, we will redirect all make output to a file so that any error
messages will be captured and not scroll off the screen.

External Programs
-----------------

VMD depends on several external programs, some of which have to be
compiled.

STRIDE
~~~~~~

**STRIDE**\  [4]_ [5]_ secondary structure prediction. We use the
version of STRIDE archived by the VMD team.

| ``    cd $VMDSRCDIR/vmd-1.9.1/lib/stride``
| ``    wget ``\ ```http://www.ks.uiuc.edu/Research/vmd/extsrcs/Stride_src.tar.Z`` <http://www.ks.uiuc.edu/Research/vmd/extsrcs/Stride_src.tar.Z>`__
| ``    tar zxf Stride_src.tar.Z``

Edit the file ``stride.h``, and change line 43 to:

``    #define MAX_AT_IN_RES             75``

i.e. change the value from 50 to 75.

Also, edit ``stride.c``, and change line 96 from "return(SUCCESS);" to:

``    return 0;``

Create your own makefile named Makefile.deac. **IMPORTANT** you cannot
just copy and paste this. Makefiles are sensitive to whitespace -- there
is a difference between TAB and SPACE. [6]_

| ``CC = icc -O3 -static -ipo -xSSE2 -no-prec-div -pthread -I$(MKLROOT)/include``
| ``LDFLAGS =  -L$(MKLROOT)/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm``
| ``SOURCE = stride.c splitstr.c rdpdb.c initchn.c geometry.c \``
| ``    thr2one.c one2thr.c filename.c tolostr.c strutil.c place_h.c \``
| ``    hbenergy.c memory.c helix.c sheet.c rdmap.c phipsi.c command.c \``
| ``    molscr.c die.c hydrbond.c mergepat.c fillasn.c escape.c p_jrnl.c \``
| ``    p_rem.c p_atom.c p_helix.c p_sheet.c p_turn.c p_ssbond.c p_expdta.c \``
| ``    p_model.c p_compnd.c report.c nsc.c area.c ssbond.c chk_res.c \``
| ``    chk_atom.c turn.c pdbasn.c dssp.c outseq.c chkchain.c elem.c measure.c \``
| ``    asngener.c p_endmdl.c stred.c``
| ``OBJECT = ${SOURCE:.c=.o}``
| ``.c.o:``
| ``    $(CC) -c $<``
| ``stride : $(OBJECT)``
| ``    $(CC) $(OBJECT) -o $@ $(LDFLAGS)``
| ``$(OBJECT) : stride.h protot.h``
| ``clean:``
| ``    -rm -f $(OBJECT) stride``
| ``show:``
| ``    -echo $(SOURCE)``

Build stride:

| ``    make -f Makefile.deac >& Make.out &``
| ``    tail -f Make.out     # Ctrl-C to stop following the output``

Once done:

``    ln -s stride stride_LINUXAMD64``

SURF
~~~~

**SURF** solvent accessible surface. Since the original authors of SURF
no longer make the source code available. The source is provided in the
vmd-1.9.1.tar.gz archive

| ``    cd $VMDSRCDIR/vmd-1.9.1/lib/surf``
| ``    tar zxf surf.tar.Z``

Build SURF:

``    make depend``

There will be many warnings which can be ignored.

This creates ``Makefile``. Make a copy of it:

``    cp Makefile Makefile.deac``

And edit so that the first 9 lines are deleted and replaced with the
following 5 lines:

| ``    # Compilation flags``
| ``    CC      = icc``
| ``    INCLUDE     = -I.  -I$(MKLROOT)/include``
| ``    LINCLUDE    = -L$(MKLROOT)/lib/intel64 -lmkl_intel_lp64 -lmkl_sequential -lmkl_core -lpthread -lm``
| ``    CFLAGS      = -O3 -static -no-prec-div -ipo -xSSE2 -pthread $(FLAGS) $(INCLUDE)``

Edit ``surf.c`` so that lines 10-13 are:

| ``    int``
| ``    main(ac,av)``
| ``    int ac;``
| ``    char*   av[];``

and insert a statement before line 59 so that lines 58-60 are:

| ``       if (Write_Option) end_output_dataset();``
| ``       return 0;``
| ``    }``

Build:

| ``    make -f Makefile.deac >& Make.out &``
| ``    tail -f Make.out     # Ctrl-C to stop following the file``

Once this is done, the executable ``surf`` is produced. Then, do:

``    ln -s surf surf_LINUXAMD64``

TACHYON
~~~~~~~

**TACHYON** is not provided. [7]_ It is a parallel raytracer. VMD
requires version 0.99 or higher

| ``    cd $VMDSRCDIR/vmd-1.9.1/lib``
| ``    wget ``\ ```http://jedi.ks.uiuc.edu/~johns/raytracer/files/0.99b2/tachyon-0.99b2.tar.gz`` <http://jedi.ks.uiuc.edu/~johns/raytracer/files/0.99b2/tachyon-0.99b2.tar.gz>`__
| ``    tar zxf tachyon-0.99b2.tar.gz``

Then, edit the file ``unix/Make-arch``:

| ``    cd tachyon/unix``
| ``    ``\ *``edit``\ ````\ ``Make-arch``*

Create a new "arch" type by adding the following to the file Make-arch -
note that this is a Makefile, so the initial whitespace on the line
"$(MAKE) all" is a single TAB character:

| ``    # Linux on AMD64/EM64T, using icc``
| ``    linux-64-thr-icc:``
| ``        $(MAKE) all \``
| ``        "ARCH = linux-64-thr-icc" \``
| ``        "CC = icc" \``
| ``        "CFLAGS = -O3 -static -no-prec-div -xSSE2 -ipo -pthread -fomit-frame-pointer -DLinux -DLP64 -DTHR -D_REENTRANT $(MISCFLAGS)" \``
| ``        "AR = xiar" \``
| ``        "ARFLAGS = r" \``
| ``        "STRIP = strip" \``
| ``        "RANLIB = ranlib" \``
| ``        "LIBS = -L. -ltachyon $(MISCLIB) -lm -lpthread"``

Build:

| ``    make linux-64-thr-icc >& Make.out &``
| ``    tail -f Make.out     # Ctrl-C to stop following output``

Once complete, copy several tachyon files to the appropriate places

| ``    cd $VMDSRCDIR/vmd-1.9.1/lib/tachyon``
| ``    mkdir include``
| ``    cp src/tachyon.h include``
| ``    cp src/util.h include``
| ``    cp src/tachyon_dep.h include``
| ``    ``
| ``    mkdir lib_LINUXAMD64``
| ``    cd $VMDSRCDIR/vmd-1.9.1/lib/tachyon/compile/linux-64-thr-icc``
| ``    cp tachyon $VMDSRCDIR/vmd-1.9.1/lib/tachyon/tachyon_LINUXAMD64``
| ``    cp libtachyon.a $VMDSRCDIR/vmd-1.9.1/lib/tachyon/lib_LINUXAMD64``

ACTC
~~~~

**ACTC** is a triangle mesh consolidator. [8]_

| ``    cd $VMDSRCDIR/lib``
| ``    wget ``\ ```http://plunk.org/~grantham/actc-1.1.tar.gz`` <http://plunk.org/~grantham/actc-1.1.tar.gz>`__
| ``    tar zxf actc-1.1.tar.gz``

Edit the makefile:

| ``    ln -s actc-1.1 actc``
| ``    cd actc``
| ``    ''edit Makefile'``

Change one line, add one line:

| ``    ``\ **``Makefile``**\ `` - comment out line 17, and add a line after it:``
| ``    #CFLAGS=-g $(DEBUG)``
| ``    CFLAGS=-O3 -static -no-prec-div -xSSE2 -ipo``

Then build:

| ``    make >& Make.out &``
| ``    tail -f Make.out       # Ctrl-C to stop following``

Copy include files and library files:

| ``    mkdir include``
| ``    cp tc.h include``
| ``    mkdir lib_LINUXAMD64``
| ``    mv libactc.a lib_LINUXAMD64``

Plugins
-------

As prep, create the directory where plugins will be installed:

| ``    export PLUGINDIR=$VMDHOME/lib/vmd/plugins``
| ``    mkdir -p $PLUGINDIR/LINUXAMD64``

The next stage is to build the plugins for VMD.

``    cd $VMDSRCDIR/plugins``

**``Make-arch``** needs to be modified first to use the Intel compilers.
Lines 358-373 define the compilers and flags for compiling in the
LINUXAMD64 architecture. Replace the whole block with the following
(**NOTE** the whitespace at the front of the line "$(MAKE) dynlibs
staticlibs bins" is a TAB character, *not* space):

| ``LINUXAMD64:``
| ``    $(MAKE) dynlibs staticlibs bins \``
| ``    "ARCH = LINUXAMD64" \``
| ``    "COPTO = -fPIC -o " \``
| ``    "LOPTO = -fPIC -o " \``
| ``    "CC = icc" \``
| ``    "CXX = icpc" \``
| ``    "DEF = -D" \``
| ``    "CCFLAGS = -O3 -xSSE2 -no-prec-div -ipo -fPIC -shared " \``
| ``    "CXXFLAGS = -O3 -xSSE2 -no-prec-div -ipo -fPIC -shared " \``
| ``    "TCLLDFLAGS = -ltcl8.5 -ldl" \``
| ``    "NETCDFLDFLAGS = -lnetcdf " \``
| ``    "AR = xiar" \``
| ``    "NM = nm -p" \``
| ``    "RANLIB = touch" \``
| ``    "SHLD = icc -shared"``

Next, edit **``build.csh``** and add a new ``switch`` block starting at
line 205:

| ``    case rhel6head*:``
| ``      echo "Using build settings for DEAC..."``
| ``      set archname=LINUXAMD64``
| ``      setenv TCLINC -I/usr/include``
| ``      setenv TCLLIB -L/usr/lib64``
| ``      setenv NETCDFINC -I/usr/include``
| ``      setenv NETCDFLIB -L/usr/lib64``
| ``      cd $unixdir; gmake ${archname} >& log.${archname}.$DATE < /dev/null &``
| ``      echo "Waiting for all plugin make jobs to complete..."``
| ``      wait;``
| ``      echo "^G^G^G^G"``
| ``      echo "Plugin builds done."``
| ``      breaksw;``

Next, fix some errors in source code. This will be an iterative process:
"make world; look at log; fix code; make clean; make world; repeat;" The
specific errors will probably vary by VMD version: look in the log file
``log.LINUXAMD64-MMDD-TTTTTT`` that "make world" produces, and look for
problems of the type:

``    src/gamessplugin.c(385): warning #592: variable "data" is used before its value is set``

Most of them are "variable used before being set". In C, there is no
guarantee that a new (non-static) variable will be initialized to
zero. [9]_ Several of the source files here assume an initial value of 0
or NULL. Instances where a NULL pointer is freed will cause the program
to crash.

| ``    ``\ **``molfile_plugin/src/offplugin.C``**\ `` -- line 125: replace with two separate lines``
| ``    int idx[4];``
| ``    int j = 0;``

| ``    ``\ **``molfile_plugin/src/lammpsplugin.c``**\ `` -- line 407: replace with two separate lines``
| ``    int atomid, atomtype, needhash;``
| ``    int *idlist = (int*)NULL;``

| ``    ``\ **``molfile_plugin/src/moldenplugin.c``**\ `` -- lines 96--98: replace with these three lines``
| ``    FILE *fd = (FILE*)NULL;``
| ``    qmdata_t *data = (qmdata_t*)NULL;``
| ``    moldendata_t *moldendata = (moldendata_t*)NULL;``

| ``    ``\ **``molfile_plugin/src/gamessplugin.c``**\ `` -- lines 372--374: replace with these three lines``
| ``    FILE *fd = (FILE*)NULL;``
| ``    qmdata_t *data (qmdata_t*)NULL;``
| ``    gmsdata *gms = (gmsdata*)NULL;``

Build:

``    make world``

Output is automatically logged to a file named
``log.LINUXAMD64-MMDD-TTTTTT`` (where "MM" is the two-digit month
number, "DD" is the two-digit day number, and "TTTTTT" is some
representation of time in the Unix epoch). Check the log file -- if
there are any errors, fix the appropriate source file, then:

| ``    make clean``
| ``    make world``

Once you are satisfied with the build, install the plugins:

``    make distrib >& Make.distrib.out &``

This installs all the plugins in $PLUGINDIR.

Configure and Build VMD
-----------------------

The following environment variables must be set (these are bash
commands; if you use csh/tcsh, use setenv):

| ``    export PYTHON_INCLUDE_DIR=/usr/include/python2.6``
| ``    export NUMPY_INCLUDE_DIR=/usr/lib64/python2.6/site-packages/numpy/core/include``

Go to the base source directory:

``    cd $VMDSRCDIR/vmd-1.9.1``

and edit the file named "configure":

| ``    # line 16: replace with the following.``
| ``    $install_bin_dir=$ENV{VMDHOME};``

| ``    # line 19: replace with the following.``
| ``    $install_library_dir= "$install_bin_dir/lib/$install_name";``

| ``    # line 409: replace with``
| ``    $arch_gnucompress = "/usr/bin/gzip";``

| ``    # line 454: replace with``
| ``    $plugin_dir = $ENV{PLUGINDIR};``

| ``    # lines 516-519: replace with:``
| ``    $mesa_dir         = "";``
| ``    $mesa_include     = "";``
| ``    $mesa_library     = "";``
| ``    $mesa_libs   = "-lGL -lGLU";``

| ``    # line 1104: replace with ``
| ``    $python_libs        = "-lpython2.6 -lpthread";``

| ``    # line 1968: replace with``
| ``    $arch_opt_flag    = "-Wall -xSSE2 -O3 -ipo -no-prec-div";``

| ``    # line 1970: replace with``
| ``    $arch_copts       = "-Wall -xSSE2 -O3 -ipo -no-prec-div";``

| ``    # line 1985: replace with``
| ``    $arch_lopts       .= "-static-intel ";``

| ``    # line 2009-2010: replace with``
| ``    $opengl_libs    = "-lGL -lGLU -lX11";``
| ``    $mesa_libs          = "-lGL -lGLU -lXext -lX11";``

| ``    # line 3047: replace with (NOTE: no space at the end of the line)``
| ``    \$(COPY) run_vmd_tmp $install_bin_dir/$install_name ; \\``

| ``    # line 3049: replace with ``
| ``    \$(ECHO) "Make sure $install_bin_dir/$install_name is in your path."``

Link the plugins directory to the proper place:

``    ln -s ../plugins .``

Edit the file configure.options to contain just one line:

``    LINUXAMD64 MESA FLTK TK ACTC XINERAMA XINPUT LIBTACHYON NETCDF TCL PYTHON PTHREADS NUMPY ICC``

Run configure:

``    ./configure``

Then build:

| ``    cd src``
| ``    make >& Make.out &``
| ``    tail -f Make.out      # Ctrl-C to stop following``

And install:

| ``    make install >& Make.install.out &``
| ``    tail -f Make.install.out     # Ctrl-C to stop following``

This installs the executable shell script in

``    $VMDHOME/vmd``

To run vmd, you may need:

``    export LIBGL_ALWAYS_INDIRECT=1``

References
==========

.. raw:: html

   <references/>

.. [1]
   `VMD official project page <http://www.ks.uiuc.edu/Research/vmd/>`__

.. [2]
   `VMD Documentation - Compiling VMD from source
   code <http://www.ks.uiuc.edu/Research/vmd/doxygen/compiling.html#compiling>`__

.. [3]

.. [4]
   `STRIDE official site <http://webclu.bio.wzw.tum.de/stride/>`__

.. [5]
   `STRIDE secondary structure
   prediction <http://www.ks.uiuc.edu/Research/vmd/doxygen/extprogs.html#stride>`__

.. [6]
   `Quick Start Guide:Make </Quick_Start_Guide:Make>`__

.. [7]
   `Tachyon Parallel / Multiprocessor Ray Tracing System web
   page <http://jedi.ks.uiuc.edu/~johns/raytracer/>`__

.. [8]
   `ACTC triangle mesh
   consolidator <http://plunk.org/~grantham/public/actc/>`__ by Brad
   Granthan

.. [9]
   `Q: What happens to a declared, uninitialized variable in C? Does it
   have a
   value? <http://stackoverflow.com/questions/1597405/what-happens-to-a-declared-uninitialized-variable-in-c-does-it-have-a-value>`__
   at Stack Overflow
