.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

**R Language**
==============

__forcetoc__

Description & Info
------------------

-  The `Software:RStudio </Software:RStudio>`__ IDE can be used on any
   head-node.
-  The **foreach**, **iterators** & **doParallel** packages must be
   installed. Same steps as the `Software:RStudio#Installing_Packages
   Rmpi package
   installation </Software:RStudio#Installing_Packages_'''Rmpi'''_package_installation>`__
-  Wikibook: `R
   Programming <http://en.wikibooks.org/wiki/R_Programming>`__
-  `HPC with
   R <http://cran.r-project.org/web/views/HighPerformanceComputing.html>`__

**Testing foreach Package**
===========================

Matrix Multiplication with *foreach* Package
--------------------------------------------

-  Matrix multiplication is used to test the **foreach** package on the
   cluster
-  The example was taken from `foreach Cran
   PDF <http://cran.r-project.org/web/packages/foreach/foreach.pdf>`__
-  Template:

::

   # clears all global environment before starting program
   rm(list = ls())

   # List of libraries packages that must be included
   # doParallel, iterators & foreach have to be present
   library(foreach); library(iterators); library(doParallel)

   # Before running parallel command, program must have
   # a register parallel backend in order to run in parallel
   # cl is a 'cluster' object of 8 cores
   cl <- makePSOCKcluster(8)
   registerDoParallel(cl)

   # 'a' is a 10x200,000 matrix with 2,000,000 random elements
   # 'b' is the transpose matrix of 'a' - 200,000x10
   # Resultant matrix of dim 10x10
   a <- matrix(rnorm(2000000), 10,200000)
   b <- t(a)

   # For each iteration:
   # Breaks down each column from 'b' and multiply it by 'a'
   # The results are collected by .combine=cbind
   # The %dopar% operator will generated the threads to execute in parallel
   # The operation of multiplying must be also surrounded by the %-sign
   # Otherwise, it will execute in serial mode
   foreach(b=iter(b, by='col'), .combine=cbind) %dopar% (a %*% b)

   # Good practice to close/kill the socket communication
   # of all the workers by using the Cluster object 'cl'
   stopCluster(cl)

-  Output that gets generated should be a 10x10
-  Note: Each time this example runs, different element values will get
   generated
-  Example of a possible output:

::

                [,1]         [,2]          [,3]         [,4]        [,5]        [,6]        [,7]         [,8]          [,9]        [,10]
    [1,] 199169.6015    794.22361    262.055677    283.99548    402.3996   -292.5005   -806.5746     35.48630   -208.976473    353.57920
    [2,]    794.2236 200880.89297    210.791207    285.83114   -336.8855  -1013.3063   -420.5574     82.13992    558.076190    343.20755
    [3,]    262.0557    210.79121 200157.047011    861.73804   -382.5887   -405.8085    577.7373   -599.35569      1.750347    383.42479
    [4,]    283.9955    285.83114    861.738043 200171.13075   -213.1187    541.8806    325.8889   -592.05285    596.271144     64.79383
    [5,]    402.3996   -336.88554   -382.588695   -213.11870 199209.6985    220.2736    250.3666   -246.30454   -265.334563    669.30438
    [6,]   -292.5005  -1013.30628   -405.808523    541.88058    220.2736 200816.2702   -552.9066   -128.75266   -595.465460    454.24774
    [7,]   -806.5746   -420.55737    577.737350    325.88891    250.3666   -552.9066 199313.6753   -175.09126   -413.613558    307.94146
    [8,]     35.4863     82.13992   -599.355688   -592.05285   -246.3045   -128.7527   -175.0913 200700.25553   -476.442597    138.90606
    [9,]   -208.9765    558.07619      1.750347    596.27114   -265.3346   -595.4655   -413.6136   -476.44260 200074.405654   -238.64176
   [10,]    353.5792    343.20755    383.424786     64.79383    669.3044    454.2477    307.9415    138.90606   -238.641757 199055.30105
