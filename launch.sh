#!/bin/bash

./run.sh ../Continuous-CBS CCBS-original
./extract.sh ../Continuous-CBS original

./run.sh ../Continuous-CBS CCBS-rtree
./extract.sh ../Continuous-CBS rtree
