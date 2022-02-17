.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

Overview
========

POVray is also known as "Persistence of Vision Raytracer". The home page
for the software is http://www.povray.org/. From their website, the
software "is a high-quality, totally free tool for creating stunning
three-dimensional graphics. It is available in official versions for
Windows, Mac OS/Mac OS X and i86 Linux. The source code is available for
those wanting to do their own ports."

A sample of the quality of images that can be generated is found in
their `Hall of Fame <http://hof.povray.org/>`__ gallery.

Versions
========

The following versions are available:

-  POVray 3.6.1
-  POVray 3.7.0.rc6

**IMPORTANT NOTE:** The beta version appears to default to a
multi-threaded operation. Therefore, when submitting these jobs for
rendering, you must select all the processors on a given node unless you
can configure POVray to use less processing cores.

The software is installed in the usual /deac/opt directory. We have
built the usual environment
`module </Quick_Start_Guide:Environment_Modules>`__ files.

Using Version 3.6.1
===================

::

   module load povray/3.6.1

   The POVray command is **povray**

Using Version 3.7.0.rc6
=======================

::

   module load povray/3.7.0.rc6

   The POVray command is **povray**

Documentation
=============

Man Pages
   **man povray** - works with both software versions

HTML documentation
   $POVRAYDOCS - environment variable defined by the environments module
   that you load that will take you to the root of the provided
   documentation for POVray.
