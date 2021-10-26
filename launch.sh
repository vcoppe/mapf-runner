#!/bin/bash

dir=$(pwd)

# cd ../Continuous-CBS
#
# git checkout master
# git pull
# cmake .
# make
#
# results_dir="../results-$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)"
#
# cd $dir
#
# ./run.sh ../Continuous-CBS
# ./extract.sh ../Continuous-CBS $results_dir

cd ../Continuous-CBS

rm CMakeCache.txt
rm -r CMakeFiles

git checkout dev
git pull
cmake .
make

results_dir="../results-$(git rev-parse --abbrev-ref HEAD)-$(git rev-parse --short HEAD)"

cd $dir

./run.sh ../Continuous-CBS
./extract.sh ../Continuous-CBS $results_dir
