#!/bin/bash
prefix="drawio -x -o "
$prefix img/checking-gromacs-configuration.svg diagrams/checking-gromacs-configuration.drawio
$prefix img/forces-concurrency.svg diagrams/forces-concurrency.drawio
$prefix img/molecular-dynamics-short-range-and-pair-lists.svg diagrams/molecular-dynamics-short-range-and-pair-lists.drawio
$prefix img/molecular-dynamics-workflow-all-on-gpu.svg diagrams/molecular-dynamics-workflow-all-on-gpu.drawio
$prefix img/molecular-dynamics-workflow.svg diagrams/molecular-dynamics-workflow.drawio
$prefix img/molecular-dynamics-workflow-on-cpu-and-one-gpu.svg diagrams/molecular-dynamics-workflow-on-cpu-and-one-gpu.drawio
$prefix img/molecular-dynamics-workflow-on-cpus.svg diagrams/molecular-dynamics-workflow-on-cpus.drawio
$prefix img/molecular-dynamics-workflow-short-range-gpu-bonded-cpu.svg diagrams/molecular-dynamics-workflow-short-range-gpu-bonded-cpu.drawio
$prefix img/molecular-dynamics-workflow-short-range-gpu-bonded-gpu.svg diagrams/molecular-dynamics-workflow-short-range-gpu-bonded-gpu.drawio
$prefix img/molecular-dynamics-workflow-short-range-gpu-pme-gpu-bonded-cpu.svg diagrams/molecular-dynamics-workflow-short-range-gpu-pme-gpu-bonded-cpu.drawio
$prefix img/molecular-dynamics-workflow-short-range-gpu-pme-gpu-pmefft-cpu-bonded-cpu.svg diagrams/molecular-dynamics-workflow-short-range-gpu-pme-gpu-pmefft-cpu-bonded-cpu.drawio
