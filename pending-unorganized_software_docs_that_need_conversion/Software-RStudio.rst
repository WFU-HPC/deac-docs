.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

**RStudio**
===========

__forcetoc__

Description
-----------

-  An Integrated Development Environment (IDE) for generating & testing
   R-programs
-  Basic information in running **R** jobs on DEAC
   `page </Software:R>`__
-  Multi-process **R** using MPI `wiki
   page </Software:R_-_Multiprocess_with_MPI>`__
-  Multi-process **R** using foreach `wiki
   page </Software:R_-_Multiprocess_with_foreach>`__
-  The RStudio is installed in all RHEL6 head-nodes.
-  Make sure you have **X-Window Forwarding** on your shell session

**Running RStudio**
===================

Launching
---------

-  In any of the headnodes, run this command:

::

   $ rstudio

-  What you see is the IDE window:

File:Screenshot-RStudio.png

**Installing Packages**
=======================

Default Path
------------

-  When installing a package as ROOT for **R**, the packages will be
   installed

::

   # /usr/lib64/R/library

-  From the IDE's bottom right panel window > under **Packages** tab >
   click **Install** for packages
-  New window pops up
-  95% of the packages will come from the CRAN repo
-  Name the packages that is needed

File:Screenshot-RStudio-1.png

-  The installation of any package is only that LOCAL head-node;
   meaning, the installation its not broadcasted to the other head-nodes
-  If a user installs packages using RStudio > package will be stored on
   their home directory and generate a directory called

::

   /home/username/R/x86_64-redhat-linux-gnu-library/3.0/

-  This is the default path for the IDE to install own packages

Installing **Rmpi** Package
---------------------------

-  The Rmpi Package `PDF
   page <http://cran.r-project.org/web/packages/Rmpi/Rmpi.pdf>`__
-  In order to install the Rmpi Package, loaded MPI environment

::

   # module load openmpi/1.6-intel

-  Use **R** in terminal mode
-  Knowingly using the OpenMPI module, configured the installed to
   correct path:

::

   # R

   R version 3.0.2 (2013-09-25) -- "Frisbee Sailing"
   Copyright (C) 2013 The R Foundation for Statistical Computing
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

   > install.packages("Rmpi", configure.args="--with-mpi=/deac/opt/openmpi/1.6-intel/")

-  Without specifying the MPI path, R will not be able to read the
   correct **mpi.h** file path correctly
-  This is the functions (methods) that come with Rmpi:

::

   installing to /usr/lib64/R/library/Rmpi/libs
   ** R
   ** demo
   ** inst
   ** preparing package for lazy loading
   ** help
   *** installing help indices
     converting help for package ‘Rmpi’
       finding HTML links ... done
       hosts                                   html  
       internal                                html  
       mpi.abort                               html  
       mpi.apply                               html  
       mpi.barrier                             html  
       mpi.bcast                               html  
       mpi.bcast.Robj                          html  
       mpi.bcast.cmd                           html  
       mpi.cart.coords                         html  
       mpi.cart.create                         html  
       mpi.cart.get                            html  
       mpi.cart.rank                           html  
       mpi.cart.shift                          html  
       mpi.cartdim.get                         html  
       mpi.comm                                html  
       mpi.comm.disconnect                     html  
       mpi.comm.free                           html  
       mpi.comm.inter                          html  
       mpi.comm.set.errhandler                 html  
       mpi.comm.spawn                          html  
       mpi.const                               html  
       mpi.dims.create                         html  
       mpi.exit                                html  
       mpi.finalize                            html  
       mpi.gather                              html  
       mpi.gather.Robj                         html  
       mpi.get.count                           html  
       mpi.get.processor.name                  html  
       mpi.get.sourcetag                       html  
       mpi.iapply                              html  
       mpi.info                                html  
       mpi.intercomm.merge                     html  
       mpi.parSim                              html  
       mpi.parapply                            html  
       mpi.probe                               html  
       mpi.realloc                             html  
       mpi.reduce                              html  
       mpi.remote.exec                         html  
       mpi.scatter                             html  
       mpi.scatter.Robj                        html  
       mpi.send                                html  
       mpi.send.Robj                           html  
       mpi.sendrecv                            html  
       mpi.setup.rng                           html  
       mpi.spawn.Rslaves                       html  
       mpi.universe.size                       html  
       mpi.wait                                html  
   ** building package indices
   ** testing if installed package can be loaded
   * DONE (Rmpi)
   Making 'packages.html' ... done

   The downloaded source packages are in
       ‘/tmp/RtmpSZ7TtC/downloaded_packages’
   Updating HTML index of packages in '.Library'
   Making 'packages.html' ... done

See Also
--------

-  `Software:R </Software:R>`__
