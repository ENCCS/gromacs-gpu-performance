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
# Run mdrun assigning only the non-bonded interactions to the
# GPU and PME to the CPU
srun gmx mdrun $options -g manual-nb.log           -nb gpu -pme cpu
# Run mdrun assigning the non-bonded interactions and all of
# the PME task to the GPU
srun gmx mdrun $options -g manual-nb-pmeall.log    -nb gpu -pme gpu
# Run mdrun assigning the non-bonded interactions and just
# the first part of the PME task to the GPU
srun gmx mdrun $options -g manual-nb-pmefirst.log  -nb gpu -pme gpu -pmefft cpu

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
