#!/bin/bash
#SBATCH --job-name="Lumerical FDTD"     # Name that appears in queue
#SBATCH --partition=gpu_small           # Resource group (small/medium/large)
#SBATCH --nodes=1                       # Number of Nodes
#SBATCH --ntasks-per-gpu=1             # Number of tasks (MPI processes)
#SBATCH --mem=64G                       # Requested memory
#SBATCH --time=00-01:00:00              # Job duration in DD-hh:mm:ss
#SBATCH --gres="gpu:A100_40:1"          # Request 1 gpu

# Convenient environment variables
export SCRATCH="/scratch/$SLURM_JOB_ID"
export EXAMPLE="/deac/opt/rocky9-noarch/lumerical/examples/2D_Polarization_Splitting_Grating_Couplers"

# Copy the example to the scratch directory
cp -r $EXAMPLE ${SCRATCH}/couplers

# Change into the scratch directory
cd ${SCRATCH}/couplers

# Load the Lumerical FDTD module
module load apps/lumerical/2025-R1.2

# Enable MPI gpu support
export OMPI_MCA_mpi_cuda_support=1

# Run the solver ($FDTDMPI) on the .fsp file
mpirun $FDTDMPI -checkpoint $SCRATCH -gpu -t 1 ${SCRATCH}/couplers/GenO-Si2-dia-Ppol.fsp
# mpirun $FDTDMPI -checkpoint $SCRATCH -gpu -t 1 ${SCRATCH}/couplers/GenO-Si2-dia-Spol.fsp
# mpirun $FDTDMPI -checkpoint $SCRATCH -gpu -t 1 ${SCRATCH}/couplers/GenO-Si2-dia-Ppol_pre-opt.fsp
# mpirun $FDTDMPI -checkpoint $SCRATCH -gpu -t 1 ${SCRATCH}/couplers/GenO-Si2-dia-Spol_pre-opt.fsp
