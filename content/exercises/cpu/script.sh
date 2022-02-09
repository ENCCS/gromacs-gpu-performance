#!/bin/bash

#SBATCH --time=00:15:00
#SBATCH --partition=test
#SBATCH --ntasks=XX
#SBATCH --cpus-per-task=YY
#SBATCH --account=project_2003752

module purge
module load gromacs-env/2021-gpu
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK

srun gmx_mpi mdrun -ntomp $SLURM_CPUS_PER_TASK -nsteps 20000 -resetstep 19000
