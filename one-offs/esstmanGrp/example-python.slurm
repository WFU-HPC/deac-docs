#!/bin/bash
#SBATCH --job-name="PythonJob"          # Just a name for your job
#SBATCH --nodes=1                       # Number of nodes (servers)
#SBATCH --ntasks-per-node=1             # Number of tasks (cores) per node
#SBATCH --mem=8GB                       # Requested RAM per node
#SBATCH --partition=small               # Resource group (small/large)
                                        # small: 1 node (<=64 cores), up to 24 hours
                                        # large: up to 16 nodes, up to 180 days
#SBATCH --time=00-01:00:00              # Requested time in DD-HH:MM:SS
#SBATCH --mail-user=otool23@wfu.edu     # User email
#SBATCH --mail-type=BEGIN,END,FAIL      # Sends email when beginning, ending, or failing

## Load the module
# module load apps/python/3.11.8
# or
module load envs/biology/esstmanGrp

## Go into your work path
cd /deac/bio/esstmanGrp/otool23

## Run the actual command
python3 your_script.py
