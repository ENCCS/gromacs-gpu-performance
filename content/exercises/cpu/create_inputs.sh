#!/bin/bash

mkdir ensemble_inputs

for i in $(seq 1 32); do
    dirname=""
    if [ $i -lt 10 ] ; then
        dirname="ensemble_inputs/repl_0${i}"
    else
        dirname="ensemble_inputs/repl_${i}"
    fi
    mkdir $dirname
    cp topol.tpr $dirname
done
