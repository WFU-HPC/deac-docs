.. _sec.qs3:

============================
Quickstart 3: Job Submission
============================

.. contents::
   :depth: 3
..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

What is SLURM?
==============

The SLURM Workload Manager is *an open source, fault-tolerant and highly
scalable cluster management and job scheduling system*\  [1]_ used on
the DEAC cluster. Formerly known as Simple Linux Utility for Resource
Management (aka **SLURM**) [2]_, it provides three key functions:

#. Allocates exclusive and/or non-exclusive access to resources (compute
   nodes) to users for X period of time
#. Provides a framework for starting, executing, and monitoring work on
   allocated nodes
#. Arbitrates contention for resources by managing a queue of pending
   jobs

Example Usage
=============

Training Videos
---------------

-  SLURM Job-Submission Part 1 - `Batch Scripts and
   Components <https://youtu.be/ChcsBE6tJr8?list=PL-g8n27Db1XfPrRvZMBSxK55_lIy39sqZ>`__
-  SLURM Job-Submission Part 2 -
   `Commands <https://youtu.be/yjDwCnLTVPk?list=PL-g8n27Db1XfPrRvZMBSxK55_lIy39sqZ>`__
-  SLURM Job-Submission Part 3 - `Resource
   Availability <https://youtu.be/awspKUrvRIg?list=PL-g8n27Db1XfPrRvZMBSxK55_lIy39sqZ>`__

Job Submission
--------------

This is a trivial example of using a SLURM script to submit a job
consisting of a single program (called ``hello_world``). Further details
are in the *SLURM Sbatch Guide* online, [3]_ or found on multiple other
college websites. [4]_ The program prints "hello, world!" to stdout, and
then sleeps for 30 seconds before terminating. We run it interactively
here:

| ``   ``\ **``[username@headnode]>``**\ `` pwd``
| ``   ~/Code/Sandbox/trunk/slurm/NiceCode/``
| ``   ``\ **``[username@headnode]>``**\ `` ./hello_world``
| ``   hello, world!``

Here's the job/batch script **``myjob.slurm``**. The lines starting with
``#SBATCH`` specify SLURM directives. They are basically glorified
comments as far as the bash script would be concerned, but sbatch
requires them for job submission. Most of them can be specified as
options to the **sbatch** command, which overrides directives within the
script. It's important to set your email address with "#SBATCH
--mail-user=username@wfu.edu" so that you receive notifications about
your job.

::

   #!/bin/bash -l
   #SBATCH --partition=medium
   #SBATCH --job-name=hello01
   #SBATCH --mail-type=BEGIN,END,FAIL
   #SBATCH --mail-user=username@wfu.edu
   #SBATCH --account=researcherGrp
   #SBATCH --nodes=2
   #SBATCH --tasks-per-node=8
   #SBATCH --mem=4gb
   #SBATCH --time=0-00:30:00

   $HOME/Code/Sandbox/trunk/slurm/NiceCode/hello_world

This sbatch script sets some SLURM-specific variables, and then calls
the actual program **hello_world**. The job is submitted with
``sbatch``:

| ``   ``\ **``[username@headnode]>``**\ `` sbatch myjob.slurm``
| ``   Submitted batch job 1234``

Test Submission
---------------

To see if you job will submit successfully, you can use the
**--test-only** flag with sbatch. It will show the approximate start
time, resources used, and node name to be assigned to your job:

| ``   ``\ **``[username@headnode]$``**\ `` sbatch --test-only ./myjob.slurm ``
| ``   sbatch: Job 1234 to start at 2016-04-29T15:17:22 using 16 processors on bc04bl[06,08]``

Job Status
----------

You can check the status of a job with ``sacct``:

| ``   ``\ **``[username@headnode]>``**\ `` sacct --jobs 1234``
| ``   JobID    JobName  Partition    Account  AllocCPUS      State ExitCode ``
| ``   ------------ ---------- ---------- ---------- ---------- ---------- -------- ``
| ``   1234         hello_wor_+      medium   researchgrp          1  COMPLETED      0:0 ``
| ``   1234.batch        batch                researchgrp          1  COMPLETED      0:0``

Check the `SLURM commands </SLURM:Commands#sacct>`__ page for more
information on output formatting!

Email Messages
--------------

You should receive an email message when the job begins:

::

   Job <hello_world> was executed on node(s) <compute_node1>, in partition <partition>, as user <username> from group <researchgrp>.
   The initial working directory of this job was /home/username/Code/Sandbox/trunk/slurm/NiceCode/.

   Job has started execution.

   Job Times:
   =======
       Submitted:  2015-09-04 09:16:12
       Started:    2015-09-04 09:16:12


   Summary email to be sent upon job completion.

And then another when the job completes:

::

   Job <hello_world> was executed on node(s) <compute_node1>, in partition <partition>, as user <username> from group <researchgrp>.
   The initial working directory of this job was /home/username/Code/Sandbox/trunk/slurm/NiceCode/.

   Job successfully completed.

   Job Times:
   =======
       Submitted:  2015-09-04 09:16:12
       Started:    2015-09-04 09:16:12
       Ended:      2015-09-04 09:16:25
       Elapsed:    00:00:13

   Job Resource Usage Summary:
   ======================

       JOB ID:   1234
       # CPUS:   8
       # NODES:  2
       MEM/task: n/a
       JOB Name: hello_world

       JOB ID:   6352.batch
       # CPUS:   8
       # NODES:  2
       MEM/task: 19540K
       JOB Name: batch


   Requested Resources and Totals:
   =======================
       Requested time limit:  0-00:30:00
       Requested memory:      4G (per Node)
       Total CPU time :       00:00:13
       Total Allocated CPUs:  8
       Total Allocated Nodes: 2

Output Files
------------

When the job completes, by default there is one output file created in
the working path when the job was submitted: **slurm-.out**. This file
will contain data written to *stdout* (printed output messages) and
*stderr* (generated error messages) information. To change this default
action and create separate files, use the following directives:

Create a starndard output file with whichever name you desire (best
practice - include the job name), and containing job id:

``  #SBATCH --output="hello_world-%j.o"``

Create a standard error file with whichever name you desire, and
containing job id:

``  #SBATCH --error="hello_world-%j.e"``

These files are also created by default in the working path when the job
was submitted. To change the path where the file is created, add the
following directive to your batch script.

``  #SBATCH --workdir="``\ \ ``"``

The job output file(s) will then be created in that specified workdir
path.

Job Submission Details
======================

A job script is a normal script. It can be a shell script (bash, tcsh,
sh, csh, zsh) or even any other scripting language (Perl, Python, etc).
SLURM will set environment variables before executing the script, and
the job script has access to these environment variables. If your script
is not a shell script, then you would have to use the script language
features to get access to the environment variables.

A job script may consist of SBATCH directives, comments, and executable
statements. SBATCH directives -- lines beginning with "**#SBATCH**" --
specify job attributes as well as (sbatch) command line options. Lines
where the first non-whitespace character is "``#``" are comments (other
than the "``#SBATCH``" lines).

When a job script is submitted with sbatch, it parses the script for
#SBATCH directives. These directives correspond to sbatch command line
options; any directive given via command line during submission will
override matching directives within the job script.

sbatch
------

There are many sbatch options, all of which may be put into the SLURM
batch script with "#SBATCH" directives. This helps you avoid typing long
sbatch commands. See the sbatch man page for complete details. Look at
the for the `sbatch <https://slurm.schedmd.com/sbatch.html>`__ online
documentation, or on command line by running **sbatch -h**. You can run
sbatch with the **--test-only** parameter to test syntax and logic of
your directives and determine if submission would be successful. Another
helpful resource is the official SLURM cheatsheet [5]_. NOTE that
**srun** usage is not normally used on the cluster.

Requesting Resources
--------------------

Within SLURM, CPU and Memory are used as consumable resources. This
means that when these resources are requested, they are the primary
deciding factor in node assignment. CPU specifies the number of cores,
and memory specifies the amount of RAM required. Jobs should also
specify the number of nodes and time required. All resource requests
should be explicitly listed within the job script using the #SBATCH
directive. More details on consumable resources are in SLURM
documentation online. [6]_

| ``   # Example of requesting 16 total CPUS across 2 nodes, with 32 GB of memory, to run for 24 hours``
| ``   #SBATCH --nodes=2``
| ``   #SBATCH --tasks-per-node=8``
| ``   #SBATCH --mem=32gb``
| ``   #SBATCH --time=24:00:00``

Every node sets aside 1 GB of RAM for system use, so the amount
available for user jobs is less than the total installed RAM. This means
that, if your job requires less than 96 GB of RAM, it is better to
request <= 95 GB. This is because there are nodes with 96 GB of RAM
installed, and requesting exactly 96 GB means the job will not run on
these otherwise available nodes.

Also, there is no consideration for CPU Time within SLURM, all time
estimates should be based on actual run time (walltime) only.

Partitions
----------

Partitions are used within SLURM to provide additional weight for job
types allocated on the DEAC cluster. To specify a partition, use the
following directive:

   #SBATCH --partition=

A partition must be specified to run jobs on the cluster, the default
partition is not designed to work outside of testing. See
`SLURM:Resources#Partitions </SLURM:Resources#Partitions>`__ for a full
list of available SLURM partitions to submit jobs to.

Scratch Disk Space
------------------

For jobs which do a lot of disk i/o, it may be advantageous to use a
local disk during execution. Local disk i/o is much faster than network
disk i/o. Every compute node has at least 40GB of scratch disk space on
a local disk, with newer nodes having 250GB. A constraint can be used to
specify desired scratch space availability on nodes.

When a job starts up on a compute node, a scratch directory is
automatically created in ``/scratch/$SLURM_JOBID``. Make sure to write
your job scripts to use that directory as scratch space. If you need
more scratch disk space than available, you can A) Reduce the job output
and run into smaller chunks, B) Intermittently clean up output in
scratch space, or C) Use your research data directory. Option C will
incur a performance penalty as disk i/o over the network is slower than
local disk i/o.

**IMPORTANT**: DO NOT use your home directory for writing out files
created during a run, especially if there is a lot of data and/or a lot
of files. This will be slow for your job, and will cause interactive
sessions on the head node to slow down, too. To prevent slow down,
admins may terminate suspect jobs that are actively performing many
read/writes to home directories.

Please see `Quick Start Guide:Disk
Space </Quick_Start_Guide:Disk_Space>`__ for more information.

Permissions of Output Files
---------------------------

Files created by the job script (not the output file(s) mentioned
`previously </SLURM:Quick_Start_Guide#Output_Files>`__ are created by
default with permissions of 775 (people in your group can read and
write; everyone else can read) that only allow the owner to read them.
To make it so only you can access files created by your script, insert
the following after the directives in your job script:

   umask 0077

SLURM also has a built in variable, SLURM_UMASK, but it does not
function properly at this time. If you want your output files to be
accessable by your group, but not to everyone else, insert the following
after the directives in your job script:

   umask 0027

Environment Variables
---------------------

SLURM has two types of environment variables. INPUT environment
variables [7]_ are read and used during execution; they override options
set in the batch script, but command line options override any
environment variables. OUTPUT environment variables [8]_ are set by the
controller daemon, and can not be overridden in a batch script. Both
types contain information about the runtime environment, e.g. the
working directory, the node on which it is running, etc. See the
referenced source pages for more information.

SLURM constraints
-----------------

When running parallel processing jobs, users typically will want all of
the nodes assigned to the job to be similar (e.g. on the same chassis).
In most cases, it doesn't matter which chassis the job is run on so long
as all the nodes are in the same one.

This scenario requires the use of SLURMs constraint functionality.
Constraints are matched against a nodes' assigned features, which are
dependent upon a node's `Hardware
Configuration </Cluster:Hardware_Configuration#SLURM_Node_Features>`__.
To use the constraint function, simply include one of the following line
within your script:

-  Single flag

..

   ::

      #SBATCH --constraint="x"

-  Multiple flags allowed

..

   ::

      #SBATCH --constraint="x|y|z"
      ###This allows different constraints to be selected across multiple nodes

-  Matching Multiple flags

..

   ::

      #SBATCH --constraint="[x|y|z]"
      ###This matches a singular constraint against all selected nodes

-  Multiple flags required

..

   ::

      #SBATCH --constraint=[x&y&z]
      ###This requires all constraint listed to be present for a node to be selected

When using constraints, be careful not to require groupings of
constraints that do not exist. For example, do not require
[cascade&skylake] as that does not exist; meaning the jobs will never
run.

Job Chaining and Dependencies
-----------------------------

Job execution can be dependent on other jobs completing (successfully or
not). This dependency feature is an advanced capability requires
submitting a job that references an existing job on which to be
dependent via:

``   sbatch --dependency=``\ \ ``:``\ \ ``[:``\ \ ``...] <mywaitingjob.slurm>``

Along with the ** to depend on, an '' clause must be included. Those
options are:

-  after - Can begin after the specified job starts running
-  afterok - Can begin running after the specified jobs ends
   successfully
-  afternotok - Can begin running after the specified job ends with
   failure
-  afterany - Can begin running after specified job ends, regardless of
   status.

A job can have multiple JOB_IDs that it depends upon, which are
delimited with a colon. Dependencies are usually used within job chains,
which are long sequences of small jobs that run sequentially. A simple
bash script example that creates a singular job chain is shown below:

::

   #!/bin/bash

   FIRST=$(sbatch --parsable $1)
   COUNTER=1
   while [ $COUNTER -lt $2 ]; do
      SECOND=$(sbatch --parsable --dependency=afterany:$FIRST $1)
      let COUNTER=COUNTER+1
      FIRST=$SECOND
   done

The above example requires two input parameters to create a job chain.

#. Path to the job file to execute: "myscript.slurm"
#. An integer representing the number of dependent iterations: "100"

Job Arrays
----------

Job arrays used to start more than one job with a single job script
submission. The --array directive must be used to create an array Job
arrays will have two additional environment variabels set.
**SLURM_ARRAY_JOB_ID**, which is set to the first job ID of the array,
and **SLURM_ARRAY_TASK_ID**, which is the index value for that job.
Essentially, the "SLURM_JOBID" environment variable will only match the
"SLURM_ARRAY_JOB_ID" of the first job. To create output an output file
containing the assigned Array JOB_ID value with special environment
variables, define the output directive as follows within your job:

``  #SBATCH --output=JOB_NAME-%A_%a.o``

The **%A** will automatically inherit the **SLURM_JOBID** if used
outside of an array; whereas **%a** will be assigned "4,294,967,294
(equivalent to 0xfffffffe or NO_VAL) if used. Please see the `Official
Slurm Job Array Support <http://slurm.schedmd.com/job_array.html>`__
article for more in depth information.

Interactive Jobs
----------------

-  Though batch submission is the recommended way to submit jobs to the
   cluster
-  Interactive jobs can also be run in the foreground, which can be
   useful for things like:

   -  Iterative data exploration at the command line
   -  RAM intensive graphical applications like MATLAB or SAS.
   -  Interactive "console tools" like R and iPython

-  Interactive jobs can be submitted using the **srun** command with the
   **--pty** option

   -  The below example will open a bash command line shell on a node
      for 6 hours with 2GB of RAM.

      -  The --pty option allows the session to act like a standard
         terminal on the assigned node.

..

   ::

      srun -p small --pty -n 1 --mem=64G --time=6:00:00 --reservation=x11_2 /bin/bash 

X11 forwarding
--------------

-  Interactive srun jobs can submit **--x11=[first|last|all]** to enable
   forwarding

..

   ::

       srun -p small --pty --x11 -n 1 --mem 4000 -t 0-06:00 /usr/bin/bash -i 

Job States
==========

A job may have one of several states during its lifetime. If you run
**squeue -l**, the job state is reported as *STATE*, in its full or
abbreviated name. See
http://slurm.schedmd.com/squeue.html#lbAG\ `Official Slurm Listing of
Job State
Codes </http://slurm.schedmd.com/squeue.html#lbAG_Official_Slurm_Listing_of_Job_State_Codes>`__
for the full listing of states, below are the most common you will see
on our cluster:

CANCELLED (CA) : Job was explicitly cancelled by the user or system administrator. The job may or may not have been initiated.
COMPLETED (CD) : Job has terminated all processes on all nodes.
FAILED (F) : Job terminated with non-zero exit code or other failure condition.
NODE_FAIL (NF) : Job terminated due to failure of one or more allocated nodes.
PENDING (PD) : Job is awaiting resource allocation.
RUNNING (R) : Job currently has an allocation.

Querying the Cluster
====================

SLURM provides several commands which allow you to query the state of
the queue, the state of a partition, the state of your job, or the state
of the compute nodes. Some officially supported plugins are available
and installed on the cluster to provide even more command line options.
Some of which are designed to replicate output of previously used Torque
commands. See the [https://github.com/ubccr/stubl\ \| official STUBL
support page] for more information.

Job information
---------------

squeue [--start --job ]
   Use this command to query the list of jobs currently running and
   queued on the cluster
   Use the optional input to determine estimated start time and node(s)
   for a job
scontrol show job JOB_ID
   Show detailed information about an active job
sinfo --jobs= [ etc]
   Show detailed information about a completed job

Changing jobs
-------------

   NOTE: you can only modify your own job
scontrol update JobID= TimeLimit=d-hh:mm:ss
   Change wall time of a job to d-hh:mm:ss
scancel 
   Terminate a queued or running job

Partition information
---------------------

For information on partitions, visit the
`SLURM:Resources#Partitions </SLURM:Resources#Partitions>`__ page.

Commands used to query nodse and gather partition information is as
followS:

sinfo -p 
   Queries the specified partition
sinfo --long --Node --summarize
   Shows an overall listing of nodes sorted by partition
scontrol show partition []
   Show detailed information for all or specified partition
spinfo (STUBL)
   Custom designed output for partition information

Node information
----------------

sinfo -Nel
   Shows an overall listing of nodes, sorted by nodes
sinfo -t idle
   Show only idle nodes
scontrol show nodes []
   Shows hardware details for all or specified node, including features
snodes (STUBL)
   Displays node information in an easy-to-interpret format

Matlab Jobs
===========

To submit Matlab to the queue, please see
`Software:Matlab </Software:Matlab>`__

See Also
========

-  `SLURM:Job Script Templates </SLURM:Job_Script_Templates>`__
-  `SLURM:Resources </SLURM:Resources>`__
-  `SLURM:Troubleshooting </SLURM:Troubleshooting>`__
-  `Troubleshooting <http://slurm.schedmd.com/troubleshoot.html>`__ on
   the official SLURM support page
-  `FAQ <http://slurm.schedmd.com/faq.html>`__ on the official SLURM
   support page
-  `Unofficial SLURM Cheat
   Sheet <https://confluence.csiro.au/download/attachments/342229594/SLURM.pdf?version=1&modificationDate=1466993467567&api=v2>`__
   (pdf document)
-  `SLURM Node
   Features </Cluster:Hardware_Configuration#SLURM_Node_Features>`__ --
   specify nodes that you want for your job by their specific features

References
==========

.. raw:: html

   <references/>

.. [1]
   `SLURM Quickstart Guide <http://slurm.schedmd.com/quickstart.html>`__
   at Department of Energy's National Nuclear Security Administration

.. [2]
   `Slurm Workload Manager
   article <https://en.wikipedia.org/wiki/Slurm_Workload_Manager>`__ at
   Wikipedia

.. [3]
   `Job Submission <http://slurm.schedmd.com/sbatch.html>`__ under
   *OPTIONS*

.. [4]
   Google Search
   `1 <https://www.google.com/search?q=slurm+sbatch+edu+examples&oq=slurm+sbatch+edu+examples>`__;
   or type sbatch --help on the command line

.. [5]
   `SLURM Cheat Sheet <https://slurm.schedmd.com/pdfs/summary.pdf>`__

.. [6]
   `Resources in
   SLURM <http://slurm.schedmd.com/cons_res.html#Consumable>`__

.. [7]
   `Sbatch Input
   Variables <http://slurm.schedmd.com/sbatch.html#lbAF>`__ at SchedMD

.. [8]
   `Sbatch Output
   Variables <http://slurm.schedmd.com/sbatch.html#lbAG>`__ at SchedMD

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

SLURM commands
==============

User Commands
-------------

-  SLURM commands have many different parameters and options.
-  Any favorite custom options or detailed information should be added
   to this page down below.

===================
================================================================================
Command             Slurm
===================
================================================================================
Cluster Status      `sinfo <http://slurm.schedmd.com/sinfo.html#OPT_node>`__ [-Nel]
Queue List          `squeue <http://slurm.schedmd.com/squeue.html>`__ [-u ]
Job Submission      `sbatch <http://slurm.schedmd.com/sbatch.html>`__
Job deletion        `scancel <http://slurm.schedmd.com/scancel.html>`__
Job status          `squeue <http://slurm.schedmd.com/squeue.html>`__
Job information     | `scontrol <http://slurm.schedmd.com/scontrol.html#OPT_show>`__ show job 
\                   `sstat <http://slurm.schedmd.com/sstat.html#OPT_jobs>`__ -j .batch
Job Completion Info `sacct <http://slurm.schedmd.com/sacct.html#OPT_jobs>`__ -j -l
Node List           `sinfo <http://slurm.schedmd.com/sinfo.html#OPT_node>`__ -N
Show Reservation    `scontrol <http://slurm.schedmd.com/scontrol.html#OPT_show>`__ show reservation=
Fairshare Info      `sshare <http://slurm.schedmd.com/sshare.html#OPT_accounts=>`__ [-A ] [-u ]
Job Queue Priority  `sprio <http://slurm.schedmd.com/sprio.html>`__
\                  
===================
================================================================================

Environment Variables
---------------------

-  Nearly every SLURM command has an option to set an output format
   *environment variable* to change it's default output
-  Output Formatting can be made temporary by setting the environment
   variable on command line.
-  It can also be made permanent for your account by adding that command
   to your "~/.bashrc" file

:*Before adding to your "~/.bashrc" file it is recommended that you test
setting the environment variable on command line first

:*If not tested first, you will need to log out and back in for the
command to run from "~/.bashrc"

-  If the environment variable is successfully set, the change in format
   to the command output will be immediate.
-  Another way to confirm is to run **echo $SQUEUE_FORMAT** for example

:*This will show the applied value to the variable if set.

:*If the result returns blank, the variable was not set.

-  To undo your test, run **unset $SQUEUE_FORMAT** to unassign the
   environment variable
-  If successfully unassigned, the change in format will revert back to
   default immediately.

squeue
------

-  Display list of all jobs in the queue

::

   [username@headnode ~]$ squeue -u username
    JOBID PARTITION      NAME     USER ST       TIME  NODES NODELIST(REASON)
    10011     small   aweome1 username PD       0:00      1 (Resources)
    10012     small   a-groov username PD       0:00      1 (Priority)
    10013     small  a-awesom username PD       0:00      1 (Priority)
    10032     small   tubular username  R      12:43      1 a1a-u2-c2-b8
    10000    medium  cowabung username  R   23:29:13      1 a1a-u2-c11-b2
    10001    medium   radical username  R   23:29:47      1 a1a-u2-c11-b1
    10002    medium  most-exc username  R   23:30:16      1 a1a-u2-c10-b1

Start Time
~~~~~~~~~~

-  Display estimated start times of next jobs in the queue, as well as
   expected host nodes

::

   [username@headnode ~]$ squeue --start
    JOBID PARTITION      NAME     USER ST          START_TIME  NODES SCHEDNODES           NODELIST(REASON)

    11901    medium  funstuff username PD 2017-02-21T08:40:15      8 bc12bl[01,04,06-07,0 (Resources)
    12001    medium  superman username PD 2017-02-21T09:03:25      8 a1a-u2-c5-b7,a1a-u2- (Resources)
    12022     small   yellow1 username PD 2017-02-21T09:08:24      1 a1a-u2-c10-b3        (Resources)
    12023     small   yellow2 username PD 2017-02-21T09:09:56      1 a1a-u2-c10-b5        (Priority)
    12024     small   yellow3 username PD 2017-02-21T09:10:47      1 a1a-u2-c10-b6        (Priority)
    12025     small   yellow4 username PD 2017-02-21T09:11:28      1 a1a-u2-c11-b2        (Priority)
    12026     small   yellow5 username PD 2017-02-21T09:11:28      1 a1a-u2-c11-b8        (Priority)
    12034    medium   potatoe username PD 2017-02-21T09:12:42      2 bc01bl[10,13]        (Resources)
    12035     small    turtle username PD 2017-02-21T09:12:47      1 a1a-u2-c13-b3        (Priority)

Output Formatting
~~~~~~~~~~~~~~~~~

There are many output options available with squeue; to see them, run
**man squeue** and scroll down to *output_format*. From there, custom
outputs can be defined and viewed with the *-o * option. If you wish to
see certain fields all the time when you run squeue, you can follow the
below instructions to set the SQUEUE_FORMAT environment variable within
your profiles to change your default output format of the squeue
command.

-  Example: ensure the default output has longer job names

:*NOTE - default output format retrieved from man page

:*Add the following line to your ~/.bashrc file

:: export SQUEUE_FORMAT="%.18i %.9P %.16j %.8u %.2t %.10M %.6D %R"

:\* In tcsh, add the following line to your ~/.cshrc file

      set SQUEUE_FORMAT="%.18i %.9P %.16j %.8u %.2t %.10M %.6D %R"

-  When set, the SQUEUE_FORMAT environment variable will override the
   default format.
-  For both examples, we are using short form notation.
-  Format for each field is "%[[.]size]type"

:\* Adding a "." before the number will print the characters right
justified

-  Before adding to your .bashrc file, setting the variable can be done
   on command line to test

sacct
-----

Default Output
~~~~~~~~~~~~~~

You can check the status of a job with sacct:

::

   [username@headnode ~]$ sacct --jobs 1234
   JobID    JobName  Partition    Account  AllocCPUS      State ExitCode 
   ------------ ---------- ---------- ---------- ---------- ---------- -------- 
   1234         hello_wor_+      medium   researchgrp          1  COMPLETED      0:0 
   1234.batch        batch                researchgrp          1  COMPLETED      0:0 

The sacct command has a vast amount of information that can be
displayed. Adding the -l option gives more information, but adding the
-e option shows all available fields:

Available Content
~~~~~~~~~~~~~~~~~

::

   [username@headnode slurm_examples]$ sacct -e
   AllocCPUS         AllocGRES         Account           AssocID          
   AveCPU            AveCPUFreq        AveDiskRead       AveDiskWrite     
   AvePages          AveRSS            AveVMSize         BlockID          
   Cluster           Comment           ConsumedEnergy    ConsumedEnergyRaw
   CPUTime           CPUTimeRAW        DerivedExitCode   Elapsed          
   Eligible          End               ExitCode          GID              
   Group             JobID             JobIDRaw          JobName          
   Layout            MaxDiskRead       MaxDiskReadNode   MaxDiskReadTask  
   MaxDiskWrite      MaxDiskWriteNode  MaxDiskWriteTask  MaxPages         
   MaxPagesNode      MaxPagesTask      MaxRSS            MaxRSSNode       
   MaxRSSTask        MaxVMSize         MaxVMSizeNode     MaxVMSizeTask    
   MinCPU            MinCPUNode        MinCPUTask        NCPUS            
   NNodes            NodeList          NTasks            Priority         
   Partition         QOS               QOSRAW            ReqCPUFreq       
   ReqCPUS           ReqGRES           ReqMem            Reservation      
   ReservationId     Reserved          ResvCPU           ResvCPURAW       
   Start             State             Submit            Suspended        
   SystemCPU         Timelimit         TotalCPU          UID              
   User              UserCPU           WCKey             WCKeyID  

.. _output-formatting-1:

Output Formatting
~~~~~~~~~~~~~~~~~

To see any of the fields specified above in the command output, run
''sacct --jobs= --format FIELD1[,FIELD2,etc]

If you wish to see certain fields all the time when you run sacct, you
can follow the below instructions to set the SACCT_FORMAT environment
variable within your profile to change your output format of the sacct
command

-  In bash, add the following line to your ~/.bashrc file

   export SACCT_FORMAT="JobID,User,Account,Cluster,NodeList%-50"

-  In tcsh, add the following line to your ~/.cshrc file

   set SACCT_FORMAT="JobID,User,Account,Cluster,NodeList%-50"

-  When set, the SACCT_FORMAT environment variable will override the
   default format.
-  For both examples, you can set spacing of each field by placing "%##"
   after the field name.

:\* Adding a "-" before the number will print the characters left
justified

sinfo
-----

.. _default-output-1:

Default Output
~~~~~~~~~~~~~~

You can check the status of nodes and partitions with sinfo:

::

   [username@headnode ~]$ sinfo
   PARTITION  AVAIL  TIMELIMIT  NODES  STATE NODELIST
   debug*        up    6:00:00      3    mix a1a-u2-c10-b[1-3]
   debug*        up    6:00:00      5  alloc a1a-u2-c10-b[4-7],a1a-u2-c11-b1
   debug*        up    6:00:00     24   idle a1a-u2-c10-b8,a1a-u2-c11-b[2-8],bc02bl[03,12],bc03bl[01-14]
   small         up 1-00:00:00      3    mix a1a-u2-c10-b[1-3]
   small         up 1-00:00:00      5  alloc a1a-u2-c10-b[4-7],a1a-u2-c11-b1
   small         up 1-00:00:00     24   idle a1a-u2-c10-b8,a1a-u2-c11-b[2-8],bc02bl[03,12],bc03bl[01-14]
   medium        up 7-00:00:00      3    mix a1a-u2-c10-b[1-3]
   medium        up 7-00:00:00      5  alloc a1a-u2-c10-b[4-7],a1a-u2-c11-b1
   medium        up 7-00:00:00     24   idle a1a-u2-c10-b8,a1a-u2-c11-b[2-8],bc02bl[03,12],bc03bl[01-14]
   large         up 365-00:00:      3    mix a1a-u2-c10-b[1-3]
   large         up 365-00:00:      5  alloc a1a-u2-c10-b[4-7],a1a-u2-c11-b1
   large         up 365-00:00:     22   idle a1a-u2-c10-b8,a1a-u2-c11-b[2-8],bc03bl[01-14]
   gpu           up 365-00:00:      1  down* gpu01
   gpu           up 365-00:00:      4   idle gpu[02-05]
   infiniband    up 365-00:00:      2   idle bc02bl[03,12]

.. _available-content-1:

Available Content
~~~~~~~~~~~~~~~~~

The sinfo command has a vast amount of information that can be
displayed. Adding the -l option gives more information, -N groups by
node, and -p limits output to specific partitions. The commands manpage
shows all possible fields available for output, listed below:

::

                The field specifications available include:
                 %all  Print all fields available for this data type with a vertical bar separating each field.
                 %a    State/availability of a partition
                 %A    Number  of  nodes by state in the format "allocated/idle".  Do not use this with a node state option ("%t"
                       or "%T") or the different node states will be placed on separate lines.
                 %B    The max number of CPUs per node available to jobs in the partition.
                 %c    Number of CPUs per node
                 %C    Number of CPUs by state in the format "allocated/idle/other/total". Do not use  this  with  a  node  state
                       option ("%t" or "%T") or the different node states will be placed on separate lines.
                 %d    Size of temporary disk space per node in megabytes
                 %D    Number of nodes
                 %E    The reason a node is unavailable (down, drained, or draining states).
                 %f    Features associated with the nodes
                 %F    Number  of  nodes  by state in the format "allocated/idle/other/total".  Do not use this with a node state
                       option ("%t" or "%T") or the different node states will be placed on separate lines.
                 %g    Groups which may use the nodes
                 %G    Generic resources (gres) associated with the nodes
                 %h    Jobs may share nodes, "yes", "no", or "force"
                 %H    Print the timestamp of the reason a node is unavailable.
                 %l    Maximum time for any job in the format "days-hours:minutes:seconds"
                 %L    Default time for any job in the format "days-hours:minutes:seconds"
                 %m    Size of memory per node in megabytes
                 %M    PreemptionMode
                 %n    List of node hostnames
                 %N    List of node names
                 %o    List of node communication addresses
                 %O    CPU load of a node
                 %p    Partition scheduling priority
                 %P    Partition name followed by "*" for the default partition, also see %R
                 %r    Only user root may initiate jobs, "yes" or "no"
                 %R    Partition name, also see %P
                 %s    Maximum job size in nodes
                 %S    Allowed allocating nodes
                 %t    State of nodes, compact form
                 %T    State of nodes, extended form
                 %u    Print the user name of who set the reason a node is unavailable.
                 %U    Print the user name and uid of who set the reason a node is unavailable.
                 %v    Print the version of the running slurmd daemon.
                 %w    Scheduling weight of the nodes
                 %X    Number of sockets per node
                 %Y    Number of cores per socket
                 %Z    Number of threads per core
                 %z    Extended processor information: number of sockets, cores, threads (S:C:T) per node
                 %.<*> right justification of the field
                 %<Number><*>
                       size of field

.. _output-formatting-2:

Output Formatting
~~~~~~~~~~~~~~~~~

The output of sinfo can be customized based on user preference using two
different methods. One can be done on the command line using "-o " or
"--format=", where the desired fields are specified at the users
discretion.

If you wish for the custom sinfo output to be default for your login
session, follow the below instructions to set the SINFO_FORMAT
environment variable within your profile to change the output format:

*  In bash, add the following line to your ~/.bashrc file

export SINFO_FORMAT='%N %.11T %.4c %.8z %.6m %.8d %.6w %.8f %20E'

*  In tcsh, add the following line to your ~/.cshrc file

set SINFO_FORMAT='%N %.11T %.4c %.8z %.6m %.8d %.6w %.8f %20E'

*  When set, the SINFO_FORMAT environment variable will override the default format.

*  For both examples, you can set spacing of each field by placing "%##" after the field name.

:\* Adding a "-" before the number will print the characters left
justified

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Job Templates: Prerequisites and Provisos
==========================

*  Before submitting any jobs, please read **and** understand the `Cluster:User Agreement </Cluster:User_Agreement>`__.

*  Note that any given system is using approximately 1-4GB of its memory  for operating system and filesystem purposes.

*  When configuring your jobs, please use 1GB less of memory than the  blade claims to have.

*  The *generalGrp* fair share group is provided here. Please replace that with your designated fair share group.

*  You **must** specify an email address even if you do not want notifications

Serial Jobs
===========

*  Serial jobs only use a single processor

Single processor job, 128MB RAM with 96 Hour Time Limit
-------------------------------------------------------

::

   #!/bin/bash
   #SBATCH --partition=medium
   #SBATCH --job-name="single_proc_128mb"
   #SBATCH --constraint="skylake"
   #SBATCH --nodes=1
   #SBATCH --tasks-per-node=1
   #SBATCH --time=0-96:00:00
   #SBATCH --account="generalGrp"
   #SBATCH --mail-type=BEGIN
   #SBATCH --mail-user=my_username@wfu.edu
   #SBATCH --output="single_proc_128mb-%j.o"
   #SBATCH --error="single_proc_128mb-%j.e"
   #SBATCH --mem=128MB
   # Note: SLURM has no batch input for cputime, excluding.
   # Note: NCPUS directive is redundant from expected nodes#:ppn# input, excluding.

   # set up your environment - this is for bash. For csh/tcsh: source /etc/profile.d/modules.csh
   umask 027
   . /etc/profile.d/modules.sh
   module load rhel7/compilers/intel-2018-lp64

   cd /scratch/${SLURM_JOBID}
   ###Now do your stuff

   ###  Don't forget to copy results out of /scratch to a /deac directory!

Single processor job, 128MB RAM with 2 Day Time Limit
-----------------------------------------------------

::

   #SBATCH --partition=small
   #SBATCH --job-name="single_proc_two_day"
   #SBATCH --constraint="haswell"
   #SBATCH --nodes=1
   #SBATCH --tasks-per-node=1
   #SBATCH --time=0-48:00:00
   #SBATCH --account="generalGrp"
   #SBATCH --mail-type=BEGIN
   #SBATCH --mail-user=my_username@wfu.edu
   #SBATCH --output="single_proc_two_day-j%.o"
   #SBATCH --error="single_proc_two_day-j%.e"
   #SBATCH --mem=128MB

   umask 027
   cd /scratch/${SLURM_JOBID}
   ###Now do your stuff

   ###  Don't forget to copy results out of /scratch to a /deac directory!

Multiple Processor Jobs
=======================

Parallel Job Type 1
-------------------

*  N nodes using X processors per node, using ethernet enabled nodes

*  A program needing 128MB of RAM per processor, totaling 1GB per node

*  16 Hour Time Limit

   *Even though the time limit is <24hours, the node requirement requires the job to run on the medium partition

::

   #SBATCH --partition=medium
   #SBATCH --job-name="multinode_job"
   #SBATCH --nodes=4
   #SBATCH --tasks-per-node=8
   #SBATCH --cpus-per-task=1
   #SBATCH --time=0-16:00:00
   #SBATCH --account="generalGrp"
   #SBATCH --mail-type=BEGIN
   #SBATCH --mail-user=my_username@wfu.edu
   #SBATCH --output="multinode_job.o"
   #SBATCH --error="multinode_job.e"
   #SBATCH --mem=1gb
   #SBATCH --constraint="ucs3-2|ucs3-3|ucs3-4"

   umask 027
   cd /scratch
   cd $SLURM_JOBID

   ###Now do your stuff

   ###  Don't forget to copy your data from /scratch to your /deac* directory                                                                            

*  Important items to note

   *  SLURM has no **cput** directive! Base your time value purely on the overall estimated runtime.
   
   *  The **mem** directive is the per node requirement

      *  An available directive to use is **--mem-per-cpu=memory**, which allocates memory on a per-CPU basis.
      
   *  The list of *comp##* in the **--constraint** directive should be customized to the type of parallel job you wish to run. For more information on hardware features, see `Cluster:Hardware Configuration </Cluster:Hardware_Configuration>`__.

Job Script for GPU
==================

::

   #!/bin/bash
   #SBATCH --job-name=GPUJOB
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=1
   #SBATCH --time=0-12:00:00
   #SBATCH --output="1_HPL-CISCO-%j.o"
   #SBATCH --error="1_HPL-CISCO-%j.e"
   #SBATCH --mail-user=username@wfu.edu
   #SBATCH --mail-type=BEGIN,END,FAIL
   #SBATCH --account="researchGrp"
   #SBATCH --partition=gpu
   #SBATCH --mem=120gb
   #SBATCH --workdir="/deac/researchGrp/user/CUDA"
   #SBATCH --gres=gpu:V100:1

*  IMPORTANT DIRECTIVES

   *  --gres=gpu[type:#]

      * This directive specifies the type of GPU required and the number of cards

      *  By default, a singular GPU of anytype will be used.

      * Optionally, users can specify the GPU type by name and number of cards required.

      *  Valid types are:
      
         *  `V100 </Information:GPU_Computing#Tesla_V100_GPU_Nodes>`__ and

         *  `P100 </Information:GPU_Computing#Tesla_P100_GPU_Nodes>`__

      * See `Information:GPU_Computing </Information:GPU_Computing>`__ for most up to date list of DEAC cluster GPU information

   *  --partition=gpu

      * The GPU partition will assign higher priority to GPU type jobs for using the hardware for their designated purpose

Job Script for Compute Nodes
============================

* The new blade specs:

   *  44 or 48 processing cores available per blade
   *  180GB of consumable of RAM
   *  10Gbps Bandwidth per ethernet channel (dual-channel)
   *  220G or 425G of scratch for temporary local storage space

Recognized Constraints
----------------------

*  In order for jobs to run on the newer CISCO UCS nodes, the job scripts have to be modified to the following features:
*  These attributes have been placed to the blades:

   *  skylake -- (The Skylake Intel Architecture)

   *  cascade -- (The Skylake Intel Architecture)

   *  scr220gb -- (220G of /scratch space available)

   *  scr425gb -- (425G of /scratch space available)
   
   *  comp## -- (Specific Name of UCS Chassis in SLURM)

*  Node details of a 44-Core UCS blade

   NodeName=comp-07-1 Arch=x86_64 CoresPerSocket=24
    CPUAlloc=0 CPUErr=0 CPUTot=48 CPULoad=0.47 Features=comp07,skylake,scr425gb
    Gres=(null)
    NodeAddr=10.1.53.71 NodeHostName=comp-07-1 Version=20.03
    OS=Linux RealMemory=196608 AllocMem=0 Sockets=2 Boards=1
    State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1
    BootTime=2022-06-09T15:21:51 SlurmdStartTime=2022-06-11T13:58:01
    CurrentWatts=0 LowestJoules=0 ConsumedJoules=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
   
Job Script Template
-----------------------

*  A generic example of job script:

   *  The small partition has a 24 hour maximum run time

   #SBATCH --partition=small
   #SBATCH --job-name="generic"
   #SBATCH --nodes=1
   #SBATCH --tasks-per-node=16
   #SBATCH --time=06:00:00
   #SBATCH --account="fairshareGrp"
   #SBATCH --mail-type=BEGIN,END,FAIL
   #SBATCH --mail-user=username@wfu.edu
   #SBATCH --output="generic-%j.o"
   #SBATCH --error="generic-%j.e"
   #SBATCH --mem=32gb

*  All UCS (tengig) nodes have:

   *  44 or more cores, so the above generic example will run on any available ucs node

   *  188 gb of consumable memory. Using the previous recommendation, **the max value you should request is 180GB**

*  If you wish to be more specific on which type of need to be more specific on the resources needed for specific UCS blades:

   *  For a **cacade lake** node only:

   | ''#SBATCH --constraint="skylake"

*  This template was used during a testing period. If you encounter errors or incidents, please send them to deac-help@wfu.edu

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Resource Requests
=================

Standard Resource Request
-------------------------

Resources for a job are requested with 4 primary directives. In a SLURM
script:

   #SBATCH --nodes=1
   #SBATCH --tasks-per-node=8
   #SBATCH --cpus-per-task=1
   #SBATCH --mem=16gb

Which requests 1 node, 8 CPUs, and 16GB of RAM.

Generic Resource Request - GPUs
-------------------------------

Generic resource scheduling (GRES) is used for requesting GPU resources
with one primary directive. In a SLURM script:

   #SBATCH --partition="gpu"
   #SBATCH --nodes=1
   #SBATCH --gres=gpu:1

Which requests 1 GPU to be used from 1 node belonging to the GPU
partition. Obviously, GPU resources are requested differently that
standard resources. Official documentation is available from SchedMD on
GRES configuration [1]_ and SBATCH GRES specification [2]_.

Partitions
==========

*  **small**

   *  Purpose: Small consumption, short serial or parallel jobs

   *  Limits: < 24:00:00, 1 node
   
   *  Priority: 40

*  **medium**

   *  Purpose: Mid-range jobs
   
   *  Limits: < 7-00:00:00, < 8 nodes
   
   *  Priority: 30

*  **large**

   * Purpose: Large consumption, long running jobs
   
   *  Limits: < 365-00:00:00, no node limit
   
   *  Priority: 20

*  **gpu**

   *  Purpose: GPU required jobs

   *  Limits: < 365-00:00:00, no node limit

   *Priority: 50

List of Resource Specifiers
===========================

Below is a list of all resource specifications and their definitions.
Please see the official documentation for a requesting resources and
detailed definitions with batch submission. [3]_ There are many SLURM
users, so a Google search is bound to find great documentation as well,
like this page at the Leibniz Supercomputing Centre [4]_.

*  **tasks-per-node**\ =

   *  *integer* -- processes per node (*not* processors)

*  **nodes**\ =

   *  *integer* -- number of nodes OR
   
   *  *string* -- name of specific node

*  **mem**

   *  *string* -- memory allocation per node, 90gb, 16gb, 512mb, etc

*  **time**

   *  *string* -- time specification, ((d-)hh:mm:ss; Maximum amount of real time during which the job can be in the running state.

*  **gres**\ = (Generic Resources Scheduling)

   *  ''string[[:string]:number -- **GPU** allocation example, gpu:4

cpusets
-------

In brief:

   In the Linux kernel, the cpuset facility provides a mechanism for
   creating logical entities called "cpusets" that encompass definitions
   of CPUs and NUMA Memory Nodes (if NUMA is available). Cpusets
   constrain the CPU and Memory placement of a task to only the
   resources defined within that cpuset. These cpusets can then be
   arranged into a nested hierarchy visible in the "cpuset" virtual
   filesystem. Sets of tasks can be assigned to these cpusets to
   constrain the resources that they use. The tasks can be moved from
   one cpuset to another to utilize other resources defined in those
   other cpusets. [5]_

Node Features
-------------

*  In SLURM, nodes may be tagged with a number of strings. These strings  are called *features*. You can query any particular node to see its  properties:

$ scontrol show node comp-07-1
  NodeName=comp-07-1 Arch=x86_64 CoresPerSocket=24
   CPUAlloc=0 CPUErr=0 CPUTot=48 CPULoad=0.47 Features=comp07,skylake,scr425gb
   Gres=(null)
   NodeAddr=10.1.53.71 NodeHostName=comp-07-1 Version=20.03
   OS=Linux RealMemory=196608 AllocMem=0 Sockets=2 Boards=1
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1
   BootTime=2022-06-09T15:21:51 SlurmdStartTime=2022-06-11T13:58:01
   CurrentWatts=0 LowestJoules=0 ConsumedJoules=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s
   
*  A node with GPU resources available has the following listed in it's  properties:

$ scontrol show node usb-gpu-04 
  NodeName=gpu05 Arch=x86_64 CoresPerSocket=22
   CPUAlloc=0 CPUErr=0 CPUTot=44 CPULoad=0.10 Features=gpu
   Gres=gpu:6
   NodeAddr=10.1.52.07 NodeHostName=usb-gpu-04 Version=14.11
   OS=Linux RealMemory=196608 AllocMem=0 Sockets=1 Boards=1
   State=IDLE ThreadsPerCore=1 TmpDisk=0 Weight=1
   BootTime=2021-12-16T12:55:25 SlurmdStartTime=2021-12-16T12:55:54
   CurrentWatts=0 LowestJoules=0 ConsumedJoules=0
   ExtSensorsJoules=n/s ExtSensorsWatts=0 ExtSensorsTemp=n/s

References
==========

.. raw:: html

   <references/>

.. [1]
   `GRES Configuration <http://slurm.schedmd.com/gres.html>`__

.. [2]
   `SBATCH GRES
   Specification <http://slurm.schedmd.com/sbatch.html#OPT_gres>`__

.. [3]
   `Slurm Sbatch Documentation - Job
   Submission <http://slurm.schedmd.com/sbatch.html>`__

.. [4]
   `Leibniz Supercomputing Centre - Resource
   Specification <https://www.lrz.de/services/compute/linux-cluster/batch_parallel/specifications/>`__

.. [5]
   `cpuset (cset) tutorial - Novell,
   Inc. <https://www.suse.com/documentation/slerte_11/slerte_tutorial/data/slerte_tutorial.html>`__

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

..
    Troubleshooting

Windows Newline
===============

If you write any scripts under Windows and transfer them to a UNIX/Linux
machine, every line will contain an extra character (^M). This character
appears as a result of different End-Of-Line (EOL) conventions [1]_.
Unfortunately, it does more than just appear annoyingly at the end of
every line. The symbols are interpreted when run by the scripts
interpreter (i.e. `PERL </Software:Perl>`__ or
`bash </Quick_Start_Guide:Bash>`__ or
`tsch </Quick_Start_Guide:Tcsh>`__). Executable shell scripts written
under Windows, transferred to the cluster, and run without change will
almost certainly fail with a "Command not found" error message.

To remove these "control" characters, there is a command line utility
called ``dos2unix`` which will strip the characters from the file. See
the man page for usage details.

References
----------

.. raw:: html

   <references/>

Memory Consumption
==================

Memory consumption can be a primary reason for job cancellation... read
the following to assist with troubleshooting...

Refresher
---------

**Physical memory** is RAM. Operating systems, however, have the concept
of **virtual memory**: virtual memory includes some disk space
specifically set aside for use as program memory (as opposed to file
storage). This disk space is known as **swap**.

This is useful because it allows programs to temporarily grow in memory
usage without crashing the computer: any excess usage can be transferred
to disk. However, this imposes a huge performance penalty. Disk access
times may be a factor of a million or more slower than RAM. [2]_

Check Job Statistics
--------------------

When you submit a job, you make a request for **mem** -- based on the
total memory used on a PER NODE basis... this differs from previous
behavior utilized in Torque. Once the job is running, the resource
manager `SLURM </SLURM>`__ tracks the actual resources used. If you run
"**scontrol show job JOBID**" on a running job, you will see something
like this:

| ``JobId=6449 JobName=Low_Size_HPL_C11``
| ``  UserId=vallesd(10013) GroupId=vallesd(10013)``
| ``  Priority=437 Nice=0 Account=admingrp QOS=normal``
| ``  JobState=RUNNING Reason=None Dependency=(null)``
| ``  Requeue=1 Restarts=0 BatchFlag=1 Reboot=0 ExitCode=0:0``
| ``  RunTime=3-19:30:33 TimeLimit=4-00:00:00 TimeMin=N/A``
| ``  SubmitTime=2015-09-11T16:08:00 EligibleTime=2015-09-11T16:08:00``
| ``  StartTime=2015-09-11T16:08:01 EndTime=2015-09-15T16:08:01``
| ``  PreemptTime=None SuspendTime=None SecsPreSuspend=0``
| ``  Partition=large AllocNode:Sid=headnode:31102``
| ``  ReqNodeList=(null) ExcNodeList=(null)``
| ``  NodeList=a1a-u2-c10-b[1-4,6-8],a1a-u2-c11-b1``
| ``  BatchHost=a1a-u2-c10-b1``
| ``  NumNodes=8 NumCPUs=256 CPUs/Task=1 ReqB:S:C:T=0:0:*:*``
| ``  Socks/Node=* NtasksPerN:B:S:C=32:0:*:* CoreSpec=*``
| ``  MinCPUsNode=32 MinMemoryNode=125G MinTmpDiskNode=0``
| ``  Features=haswell Gres=(null) Reservation=(null)``
| ``  Shared=OK Contiguous=0 Licenses=(null) Network=(null)``
| ``  Command=/home/vallesd/hpl-2.1/bin/chassis11/test_low_problem_sizes_carlson.SLURM``
| ``  WorkDir=/home/vallesd``
| ``  StdErr=/home/vallesd/lowsizes_chassis11-6449.e``
| ``  StdIn=/dev/null``
| ``  StdOut=/home/vallesd/lowsizes_chassis11-6449.o``

This is essentially the output of all metadata SLURM tracks about your
job, including resources used and requested, directives, output
information and tracking information. Note, this output can only be seen
DURING job execution. The information is also inserted into your job
output file when the task prolog runs.

During and after job execution, you can also see resources utilized with
the `sacct </SLURM_commands#sacct>`__ command. To see specifically
Nodes, CPUs, and Memory requested, run:

| ``[username@headnode ~]$ ``\ **``sacct``\ ````\ ``--jobs=6449``\ ````\ ``--format``\ ````\ ``JobID,JobName,NCPUS,NNodes,ReqCPUs,ReqMem``**
| ``       JobID    JobName      NCPUS   NNodes  ReqCPUS     ReqMem``
| ``------------ ---------- ---------- -------- -------- ----------``
| ``6449         Low_Size_+        256        8      256      125Gn``
| ``6449.0            orted          7        7        7      125Gn``

When a job completes you can see consumed resources (CPUs, Nodes, Memory
and Time) specifically by running:

| ``[username@headnode ~]$ ``\ **``sacctr``\ ````\ ``--jobs=JOBID``\ ````\ ``--format``\ ````\ ``JobId,JobName,NCPUS,NNodes,MaxRSS,Elapsed``**
| ``      JobID    JobName      NCPUS   NNodes     MaxRSS    Elapsed                                          NodeList ``
| ``------------ ---------- ---------- -------- ---------- ---------- -------------------------------------------------- ``
| ``6449         Low_Size_+        256        8 121896960K 3-22:30:00 a1a-u2-c10-b[1-4,6-8],a1a-u2-c11-b1                ``
| ``6449.0            orted          7        7 121896960K 3-22:30:00 a1a-u2-c10-b[2-4,6-8],a1a-u2-c11-b1     ``

Jobs where MaxRSS exceeds the requested amount of memory will be
cancelled by SLURM.

If it is the first time you are running a particular class of job, it
would be good if you ran one, requesting lots of memory, and then
examine it via the `sacct </SLURM_commands#sacct>`__ command to see the
actual amount your job will need. Be sure to allow about 1GB per node
for system usage.

Remember that memory allocation must be requested on a **per NODE**
basis, overall memory utilization is not requested (SLURM calculates
that for us)!

The other complication is that the cluster is a multi user system. Any
one node may have more than one job running on it, owned by more than
one user. When job requests come in, if SLURM finds a node that has
enough free resources (cpus and memory) to handle the amount requested
by a job, that job will be scheduled on that node.

Now, if that job's memory usage grows beyond its request, it will now be
given a "CANCELLED" status and the job will die. There is also a
possibility that the node could crash and end all the other jobs that
may have been allocated to that node.

Request Memory Correctly
------------------------

As it is undesirable for jobs to swap to disk, request memory generously
but accurately. Obviously, the closer your request to what is actually
needed, the better - but we don't want to risk your job dying, or the
compute node potentially crashing. In SLURM, memory requested is on a
PER NODE basis, so

It is very important to understand how much memory your job will
actually use. Requesting the minimum required may get more of your jobs
running sooner. Here is an example:

-  Job actually needs 14 GB memory
-  Job requests 16 GB memory
-  Therefore, the job cannot run on nodes with 16 GB of RAM because of
   the 16 GB, only 15 GB are available for user processes. 1 GB is
   reserved for the system. This eliminates 84 of the 16 GB nodes that
   are available in the cluster (as of 2015-09-15).

On the other hand, if the code you run does not control its memory usage
well, i.e. it can grow to an unknown amount during a run, then it is
better to request for more memory to avoid the job being cancelled if it
overruns its memory request.

Again, it is very important to understand the resource requirements for
your jobs. Make several trial runs in order to understand what your job
needs so you may request only as much as is necessary (plus a small
safety margin).

Job Submission Troubleshooting
==============================

   .. rubric:: NODE_FAIL
      :name: node_fail

   -  Problem Symptom: (from job email)

      ::

         Job exited with exit code 1.

   -  Problem Symptom: No output files created

   ..

      ::

         [2015-09-14T16:58:51.996] [6454] Could not open stdout file /home/username/babel/test/SAMHD1/salsbufr_test-6454.o: No such file or directory
         [2015-09-14T16:58:51.996] [6454] IO setup failed: No such file or directory

   -  Problem resolution

   :\* Most likely this is an admin issue with the node

   ::\* Often the primary culprit is research group filesystems are not
   mounted and proper output files are not created.

   ::\* If output files are attempting to write to these filesystems,
   prolog scripts die without logging information

   ::\* The job will often sit in a "Running" state without doing
   anything until the NODE_FAIL message is sent

   :\* Reply to the email and send it to deac-help@wfu.edu and the HPC
   team will investigate.

   .. rubric:: (PartitionTimeLimit)
      :name: partitiontimelimit

   -  Problem Symptom: (from *squeue -u username* output)

   ..

      ::

          $ squeue -u username
                      JOBID PARTITION     NAME     USER ST       TIME  NODES NODELIST(REASON)
                       1234     small     test username PD       0:00      1 (PartitionTimeLimit)

   -  Problem Symptom: Job does not run

   -  Problem resolution

   :\* You are requesting resources that exceed the defined limits of
   the specified partition

   ::\* Check partition limits by running *scontrol show partition
   small* (for this case)

   ::\* Check requested job resources by running *scontrol show job
   1234*

   :*Change partition requested by canceling your job and editing the
   batch script, OR by running

   ::\***scontrol update JobID=1234 Partition=medium** to change
   partition requested

   :*Change requested resources by canceling your job and editing batch
   script, OR by running

   ::*Change Timelimit: **scontrol update JobID=1234
   TimeLimit=<24:00:00** (for this case)

   ::*Change Requested Nodes (and CPU# if possible): **scontrol update
   JobID=1234 [NumCPUs=(total needed)]** (for this case)

   :::*Remember, it is possible to request up to 32 CPUs per node, but
   be sure constraints don't prevent that as a possible option if
   changing

Job Stuck in Queue or Stalled
=============================

Potential Reasons
=================

-  Resource request has conflicting resource specifications that result
   in no viable nodes on which to run the job
-  Resource request is so specific only a few nodes exist to fulfill the
   request
-  Resource request needs resources that are not available yet

Resource Specification Collisions
---------------------------------

"I need all the memory on a node"

..

   ::

      ############################## SLURM directives ##########################
      #SBATCH --nodes=1
      #SBATCH --tasks-per-node=20
      #SBATCH --mem=128gb
      #SBATCH --constraint=tengig
      ##########################################################################

   -  We have nodes with 128GB of RAM. This should work. Right? Wrong!

   Explanation of Resource Allocation

   -  The SLURM workload manager knows that your job requires 128GB of
      RAM.
   -  SLURM will only schedule your job on a node that has 128GB of
      **available** RAM.
   -  Operating systems, system services, and the cluster filesystems
      consume memory too. A good rule of thumb is 1GB.
   -  So, a 128GB blade really only has 127GB of RAM for use by jobs.
      So, the above job will not run on our cluster of 128GB nodes.

   Corrected Resource Request

   ::

      ############################## SLURM directives ##########################
      #SBATCH --nodes=1
      #SBATCH --tasks-per-node=20
      #SBATCH --mem=127gb
      #SBATCH --constraint=tengig
      ##########################################################################

"I only want to run on '16 core tengig nodes'":

..

   ::

      ############################## SLURM directives ##########################
      #SBATCH --nodes=1
      #SBATCH --tasks-per-node=20
      #SBATCH --mem=128gb
      #SBATCH --constraint=tengig&sandy
      ##########################################################################

   Explanation of Resource Allocation

   -  Here, the constraint syntax is correct assuming any one particular
      node with SANDY processors is eligible for use.
   -  Unfortunately, none of the sandy blades do not have the **20**
      CPUS.
   -  As a result, the sandy constraint and 20 CPU requirement are
      mutually exclusive and result in a "null" set of nodes to run on.

   Corrected Resource Request

   ::

      ############################## SLURM directives ##########################
      #SBATCH --nodes=1
      #SBATCH --tasks-per-node=20
      #SBATCH --mem=128gb
      #SBATCH --constraint=tengig&ivy
      ##########################################################################

   -  As a best practice, **if** you really want only nodes with 20
      processors, you want to reduce all other optional resource
      requests to avoid the possibility of mutually exclusive resource
      requests. IE (exclude the ivy, and tengig constraint).
   -  Note: it's not considered a best practice to restrict your jobs to
      only ONE, SPECIFIC type (in this case, ivy) unless there is a
      REALLY good reason.

   :\* Clarification: It's okay for your job to be restricted to ONE
   GROUP (especially for parallel jobs). However, you should include as
   many candidate clans as possible using the "constraint=X|Y|Z" OR
   capability of SLURM's constraint directive so that your job has
   better chances of running on the cluster.

Potential Job Termination Issues
================================

   .. rubric:: Resource Utilization Violation
      :name: resource-utilization-violation

      Problem Symptom (from job email)
         ::

            Job cancelled by the system administrator.

      Resource Required (from job email)

      ..

         ::

            Requested time limit:   23:00:00
            Requested memory:     48000M (per Node)
            Total CPU time :          00:00:30
            Total Allocated CPUs:  1
            Total Allocated Nodes: 1

      Resource Usage (from job email)

      ..

         ::

            JOB ID:      6398.batch
            # CPUS:     1
            # NODES:  1
            MEM/task: 50385312K
            JOB Name: batch

      Analysis of request
         Job requested 1 processors (nodes=1, CPUS=1)
         Job requested 48GB of memory (mem=48gb)
         Job consumed 48.05GB overall (MEM: 50385312K)

      Problem resolution
         Increase the requested memory value
         Resolve the memory request mismatch.
         As soon as memory is exceed, the job will be cancelled by the
         scheduler.

   Memory Resource Consumption fails before reaching request
      If a job fails due to a malloc error before the requested memory
      limit has been reached, it could be due to ulimits
      Include **'ulimit -v hard**' below your directives, and above the
      script portion of your job to see if that fixes the issue.

   .. rubric:: Job Deleted
      :name: job-deleted

      Problem Symptom (from job email)
         ::

            Job cancelled by the system administrator.

      Probable Causes
         The job was simply deleted by a user. No resolution needed.
         The job was deleted because of a system software bug.

      Problem Solution
         If you did not delete the job, contact deac-help@wfu.edu to
         report the problem.

Email from SLURM
================

   ::

      Job <test_48gb.slurm> was executed on node(s) <a1a-u2-c10-b1>, in partition <small>, as user <username> from group <researchgrp>.
      The initial working directory of this job was /deac/researchGrp/username/output.

      Job cancelled by the system administrator.

      Job Times:
      =======
          Submitted:  2015-09-04 16:40:17
          Started:      2015-09-04 16:40:17
          Ended:       2015-09-04 16:40:47
          Elapsed:    00:00:30

      Job Resource Usage Summary:
      ======================

          JOB ID:      6398
          # CPUS:     1
          # NODES:  1
          MEM/task: n/a
          JOB Name: test_48gb.slurm

          JOB ID:      6398.batch
          # CPUS:     1
          # NODES:  1
          MEM/task: 50385312K
          JOB Name: batch


      Requested Resources and Totals:
      =======================
          Requested time limit:   23:00:00
          Requested memory:     48000M (per Node)
          Total CPU time :          00:00:30
          Total Allocated CPUs:  1
          Total Allocated Nodes: 1

Job Error Output File from SLURM (on filesystem)
================================================

   ::

      slurmstepd: Job 6398 exceeded memory limit (50385312 > 49152000), being killed
      slurmstepd: Exceeded job memory limit
      slurmstepd: *** JOB 6398 CANCELLED AT 2015-09-04T16:40:47 *** on a1a-u2-c10-b1
      slurmstepd: task_p_post_term: rmdir(/dev/cpuset/slurm6398/slurm6398.4294967294_0) failed Device or resource busy

.. raw:: html

   <references/>

.. [1]
   `Newline article at
   Wikipedia <http://en.wikipedia.org/wiki/Newline>`__

.. [2]
   `Disk vs. Memory speed discussion at Joel on Software
   forums <http://discuss.joelonsoftware.com/default.asp?joel.3.731942.7>`__

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################
