.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__ **CafeMol** is a
general-purpose coarse-grained(CG) biomolecular modeling and simulation
software.It can simulate proteins,nucleic acids,lipids and their mixture
with various CG models. [1]_

Version
=======

Version installed on the cluster:

:\* **2.0.992**

Usage
=====

-  Load `module </Quick_Start_Guide:Environment_Modules>`__ to set up:

``    module load cafemol/2.0.992-intel-2012``

-  Run under OpenMPI:

``    mpirun cafemol inputfile.inp >& outputfile.out``

Compiling
=========

Use the `Compiler:Intel Cluster
Studio </Compiler:Intel_Cluster_Studio>`__ with
`Software:OpenMPI </Software:OpenMPI>`__.

-  Set up your environment:

| ``    $ module purge``
| ``    $ module load openmpi/1.6-intel``

-  Download the cafemol-2.0 distribution from
   http://www.cafemol.org/download.php
-  Expand the archive:

``    $ tar zxf cafemol_2.0.XXX.tar.gz``

-  Go into the source directory:

``    $ cd cafemol2/src``

-  Edit **``Makefile``**:

| ``    ``\ **``comment``\ ````\ ``out``\ ````\ ``lines``\ ````\ ``55-60``\ ````\ ``(put``\ ````\ ``a``\ ````\ ``"#"``\ ````\ ``at``\ ````\ ``the``\ ````\ ``start``\ ````\ ``of``\ ````\ ``each``\ ````\ ``line)``**
| ``    #FC = g95``
| ``    #FC_UTIL = g95``
| ``    #CPP = -DUNFORMATTED``
| ``    #OPT = -O2 -ffree-form -ffree-line-length-huge``
| ``    #NC =``
| ``    #LIB =``

| ``    ``\ **``add``\ ````\ ``the``\ ````\ ``following``\ ````\ ``block``\ ````\ ``starting``\ ````\ ``at``\ ````\ ``line``\ ````\ ``86``\ ````\ ``to``\ ````\ ``define``\ ````\ ``compiler``\ ````\ ``and``\ ````\ ``compiler``\ ````\ ``options``**
| ``    FC = mpif90``
| ``    FC_UTIL = mpif90``
| ``    CPP = -cpp -DTIME -DMPI_PAR -DMPI_PAR2 -DMPI_PAR3 -DMPI_REP``
| ``    INC = -I$(MKLROOT)/include/intel64/lp64 -I$(MKLROOT)/include``
| ``    OPT = -O3 -xSSE4.1 -ipo ``
| ``    LIB =  $(MKLROOT)/lib/intel64/libmkl_blas95_lp64.a \``
| ``           $(MKLROOT)/lib/intel64/libmkl_lapack95_lp64.a \``
| ``           $(MKLROOT)/lib/intel64/libmkl_scalapack_lp64.a \``
| ``           -Wl,--start-group  $(MKLROOT)/lib/intel64/libmkl_intel_lp64.a \``
| ``           $(MKLROOT)/lib/intel64/libmkl_sequential.a \``
| ``           $(MKLROOT)/lib/intel64/libmkl_core.a \``
| ``           $(MKLROOT)/lib/intel64/libmkl_blacs_openmpi_lp64.a \``
| ``           -Wl,--end-group -lpthread -lm``

-  Compile -- this will take about 30 minutes:

``    $ make >& Make.out &``

-  Copy the executables to somewhere useful, e.g. ``~/bin``

| ``    $ cd ..``
| ``    $ cp cafe_calc_rmsd dcd2movie movie2dcd pdb2crd crd2pdb cafemol ~/bin``

-  Copy utility programs:

| ``    $ cd utility``
| ``    $ cp * ~/bin``

References
==========

.. raw:: html

   <references/>

.. [1]
   `CafeMol web site <http://www.cafemol.org/>`__
