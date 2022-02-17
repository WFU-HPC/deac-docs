.. contents::
   :depth: 3
..

**OpenMP** Application Program Interface (API) supports multi-platform
shared-memory parallel programming in C/C++ and Fortran on all
architectures, including Unix platforms and Windows platforms. Jointly
defined by a group of major computer hardware and software vendors,
OpenMP is a portable, scalable model that gives shared-memory parallel
programmers a simple and flexible interface for developing parallel
applications for platforms ranging from the desktop to the
supercomputer. [1]_

**Note: Do NOT confuse OpenMP
with**\ `Software:OpenMPI </Software:OpenMPI>`__

Compilers
=========

All the compilers installed on the cluster support OpenMP. [2]_ This
includes GNU, Intel, PGI, and Absoft.

Example
=======

This is a very simple example of computing :math:`\pi` by approximating
an integral:
:math:`\pi = \int_{0}^{1}\frac{4}{1 + x^2}dx \approx \frac{1}{N}\sum_{i=0}^{N-1}\frac{4}{1 + (\frac{i + 0.5}{N})^2}`.

Here is the serial version:

| ``   #include <stdio.h>``
| ``   #include <stdlib.h>``
| ``   #include <math.h>``
| ``   ``
| ``   int main(int argc, char** argv)``
| ``   {``
| ``       const int N = 1000000;``
| ``       double step;``
| ``       int i;``
| ``       double x = 0.;``
| ``       double sum = 0.;``
| ``       ``
| ``       step = 1./(double)N;``
| ``       for (i = 0; i < N; ++i) {``
| ``           x = (i + 0.5) * step;``
| ``           sum += 4./(1. + x*x);``
| ``       }``
| ``       sum *= step;``
| ``       printf("approx. pi = %.14g; delta = %.14g\n", sum, fabs(M_PI - sum));``
| ``       return 0;``
| ``   }``

The OpenMP parallel version uses a reduction to accumulate the
intermediate sums computed by the separate threads:

| ``   #include <stdio.h>``
| ``   #include <stdlib.h>``
| ``   #include <math.h>``
| ``   #include <omp.h>``
| ``   ``
| ``   int main(int argc, char** argv)``
| ``   {``
| ``       const int N = 1000000;``
| ``       double step;``
| ``       int i;``
| ``       double x = 0.;``
| ``       double sum = 0.;``
| ``       ``
| ``       step = 1./(double)N;``
| ``       #pragma omp parallel for private(i,x) reduction(+:sum)``
| ``       for (i = 0; i < N; ++i) {``
| ``           x = (i + 0.5) * step;``
| ``           sum += 4./(1. + x*x);``
| ``       }``
| ``       sum *= step;``
| ``       printf("approx. pi = %.14g; delta = %.14g\n", sum, fabs(M_PI - sum));``
| ``       return 0;``
| ``   }``

The compiler automatically generates the appropriate code, taking care
of protecting variables and synchronizing the reduction at the end.

References
==========

.. raw:: html

   <references/>

`Category:Software </Category:Software>`__

.. [1]
   `About OpenMP - OpenMP official
   website <http://openmp.org/wp/about-openmp/>`__

.. [2]
   `OpenMP Compilers - OpenMP official
   website <http://openmp.org/wp/openmp-compilers/>`__
