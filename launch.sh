#!/bin/bash

dir=$(pwd)

branches=( dev-reverse )

for branch in "${branches[@]}"
do
    cd ../Continuous-CBS

    rm CMakeCache.txt
    rm -r CMakeFiles

    git checkout $branch
    git pull
    cmake .
    make

    results_dir="../results/$branch-$(git rev-parse --short HEAD)"

    cd $dir

    ./run.sh ../Continuous-CBS
    ./extract.sh ../Continuous-CBS $results_dir
done
