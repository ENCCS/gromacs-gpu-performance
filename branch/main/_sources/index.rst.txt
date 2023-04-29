GROMACS GPU performance
================================================

In this workshop, we will examine how GROMACS uses GPUs and
how you as a user can get the best value from that.

.. prereq::

   Experience running production simulations with GROMACS. General
   concepts will be introduced with brief descriptions that should be
   familiar to experienced MD users. Links to the GROMACS
   documentation will be used frequently.


.. csv-table::
   :widths: auto
   :delim: ;

   20 min ; :doc:`introduction`
   20 min ; :doc:`puhti`
   40 min ; :doc:`md-algorithm`
   50 min ; :doc:`using-pme`
   15 min ; :doc:`general-considerations`

.. toctree::
   :hidden:
   :maxdepth: 1
   :caption: The lesson

   introduction
   puhti
   cpu-runs
   md-algorithm
   using-pme
   multi-gpu
   general-considerations


.. toctree::
   :maxdepth: 1
   :caption: Reference

   quick-reference
   guide



.. _learner-personas:

Who is the course for?
----------------------

This material is targeted towards researchers who already have
experience with GROMACS and who would like to learn how to improve
simulation performance when running on GPUs.



About the course
----------------

This lesson material is developed by the `EuroCC National Competence
Center Sweden (ENCCS) <https://enccs.se/>`_ and taught in ENCCS
workshops. It is aimed at researchers and developers who already have
production experience with GROMACS. Each lesson episode has clearly defined learning
objectives and includes multiple exercises along with solutions, and
is therefore also useful for self-learning.
The lesson material is licensed under `CC-BY-4.0
<https://creativecommons.org/licenses/by/4.0/>`_ and can be reused in any form
(with appropriate credit) in other courses and workshops.
Instructors who wish to teach this lesson can refer to the :doc:`guide` for
practical advice.

Related material
----------------

BioExcel webinars on performant simulations with GROMACS

* https://bioexcel.eu/webinar-performance-tuning-and-optimization-of-gromacs/ (based on GROMACS 2016)
* https://bioexcel.eu/webinar-more-bang-for-your-buck-improved-use-of-gpu-nodes-for-gromacs-2018-2019-09-05/
* https://bioexcel.eu/webinar-6-best-bang-for-your-buck-optimizing-cluster-and-simulation-setup-for-gromacs-7-september-2016/
* https://bioexcel.eu/webinar-mdbenchmark-a-tedious-task-made-straightforward-2018-11-23/

Publications with useful information for fast GROMACS simulations

* "Heterogeneous parallelization and acceleration of molecular dynamics simulations in GROMACS" https://doi.org/10.1063/5.0018516
* "More bang for your buck: Improved use of GPU nodes for GROMACS 2018" https://doi.org/10.1002/jcc.26011
* "Best bang for your buck: GPU nodes for GROMACS biomolecular simulations" https://doi.org/10.1002/jcc.24030

Credits
-------

The lesson file structure and browsing layout is inspired by and derived from
`work <https://github.com/coderefinery/sphinx-lesson>`_ by `CodeRefinery
<https://coderefinery.org/>`_ licensed under the `MIT license
<http://opensource.org/licenses/mit-license.html>`_. We have copied and adapted
most of their license text.

Instructional Material
^^^^^^^^^^^^^^^^^^^^^^

All ENCCS instructional material is made available under the `Creative Commons
Attribution license (CC-BY-4.0)
<https://creativecommons.org/licenses/by/4.0/>`_. The following is a
human-readable summary of (and not a substitute for) the `full legal text of the
CC-BY-4.0 license <https://creativecommons.org/licenses/by/4.0/legalcode>`_.
You are free:

- to **share** - copy and redistribute the material in any medium or format
- to **adapt** - remix, transform, and build upon the material for any purpose,
  even commercially.

The licensor cannot revoke these freedoms as long as you follow these license terms:

- **Attribution** - You must give appropriate credit (mentioning that your work
  is derived from work that is Copyright (c) ENCCS and, where practical, linking
  to `<https://enccs.se>`_), provide a `link to the license
  <https://creativecommons.org/licenses/by/4.0/>`_, and indicate if changes were
  made. You may do so in any reasonable manner, but not in any way that suggests
  the licensor endorses you or your use.
- **No additional restrictions** - You may not apply legal terms or
  technological measures that legally restrict others from doing anything the
  license permits. With the understanding that:

  - You do not have to comply with the license for elements of the material in
    the public domain or where your use is permitted by an applicable exception
    or limitation.
  - No warranties are given. The license may not give you all of the permissions
    necessary for your intended use. For example, other rights such as
    publicity, privacy, or moral rights may limit how you use the material.
  
Software
^^^^^^^^

Except where otherwise noted, the example programs and other software provided
by ENCCS are made available under the `OSI <http://opensource.org/>`_-approved
`MIT license <http://opensource.org/licenses/mit-license.html>`_.



