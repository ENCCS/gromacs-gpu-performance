#!/bin/bash -l
#SBATCH --job-name=rf
#SBATCH --account=training
#SBATCH --partition=gpu
#SBATCH --gres=gpu:v100:1
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=20
#SBATCH --mem=20GB
#SBATCH --time=00:10:00

# Load the GROMACS module and its dependencies
module load CUDA FFTW OpenBLAS ScaLAPACK Python GCC/9
source /veracruz/projects/t/training/gromacs-2021.3/bin/GMXRC
# Ensure that mdrun uses all the CPU cores well
export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
export SLURM_CPU_BIND=none

# Make sure we don't spend time writing useless output
options="-ntmpi 1 -noconfout"

# Run mdrun with the default task assignment
srun gmx mdrun $options -g default
# Run mdrun assigning the non-bonded and bonded interactions to the GPU
srun gmx mdrun $options -g manual-nb-bonded  **FIXME**
# Run mdrun assigning only the non-bonded interactions to the GPU
srun gmx mdrun $options -g manual-nb         **FIXME**

# Let us know we're done
echo Done

# Clean up files we don't care about
rm -f *cpt *edr *trr *tng *gro \#*
