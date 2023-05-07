#!/bin/bash

# Script to start nvidia-dcgm and run perf_analyzer

for path in ${PWD}/perf_repo/*
do
    f=$(basename "$path")
    taskset -c 1,3,5,7 dcgmi dmon -e 150,155,156,203,204 > dcgm_output/$f.csv &
    taskset -c 0,2,4,6 perf_analyzer -m $f --percentile=99
    pkill -f dcgmi;
done

