.. contents::
   :depth: 3
..

This page is to document the software Mplus installed on the DEAC
Cluster.

https://www.statmodel.com/index.shtml

VERSION: 8.1

Installed Node: a1a-u3-c4-b8

Job Script Template
===================

| `` #!/bin/bash``
| `` #SBATCH --partition=large``
| `` #SBATCH --job-name="mplus_job-%j"``
| `` #SBATCH --constraint="mplus"``
| `` #SBATCH --nodes=1``
| `` #SBATCH --tasks-per-node=1``
| `` #SBATCH --mem=32GB``
| `` #SBATCH --time=14-00:00:00``
| `` #SBATCH --account="generalGrp"``
| `` #SBATCH --mail-type=BEGIN,END,FAIL``
| `` #SBATCH --mail-user=my_username@wfu.edu``
| `` #SBATCH --output="mplus_job-%j.o"``
| `` #SBATCH --error="mplus_job-%j.e"``
| `` ``
| `` # set up your environment``
| `` . /etc/profile.d/modules.sh``
| `` module load mplus/8.1``
| `` ``
| `` ###Now do your stuff``
