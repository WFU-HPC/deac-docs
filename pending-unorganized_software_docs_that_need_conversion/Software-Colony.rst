.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

-  **COLONY** is a program that "implements a maximum likelihood method
   to assign sibship and parentage jointly, using individual multilocus
   genotypes at a number of codominant or dominant marker loci"
-  For complete information on **COLONY**, go to the `OFFICIAL
   WEBSITE <http://www.zsl.org/science/software/colony>`__

Version
=======

Version installed on the cluster is:

:\* **2.0.5.5**

:\* **COLONY** on the cluster does not have a GUI

Usage
=====

-  The different executable binaries are:

:\* colony2s-ifort13.out

:\* colony2p-ifort13-ompi145.out

:\* colony2p-ifort11-qlcmpi127.out

:\* colony2p-gun463-ompi165.out

::

   Note:
         colony2s - Serial binary for COLONY
         colony2p - Parallel binaries for COLONY

Template
========

-  Template for a serial execution of colony

::

   #!/bin/bash
   #SBATCH --partition=small
   #SBATCH --job-name="Colony_test_Serial"
   #SBATCH --constraint="ethernet"
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=1
   #SBATCH --cpus-per-task=1
   #SBATCH --time=0-00:20:00
   #SBATCH --output="Colony_test_Serial-%j.o"
   #SBATCH --error="Colony_test_Serial-%j.e"
   #SBATCH --mail-type=BEGIN,END,FAIL
   #SBATCH --mail-user=username@wfu.edu
   #SBATCH --account="'fairshareGrp'"
   #SBATCH --mem=8gb

   # set variables for directories
   cd /home/username/colony

   ./colony2s-ifort13.out INF:colony2.dat > Serial_Output.txt
