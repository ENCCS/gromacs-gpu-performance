#!/bin/bash
name=navigator-hpc-only
lstopo -f --no-legend --no-factorize --no-caches -i $name.xml $name.svg
convert $name.svg $name.png
eog $name.png
