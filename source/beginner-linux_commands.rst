.. _sec.linux:

==========
Linux Help
==========

.. contents::
   :depth: 3
..

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

Below is a summary of many commonly used Linux commands. There are several excellent 
tutorials and tools available online. Below is a list that we have compiled:

.. _sec.linux.references:

Linux Reference Material
========================

.. _sec.linux.training:

Linux Training
--------------
* `<linuxjourney.com>`_
* `<linuxcommand.org>`_
* `<linuxsurvival.com>`_
* `<lym.readthedocs.io>`_
* `<ryanstutorials.net/linuxtutorial/>`_
* `<docs.rockylinux.org/labs/>`_

.. _sec.linux.basics:

Linux Basics
------------
* `<docs.rockylinux.org/books/admin_guide/00-toc/>`_
* `<wiki.archlinux.org>`_
* `<debian.org>`_
* `<reddit.com/r/linux4noobs/>`_

.. _sec.linux.info:

Linux Command Info
------------------
* `<explainshell.com>`_
* `<tldr.sh>`_
* `<gto76.github.io/linux-cheatsheet/>`_
* :download:`<files.fosswire.com/2007/08/fwunixref.pdf>`_

.. _sec.linux.wikis:

Linux Wikis
-----------
* `<wiki.rockylinux.org>`_
* `<wiki.archlinux.org>`_
* `<wiki.debian.org>`_

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.command_references:

Linux Command References
========================

.. _sec.linux.file_commands:

File Commands
-------------

* ``ls`` -- directory listing
* ``ls -al`` -- formatted listing with hidden files
* ``cd dir`` -- change directory to ``dir``
* ``pwd`` -- show current directory (Print Working Directory)
* ``mkdir dir`` -- create a directory ``dir``
* ``rm file`` -- delete `file`
* ``rm -r dir`` -- delete directory ``dir`` and all its contents
* ``rm -f file`` -- force delete file
* ``rm -rf dir`` -- force delete directory ``dir`` and all its contents (use with caution)
* ``cp file1 file2`` -- copy ``file1`` to ``file2`` (overwrites ``file2`` if it exists)
* ``cp -r dir1 dir2`` -- copy ``dir1`` to ``dir2``; create ``dir2`` if it doesn't exist
* ``mv file1 file2`` -- rename ``file1`` to ``file2`` (overwrites ``file2`` if it exists)
* ``mv file dir`` -- move ``file`` into directory ``dir``
* ``ln -s file_or_dir link`` -- create a symbolic link ``link`` pointing to ``file_or_dir``
* ``touch file`` -- create empty ``file``; if ``file`` exists, updates last-modified date
* ``less file`` -- view contents of ``file``
* ``head file`` -- output first 10 lines of ``file``
* ``tail file`` -- output last 10 lines of ``file``
* ``tail -f file`` -- output contents of ``file`` as it grows, starting with last 10 lines

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.process_management:

Process Management
------------------

* ``ps`` -- display your currnet active processes
* ``top`` -- display all running processes
* ``kill pid`` -- kill process id ``pid`` (numerical ID)
* ``bg`` -- lists stopped or background jobs; resume a stopped job in the background
* ``fg`` -- brings the most recent job to the foreground
* ``fg n`` -- brings job ``n`` to the foreground

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.file_permissions:

File Permissions
----------------

* ``chmod mode file`` -- change permissions of ``file`` to given ``mode``; mode
  can be ``[ugoa...][[+-=][perms...]...]``

    * ``u, g, o, a`` -- specify the owner: ``user``, ``group``, ``other``, or ``all``
    * ``+, -, =`` -- ``+`` adds given permissions to file, ``-`` removes given
      permissions from file, ``=`` sets given permissions on file
    * ``perms : r, w, x`` or any combination of the three -- ``r`` means read
      permission, ``w`` means write permission, ``x`` means execute (file) or cd
      (directory) permission

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.searching:

Searching Within Files
----------------------

These commands can be used to find content within files:

* ``grep pattern files`` -- print out lines containing ``pattern`` in ``files``
* ``grep -r pattern dir`` -- print out lines containing ``pattern`` in all files
  found recursively descending into directory ``dir``
* ``command | grep pattern`` -- print out lines from the output of ``command``
  which contain ``pattern``

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.system_info:

System Info
-----------

* ``date`` -- show current date and time
* ``cal`` -- show this month's calendar
* ``cal year`` -- show calendar for entire ``year``
* ``uptime`` -- show how long the machine has been up
* ``w`` -- display users who are logged in
* ``whoami`` -- who you are logged in as
* ``id`` -- print all user ID information for yourself
* ``finger user`` - display information about ``user``
* ``uname -a`` -- show information about machine
* ``cat /proc/cpuinfo`` -- cpu information
* ``cat /proc/meminfo`` -- memory information
* ``man command`` -- show manual for ``command``
* ``df -h`` -- show disk usage
* ``free`` -- show memory and swap usage
* ``whereis command`` -- show possible paths to ``command``
* ``which command`` -- show absolute path to ``command``

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.compression:

Compression
-----------

* ``tar cf dir.tar dir`` -- create a tar file named `dir.tar` containing all
  files in the directory `dir`
* ``tar xf dir.tar`` -- extract all files from `dir.tar`
* ``tar zcf dir.tar.gz dir`` -- create a gzipped tar file named `dir.tar.gz`
  containing all files in `dir`
* ``tar zxf dir.tar.gz`` -- extract all files from `dir.tar.gz`
* ``tar jcf dir.tar.bz2 dir`` -- create a tar file named `dir.tar.bz2` compressed
  with bzip2 containing all files in `dir`
* ``tar jxf dir.tar.bz2`` -- extract all files from `dir.tar.bz2`
* ``gzip file`` -- compress `file` and rename it `file.gz`
* ``gzip -d file.gz`` -- uncompress `file.gz` into `file`

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.internet:

Internet and Network
--------------------

* ``jwhois domain`` -- print administrative and contact information for the owner of `domain`
* ``dig domain`` -- print DNS information for `domain`
* ``dig -x host`` -- print reverse DNS lookup of `host`
* ``wget url`` -- download the file at `url`
* ``wget -c url`` -- resume a stopped download

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.package_installation:

Package Installation from Source
--------------------------------

Typical GNU-style source packages for software follow this recipe for building:

.. code-block:: console

   $ ./configure --prefix=$HOME/dir
   $ make
   $ make install

You can also :doc:`read our in-depth guide to compiling software
<software-building>` on DEAC, for software packages that require considerably
more work than this.

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

.. _sec.linux.other:

Other Useful Commands
---------------------

* ``Ctrl-C`` -- halts the current command (send signal ``SIGINT``)
* ``Ctrl-Z`` -- pauses the current command
* ``fg`` -- resumes a ``Ctrl-Z``'ed command
* ``bg`` -- resumes a ``Ctrl-Z``'ed command into the background (returning terminal control)
* ``!!`` -- repeats the last command
* Up and Down keys on your keyboard -- browse command history

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################
