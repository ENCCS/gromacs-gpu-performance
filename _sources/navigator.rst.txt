Understanding Navigator GPU nodes
=========================================

.. questions::

   - What hardware is available on Navigator's GPU nodes?
   - How do we organize computational work to go where it should?

.. objectives::

   - Understand that the time to transfer data between compute units is finite
   - Understand that managing the locality of data (and the tasks that use them) is critical for performance

Trends in HPC hardware in 2021
------------------------------

Most of the compute performance in new clusters and supercomputers
will be made available in the form of GPUs that accompany the
CPUs. Many applications, including GROMACS, have been ported to run on
GPUs. The dominant GPU vendor in HPC is Nvidia, and their CUDA
programming framework is close to ubiquitous in HPC applications like
GROMACS. Recently, AMD and Intel have both won major contracts around
the world to deliver GPU-enabled machines, so the future will be
interesting.

All such machines have the same general characteristics. There are
many CPU cores, perhaps separated into a few sockets. There are a
handful of GPUs, each with thousands of cores less powerful than the
CPU cores. The GPUs are able to transfer data to nearby parts of the
CPU, or to other GPUs.

Navigator GPU nodes
-------------------

In this workshop we will focus on the GPU nodes of the supercomputer
Navigator, located at LAC in Portugal
(see https://www.uc.pt/lca/ClusterResources/Navigator).
It has 4 nodes with GPUs, and there are 2 GPUs on each node.
Like nearly all modern hardware, it
is built around the notion of *non-uniform memory access* (NUMA). Some
parts of the memory are closer to a particular core than any other.
To get best performance, users and programmers need to make sure that
tasks are allocated to cores and GPUs that prefer the same memory.

.. figure:: lstopo-outputs/navigator-hpc-only.png
   :align: center

   Slightly simplified output of ``lstopo`` on a Navigator GPU node. The
   20 cores are divided evenly across 2 sockets ("packages") and both
   GPUs are located on the first socket.
   Compute resources in one socket are closer together than they are to
   resources in the other socket.

.. challenge:: 1.1 Quiz: Which range of CPU cores would be least
   effective to use in work related to ``card2``?

   1. Cores 0-9
   2. Cores 10-19
   3. Cores 20-29
   4. Cores 30-39

.. solution::

   3. (or 4.) Cores 20-39 in NUMANode 2 and 3 prefer to use different
      memory than ``card2``. Data transfer will be less efficient.

Running jobs on Navigator
-------------------------

When requesting GPU nodes on Navigator, a number of CPUs and GPUs are
requested. The SLURM job scheduler is capable of quite complex
assignments, but today we'll keep it simple and focus solely on jobs
that have one or more GPUs and matching groups of 20 CPU cores.

For example (adapted from
https://www.uc.pt/lca/ClusterResources/Navigator/running)
to get a single GPU, 20 nearby CPU cores and some memory for 10
minutes using the project for this workshop, we could use a job script
like

.. code-block:: bash

    #!/bin/bash

    #SBATCH --account training
    #SBATCH --nodes 1          # One node
    #SBATCH --ntasks 1         # One task
    #SBATCH --cpus-per-task=20 # 20 cores per task
    #SBATCH --time 0-00:20     # Runtime in D-HH:MM
    #SBATCH --partition gpu    # Use the GPU partition
    #SBATCH --gres=gpu:v100:1  # One GPU requested
    #SBATCH --mem=20GB         # Total memory requested

    export OMP_NUM_THREADS=$SLURM_CPUS_PER_TASK
    module load GROMACS/2021.3-foss-2020b

    srun gmx mdrun

If that was in a file ``run-script.sh`` then we can submit it to the
Navigator batch queue with ``sbatch run-script.sh``. For this workshop,
that will start quickly because we have a dedicated reservation.

See also
--------

* https://www.uc.pt/lca/ClusterResources/Navigator/running

.. keypoints::

   - HPC nodes have internal structure that affects performance
   - Expect to see many clusters that have multiple GPUs per node
