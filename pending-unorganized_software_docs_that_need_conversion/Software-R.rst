.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__\ `Category:Languages </Category:Languages>`__
**R** is open source statistical analysis software. [1]_

**R** has an IDE called `Software:RStudio </Software:RStudio>`__ that
you can use at any head-node

Multi-process **R** with MPI can be found `Software:R - Multiprocess
with MPI </Software:R_-_Multiprocess_with_MPI>`__

Example
=======

To run on the cluster, you need to run as a batch command. And you will
also need to be aware of file paths.

| ``    ###``
| ``    ### mycomputation.R``
| ``    ###``
| ``    # You have a datafile stuff.dat to load in the ``
| ``    # in the same directory where you will issue the ``
| ``    # sbatch command``
| ``    f <- file.path(Sys.getenv("SLURM_SUBMIT_DIR"), "stuff.dat")``
| ``    load(f)``
| ``    ``
| ``    # Do some processing...``
| ``    # ... and write the output to a file /scratch/${SLURM_JOBID}/my_output.dat``
| ``    output_file <- file.path("/scratch", Sys.getenv("SLURM_JOBID"), "my_output.dat")``
| ``   ``

and the corresponding SLURM job script, named "my_computation.slurm":

::

   #!/bin/bash
   #SBATCH --partition=small
   #SBATCH --job-name="my_computation"
   #SBATCH --mail-type=FAIL,END
   #SBATCH --output="my_computation-%j.o"
   #SBATCH --error="my_computation-%j.e"
   #SBATCH --mail-user=MY_EMAIL_ADDRESS@wfu.edu
   #SBATCH --account="myresearchGrp"
   #SBATCH --mem=48gb
   #SBATCH --nodes=1
   #SBATCH --ntasks-per-node=1
   #SBATCH --cpus-per-task=1
   #SBATCH --time=20:00:00

   module load R/3.5.0

   cd ${SLURM_SUBMIT_DIR}
   scratchdir="/scratch/${SLURM_JOBID}"
   R --vanilla --no-timing CMD BATCH my_computation.R my_computation.out
   mv ${scratchdir}/my_output.dat .

To run, do: **sbatch my_computation.slurm**

Installing Packages
===================

For R packages to be installed globally on the DEAC cluster please email
deac-help@wfu.edu with name of the desired R package.

If you would like to install an R package locally to your research group
path, you can do so with the following steps:

-  Create a directory where the R packages will be installed (Preferably
   in a shared folder your entire research group can use):

``    mkdir -p /deac/generalGrp/``\ **``yourResearchGrp``**\ ``/R-packages/``

-  Load the environment module file for your desired version of R and
   start and R session:

| ``    module load rhel7/R/3.5.0``
| ``    R``

-  After starting an R session add the directory where you want to
   install the R package to your library path:

| ``    R version 3.5.0 (2018-04-23) -- "Joy in Playing"``
| ``    Copyright (C) 2018 The R Foundation for Statistical Computing``
| ``    Platform: x86_64-pc-linux-gnu (64-bit)``
| ``    ``
| ``    R is free software and comes with ABSOLUTELY NO WARRANTY.``
| ``    You are welcome to redistribute it under certain conditions.``
| ``    Type 'license()' or 'licence()' for distribution details.``
| ``    ``
| ``    Natural language support but running in an English locale``
| ``    ``
| ``    R is a collaborative project with many contributors.``
| ``    Type 'contributors()' for more information and``
| ``    'citation()' on how to cite R or R packages in publications.``
| ``    ``
| ``    Type 'demo()' for some demos, 'help()' for on-line help, or``
| ``    'help.start()' for an HTML browser interface to help.``
| ``    Type 'q()' to quit R.``
| ``    ``
| ``    > .libPaths("/deac/generalGrp/``\ **``yourResearchGrp``**\ ``/R-packages/")``

-  Now any package you install in this R session will be installed to
   this libPath directory. You are then free to install any package
   using the following command:

``   > install.packages("``\ *``package_name``*\ ``")``

When submitting jobs to the DEAC cluster you will need to add the
following line to your R script before loading any packages to ensure
your R script is able to find the packages during execution:

``    .libPaths("/deac/generalGrp/``\ **``yourResearchGrp``**\ ``/R-packages/")``

If you get an error like "X connection to localhost:14.0 broken", that
means that you are not running an X11 display. R's package installation
defaults to using a Graphical User Interface (GUI) to select a CRAN
mirror.

To work around this, you can select a CRAN mirror before installing a
package. Doing the following will bring up a terminal-based CRAN mirror
selector:

``    [username@headnode]> chooseCRANmirror(graphics=F)``

and then run the install.packages() command as usual.

If you receive any other errors when trying to install packages this
way, please contact deac-help@wfu.edu for assistance.

References
==========

.. raw:: html

   <references/>

See Also
========

-  `Revolution
   R <http://www.revolutionanalytics.com/products/revolution-r.php>`__ -
   a faster (optimized) version of R (100% compatible) with support for
   multi-core; supports RedHat Enterprise Linux 5; source code available

.. [1]
   `The R Project for Statistical
   Computing <http://www.r-project.org/>`__ - official web page
