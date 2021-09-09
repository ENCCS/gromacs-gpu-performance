#!/bin/bash -l
#SBATCH --job-name=pme
#SBATCH --account=training
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=10GB
#SBATCH --time=00:10:00

# Load the GROMACS module and its dependencies
module load CUDA FFTW OpenBLAS ScaLAPACK Python GCC/9
source /veracruz/projects/t/training/gromacs-2021.3/bin/GMXRC
# Ensure that mdrun uses all the CPU cores well
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export SLURM_CPU_BIND=none

# Make sure we don't spend time writing useless output.
# Also make sure the time spent doing PME tuning doesn't
# go into the performance statistics, by resetting the
# counters at step 10000.
options="-ntmpi 1 -noconfout -resetstep 10000"

# Run mdrun with the default task assignment
srun gmx mdrun $options -g default
# Run mdrun assigning only the non-bonded interactions to the
# GPU and PME to the CPU
srun gmx mdrun $options -g manual-nb          **FIXME**
# Run mdrun assigning the non-bonded interactions and all of
# the PME task to the GPU
srun gmx mdrun $options -g manual-nb-pmeall   **FIXME**
# Run mdrun assigning the non-bonded interactions and just
# the first part of the PME task to the GPU
srun gmx mdrun $options -g manual-nb-pmefirst **FIXME**

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
