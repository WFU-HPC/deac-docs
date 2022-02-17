.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Compiling </Category:Compiling>`__

About
=====

From the `official site <http://www.charmm.org/>`__, CHARMM (Chemistry
at HARvard Macromolecular Mechanics):

-  is a versatile and widely used molecular simulation program with
   broad application to many-particle systems
-  has been developed with a primary focus on the study of molecules of
   biological interest, including peptides, proteins, prosthetic groups,
   small molecule ligands, nucleic acids, lipids, and carbohydrates, as
   they occur in solution, crystals, and membrane environments
-  provides a large suite of computational tools that encompass numerous
   conformational and path sampling methods, free energy estimates,
   molecular minimization, dynamics, and analysis techniques, and
   model-building capabilities
-  is useful for a much broader class of many-particle systems
-  can be utilized with various energy functions and models, from mixed
   quantum mechanical-molecular mechanical force fields, to all-atom
   classical potentials with explicit solvent and various boundary
   conditions, to implicit solvent and membrane models

Version
=======

Installed versions on the cluster include:

:\* **c35b6**.

Using CHARMM
============

Load one of the CHARMM
`modules </Quick_Start_Guide:Environment_Modules>`__:

GNU-compiled:

``module load charmm/c35b6-gnu-serial``

GNU-compiled against Open MPI 1.6

``module load charmm/c35b6-gnu``

Intel compiled

``module load charmm/c35b6-intel-2012-serial``

Intel compiled against Open MPI 1.6

``module load charmm/c35b6-intel-2012``

To run on command line:

``mpirun -np $np charmm``

To take a serial script file:

``mpirun -np $np charmm < filename .``

To run a script file on infiniband:

``mpirun --mca btl ^tcp ${CHARMMDIR}/charmm ...``

Examples can be found on
[http://www.charmmtutorial.org/index.php/Full_example\ \| online].

Compilation Instructions
========================

The source contains a script named ``install.com`` which takes arguments
for building CHARMM. Here is its help message, edited to list only the
host machine types available on DEAC:

**NOTE**: "huge" does not work but "large" does. , most likely would
work if using 8-byte integers. That would involve the "ilp64" version of
the Intel Compiler which the cluster does not have.

| ``Usage: install.com host-machine-type [charmm-size] [Sw]``
| ``  ``
| ``      [1] host-machine-type is one of the following.``
| ``              alpha     DEC 3000 AXP 500``
| ``              alphamp   DEC Alpha-MP parallel computers``
| ``              altix     SGI Itanium Altix series (64 bit)``
| ``              em64t     ifort compilers on em64t/xeon``
| ``              gnu       GNU compilers``
| ``              g95       G95 compiler``
| ``              hal       HAL work stations``
| ``              hpitanium HP-UX Itaniums``
| ``              hpux      HP Apollo 9000 Series 700``
| ``              ibmaix    IBM AIX not parallel``
| ``              ibmaixmp  IBM AIX parallel``
| ``              ibmlnxmp  IBM GNU/Linux parallel``
| ``              itanium   INTEL Itanium 2 using ifort compiler``
| ``              osx       Mac OSX machines``
| ``              sgi       SGI IRIS series (32 bit)``
| ``              sgi64     SGI IRIS series (64 bit)``
| ``              sun       SUN work stations (32-bit)``
| ``              sunmpi    SUN work stations running SUN MPI``
| ``              sun64     SUN work stations (64-bit)``
| ``              t3e       Cray T3E MPP``
| `` ``
| ``      [2] Choose [charmm-size] from {huge, xxlarge, xlarge, large,``
| ``                                     medium, small, xsmall, reduce}.``
| ``          The default is medium.``
| ``      [3] [Sw] are install switches, which must be specified after``
| ``          the size argument.  You may specify any of the following.``
| ``          X and G, P, M and E are mutually exculsive, respectively.``
| ``          MPICH, LAM and MPISPECIAL are mutually exclusive.``
| ``          X  include Xlib graphics, along with .ps .pov .fdat files``
| ``     NODISP  graphics, no display; make .ps .pov .fdat files only``
| ``          P  links to PVM``
| ``          M  links to MPI``
| ``          1  to halt after setting up installation directory.``
| ``          2  to halt after making installation utilities.``
| ``          64 to compile in 64-bit mode on SGI and IBM/AIX platforms.``
| ``         i8  to request 64 bit integers``
| ``          Q  replace QUANTUM with GAMESS.``
| ``          U  replace QUANTUM with GAMESS-UK.``
| ``          C  replace QUANTUM with CADPAC.``
| ``          T  replace QUANTUM with SCCDFTB.``
| ``         QC  replace QUANTUM with Q-CHEM.``
| ``         SQ  replace QUANTUM with SQUANTUM, only with altix/gnu/ibmaix.``
| ``          W  replace QUANTUM with MNDO97, only with altix/gnu/ibmaix/sgi.``
| ``       APBS  compile with APBS support.``
| ``          S  Uses TCP/IP SOCKET library for parallel.``
| ``          E  Builds a version with ensemble replicas``
| ``       FULL  For FULL featured version (default).``
| ``       LITE  For a version with reduced functional features.``
| ``      XLF95  Uses xlf95/MacOSX driven by xlf95 (default is gfortran).``
| ``        F77  Uses Absoft/Linux (default is gfortran).``
| ``        G77  Uses obsolete GNU g77 (default is gfortran).``
| ``        F2C  Uses f2c/Linux driven by fort77(default is gfortran).``
| ``        IFC  Uses IA-32 Intel Fortran ifc/Linux (default is gfortran).``
| ``        EFC  Uses IA-64 Intel Fortran efc/Linux and forces I8 (default is gfortran).``
| ``      IFORT  Uses Intel Fortran ifort/Linux (default is gfortran).``
| ``        G95  Uses  g95/Linux (default is gfortran).``
| ``      PGF95  Uses PGI pgf95/Linux (default is gfortran).``
| ``         PS  Uses PathScale Linux compiler (default is gfortran).``
| ``       FORT  Uses Compaq ccc and fort on Alpha Linux (default is gfortran).``
| ``   GFORTRAN  Uses extra keywords for gfortran.``
| ``     X86_64  Uses extra keywords for X86_64, both AMD64 & EM64T.``
| ``      AMD64  Uses extra keywords for g77 on AMD64.``
| ``        NIH  Uses extra keywords for NIH.``
| ``       TSRI  Uses extra keywords for TSRI.``
| ``      MPICH  adds special library options for standard MPICH.``
| ``     LAMMPI  adds special library options for standard LAM/MPI.``
| ``     SCALI   adds special library options for standard SCALI MPI Connect.``
| `` MPISPECIAL  prompts for special MPI library options for load.``
| ``         GA  Use GA tools version of GAMESS-UK``
| ``          D  link dynamically (ifc/ifort)``
| ``    MODPREF  add/remove keywords from pref.dat (w/ addtl. parameter)``
| ``      keepf  Will keep the preprocessed .f files in build/mach.``
| ``      keepo  Will keep the preprocessed .o files in build/mach.``
| ``      DEBUG/debug Compile with debugging options to compiler (FCD)``
| ``      big_e/little_e  Use big/little_endian binary I/O if supported by compiler``

Since the preferred MPI implementation on the cluster is Open MPI 1.6
(implementing MPI-2), and the ``install.com`` does not have preset
options for it, the ``MPISPECIAL`` needs to be used.

References
==========

.. raw:: html

   <references/>
