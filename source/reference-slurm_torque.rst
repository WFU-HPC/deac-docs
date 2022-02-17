======================
Slurm for Torque Users
======================

.. contents::
   :depth: 3
..


Slurm to Torque/Maui Equivalents
================================

-  Summary of equivalent commands can be found
   `here <http://slurm.schedmd.com/rosetta.pdf>`__
-  A good transition reference guide can be found
   `here <https://wiki.csiro.au/display/ASC/Reference+Guide%3A+Migrating+from+Torque+to+SLURM>`__

User Commands
-------------

-  SLURM commands have many different parameters and options.
-  Any favorite custom options should be added to the `SLURM
   commands </SLURM_commands>`__ wiki page.

===================
================================================================================
=====================
Command             Slurm                                                                            Torque/Maui
===================
================================================================================
=====================
Cluster Status      `sinfo <http://slurm.schedmd.com/sinfo.html#OPT_node>`__ [-Nel]                  viewnodes OR qstat -a
Queue List          `squeue <http://slurm.schedmd.com/squeue.html>`__ [-u ]                          showq OR qstat -Q
Job Submission      `sbatch <http://slurm.schedmd.com/sbatch.html>`__                                qsub
Job deletion        `scancel <http://slurm.schedmd.com/scancel.html>`__                              qdel
Job status          `squeue <http://slurm.schedmd.com/squeue.html>`__                                qstat
Job information     | `scontrol <http://slurm.schedmd.com/scontrol.html#OPT_show>`__ show job        | qstat -f 
\                   `sstat <http://slurm.schedmd.com/sstat.html#OPT_jobs>`__ -j .batch               | checkjob 
Job Completion Info `sacct <http://slurm.schedmd.com/sacct.html#OPT_jobs>`__ -j -l                   tracejob
Node List           `sinfo <http://slurm.schedmd.com/sinfo.html#OPT_node>`__ -N                      pbsnodes -l
Show Reservation    `scontrol <http://slurm.schedmd.com/scontrol.html#OPT_show>`__ show reservation= showres
Fairshare Info      `sshare <http://slurm.schedmd.com/sshare.html#OPT_accounts=>`__ [-A ] [-u ]      diagnose -f
Job Queue Priority  `sprio <http://slurm.schedmd.com/sprio.html>`__                                  diagnose -p
\                                                                                                   
===================
================================================================================
=====================

Batch / Script Parameters
-------------------------

-  Review the `SLURM conversion
   script </SLURM:Torque_Conversion_Script>`__ wiki page to see how to
   use the DEAC cluster's custom conversion script and convert your old
   Torque batch scripts to SLURM.

================== ====================================================
============================================
Environment        Slurm                                                Torque/Maui
================== ====================================================
============================================
Directive          #\ `SBATCH <http://slurm.schedmd.com/sbatch.html>`__ #PBS
Queue              --partition=                                         -q
Name               --job-name=                                          -N
CPU/Node Resources --nodes=1                                           
\                  --tasks-per-node=8                                   -l nodes=1:ppn=8:ethernet
\                  --constraint=”ethernet”                             
Memory Size        --mem=2048                                           -l mem=2048mb
Memory Per CPU     --mem-per-cpu=2048                                   -l pmem=2048mb
Time               --time=[days-]hh:mm:ss                               -l walltime=[dd:]hh:mm:ss
\                                                                       -l cput=48:00:00
Error Output File  --error=%j.job_id_error                              -j oe
\                  --output=%n.node_name_output                        
Charge Account     --account=                                           -W group_list=
Email Address      --mail-user=carlsoas@wfu.edu                         -M carlsoas@wfu.edu
Run Variables      --export=“var1=X[,var2=Y]“                           -v var1=X,var2=Y
Specify Feature    --constraint=“[clan03|clan04]“                       -W x=\”NODESET=ONEOF:FEATURE:clan03:clan04\”
================== ====================================================
============================================

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

SLURM Torque Conversion: Purpose
=======

-  This script exists to convert Legacy Torque pbs scripts to SLURM
   batch scripts

Usage
=====

-  To convert a legacy Torque script to a SLURM batch script
-  Log into any SLURM head node, and the script is part of the default
   $PATH

:\* Provide the path to the file for the input [**-i**]

::

    # pbs2slurm.py -i ./path/to/file1.pbs 

:\* To change the file name besides .slurm

::\* Provide the desired output filepath/name for the output [**-o**]

   ::

       # pbs2slurm.py -i ./path/to/file1.pbs -o ./output/NEWFILE.slurm 

-  To convert multiple legacy Torque scripts to SLURM batch scripts

:\* Specify multiple filepaths (space delimited) or a directory path for
the input [**-i**]

::

    # pbs2slurm.py -i ./path/to/file1.pbs ./path/to/file2.pbs ./path/to/file3.pbs 

      OR

::

    # pbs2slurm.py -i ./path/to/files/ 

:\* To change the output from default, a directory MUST be specified for
the output

::

    # pbs2slurm.py -i ..... -o ./output/path/ 

-  Preview conversion changes

:\* Run the script as you normally would, but include the [**-p**]
option

::

   $ pbs2slurm.py  -i ./pbs_jobs/torqur_script.pbs -o ./ -p
   PREVIEW: ./torque_script.pbs.slurm
   #SBATCH --partition=test
   #SBATCH --output="JOB.o"
   #SBATCH --error="JOB.e"
   #SBATCH --account="adminGrp"
   #SBATCH --mail-user=arteca9@wfu.edu
   #SBATCH --constraint="ethernet"
   #SBATCH --time=0-100:00:00
   # Note: SLURM has no batch input for cputime, excluding.
   #SBATCH --mem=50gb
   #SBATCH --job-name="convert_torque_script"
   #SBATCH --mem-per-cpu=50gb
   #NOTE:SLURM defaults to running jobs in the directory where submitted; check functionality!
   cd $SLURM_SUBMIT_DIR
   SCRATCH=/scratch/$SLURM_JOBID

:*To see the entire script output in preview mode, include the [**-v**]
option

Typical Required Fixes
======================

-  Partition should be changed from "debug"

:\* This is the default partition the conversion script assigns, you
should replace it with your desired partition

-  Infiniband job submission

:\* Remove any infiniband constraints, assign the job to the
"infiniband" partition, and add the "switches=1" directive

-  Multiple "constraint" directives are present

:\* Because SLURM can apply and/or logic to constraints, only one entry
should be present

:\* Furthermore, some constraints required previously in Torque are no
longer necessary or present (like the "infiniband" constraint)

:\* Combine them to a single line, use the
[https://computing.llnl.gov/linux/slurm/sbatch.html#OPT_constraint\ \|
SLURM constraint manpage] for guidance

-  The title "JOB" will be applied to your output files.

:\* This is due to the nature in which the script scans the file for
conversion

:\* If it appeared first, the job name would be able to be extrapolated
and inserted into the log file name

:\* Replace the word "JOB" with your job-name to follow best practices

-  Memory directive change for multi-node jobs

:\* The SLURM memory directive is defined on a **per node** basis,
whereas Torque memory entries are based on the sum total.

:\* For multinode jobs, the previous value must be divided by the number
of nodes requested

:\* For example, a previously existing 200gb entry for a 5 node job,
will equate to a 40gb per node requirement in SLURM

:*\* --mem=40gb

Script Help
===========

-  The slurm conversion script uses the argparse module to accept script
   input

::

   # pbs2slurm.py -h
   usage: pbs2slurm.py [-h] -i INPUT [INPUT ...] [-o OUTPUT] [-p] [-v]

   Script to convert Torque batch scripts to SLURM batch scripts.

   optional arguments:
     -h, --help            show this help message and exit
     -i INPUT [INPUT ...], --input INPUT [INPUT ...]
                           Input directory/file(s) to be converted. Note: Only
                           converts file's with extensions '.pbs' and '.SC
     -o OUTPUT, --output OUTPUT
                           Output directory/file for converted files (optional)
                           Default: Create output file with same name as
                           converted plus '.slurm' extension
     -p, --preview         Only show converted directives and errors, no files
                           created.
     -v, --verbose         Show non-converted files, preview entire script, and
                           see directory information.
