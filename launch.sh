#!/bin/bash

dir=$(pwd)

cd ../Continuous-CBS

git checkout master
git pull
cmake .
make

cd $dir

./run.sh ../Continuous-CBS
./extract.sh ../Continuous-CBS original

cd ../Continuous-CBS

git checkout dev
git pull
cmake .
make

cd $dir

./run.sh ../Continuous-CBS
./extract.sh ../Continuous-CBS rtree
