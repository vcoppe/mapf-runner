#!/bin/bash

# get this directory
cur_dir=$(pwd)
script="$cur_dir/run_instance.sh"

# move to CCBS directory
cd $1

# update
git pull

# recompile
cmake .
make

# get number of processors
n=$(nproc --all)

# get all original instance files
find Instances -name all -prune -o -name \*.xml -not -name \*map.xml -print | parallel -P $n --bar $script {}
