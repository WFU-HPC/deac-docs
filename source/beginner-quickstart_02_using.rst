.. _sec.qs2:

====================================
Quickstart 2: Working on the Cluster
====================================

.. contents::
   :depth: 2
..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Disk Space on the Cluster
=========================

There are a few
locations where you can store your files (data and programs). The choice
of which one to use depends on what you will be using those files for.

Home Directory
==============

Your **home directory**, ``/home/$USER``, is a general
purpose space. Typically, your source code and compiled programs will be
kept here. If you have very large data files (multiple gigabytes, say),
they should be stored elsewhere as described below. Submitted jobs are
not to be executed, nor data written to/read from, this path.

If you install your programs in ``~/bin``, just add ``~/bin`` to your
``PATH`` environment variable. Set it in .bashrc or .cshrc/.tcshrc
depending on your shell.

Research Group Directory
========================

Each research group has a path created to store that group's shared
research data. These paths are designed to be used as your primary
working directory for job output and file creation. They should also be
used for long-term storage of data that the entire group can use.

Wake Forest University research groups have their paths created on the
cluster's `primary storage
array </Cluster:Hardware_Configuration#Storage>`__. They are shared via
NFS to all cluster nodes, and fall under the following categories based
on group type:

#. *'/deac/*\ '' '''- These paths are created for contributing research
   groups only. These groups can be identified by those who submit to
   their own fairshare account in SLURM. Each group's path lies on it's
   own standalone filesystem with dedicated storage. Access to research
   data is limited only to those who belong to the overarching research
   group.
#. *'/deac/generalGrp/*\ '' '''- These paths are created for
   non-contributing research groups. These groups can be identified by
   those who submit to the generalGrp fairshare account in SLURM. Each
   group's path lies on the same filesystem, sharing the same dedicated
   storage. Access to research data is not shared between
   non-contributing research groups; it is limited at non-contributing
   research group level (unless otherwise specified).
#. *'/deac/generalGrp/usershare/*\ '' '''- These paths are created for
   individual users that do not belong to an overarching research group.
   They can also be identified by submitting to the generalGrp fairshare
   account in SLURM. These individual users share the dedicated 10TB of
   storage with other generalGrp users, but do not share access to their
   research data with other users.

WF Baptist Hospital groups have dedicated storage primarily found at
*'/isilon/wfuhpc/*\ '' ''', as well as other dedicated paths. These
paths are shared via NFS from WFBH storage that is maintained by WFBH
admins, not the HPC Team. Collaboration with the hospital does ensure
these paths are shared to all cluster nodes and available for use on the
DEAC cluster.

See how to report `Disk Space
Issues </Quick_Start_Guide:Error_Reporting#Disk_Space_Issues>`__ if your
filesystem runs out of space.

``/scratch`` Directories (Per Node)
===================================

Each compute node has a **``/scratch`` directory**, which is a local
SCSI-attached disk. Since it is a device local to the compute node, disk
operations to that device will tend to be much faster than to user home
or research group directories, both of which are accessed over the
network.

/scratch is meant purely for transient data to be used during the
lifetime of a job. The amount of space is not guaranteed because other
jobs may use /scratch, too. Scratch data is automatically removed when
your job completes; you do not need to clean up this data, but it is
appreciated.

If your job performs a lot of disk I/O, it will likely be better for you
to run your job using files stored in /scratch. In your
`SLURM </SLURM>`__ job script, you will have to write commands to copy
the files over to the appropriate directory. A useful
[https://slurm.schedmd.com/sbatch.html#lbAH\ \| SLURM Environment
Variable] is ``SLURM_JOBID`` -- the i.d. of the job that is executing.
Use this variable to write to and read from the scratch directory:

-  csh/tcsh version

| ``   setenv SCRATCHDIR /scratch/$SLURM_JOBID``
| ``   setenv DATAFILE myNiceInput.dat``
| ``   ``
| ``   # Copy program and inputs to scratchdir``
| ``   cp ~/bin/giantProgram $SCRATCHDIR``
| ``   cp /deac/researchGrp/${DATAFILE} $SCRATCHDIR``
| ``   ``
| ``   # go into scratchdir and run program``
| ``   cd $SCRATCHDIR``
| ``   ${SCRATCHDIR}/giantProgram ${DATAFILE}``
| ``   ``
| ``   # Clean up after we're done``
| ``   #    copy outputs back to home``
| ``   cp ${SCRATCHDIR}/giantOutputs_${SLURM_JOBID}.dat /deac/researchGrp/``
| ``   ``
| ``   #    delete scratchdir and its contents``
| ``   /bin/rm -rf ${SCRATCHDIR}``

-  bash version

| ``   export SCRATCHDIR=/scratch/$SLURM_JOBID``
| ``   export DATAFILE=myNiceInput.dat``
| ``   ``
| ``   # Copy program and inputs to scratchdir``
| ``   cp ~/bin/giantProgram $SCRATCHDIR``
| ``   cp /deac/researchGrp/${DATAFILE} $SCRATCHDIR``
| ``   ``
| ``   # go into scratchdir and run program``
| ``   cd $SCRATCHDIR``
| ``   ${SCRATCHDIR}/giantProgram ${DATAFILE}``
| ``   ``
| ``   # Clean up after we're done``
| ``   #    copy outputs back to home``
| ``   cp ${SCRATCHDIR}/giantOutputs_${SLURM_JOBID}.dat /deac/researchGrp/``
| ``   ``
| ``   #    delete scratchdir and its contents``
| ``   /bin/rm -rf ${SCRATCHDIR}``

To request nodes with at least a certain size of scratch disk space, use
the "constraint" request:

| ``   #SBATCH --constraint=scr40gb``
| ``   ###40GB scratch``

| ``   #SBATCH --constraint=scr250gb``
| ``   ###250GB scratch``

See Also
========

-  https://slurm.schedmd.com/sbatch.html#lbAH -- SLURM Environment
   Variables
-  `Information:Moving Files
   Efficiently </Information:Moving_Files_Efficiently>`__ -- Guide on
   moving data efficiently


.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Using the cluster
=================

Typically, when it comes to using a cluster, there are generally only a
few things that introductory users must learn about working in the
environment:

#. Clusters are hard. You are dealing with the most powerful forms of computing
   on the planet. It takes between 15-20 years to make a supercomputer easy [1]_
#. It is not "point-and-click", review the [[Quick Start Guide:Linux] to learn
   about how to use the following required things:

   #. Command line
   #. Text editors
   #. Custom programming and scripting. Many of these issues are
      addressed in the

#. Users have to know where `#Where To Put Data </#Where_To_Put_Data>`__
   on the cluster.
#. Users have to understand `#Leverage the Software
   Environment </#Leverage_the_Software_Environment>`__ and use it in
   their jobs

Assumptions
===========

#. You've never used the cluster before and have an empty home
   directory.
#. Your username is **myacct** (the same as your WFU account).
#. You are assigned to a research group, called **advisorGrp**.
#. You are assigned a *fairshare* group, called **fairshareGrp** (often
   the same name as **advisorGrp**).
#. You have a research directory for your data, called
   **/deac/advisorGrp** OR **/deac/generalGrp/advisorGrp**
#. You have logged into a cluster head node by following the
   instructions in `Cluster:Access and
   Layout </Cluster:Access_and_Layout>`__

Where To Put Data
=================

First and foremost, you have to know where to put your files on the
cluster.

   /home/myacct
      This is your *home directory*. When your account is created, it
      will only have some default environment configuration files that
      are hidden.

   -  Your home directory is configured to store only a limited amount
      of data crucial to your **interactive** use of the cluster,
      primarily through the head nodes. For general uses, your research
      software (source codes, binaries) can be stored there.

      -  Users should NOT store files that define jobs, or are created
         by your jobs in their *home directory*.
      -  Users should NOT use their *home directory* as a job's WORKDIR
         or OUTPUT path when submitting jobs to the cluster

         -  Doing so can cause sluggish behavior for users and jobs
            running on the cluster
         -  Every single login session and job running need basic access
            to this path, adding additional load degrades the
            aforementioned **interactive** use of the cluster by
            delaying system response.

   /deac/advisorGrp OR /deac/generalGrp/advisorGrp
      This is the *research directory* for research groups, and is owned
      by faculty advisors. Advisors are the ultimate owner of research
      data after users leave the group (by graduation, transfer to
      another group, or leaving the University for another position).

   -  These research directories are set up to handle the load of
      multiple jobs from multiple compute nodes writing multiple files.
      Any files referenced or created by your computational jobs should
      go here.
   -  Depending on the research group, this directory will host shared
      research software, common libraries, and research results.

   /deac/advisorGrp/username OR /deac/generalGrp/advisorGrp/username
      Depending on the research group, individual user research
      directories may exist to store individual user results that may or
      not be shared among the group.

Second, within either directory, sub-directories need to be structured
in a logical way so that research data and conducted results are easy to
navigate. For example, break things down by project, job type, or even
individual jobs. Much of the guidance for this structure will come from
your research group colleagues and advisor; however, if you are breaking
new ground for the group, feel free to contact the HPC Team for
guidance.

Leverage the Software Environment
=================================

The WFU DEAC Cluster has software provided by Red Hat (through the base
OS distribution), the Fedora Project (through the EPEL project), and by
WFU (through licensing or user request of generally available software).
To successfully use the cluster, users must:

#. Know what software is available
#. Know how to use it

Use the wiki to search for specific names of desired software, or read
general software articles such as
`Software:Overview </Software:Overview>`__. The HPC Team relies upon
users taking the initiative to read generally available software
documentation online to conduct basic troubleshooting and learn how to
use programs specific to their research.

To help configure user environments for the different compilers we
support, `environment-modules <http://modules.sourceforge.net/>`__ are
used. Be sure to read `Quick Start Guide:Environment
Modules </Quick_Start_Guide:Environment_Modules>`__ in order to
understand the tool and how to use it.

To see how to utilize software for submitted jobs, next see the
`SLURM:Quick Start Guide </SLURM:Quick_Start_Guide>`__.

References
==========

.. raw:: html

   <references/>

.. [1]
   http://www.tgdaily.com/mobility-brief/55861-apples-ipad-2-is-as-fast-as-a-supercomputer-from-1985

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Terminology and Conventions
===========================

While most users think in terms of jobs submitted, limitations of job
submissions primarily relate to the amount of computing resources
consumed; specifically the number of nodes/processors and amount of
memory in the DEAC cluster. It is the availability of those resources on
a reasonable time table that this User Agreement is primarily concerned
with.

Fairshare is a term that essentially apportions a target average cluster
utilization for the various user groups of the cluster. However,
fairshare is only a consideration that is enforced when the cluster is
**overutilized**. Under normal circumstances, there is far more work to
be done than cluster resources available, resulting in a many jobs in
the queue waiting to run. Fairsharing is a configuration parameter that
helps determine which of those queued jobs to run next when a cluster
resource becomes available. In an *underutilized* cluster environment,
jobs run as the resources are available (which, in most cases, is
immediately).

**Use it if you need it!** The cluster exists to be used; however, there
are two situations where common courtesy may be required:

-  If no one else is using it and you need it, you should be using it!
   However, in order to ensure a productive environment for all users,
   please follow the restrictions below as they mostly apply to our
   typical, non-overutilized cluster environment.
-  If everyone else is using it, submit your jobs anyway! The cluster
   software will make sure you get your `Fairshare
   value </Cluster:Fair_Share_Policy>`__.

Job Submission
==============

-  Jobs should be submitted to the appropriate partition based upon
   their length or resource consumption. Repeat requests to extend
   TimeLimit will not be honored beyond the first instance for a batch
   of jobs.

   -  No exceptions.

-  No group should exceed their group's fair share usage by more than
   25% for longer that 24 hours at a time.

   -  Exception: During periods of extremely low cluster utilization
      (e.g. 10-25%), a single user may exceed this limit but the jobs
      over this 25% threshold should not exceed 96 hours of running. In
      addition, jobs **MUST** be submitted in a staggered fashion so
      that a quarter of the jobs exceeding the threshold complete every
      24 hours.
   -  Example: Your fairshare is 8. A single person can run on 10 nodes
      without restriction under this item. However, to run on 14 nodes
      for more than 24 hours, the user must stagger submission of those
      jobs on all 14 nodes so that 1 node is freed by job completion
      every 24 hours.

-  No single user should consume 75% of the available computational
   resources of the cluster for any period of time.

   -  No Exceptions.

-  Excessive usage of the cluster (primarily large numbers of jobs, in
   this instance) requires staggered submission of jobs so that the
   scheduling routines can work in jobs from other user within a
   reasonable amount of time.

   -  Exception: Users do not have to stagger submission if the number
      of jobs submitted is less than the total number of processors on
      the cluster and jobs are currently queued.

-  Jobs should not read/write research data to the /home filesystem.

   -  No Exceptions. Users should use local /scratch space, or research
      directories.

Head Node Usage
===============

* Users are not allowed to run production jobs on the cluster head nodes.

   * Exception: certain visualization and interactive programs can be run on the head nodes but not to exceed one instance of this program class per head node.

* Users are allowed to run test jobs on the cluster head nodes IF:

   * They consume less than 5 processors total, AND
   * They consume less than 50GB of memory, AND
   * They run for less than two hours.

* Exception: If test jobs need to run beyond these limits limit to
ensure functionality, then the HPC team should be contacted. A singular
instance may be allowed to run on one head node if the processes
`priority is lowered <http://linux.die.net/man/1/nice>`__ on the head
node to reduce impact to cluster users.

Global Exceptions
=================

While these limits and restrictions may appear like hard and fast rules
(simply because they are written down), these limits are flexible
**PROVIDED** that advanced warning and collaboration with the HPC team
and fellow users is employed. We are a friendly bunch and are willing
(and have in the past) to work with each other to ensure everyone has
access to the cluster (and as much as they need) for their research
efforts.

Significant and urgent need for significant percentages of cluster
resources can be granted pending approval of the cluster community.
Simply petition the osiris-users list and make sure someone else doesn't
have similar urgent needs. You can submit some of your jobs while
waiting for everyone to chime in **BUT** you have to make sure everyone
speaks up before proceeding with all of your jobs.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Disk
space is the most overlooked resource until it gets fully utilized.
Users are encouraged to periodically review their usage on the various
filesystems and relocate or back up/remove files that are infrequently
used or no longer needed on the cluster. Aside from space consumption,
Disk IO (Input/Output) plays a large role in High Performance Computing.
The more IO generated, the slower performance can be.

This document will instruct users on how to copy files efficiently
within the cluster or external to the cluster using a command called
**rsync**.

Requirements
============

rsync : A syncronization program that looks for differences between the source and destination files/directories in order to synchronize the two locations as specified.
SSH : If the syncronization of files/directories occurs between two different servers, you will need to use SSH to perform the file transfers (FTP and RCP are not permitted).

Examples
========

Assumptions
-----------

*srcdir* : Directory that contains the files to be moved.
*destdir* : Directory where you would like to move the contents of **srcdir** files.
*remhost* : Remote host (outside of cluster) where you would like to move the directory/files.

Copying files from researchGrp directory to Archive
---------------------------------------------------

``   rsync -av /deac/generalGrp/users/carsloas/srcdir /archive1/generalGrp/users/carlsoas/destdir/``

Copying files to **remhost**
----------------------------

``   export RSYNC_RSH=/usr/bin/ssh  ###  For bash.  Use "setenv RSYNC_RSH /usr/bin/ssh" for tcsh.``
``   rsync -av /deac/generalGrp/users/carlsoas/srcdir/ carlsoas@remhost:/home/carlsoas/cluster.archive/destdir/``

-  You will be prompted for a password for the user account on the
   **remhost** before the file transfer will begin.

About rsync
===========

The Good
--------

rsync could take a while before the actual transfer starts : If you are resuming an interrupted rsync or have a significant number of files to copy, **rsync** could take several minutes to determine the file list to transfer. This delay is even more likely for remote file transfers.

rsync can pick up where it left off : If your file transfer was aborted for whatever reason (network problem, for example), you can re-issue the exact same command in the same directory and rsync will determine what is different and resume where it left off.

rsync can be issued multiple times with the same arguments! : As the previous comment stated, you can verify that all of your files are the same one last time before you remove them from the full filesystem.

The Pitfalls
------------

*Trailing slashes on the source specification DOES matter!* : If the trailing slash is **omitted** from the file/directory source specification (**srcdir\ \ ), the directory (and all of its contents, preserving the directory structure) will get created in the destination (\ \ destdir**) specified.

``   $ ls test1/*``
``   test1/testA  test1/testB  test1/testC``
``   $ rsync -av test1 test2``
``   building file list ... done``
``   created directory test2``
``   test1/``
``   test1/testA``
``   test1/testB``
``   test1/testC``
``   wrote 232 bytes  read 68 bytes  600.00 bytes/sec``
``   total size is 0  speedup is 0.00``
``   $ ls test2``
``   test1``
``   $ ls test2/test1/*``
``   test2/test1/testA  test2/test1/testB  test2/test1/testC``

Specifying the trailing slash means the all of the files and directories
in the source specification (**srcdir\ \ ) will get copied directly the
destination specified (\ \ destdir**).

``   $ ls test1/*``
``   test1/testA  test1/testB  test1/testC``
``   $ rsync -av test1/ test3``
``   building file list ... done``
``   created directory test3``
``   test1/``
``   test1/testA``
``   test1/testB``
``   test1/testC``
``   wrote 232 bytes  read 68 bytes  600.00 bytes/sec``
``   total size is 0  speedup is 0.00``
``   $ ls test3/*``
``   test3/testA  test3/testB  test3/testC``

*rsync does not (!) mirror two directory structures!* : **rsync** merely synchronizes the source files with the destination files, creating them if they do not exist. **rsync** does not remove files (by default) from the destination that are no longer in the source.

*rsync does not remove files from the source destination as it copies them!* : This means that you have not actually freed up any space after running the rsync command! In situations where disk space is critically low, it is **STRONGLY** suggested that you rsync smaller directory structures and remove them quickly to free up space in a more timely fashion to relieve the constraints.

*rsync may not obey the destination directory's data management policies!* : This simply means that when you use rsync to move data, your destination may require different read/write/execute and owner/group membership settings than the original directory. After the rsync, before sure to make the required changes to comply with that policy.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

The modules [1]_
package allows you to modify your environment to use specific versions
of software you may need. More importantly, it allows you to easily undo
those modifications if you need to use a different package or version.

Introduction and Basic Use
==========================

Let's say you need to do compilations with Intel Cluster Studio 2012
with 4-byte integers. You would set up your environment (paths, library
paths, etc) by doing:

``   $ module load compilers/intel-2012-lp64``

You would use this in `SLURM </Software:SLURM>`__ scripts, too, because
the resulting executable may need to know the paths to the dynamic
libraries to which it is linked. If you no longer need to use that
particular compiler, you would do:

``   $ module unload compilers/intel-2012-lp64``

To switch to a different compiler, you would unload and then load the
environment for the new compiler:

| ``   $ module unload compilers/intel-2012-lp64``
| ``   $ module load compilers/pgi-XXX``

You can see modules you have loaded:

| ``   $ module list``
| ``   ``
| ``   Currently Loaded Modulefiles:``
| ``     1) dot                         2) use.own                     3) compilers/intel-2012-ilp64``

You can see all available modules that may be loaded:

| ``   $ module avail``
| ``   ``
| ``   -------------------------------------- /usr/share/Modules/modulefiles ---------------------------------------``
| ``   dot           module-cvs    module-info   modules       mpich2-x86_64 null          use.own``
| ``   ``
| ``   --------------------------------------------- /etc/modulefiles ----------------------------------------------``
| ``   mvapich-psm-x86_64 mvapich-x86_64     mvapich2-x86_64``
| ``   ``
| ``   ---------------------------------------- /home/username/privatemodules ----------------------------------------``
| ``   compilers/foobar-0.1       compilers/intel-2012-ilp64 compilers/intel-2012-lp64  null``

You can get brief information about a module:

| ``   $  module whatis compilers/intel-2012-ilp64``
| ``   compilers/intel-2012-ilp64: Sets up to use the Intel Cluster Studio 2012 compilation environment with 8-byte integers.``

And longer information:

| ``   $ module help compilers/intel-2012-ilp64``
| ``   ``
| ``   ----------- Module Specific Help for 'compilers/intel-2012-ilp64' ---------------------------``
| ``   ``
| ``           Sets up to use Intel Cluster Studio XE/Composer XE compilers and tools - 8-byte integers``
| ``           Includes: C/C++ 12.1.0, Fortran 12.1.0, Debugger 12.1,``
| ``           Inspector XE 12.0, Trace Analyzer, VTune Amplifier,``
| ``           Intel MPI/OpenMP 4.0.3, MPI Benchmarks 3.2.3,``
| ``           Intel Performance Primitives, Thread Building Blocks,``
| ``           Math Kernel Library, Cilk``
| ``   ``
| ``           Version 2012``

Use in Shell Scripts and `SLURM </Software:SLURM>`__ Job Scripts
================================================================

Incorporating the module command into shell scripts will depend on the
shell that you use: bash or tcsh.

bash/sh/ksh
-----------

Bash scripts, by default, do not execute system-wide login scripts (i.e.
the scripts in /etc/profile.d). Since the "module" command is provided
by one of the login scripts in /etc/profile.d, that means doing "module
load somemodule" in your script will fail, in general. There are two
ways to fix this:

#. Run bash as a login shell: in the first line of your script, do
   "**``#!/bin/bash``\ ````\ ``-l``**"
#. Manually execute the modules login script: in the early part of your
   script, do "**``.``\ ````\ ``/etc/profile.d/modules.sh``**"

tcsh/csh
--------

Tcsh scripts, by default, *do* execute system-wide login scripts, so the
"module" command should be available.

However, if you generally use "**``#!/bin/tcsh``\ ````\ ``-f``**", you
will have to add "**``source``\ ````\ ``/etc/profile.d/modules.csh``**"
to the early part of your script. This is because the "-f" option to
tcsh says not to source any login scripts or perform command hashing for
faster startup. This speed difference is not really noticeable on modern
systems.

Modulefiles
===========

Systemwide modulefiles are located in: /usr/share/Modules/modulefiles
and /etc/modulefiles. Each user may write their own module files, and
put them in ~/privatemodules. There may be subdirectories in the module
directories. Subdirectory names will be part of the module name, e.g.
the module file ~/privatemodules/compilers/intel-2012-ilp64 provides the
module named "compilers/intel-2012-ilp64".

More information is available in the man page for modulefile. [2]_

Before you will be able to use your own module files, you must load a
module that allows you to use your own modules:

``   $ module load use.own``

Things to Note
--------------

Modulefiles are in an extended version of the Tcl scripting language.
One important thing to note is that environment variables that are used
in one part of the script may not be used in another because the
environment variable is not yet set in the environment:

| ``   # ``\ **``THIS``\ ````\ ``WILL``\ ````\ ``NOT``\ ````\ ``WORK``**
| ``   setenv FOOBAR "/foobar"``
| ``   setenv FOOBAR_BIN "$FOOBAR/bin"``

You will need to use variables defined in the Tcl script:

| ``   # Set a variable in Tcl``
| ``   set foobar "/foobar"``
| ``   setenv FOOBAR "$foobar"``
| ``   setenv FOOBAR_BIN "$foobar/bin"``

Other things to note:

-  TCL considers "_" (underscore) as part of a variable name, but not
   "-" (hyphen).

   -  So, ``$foo_bar``, ``${foo_bar}`` are equivalent: they are the same
      variable **foo_bar**
   -  And, ``$foo-bar`` and ``${foo}-bar`` are equivalent: that is the
      variable **foo** appended by the string "-bar"

-  If you want to use "_" as a separator, you will have to either group
   the variable name in a pair of braces {}, or escape the underscore
   with a backslash:

   -  ``${foo}_bar`` -- this is **foo** appended with "_bar"
   -  ``$foo_bar`` -- this is also **foo** appended with "_bar"

Known Bugs
==========

Sometimes, the module command will crash when doing a "module unload".
It will print out a long error message. If this happens, do "cd" to go
back to your home directory, and repeat the "module unload" command. If
that still does not work, you will have to log out and back in.

Troubleshooting
===============

Command Not Found
-----------------

; Login Shell : /bin/bash

; Error Message in Job Script : **module: command not found**

.. raw:: html

   </pre>

-  Note: all other subsequent error messages in your job output can most
   likely be ignored in troubleshooting this problem as they are most
   likely a result of the missing environment setup the module command
   would have provided.

Solution
~~~~~~~~

-  As a BASH shell user, the 'module' system does not load modules
   automatically. To allow for environment modules to be used in your
   batch script, add the following line to your (after the #SBATCH
   directives):

   ::

      . /etc/profile.d/modules.sh

Example
=======

Here is an example modulefile for Mathematica 8.0.4:

::

   #%Module########################################################################
   ##
   ## mathematica-8.0.4 modulefile
   ##

   # for Tcl script use only
   set     version        8.0.4
   set     mathematicadir /deac/opt/mathematica-$version/bin

   proc ModulesHelp { } {
       global version

       puts stderr "    This module sets up the environment to use Mathematica $version"
       puts stderr "    To run remotely, you may need to install the Mathematica fonts:"
       puts stderr "    http://support.wolfram.com/technotes/latestfonts.en.html"
   }

   module-whatis   "Sets up the environment to use Mathematica $version"

   prepend-path PATH $mathematicadir

References
==========

.. raw:: html

   <references/>

.. [1]
   `Modules -- Software Environment Management: project page at
   Sourceforge <http://modules.sourceforge.net/>`__

.. [2]
   `modulefile man
   page <http://modules.sourceforge.net/man/modulefile.html>`__

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

There is a bit of an art to reporting bugs/errors in a way that helps
the support staff help you more effectively. [1]_ [2]_

Issue Tracking
==============

**Please send all help requests to**\ deac-help@wfu.edu.

Requests sent to that address generate a "ticket" in our issue tracker:
this means all the support staff have access to the report, and we can
keep a running record of information pertaining to the issue. This also
means that your report won't be missed if the person you emailed
directly happens to be away.

Key Requirements
================

An effective error report has two requirements:

#. **Reproducible:** An error must be consistently reproducible. This
   means that the report must contain enough information for the support
   staff to reproduce the error: input files, specific versions of
   software, outputs (for comparison), etc. If the report involves
   `SLURM:Quick Start Guide </SLURM:Quick_Start_Guide>`__, details about
   the job and the node(s) on which the job ran are important. Once a
   job is out of the queue, there may not be any remaining log
   information which can be used for debugging.
#. **Specific:** An "error" is really a difference between expected
   output and actual output. The report should state exactly how the
   actual output/result differs from what was expected. For example,
   "Mathematica is not working" is not specific enough. What aspect of
   it is not working? Are you getting "2 + 2 = 7"?

*Neither edit (with the exception of passwords) nor interpret the
behavior you see. Verbatim logs of actions taken and output received are
absolutely necessary.*

Specific Information for SLURM Job Issues
=========================================

When having problems with SLURM jobs, there are some details that may
make the troubleshooting process easier if included when contact the HPC
team with issues.

#. If possible, start the troubleshooting process by forwarding the job
   informational email received from SLURM when the error occurs or job
   ends.

   -  If your job is not configured to send emails upon failure, or
      ending, see the `SLURM:Job Script
      Templates </SLURM:Job_Script_Templates>`__ page to set this up.

#. In the body of the forwarded email, make attempts to include the
   following information, which will dramatically improve odds of
   diagnosing the problem.

   #. Output of "``scontrol show job``\ " while having the problem.

      -  This information is also inserted within the job output file
         during the prolog process.

   #. Output of "``sinfo --long --Node -n``\ *``NODENAME``*" while
      having problem (if possible) if you think it should be running on
      that node.
   #. Output of "``sacct --long --jobs=``\ *``YOURJOBNUM``*" if the job
      has completed.

#. Attached to the email, please include a copy of your job script and
   error file if created.

In diagnosing SLURM issues, the more real time information related to
the job and the environment the better. Recreating that environment from
log files is not the best method to arrive at a solution.

It is understood that this is a lot of information to ask for, and it
will not be possible to include everything for every job. Your
assistance in making the best effort possible when starting the
troubleshooting process is appreciated!

Disk Space Issues
=================

Research Filesystems
--------------------

When having issues concerning filesystem space on the DEAC cluster, it
is important to know some background about your shared space.

-  The /deac\* filesystems are individually assigned to research groups,
   and shared amongst the general group.
-  Each filesystem varies in size, and the only quota system enforced is
   on the general group.
-  We ask each user and group to be courteous of their usage, and to
   remove non-vital data generated as job output.

If filesystem issues occur, please include the following information
when initializing the troubleshooting process

#. The full filesystem path attempting to be written to
#. What you are attempting to write (file type, size, number of files)
#. Time at which the error occurred

Additionally, when research filesystems fill up, the HPC team will seek
out highest consumers of space and the following options can occur:

-  Unimportant files will be deleted by the user
-  Many small files will be placed into a compressed tarball and only
   kept on the filesystem in this capacity.
-  Important files to keep will be archived, and then deleted from the
   filesystem.
-  Adviser groups will collectively clean up space through the
   aforementioned means.
-  Culprit jobs will be stopped (by admins or the user) and the scripts
   will have clean-up measures implemented.
-  As a last resort, if no response is given from high consumers within
   24 hours, jobs and/or data will be forcibly deleted.

Home Directories
----------------

The /home filesystem is NOT to be used for reading/writing research
data. The aforementioned steps will be taken to clean up space if found
being used by a user.

Inodes
------

Rarely, a filesystem may show as having space available, but the "no
space left on device" error message still occurs. This is caused by the
filesystem running out of metadata, or inodes. Inodes are
administratively configured and keep track of the files on the
filesystem. Just as standard filesystem space, they have a limit of how
much they can track (on the level of millions of files). Inodes may run
out when a series of jobs creates a millions of small files in order to
arrive at a result for a job. If best practices are not used and these
small files are not cleaned up, all users attempting to use that
filesystem are impacted; and most likely, the job series will not be
able to complete successfully.

References
==========

.. raw:: html

   <references/>

.. [1]
   `How to Report Bugs
   Effectively <http://www.chiark.greenend.org.uk/~sgtatham/bugs.html>`__,
   Simon Tatham (author of PuTTY)

.. [2]
   `How to Write a Useful Bug
   Report <https://community.helixcommunity.org/2006/writingbugreport>`__,
   Helix developer community

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Managing Research Group Data
============================

Background
----------

By and large, the most difficult issue to effectively manage with a large
research group (that is, greater than 1 person!) is the data created on the
cluster by everyone in that research group. Subtle issues related to disk
storage and data ownership can make results someone you supervise has generated
be completely inaccessible to you! Some effective research group policies
regarding how your users function can help reduce the stress and frustration of
having all the results but not being able to view them. This article covers some
background information and strategies to help you develop those policies in your
group.

Account Convention
------------------

Accounts on the cluster are created such that each user has their own primary
group. This is the default convention followed by Red Hat and adopted by the WFU
DEAC cluster. This convention means that, when a user creates a file or
directory, it will be typically be owned and grouped using that user's primary
memberships.

* The caveat to this convention involves files created in a job submitted to the
  cluster. Cluster jobs run as the user submitted (as you would expect) and as
  the fairshare group under which the job was submitted (not expected). So, for
  user BOB submitting a job under the generalGrp fairshare group, all files
  created by the job will be ``BOB.generalGrp``.

Group Convention
----------------

All users are assigned to multiple groups. These groups include the "fairshare"
group (under which your priorities are determined by the cluster scheduler),
your primary research group (which could also be the fairshare group), your
primary department, a general research collaboration group, etc. Any user can
change the group membership of a file or directory that of which they are a
member (and have permission) to any other group to which they belong.

Group Sticky Bit
----------------

UNIX/Linux has this concept of a "group sticky bit" that can be set on a
directory. By setting the bit, you are making the group membership of that
directory "sticky", that is you declare that all new files and directories
created in that directory will have the same group membership of the parent. A
common misunderstanding of the sticky bit is that it changes existing files and
directories, which it is does not! Only newly created files/directories. This
sticky bit overrides any default behavior that is in effect for file or
directory creation, even the SLURM job group membership behavior!

Maintaining Group Ownership
---------------------------

The general idea is simple. Create a primary level directory with the correct
group membership and sticky bit set so that all directories and files underneath
now belong to the group. Below the desired directory, run the following
commands:

.. code-block:: console

    $ chgrp researchGrp /deac/researchGrp
    $ chmod 2770 /deac/researchGrp

The remaining steps involved require a group policy set up by the research
group. This policy must include two key features:

1.  All users must create their data files in that directory tree. You may want
    to have someone do a quarterly audit of the directory to ensure all the
    contents still have the correct group memberships.
2.  All users must have a specific ``umask`` in the login configuration files
    (``.bashrc`` or ``.tcshrc``) such that the group permissions have at least
    read access and maybe even write access (``umask 027`` or ``umask 007``,
    respectively)

Restricting Access
------------------

You want everyone in your group to be able to read and write to the directory
but no one else. For convenience, you'd like the filesystem and/or users to
automatically ensure these permissions in order to avoid that last minute
deadline hitting and you can't read the one file that you need.

First let's ensure your researchGrp directory is group writeable:

.. code-block:: console

   $ chgrp research /deac/reserachGrp
   $ chmod g+w /deac/researchGrp


Group access only
+++++++++++++++++

Remove all access to non-group members:

.. code-block:: console

   $ chmod o-wrx /deac/researchGrp

World readable
++++++++++++++

Assuming you have run the "Group access only" command... If you want non-group
members to have read only access, but not edit privileges:

.. code-block:: console

    $ chmod o+r /deac/researchGrp
