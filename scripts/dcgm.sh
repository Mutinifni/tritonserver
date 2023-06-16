#!/bin/bash

# Start nvidia-dcgm and run perf_analyzer
for path in ${PWD}/perf_repo/*
do
  f=$(basename "$path")
  echo $f
  taskset -c 1,3,5,7 dcgmi dmon -d 100 -e 150,155,156,203,204 > dcgm_output/$f.csv &
  taskset -c 0,2,4,6 perf_analyzer -m $f --percentile=99 -p 10000 | tee dcgm_output/perf/$f.txt
  pkill -f dcgmi;
done

# Read all the energy values
echo > dcgm_output/energies.txt
for path in ${PWD}/perf_repo/*
do
  f=$(basename "$path")
  start=$(grep "GPU 0" dcgm_output/$f.csv | awk '{print $5}' | head -n 1)
  end=$(grep "GPU 0" dcgm_output/$f.csv | awk '{print $5}' | tail -n 1)
  echo $f >> dcgm_output/energies.txt
  echo $(expr $end - $start) >> dcgm_output/energies.txt
  echo >> dcgm_output/energies.txt
done

echo > dcgm_output/times.txt
# Read all the energy values
for path in ${PWD}/perf_repo/*
do
  f=$(basename "$path")
  requests=$(grep "Request count" dcgm_output/perf/$f.txt | awk '{print $3}')
  throughput=$(grep "Throughput" dcgm_output/perf/$f.txt | awk '{print $2}')
  echo $f >> dcgm_output/times.txt
  echo "requests:" >> dcgm_output/times.txt
  echo $requests >> dcgm_output/times.txt
  echo "throughput (inferences/s):" >> dcgm_output/times.txt
  echo $throughput >> dcgm_output/times.txt
  echo >> dcgm_output/times.txt
done
