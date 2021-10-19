#!/bin/bash

dir=$(pwd)

# move to CCBS directory
cd $1

# get number of processors
n=$(nproc --all)

# get all original instance files
find "Instances" -name all -prune -o -name \*.xml -not -name \*map.xml -print | xargs -I{} -n1 -P$n "$dir/run_instance.sh" {} $dir
