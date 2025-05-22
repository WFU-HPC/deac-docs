===============
Python
===============

.. #############################################################################
.. #############################################################################
.. #############################################################################
.. #############################################################################

-------------
Installations
-------------

Available Versions
==================

* Python 3.9.18 (system)
* Python 3.11.8 (module)

Default Python Packages
=======================

The HPC Facility provides a compiled installation of Python3 available for
general cluster use. The module loaded Python installation has over 190 
common Python packages pre-installed that users can load out of the box, including:

* jupyter
* matplotlib
* mpi4py
* numpy
* pandas
* pyyaml
* ruamel.yaml
* scipy
* virtualenv    

To see a full list of installed Python packages user can run the command:

.. code-block:: none

    pip3 freeze


If Users wish to install their own Python packages, the HPC Team recommends 
that users utilize Python environments installing packages into their home 
directory or research path. For more advanced Python environment installations, 
the HPC Team is willing to install Python environments for individual research
groups or projects. 

------------------------------
Creating a Virtual Environment
------------------------------

Any user can create their own virtual environment in order to install
python packages for specific research projects performed on the DEAC
Cluster. You can learn more about this process `here from Python <https://docs.python.org/3/library/venv.html>`_ 
and `here from a 3rd party <https://www.geeksforgeeks.org/python-virtual-environment/>`_.


Running a Python Job
====================

For our example Python job, we will use `Phonopy <https://phonopy.github.io/phonopy>`_ , an open source package for phonon calculations at harmonic and
quasi-harmonic levels. It is already installed on the DEAC Cluster, but you can also check for the latest version 
`here <https://github.com/phonopy/phonopy/releases>`_. If you install a version to a local environment be sure to
change this line in the installation script from ``False`` to ``True`` to enable the built-in OpenMP parallelism:

.. code-block:: none

    with_openmp = False

We also have installed the tornado module, which allows Phonopy to display plots for viewing with a web-browser;
however, it is incredibly slow since you are connecting via SSH to a remote machine. We also do not allow any
calculations on the login nodes, so the best way to use the software is via our queue system, Slurm.



Usage
=====

We will be calculating some properties for NaCl from the `official Phonopy
examples <http://phonopy.github.io/phonopy/examples.html#nacl>`_. You can
download the :download:`prepared files <images/phonopy-NaCl.tar.bz2>` if you want
to run the calculation for yourself. An example Slurm script could be like this:

.. code-block:: slurm

    #!/bin/bash
    #SBATCH --job-name="phonopy-NaCl"     # Name that appears in queue
    #SBATCH --partition=small             # Resource group (small/medium/large)
    #SBATCH --nodes=1                     # Number of Nodes
    #SBATCH --ntasks-per-node=1           # Number of tasks (MPI processes)
    #SBATCH --cpus-per-task=20            # Number of threads per task (OMP threads)
    #SBATCH --mem=4G                      # Requested memory
    #SBATCH --time=00-00:05:00            # Job duration in DD-hh:mm:ss
    #SBATCH --output="SLURM-phonopy-%j.o" # Slurm stdout, %j is the job number
    #SBATCH --error="SLURM-phonopy-%j.e"  # Slurm stderr, %j is the job number
    #SBATCH --mail-type=BEGIN,END,FAIL    # Mail sent on begin, end/failure
    #SBATCH --mail-user=%u@wfu.edu        # User email
    ###SBATCH --account=<FIXME>           # Remove two leading # and update FIXME to use non-default account

    # Load the Intel Python module
    module load apps/python/3.11.8

    # Set the number of OpenMP threads to be used equal to the Slurm allocated CPUs
    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

    # Run the program
    cd $HOME/phonopy-NaCl
    python NaCl.py


It will run the calculation on 20 cores on a single node using OpenMP
parallelization. It should take less than a minute, and yield results that
closely match the website.

.. image:: images/phonopy_nacl.png

The bottom right-hand plot show the CPU and memory usage throughout the
calculation, topping out at 2000% (100% x 20 cores) and ~1.25 GB, respectively.
