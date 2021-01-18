#!/bin/bash -l
#SBATCH --job-name=rf
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

# Make sure we don't spend time writing useless output
options="-noconfout"

# Run mdrun with the default task assignment
srun gmx_mpi mdrun $options -g default
# Run mdrun assigning the non-bonded and bonded interactions to the GPU
srun gmx_mpi mdrun $options -g manual-nb-bonded  -nb gpu -bonded gpu
# Run mdrun assigning only the non-bonded interactions to the GPU
srun gmx_mpi mdrun $options -g manual-nb         -nb gpu -bonded cpu

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
