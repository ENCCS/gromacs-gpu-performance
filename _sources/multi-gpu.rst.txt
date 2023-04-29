Using multiple GPUs
===================

.. questions::

   - How one can get more performance with more than one GPU?

.. objectives::

   - Know how to use several GPUs efficiently.

Nodes with several GPUs
-----------------------

It is common to have more than one GPU in a single node.
To use them, we can leverage the domain decomposition machinery.
Indeed, it is already set up so that the communications between ranks are minimal.
So the GPUs will be assigned to ranks and do all the computations for a single domain.

.. challenge:: Run simulation on two GPUs simultaneously

   Make a new folder for this exercise, e.g. ``mkdir
   using-pme-multigpu; cd using-pme-multigpu``.
   
   :download:`Download the run input file
   <exercises/using-pme/topol.tpr>` prepared to do 20000
   steps of a PME simulation. We'll use it to experiment with task
   assignment.

   :download:`Download the job submission script
   <exercises/using-pme/many-gpus.sh>` where you will see
   several lines marked ``**FIXME**``. Remove the ``**FIXME**`` to
   achieve the goal stated in the comment before that line. You will
   need to refer to the information above to achieve that. Save the
   file and exit.

   Submit the script to the SLURM job manager with ``sbatch
   many-gpus.sh``. It will reply something like ``Submitted batch job
   4565494`` when it succeeded. The job manager will write terminal
   output to a file named like ``slurm-4565494.out``. It may take a
   few minutes to start and a few more minutes to run.

   While it is running, you can use ``tail -f slurm*out`` to watch the
   output. When it says "Done" then the runs are finished. Use Ctrl-C
   to exit the ``tail`` command that you ran.

   Once the first trajectory completes, exit ``tail`` and use ``less
   default.log`` to inspect the output. Find the "Mapping of GPU
   IDs..." Does what you read there agree with what you just learned?
   
   The ``*.log`` files contain the performance (in ns/day) of each run
   on the last line. Use ``tail *log`` to see the last chunk of each
   log file. Have a look through the log files and see what you can
   learn. What differs from log files from previous exercises? What is
   the performance gain when compared to a single GPU?

.. solution::

   You can download a :download:`working version
   <answers/using-pme/many-gpus.sh>` of the batch
   submission script. Its diff from the original is file

   .. literalinclude:: answers/using-pme/many-gpus.sh
      :diff: exercises/using-pme/many-gpus.sh   

Using direct communications between GPUs
----------------------------------------

On Puhti, GPUs are connected with NVLink. This allows them to communicate directly.
This can be explored in GROMACS, although this feature is not tested that carefully.
So use cautiously and report your experience to GROMACS developers! To enable, one
needs to set two environment variables: ``GMX_GPU_DD_COMMS`` and ``GMX_GPU_PME_PP_COMMS``.
The first will enable halo exchange between domains, the second one will allow PP and PME
ranks to communicate directly.

.. challenge:: Run simulation on two GPUs simultaneously

   :download:`Download the job submission script
   <exercises/using-pme/many-gpus-direct-comms.sh>` where you will see
   several lines marked ``**FIXME**``. Remove the ``**FIXME**`` to
   achieve the goal stated in the comment before that line. You will
   need to refer to the information above to achieve that. Save the
   file and exit.

   Submit the script to the SLURM job manager with ``sbatch
   many-gpus_direct-comms.sh``. It will reply something like ``Submitted batch job
   4565494`` when it succeeded. The job manager will write terminal
   output to a file named like ``slurm-4565494.out``. It may take a
   few minutes to start and a few more minutes to run.

   While it is running, you can use ``tail -f slurm*out`` to watch the
   output. When it says "Done" then the runs are finished. Use Ctrl-C
   to exit the ``tail`` command that you ran.

   Once the first trajectory completes, exit ``tail`` and use ``less
   default.log`` to inspect the output. Find the "Mapping of GPU
   IDs..." Does what you read there agree with what you just learned?
   
   The ``*.log`` files contain the performance (in ns/day) of each run
   on the last line. Use ``tail *log`` to see the last chunk of each
   log file. Have a look through the log files and see what you can
   learn. What differs from log files from previous exercises? What is
   the performance gain when compared to a single GPU?

.. solution::

   You can download a :download:`working version
   <answers/using-pme/many-gpus-direct-comms.sh>` of the batch
   submission script. Its diff from the original is file

   .. literalinclude:: answers/using-pme/many-gpus-direct-comms.sh
      :diff: exercises/using-pme/many-gpus-direct-comms.sh 


The most efficient way to use multi-GPU systems
-----------------------------------------------

As before, the scaling when going from one GPU to two is not linear.
This is expected: GPUs now don't have as much to compute and they have to communicate
between each other. To add to that, the communications can not be easily hidden behind
the computations. To make the best use of the resources, ensemble runs can be executed.
Try to use multi-dir approach as we did before, to see what configuration will give you the
best cumulative performance. Try to assign more than one rank to a single GPU. This will
allow to overlap communications, CPU and GPU execution more efficiently. Try to leave bonded
computation and/or update constraints to the CPU: you have 10 CPU core per single GPU and it
would be a waste to keep them idle.

.. keypoints::

   - One can use several GPUs for a single run.
   - Ensemble runs allow to overlap communications with computations thus using the resources more efficiently.
