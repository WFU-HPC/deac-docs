Using GaussView 5 (CONVERTED TO DSS 2024)
=================

Setup is similar to that for `Gaussian
09 </Software:Gaussian#Using_Gaussian_09>`__. Especially, see the setup
for the "CLASS", i.e. CPU class.

Once you have the g09class script installed, make sure you have these
lines in your ~/.cshrc (or ~/.tcshrc) file:

| :literal:`   setenv g09root /deac/opt/gaussian/`~/bin/g09class\``
| ``   source $g09root/g09/bsd/g09.login``

These should set the GV_DIR directory correctly, and sets the alias "gv"
to run GaussView.

Software Location
=================

Generic Link : /deac/opt/gaussian/CLASS/gv
Version Specific Link : /deac/opt/gaussian09-c.01/CLASS/gv

*(see below for CLASS information)*

Build Information
=================

The Gaussian 09 software contains optimizations for two classes of Intel
processors that exist in the cluster:

:; EM64T : For Intel processor series 5100, 5300, and 5400.

:; Nehalem : For Intel processor series 5500 and 5600.

By far, the easiest (Gaussian) way to dynamically determine which node
is the following:

   **/deac/opt/gaussian/em64t/g09/bsd/x86type**

There are two possible outputs for our current cluster:

:; intel : indicates *em64t*

:; intel-1 : indicates *nehalem*
