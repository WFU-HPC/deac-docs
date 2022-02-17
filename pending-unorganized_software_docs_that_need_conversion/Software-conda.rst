.. contents::
   :depth: 3
..

This page is to document conda installations on the DEAC cluster.

Installation
============

Installing Miniconda
--------------------

-  Download Miniconda installer script.

`` wget ``\ ```https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh`` <https://repo.continuum.io/miniconda/Miniconda3-latest-Linux-x86_64.sh>`__\ `` ``

-  Run Miniconda installer script.

`` bash Miniconda3-latest-Linux-x86_64.sh``

| `` Welcome to Miniconda3 4.5.11``
| `` ``
| `` In order to continue the installation process, please review the license``
| `` agreement.``
| `` Please, press ENTER to continue``
| `` >>>``
| `` ``
| `` Do you accept the license terms? [yes|no]``
| `` [no] >>> yes``
| `` ``
| `` Miniconda3 will now be installed into this location:``
| `` /home/stevenca/miniconda3``
| `` ``
| `` - Press ENTER to confirm the location``
| `` - Press CTRL-C to abort the installation``
| `` - Or specify a different location below``
| `` ``
| `` [/home/stevenca/miniconda3] >> /deac/generalGrp/usershare/stevenca/miniconda3``
| `` PREFIX=/deac/generalGrp/usershare/stevenca/miniconda3``

-  Add Miniconda3 to .bashrc

`` echo ". /deac/generalGrp/usershare/stevenca/miniconda3/etc/profile.d/conda.sh" >> ~/.bashrc``

Installing Anaconda
-------------------

-  Download Anaconda installer script.

`` wget ``\ ```https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh`` <https://repo.anaconda.com/archive/Anaconda3-5.3.0-Linux-x86_64.sh>`__

-  Run Anaconda installer script.

`` bash Anaconda3-5.3.0-Linux-x86_64.sh``

| `` Welcome to Anaconda3 5.3.0``
| `` In order to continue the installation process, please review the license agreement.``
| `` Please, press ENTER to continue``
| `` >>>``
| `` ``
| `` Do you accept the license terms? [yes|no]``
| `` [no] >>> yes``
| `` ``
| `` Anaconda3 will now be installed into this location:``
| `` /home/stevenca/anaconda3``
| `` ``
| `` - Press ENTER to confirm the location``
| `` - Press CTRL-C to abort the installation``
| `` - Or specify a different location below``
| `` ``
| `` [/home/stevenca/anaconda3] >>> /deac/generalGrp/usershare/stevenca/anaconda3``
| `` PREFIX=/deac/generalGrp/usershare/stevenca/anaconda3``

-  Add Anaconda3 to .bashrc

`` echo ".  /deac/generalGrp/usershare/stevenca/anaconda3/etc/profile.d/conda.sh" >> ~/.bashrc``
