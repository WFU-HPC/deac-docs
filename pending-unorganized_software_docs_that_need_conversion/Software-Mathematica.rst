.. contents::
   :depth: 3
..

`Category:Software </Category:Software>`__

Installed Versions
==================

As of April 2019, rhel7 installed versions of Mathematica include:

-  '''Mathematica 12.0.0'
-  '''Mathematica 11.3.0'

To use Mathematica, load the appropriate
`module </Quick_Start_Guide:Environment_Modules>`__:

``    $ module load rhel7/mathematica/12.4.1``

Then, to run the command line version:

``    $ math``

To run the GUI version:

``    $ mathematica``

Fonts
=====

To run the GUI version of Mathematica on the cluster, but displaying to
your own Linux computer, you must have Mathematica fonts installed on
your own computer. (Your computer is providing the display, and needs to
use the local font files.) Please download the fonts from Wolfram:

``    ``\ ```http://support.wolfram.com/technotes/fonts/unix/latestfonts.html`` <http://support.wolfram.com/technotes/fonts/unix/latestfonts.html>`__

Font Path Error
---------------

-  If an error about font paths occurs, the most likely issue is that
   the Mathematica fonts are not installed or were not installed
   correctly:

   ::

      xset:  bad font path element (#90)

User Environment Setup for Graphical Mathematica
================================================

-  When running the graphical instance of Mathematica on the cluster
   head nodes, the X11 protocol is used to display your window on your
   "local system". [1]_
-  Because Mathematica uses non-standard, customized fonts, you must
   install these fonts manually on your local system.

   -  To use them on Linux, follow these instructions (based on
      Wolfram's site [2]_). **IMPORTANT** These steps **MUST** be done
      on your local system and **NOT** on the cluster. This won't work
      if you are following these steps on the cluster head nodes.

-  Font installation instructions:

   -  Download the desired fonts
   -  Extract them in your home directory
      ::

         tar -xzf MathematicaV10FontsLinux.tar.gz -C $HOME

   -  On your local machine, add the font path
      ::

         xset fp+ $HOME/Fonts/Type1

   -  "Rehash" your font path
      ::

         xset fp rehash

   -  This font path must be established each time you boot your system
      and before you start Mathematica. Users are encouraged to set up
      their desktop environment or personal accounts to add these font
      path steps automatically on system boot or first login.

External Links
==============

-  `Wolfram - Mathematica product
   page <http://www.wolfram.com/mathematica/>`__

References
==========

.. raw:: html

   <references/>

.. [1]
   A "local system" is the laptop or workstation that is actually
   displaying the X11 window to you. This local device **must** support
   X11 rendering via an X11 server process. Linux/UNIX graphical
   desktops support this by design. Windows-based local devices require
   supplemental software to support X11. See `Cluster:Using from
   Windows </Cluster:Using_from_Windows>`__

.. [2]
   `Mathematica Tutorial: Fonts on
   Linux <http://reference.wolfram.com/mathematica/tutorial/FontsOnLinux.html>`__
