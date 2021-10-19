#!/bin/bash

# move to CCBS directory
# cd $1

# update
# git pull

# recompile
# cmake .
# make

# get number of processors
n=$(nproc --all)

# get all original instance files
find "$1/Instances" -name all -prune -o -name \*.xml -not -name \*map.xml -print | xargs -I{} -n1 -P$n ./run_instance.sh $2 {}
