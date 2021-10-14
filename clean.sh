#!/bin/bash

# move to CCBS directory
cd $1

find Instances -name all -exec rm -rf {} \;
