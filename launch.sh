#!/bin/bash

dir=$(pwd)

branches=( master-reverse dev-avoidance-only dev-avoidance-only-all-conflicts dev-avoidance-only-naive )

for branch in "${branches[@]}"
do
    cd ../Continuous-CBS

    git checkout $branch
    git pull
    cmake .
    make

    rm CMakeCache.txt
    rm -r CMakeFiles

    results_dir="../results/$branch-$(git rev-parse --short HEAD)"

    cd $dir

    ./run.sh ../Continuous-CBS
    ./extract.sh ../Continuous-CBS $results_dir
done
