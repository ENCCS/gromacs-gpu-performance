General considerations for performance
======================================

.. questions::

   - What things should I think about while setting up each simulation?

.. objectives::

   - Know common pitfalls to avoid


Designing an efficient simulation
---------------------------------

Here's a short list of things to consider when designing your
simulations, so that you will run efficiently.

* Choose a simulation cell that is the right shape, just large enough for your science and your physical model
* Otherwise, use LINCS and h-bonds constraints and 2 fs time steps
* Be aware that typical water models are designed to be rigid
* Use fast 3-site water models unless there's a clear scientific reason
* If your simulation has layers, align them to the X-Y plane, so that
  the automatic load balancing division along the Z axis works well
* If your simulation cell has some dimensions much shorter than the others,
  choose the short one(s) to be X and Y for the same reason as above.
* Write only the output you know you will use - if you don't know what output
  you will use, don't run a simulation yet!
* Write the output you need with a period that makes sense - no shorter
  than its autocorrelation time.
* Don't run your production simulation with energy output groups on -
  if you need that later, it's much more efficient to use ``gmx mdrun -rerun``
* Don't use temperature or pressuring coupling every step
* Choose ``nst*`` parameters to have a large common factor, like 10 or 100
* Use h-bond constraints and a timestep around 2 fs

See also
--------

.. keypoints::

   - The ``mdrun`` implementation is not fully general, some things run faster than others
