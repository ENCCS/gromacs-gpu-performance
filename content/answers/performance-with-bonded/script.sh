#!/bin/bash

#SBATCH --time=00:15:00
#SBATCH --partition=gpu
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:1
#SBATCH --account=project_2003752
#SBATCH --reservation=gmx3

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Make sure we don't spend time writing useless output
options="-nsteps 20000 -resetstep 19000 -ntomp $SLURM_CPUS_PER_TASK -pin on -pinstride 1"

# Run mdrun with the default task assignment
srun gmx mdrun $options -g default.log
# Run mdrun assigning the non-bonded and bonded interactions to the GPU
srun gmx mdrun $options -g manual-nb-bonded.log  -nb gpu -bonded gpu
# Run mdrun assigning only the non-bonded interactions to the GPU
srun gmx mdrun $options -g manual-nb.log         -nb gpu -bonded cpu

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
