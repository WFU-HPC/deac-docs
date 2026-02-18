#!/bin/bash
#SBATCH --job-name="Lumerical FDTD"     # Name that appears in queue
#SBATCH --partition=large               # Resource group (small/medium/large)
#SBATCH --nodes=2                       # Number of Nodes
#SBATCH --ntasks-per-node=32            # Number of tasks (MPI processes)
#SBATCH --mem-per-cpu=3G                # Requested memory
#SBATCH --time=00-01:00:00              # Job duration in DD-hh:mm:ss


# Convenient environment variables
export SCRATCH="/scratch/$SLURM_JOB_ID"
export EXAMPLE="/deac/opt/rocky9-noarch/lumerical/examples/2D_Polarization_Splitting_Grating_Couplers"

# Copy the example to the scratch directory
cp -r $EXAMPLE ${SCRATCH}/couplers

# Change into the scratch directory
cd ${SCRATCH}/couplers

# Load the Lumerical FDTD module
module load apps/lumerical/2025-R1.2




# Run the solver ($FDTDMPI) on the .fsp file
mpirun $FDTDMPI -checkpoint $SCRATCH ${SCRATCH}/couplers/GenO-Si2-dia-Ppol.fsp
# mpirun $FDTDMPI -checkpoint $SCRATCH ${SCRATCH}/couplers/GenO-Si2-dia-Spol.fsp
# mpirun $FDTDMPI -checkpoint $SCRATCH ${SCRATCH}/couplers/GenO-Si2-dia-Ppol_pre-opt.fsp
# mpirun $FDTDMPI -checkpoint $SCRATCH ${SCRATCH}/couplers/GenO-Si2-dia-Spol_pre-opt.fsp
