#!/bin/bash

xml_start="<?xml version="1.0" ?><root>"
xml_end="</root>"

# move to CCBS directory
cd $1

# recompile

cmake .
make

# loop through all original instance files
for instance in $(find Instances -name all -prune -o -name \*.xml -not -name \*map.xml -print); do
    # find corresponding map file (map.xml in same folder)
    dir=$(dirname $instance)
    map="$dir/map.xml"
    # create directory for new instances
    file=$(basename $instance | cut -f 1 -d '.')
    mkdir -p "$dir/all"
    # find max number of agents
    n=$(grep "agent" $instance -c)
    # for each number of agents
    for ((k=2; k<=$n; k++)) do
        input_file="$dir/all/$file-$k.xml"
        output_file="$dir/all/$file-$k.out"
        # create file with the k first agents
        echo $xml_start > $input_file
        grep -m$k "agent" $instance >> $input_file
        echo $xml_end >> $input_file
        # print progress
        echo $input_file
        # run CCBS on the instance
        ./CCBS $map $input_file > $output_file
        # if no solution found, break
        sol=$(grep "Soulution found: true" $output_file -c)
        if [[ sol -eq 0 ]]; then
            break
        fi
    done
done
