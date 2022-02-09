#!/bin/bash

#SBATCH --time=00:15:00
#SBATCH --partition=gpu
#SBATCH --ntasks=2
#SBATCH --cpus-per-task=10
#SBATCH --gres=gpu:v100:2
#SBATCH --account=project_2003752
#SBATCH --reservation=gmx3

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

# Make sure we don't spend time writing useless output
options="-nsteps 20000 -resetstep 19000 -ntomp $SLURM_CPUS_PER_TASK -pin on -pinstride 1"

# Run mdrun assigning the non-bonded, PME, and update work to the GPU
srun gmx mdrun $options -g manual-nb-pme-update.log        -nb gpu -pme gpu             -update gpu
# Run mdrun assigning the non-bonded, PME, bonded, and update
# work to the GPU
srun gmx mdrun $options -g manual-nb-pme-bonded-update.log -nb gpu -pme gpu -bonded gpu -update gpu

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
