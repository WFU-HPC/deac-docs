.. contents::
   :depth: 3
..

About
=====

-  Cygwin/X is a port of the X Window System to the Cygwin API layer for
   the Microsoft Windows family of operating systems. Cygwin provides a
   UNIX-like API, thereby minimizing the amount of porting required.
-  Because less porting is required, it can more easily handle X11
   forwarding for advanced apps on Windows.

Installation
============

-  Cygwin/X is to be installed on your Windows OS.
-  Install Cygwin following the steps listed here:
   https://x.cygwin.com/docs/ug/setup.html#setup-cygwin-x-installing
-  It is vital to select the packages listed on step 15, here are some
   tips:

:\* Select all packages in the X11 category

:\* Select vim under the System category,

:\* Search for SSH and select all matching packages.

-  Once installed, load cygwin from your start menu

Usage
=====

-  From within the cygwin terminal, run "*startx*"
-  From the new Xterm GUI window that appears...

:\* Click the icon in the lower left corner, and browse the menu to
"System Tools" -> "Xterm (terminal)"

-  From the Xterm terminal window, type "*ssh -Y pegasus.deac.wfu.edu*"
   to login to the DEAC cluster.
-  Once logged in to the cluster, type "*echo $DISPLAY*" to ensure the
   $DISPLAY variable is set.

:\* If a value is assigned, it is what will ensure software GUIs display
correctly.

:\* If not set, either you forgot the -Y when you SSHed or did not
correctly install all of the X11 packages.

-  Once the xterm window within the Cygwin/X desktop is loaded, you are
   ready to go!

External Links
==============

-  Cygwin installation -
   https://x.cygwin.com/docs/ug/setup.html#setup-cygwin-x-installing
