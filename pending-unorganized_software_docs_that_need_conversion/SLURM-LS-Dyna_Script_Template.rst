.. contents::
   :depth: 3
..

__TOC__ **UPDATE - 23 FEB 2017** -- Template migrated to new Wiki,
updated links.

**UPDATE - 05 Mar 2016** -- Template updated to properly submit
multinode jobs.

**UPDATE - 11 Feb 2016** -- Page updated with new template and
guidelines

**UPDATE - 09 Sept 2015** -- Page created to cover correlating SLURM
instructions... currently in testing, so this content may change.

LS-Dyna SLURM Script
====================

-  This wiki page provides information on running
   `Software:LS-Dyna </Software:LS-Dyna>`__ jobs.
-  Running LS-Dyna jobs can be written manually, or the template below
   can be used as a guide

General Script Sections
=======================

-  The LS-Dyna script based upon the provided template has 8 distinct
   sections

   #. Directives

      -  Not provided within the template.
      -  Directive content should have minor differences between
         requested resource type

         -  Infiniband - Specify the infiniband partition and set
            "--switches=1"
         -  Ethernet - Specify a non-infiniband partition and set
            "--constraint=ethernet" (this is optional)
         -  Tengig - Specify a non-infiniband partition and set
            "--constraint=tengig" (this is optional)

      -  Reference
         `SLURM:Job_Script_Templates </SLURM:Job_Script_Templates>`__
         for more directive guidelines

   #. LS-Dyna Setup

      -  This is where the majority of template customization will occur
      -  Replace "FIXME" as needed
      -  Define version of LS-Dyna used in this section
      -  SLURM job information is extracted here as well

         -  A FOR loop is used to create a properly formatted host list:
         -  Upon submission, each node will be listed X number of times,
            X equalling the tasks-per-node directive value.

   #. Report Header

      -  Establish formatting of output file header
      -  Display information about the job environment in output

   #. .pfile Configuration

      -  LS-Dyna specific file used for job
      -  Can change on a job to job basis

   #. MPIRUN execution

      -  Command line call to execute LS-Dyna

   #. Results Parser

      -  Extra data from command line call results

   #. Results Display

      -  Print results to output file

   #. File Chmod

      -  Change ownership of created files for team collaboration

Version
=======

-  The template is configured to use the most often desired version of
   LS-Dyna installed on the cluster (R6.1.1prime).
-  The version is set in the Setup Section where Dyna_EXE is defined
-  To use a different version of LS-Dyna, the Dyna_EXE variable must be
   replaced the with desired versions binary file
-  All versions of LS-Dyna available for use are installed to
   /deac/opt/LS-Dyna/64-Bit
-  If installing a new version of LS-Dyna, it should also be in
   /deac/opt/LS-Dyna/64-Bit

   -  To install, expand the archive file that you download, and move
      (mv) the resulting files (there are usually 2) into that
      directory. For example:

..

   ::

      > tar zxf mpp971_s_r5.1.1_67365_intel_linux86-64_hpmpi.tar.gz
      > ls -l
      total 132280
      -rwxr-xr-x  1 chindw   stitzelGrp 96522725 Jul  6 14:16 mpp971_s_r5.1.1_67365_intel_linux86-64_hpmpi
      -rwxr-xr-x  1 chindw   stitzelGrp   303241 Jul  6 14:16 mpp971_s_r5.1.1_67365_intel_linux86-64_hpmpi.l2a
      -rw-r--r--  1 kdanelso stitzelGrp 38980690 Jul  6 17:31 mpp971_s_r5.1.1_67365_intel_linux86-64_hpmpi.tar.gz
      > mv mpp971_s_r5.1.1_67365_intel_linux86-64_hpmpi mpp971_s_r5.1.1_67365_intel_linux86-64_hpmpi.l2a /deac/opt/LS-Dyna/64-Bit

Template
========

-  REMINDER - Directives need to be added to this template before
   submitting as a job to SLURM

::

   ###########################################
   # Setup for LS-Dyna - Sub FIXME as needed #
   ###########################################

   # Extract just the SLURM job ID number
   JOBID=$SLURM_JOB_ID
   NCPU=$SLURM_NCPU
   HOSTBUILD=()
   for i in $( /usr/bin/scontrol show hostnames $SLURM_JOB_NODELIST | sort -u | sed -e :a -e 'N;s/\n/ /;ba' ); do
     for j in $( seq 1 $SLURM_HOSTSLOTS ); do
       HOSTBUILD+=("${i}")
     done
   done
   HOSTLIST=$(printf ",%s" "${HOSTBUILD[@]}")
   HOSTLIST=${HOSTLIST:1}


   #Setup run parameters and file locations etc.
   Title="${SLURM_JOB_NAME}"  # If set manually, must not have any spaces.
   Series="FBM"
   WordSize="64"
   Memory="1000m"
   Memory2="100m"
   Keyword="FIXME"
   OutputDir="FIXME"
   SendMail="1"
   Email="FIXME"
   Description="FIXME - ${NCPU} cpu - Ethernet"

   # Set up for HP MPI
   export DynaPath=/deac/opt/LS-Dyna
   export HPMPIPATH=${DynaPath}/hpmpi
   export MPIRUN_OPTIONS="-prot -v"
   unset  LD_LIBRARY_PATH
   unset  DYLD_LIBRARY_PATH
   export PATH=/usr/local/bin:/usr/lpp/mmfs/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/libexec:/usr/kerberos/bin:/usr/X11R6/bin
   export LD_LIBRARY_PATH=/lib64:/usr/lib64:${HPMPIPATH}/lib/linux_amd64:${DynaPath}/libs/other-libs

   #   Prepend DynaPath, HPMPIPATH
   export PATH=$DynaPath/64-Bit:${HPMPIPATH}/bin:${HPMPIPATH}/sbin:${PATH}

   # LSTC LS-Dyna license control
   export LSTC_DIR=/deac/opt/LS-Dyna/lstc
   export LSTC_LICENSE=network
   export LSTC_LICENSE_SERVER=lstclm.deac.wfu.edu
   export PATH=${LSTC_DIR}:${PATH}

   ###
   ### For other versions of LS-Dyna, pick one of the following Dyna_EXE and comment
   ### out the other lines:
   #For R4.2.1 - Revision 53450, Product ID 67119:
   #Dyna_EXE="${DynaPath}/64-Bit/mpp971_s_R4.2.1_67119_Intel_linux86-64_hpmpi"
   #For R6.1.1 - Revision 78769, SVN Version: 79036:
   #Dyna_EXE="${DynaPath}/64-Bit/ls-dyna_mpp_s_r6_1_1_79036_x64_redhat54_ifort101_sse2_platformmpi"
   #For R6.1.1beta - Revision 78769, SVN Version: 80485:
   #Dyna_EXE="${DynaPath}/64-Bit/ls-dyna_mpp_s_r6_1_1_80485_x64_redhat54_ifort101_sse2_platformmpi"
   #For R7.1.2 - Revision , SVN Version: 95028:
   Dyna_EXE="${DynaPath}/64-Bit/ls-dyna_mpp_s_r7_1_2_95028_x64_redhat54_ifort131_sse2_platformmpi"

   echo ""
   echo "$Description

   ----General Information----
   LS-Dyna License:              $LSTC_LICENSE
   LS-Dyna License Server:       $LSTC_LICENSE_SERVER
   Current IP Address:           $( host `hostname` | awk '{print $4}' )
   Home:                         $HOME
   Job:                          $SLURM_JOB_NAME
   Working directory is:         $SLURM_SUBMIT_DIR
   Running on host               `hostname`
   Time is:                      `date`
   Directory is:                 $OutputDir
   CPUs Allocated:               $NCPU
   This job runs on the following nodes:
   $HOSTLIST

   ------Job Information------
   Title:         $Title
   Series:        $Series
   Word Size:     $WordSize
   Dyna Version:  $Dyna_EXE
   CPUs:          $NCPU
   Memory:        $Memory
   Memory2:       $Memory2
   Keyword:       $Keyword
   Output:        $OutputDir
   SendMail:      $SendMail
   Email:         $Email
   -----------------------
   "

   cd ${OutputDir}

   #
   # pfile
   #

   # Global and Local directories
   PFILE=${Title}.pfile
   GLOBALDIR=${Title}_global_dir
   LOCALDIR=${Title}_local_dir
   #/scratch/${SLURM_JOBID}/

   # create pfile
   echo "dir { transfer_files rmlocal global ${GLOBALDIR} local ${LOCALDIR} }" >> ${PFILE}


   ### UPDATE Dec 06, 2018 -- FORCING 'TCP' FOR NON-USNIC USAGE, REMOVE ALL INFINIBAND REFERENCES
   ${HPMPIPATH}/bin/mpirun -TCP \
       -e LSTC_LICENSE=${LSTC_LICENSE} \
       -e LSTC_LICENSE_SERVER=${LSTC_LICENSE_SERVER} \
       -e PATH=${PATH} \
       -e LD_LIBRARY_PATH=${LD_LIBRARY_PATH} \
       -np ${NCPU} \
       -hostlist ${HOSTLIST} \
       ${Dyna_EXE} \
       I=${OutputDir}/${Keyword} \
       p=${PFILE} \
       MEMORY=${Memory} \
       MEMORY2=${Memory2} \
       JOBID=${Title}


   # Result Parser, this script parses the results of a run

   # Files to be used
   MsgFile="${GLOBALDIR}/${Title}.mes0000"
   # Regular Expressions
   TermReg='t e r m i n a t i o n'
   TermTReg='Problem time'
   ErrReg=' \*\*\* Error'
   ShReg='shell element .* failed at time'
   SoReg='solid element .* failed at time'


   # Calculate number of errors and list of errors
   Errors="`grep \"$ErrReg\" \"$MsgFile\"`"
   FirstErr="`grep -m1 \"$ErrReg\" \"$MsgFile\" | cut -d# -f2`"
   ErrorCnt="`grep -c \"$ErrReg\" \"$MsgFile\"`"

   # Calculate failed shells
   FailedSh="`grep \"$ShReg\" \"$MsgFile\"`"
   FailedShCnt="`grep -c \"$ShReg\" \"$MsgFile\"`"

   # Calculate failed solids
   FailedSo="`grep \"$SoReg\" \"$MsgFile\"`"
   FailedSoCnt="`grep -c \"$SoReg\" \"$MsgFile\"`"

   # Figure out what kind of termination it is
   if [[/_`grep_"$TermReg"_"$MsgFile"`_=~_'E_r_r_o_r*'_| `grep "$TermReg" "$MsgFile"` =~ 'E r r o r*' ]]; then 
        TermStat="Error";
        TermTime="`grep \"$TermTReg\" \"$MsgFile\" | cut -d= -f2 | tr -d ' '`"
        TermErr="ErrEl:[$FirstErr ]"
   elif [[/_`grep_"$TermReg"_"$MsgFile"`_=~_'N_o_r_m_a_l*'_| `grep "$TermReg" "$MsgFile"` =~ 'N o r m a l*' ]]; then 
        TermStat="Normal"; 
        TermTime="`grep \"$TermTReg\" \"$MsgFile\" | cut -d= -f2 | tr -d ' '`"
        TermErr=""
   else 
        TermStat="Incomplete";
        TermTime="Incomplete";
        TermErr=""
   fi

   echo "$Description

   ------Job Termination------
   Termination:   $TermStat
   Prob. Time:    $TermTime
   ------Job Information------
   Title:         $Title
   Series:        $Series
   Word Size:     $WordSize
   Dyna Version:  $Dyna_EXE
   CPUs:          $NCPU
   Memory:        $Memory
   Keyword:       $Keyword
   Output:        $OutputDir
   SendMail:      $SendMail
   Email:         $Email
   ---------------------------
   Errors:        $ErrorCnt
   Failed Shells: $FailedShCnt
   Failed Solids: $FailedSoCnt
   -----------Stats-----------
   `tail -n14 \"$MsgFile\"`
   -----------Errors----------
   $Errors

   ------Failed Shells--------
   $FailedSh

   ------Failed Solids--------
   $FailedSo

   "

   echo "Job Complete"

   # Give group read permissions on all generated files
   chmod -Rf g+rw ${SLURM_JOB_NAME}* ${GLOBALDIR} ${LOCALDIR}

See Also
========

-  `Software:LS-Dyna </Software:LS-Dyna>`__

`Category:Software </Category:Software>`__\ `Category:SLURM </Category:SLURM>`__
