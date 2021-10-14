#!/bin/bash

# get this directory
cur_dir=$(pwd)

# move to CCBS directory
cd $1

for dir in $(find Instances -name all); do
    files="$dir/*"
    out_dir="$cur_dir/$2/$(echo $dir | cut -d"/"  -f2- | rev | cut -d"/" -f2- | rev)"
    mkdir -p $out_dir
    mv $files $out_dir
done
