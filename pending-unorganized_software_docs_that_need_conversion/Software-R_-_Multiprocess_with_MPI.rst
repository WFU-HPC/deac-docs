.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

**R Language**
==============

__forcetoc__

Description & Info
------------------

-  R is a statistical programming language.
-  The `Software:RStudio </Software:RStudio>`__ IDE can be used on any
   head-node.
-  Using R in a Parallel and Distributed cluster, the **Rmpi** package
   must be used.
-  `Software:RStudio#Installing_Packages Rmpi package
   installation </Software:RStudio#Installing_Packages_'''Rmpi'''_package_installation>`__
-  Wikibook: `R
   Programming <http://en.wikibooks.org/wiki/R_Programming>`__
-  `HPC with
   R <http://cran.r-project.org/web/views/HighPerformanceComputing.html>`__

**Testing Rmpi Package**
========================

Hello World R/MPI
-----------------

-  One way to test the **Rmpi** package on the cluster, is to run a
   classic **MPI Hello World** from the spawned process
-  The code from `Acadia
   University <http://math.acadiau.ca/ACMMaC/Rmpi/sample.html>`__ in
   Canada is used
-  Template:

::

   library(Rmpi)

   if (!is.loaded("mpi_initialize")) {
     library("Rmpi")
   }
   mpi.spawn.Rslaves()

   .Last <- function(){
     if(is.loaded("mpi_initialize")) {
       if(mpi.comm.size(1)>0) {
         print("Please use mpi.close.Rslave() to close slaves.")
         mpi.close.Rslaves()
       }
       print("Please use mpi.quit() to quit R")
       .Call("mpi_finalize")
     }
   }

   mpi.remote.exec(paste("I am",mpi.comm.rank(),"of",mpi.comm.size()))
   mpi.close.Rslaves()
   mpi.quit()

Job Script template
-------------------

-  The template is a basic script

::

   #!/bin/bash -l
   #SBATCH --job-name="name_of_job"
   #SBATCH --partition=debug
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=8
   #SBATCH --cpus-per-task=1
   #SBATCH --partition=debug
   #SBATCH --time=0-00:01:00
   #SBATCH --mail-type=BEGIN
   #SBATCH --output="name_of_job-%j.o"
   #SBATCH --error="name_of_job-%j.e"
   #SBATCH --mail-user=email@wfu.edu
   #SBATCH --account="FAIRSHAREGrp"

   module load openmpi/1.6-intel

   cd /path/to/the/R/script/file
   R --vanilla <name_of_script.R >output_file.out
   exit 0

-  Send job: **sbatch** name_of_script_file
-  It will take 3 seconds to finish the job

Output_File.OUT
---------------

-  The output that is expected from the R program

::

   R version 3.1.0 (2014-04-10) -- "Spring Dance"
   Copyright (C) 2014 The R Foundation for Statistical Computing
   Platform: x86_64-redhat-linux-gnu (64-bit)

   R is free software and comes with ABSOLUTELY NO WARRANTY.
   You are welcome to redistribute it under certain conditions.
   Type 'license()' or 'licence()' for distribution details.

     Natural language support but running in an English locale

   R is a collaborative project with many contributors.
   Type 'contributors()' for more information and
   'citation()' on how to cite R or R packages in publications.

   Type 'demo()' for some demos, 'help()' for on-line help, or
   'help.start()' for an HTML browser interface to help.
   Type 'q()' to quit R.

   > library(Rmpi)
   >
   > if (!is.loaded("mpi_initialize")) {
   +   library("Rmpi")
   + }
   > mpi.spawn.Rslaves()
           1 slaves are spawned successfully. 0 failed.
   master (rank 0, comm 1) of size 2 is running on: bc02bl03
   slave1 (rank 1, comm 1) of size 2 is running on: bc02bl03
   >
   > .Last <- function(){
   +   if(is.loaded("mpi_initialize")) {
   +     if(mpi.comm.size(1)>0) {
   +       print("Please use mpi.close.Rslave() to close slaves.")
   +       mpi.close.Rslaves()
   +     }
   +     print("Please use mpi.quit() to quit R")
   +     .Call("mpi_finalize")
   +   }
   + }
   >
   > mpi.remote.exec(paste("I am",mpi.comm.rank(),"of",mpi.comm.size()))
   $slave1
   [1] "I am 1 of 2"

   > mpi.close.Rslaves()
   [1] 1
   > mpi.quit()

Output File from Job Script
---------------------------

-  The output shows messages that are errors
-  The messages seem not to have any effects to the output or execution
   of the program

::

   #########################BEGIN-PROLOG#########################
   JobId             = 6462
   JobName           = hello_world_R
   UserId            = username(20117)
   GroupId           = username(20117)
   Priority          = 837
   Nice              = 0
   Account           = admingrp
   QOS               = normal
   Requeue           = 1
   Restarts          = 0
   BatchFlag         = 1
   Reboot            = 0
   ExitCode          = 0:0
   RunTime           = 00:00:00
   TimeLimit         = 00:01:00
   TimeMin           = N/A
   SubmitTime        = 2015-09-15T10:36:31
   EligibleTime      = 2015-09-15T10:36:31
   StartTime         = 2015-09-15T10:36:31
   EndTime           = 2015-09-15T10:37:31
   Partition         = small
   AllocNode:Sid     = headnode:12501
   NodeList          = bc02bl03
   BatchHost         = bc02bl03
   NumNodes          = 1
   NumCPUs           = 8
   CPUs/Task         = 1
   ReqB:S:C:T        = 0:0:*:*
   Socks/Node        = *
   NtasksPerN:B:S:C  = 8:0:*:*
   CoreSpec          = *
   MinCPUsNode       = 8
   MinMemoryNode     = 15948M
   MinTmpDiskNode    = 0
   Command           = /home/username/slurm_examples/example_mpi_R.pbs.slurm
   WorkDir           = /home/username/slurm_examples
   StdErr            = /home/username/slurm_examples/slurm-6462.out
   StdOut            = /home/username/slurm_examples/slurm-6462.out
   ###########################END-PROLOG#########################
   --------------------------------------------------------------------------
   Please check /var/log/messages or dmesg for driver specific failure
   reason.
   The failure occurred here:

     Local host:    mlx4_0
     Device:        openib_reg_mr
     Function:      Cannot allocate memory()
     Errno says:   

   You may need to consult with your system administrator to get this
   problem fixed.
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
   The OpenFabrics (openib) BTL failed to initialize while trying to
   allocate some locked memory.  This typically can indicate that the
   memlock limits are set too low.  For most HPC installations, the
   memlock limits should be set to "unlimited".  The failure occured
   here:

     Local host:    bc02bl03.deac.wfu.edu
     OMPI source:   ../../../../../ompi/mca/btl/openib/btl_openib_component.c:1161
     Function:      ompi_free_list_init_ex_new()
     Device:        mlx4_0
     Memlock limit: 65536

   You may need to consult with your system administrator to get this
   problem fixed.  This FAQ entry on the Open MPI web site may also be
   helpful:

       http://www.open-mpi.org/faq/?category=openfabrics#ib-locked-pages
   --------------------------------------------------------------------------
   --------------------------------------------------------------------------
   WARNING: There was an error initializing an OpenFabrics device.

     Local host:   bc02bl03.deac.wfu.edu
     Local device: mlx4_0
   --------------------------------------------------------------------------
   [bc02bl03.deac.wfu.edu:09281] 1 more process has sent help message help-mpi-btl-openib.txt / mem-reg-fail
   [bc02bl03.deac.wfu.edu:09281] Set MCA parameter "orte_base_help_aggregate" to 0 to see all help / error messages
   [bc02bl03.deac.wfu.edu:09281] 1 more process has sent help message help-mpi-btl-openib.txt / init-fail-no-mem
   [bc02bl03.deac.wfu.edu:09281] 1 more process has sent help message help-mpi-btl-openib.txt / error in device init
   [H^[[2J

**Generate More Processes**
===========================

Rslave()
--------

-  As seen on the first example: only one process; aside from the Master
   process, gets spawned
-  In order to generate more slave processes; the
   **mpi.spawn.Rslaves()** function has to specify the desired number of
   processes
-  This is done by changing line 6 to the following:

``mpi.spawn.Rslaves(``\ **``nslaves=8``**\ ``)``

Output
------

-  The output shows the process that were generated when executing the
   **mpi.spawn.Rslaves()** function
-  The output finally shows the print out from each process:

::

   R version 3.1.0 (2014-04-10) -- "Spring Dance"
   Copyright (C) 2014 The R Foundation for Statistical Computing
   Platform: x86_64-redhat-linux-gnu (64-bit)

   R is free software and comes with ABSOLUTELY NO WARRANTY.
   You are welcome to redistribute it under certain conditions.
   Type 'license()' or 'licence()' for distribution details.

     Natural language support but running in an English locale

   R is a collaborative project with many contributors.
   Type 'contributors()' for more information and
   'citation()' on how to cite R or R packages in publications.

   Type 'demo()' for some demos, 'help()' for on-line help, or
   'help.start()' for an HTML browser interface to help.
   Type 'q()' to quit R.

   > library(Rmpi)
   >
   > if (!is.loaded("mpi_initialize")) {
   +   library("Rmpi")
   + }
   > mpi.spawn.Rslaves(nslaves=8)
           8 slaves are spawned successfully. 0 failed.
   master (rank 0, comm 1) of size 9 is running on: bc02bl03
   slave1 (rank 1, comm 1) of size 9 is running on: bc02bl03
   slave2 (rank 2, comm 1) of size 9 is running on: bc02bl03
   slave3 (rank 3, comm 1) of size 9 is running on: bc02bl03
   ... ... ...
   slave7 (rank 7, comm 1) of size 9 is running on: bc02bl03
   slave8 (rank 8, comm 1) of size 9 is running on: bc02bl03
   >
   > .Last <- function(){
   +   if(is.loaded("mpi_initialize")) {
   +     if(mpi.comm.size(1)>0) {
   +       print("Please use mpi.close.Rslave() to close slaves.")
   +       mpi.close.Rslaves()
   +     }
   +     print("Please use mpi.quit() to quit R")
   +     .Call("mpi_finalize")
   +   }
   + }
   >
   > mpi.remote.exec(paste("I am",mpi.comm.rank(),"of",mpi.comm.size()))
   $slave1
   [1] "I am 1 of 9"

   $slave2
   [1] "I am 2 of 9"

   $slave3
   [1] "I am 3 of 9"

   $slave4
   [1] "I am 4 of 9"

   $slave5
   [1] "I am 5 of 9"

   $slave6
   [1] "I am 6 of 9"

   $slave7
   [1] "I am 7 of 9"

   $slave8
   [1] "I am 8 of 9"

   > mpi.close.Rslaves()
   [1] 1
   > mpi.quit()
