#!/bin/bash

dir=$(pwd)

git pull

cd ../Continuous-CBS

git checkout master
git pull
cmake .
make

cd $dir

./run.sh ../Continuous-CBS
./extract.sh ../Continuous-CBS ../results/original

cd ../Continuous-CBS

rm CMakeCache.txt
rm -r CMakeFiles

git checkout dev
git pull
cmake .
make

cd $dir

./run.sh ../Continuous-CBS
./extract.sh ../Continuous-CBS ../results/rtree
