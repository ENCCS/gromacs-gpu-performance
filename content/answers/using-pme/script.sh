#!/bin/bash -l
#SBATCH --job-name=pme
#SBATCH --account=project_2000745
#SBATCH --reservation=gromacs
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=10
#SBATCH --mem-per-cpu=8000
#SBATCH --time=00:10:00

# Load the GROMACS module and its dependencies
module load gcc/9.1.0 hpcx-mpi/2.4.0 gromacs/2020.4-cuda
# Ensure that mdrun uses all the CPU cores well
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export SLURM_CPU_BIND=none

# Make sure we don't spend time writing useless output.
# Also make sure the time spent doing PME tuning doesn't
# go into the performance statistics, by resetting the
# counters at step 10000.
options="-noconfout -resetstep 10000"

# Run mdrun with the default task assignment
srun gmx_mpi mdrun $options -g default
# Run mdrun assigning only the non-bonded interactions to the
# GPU and PME to the CPU
srun gmx_mpi mdrun $options -g manual-nb           -nb gpu -pme cpu
# Run mdrun assigning the non-bonded interactions and all of
# the PME task to the GPU
srun gmx_mpi mdrun $options -g manual-nb-pmeall    -nb gpu -pme gpu
# Run mdrun assigning the non-bonded interactions and just
# the first part of the PME task to the GPU
srun gmx_mpi mdrun $options -g manual-nb-pmefirst  -nb gpu -pme gpu -pmefft cpu

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
