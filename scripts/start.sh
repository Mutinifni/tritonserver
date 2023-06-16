#!/bin/bash

# Start the server, send it to a text file
# Change how we start it depending on if we want to load models or not, whether we're using gpu

if [ $1 = "cpu" ]; then
  if [ $2 = "load" ]; then
    docker run --cpuset-cpus="0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46" --gpus device=none --rm --net=host -v ${PWD}/$3_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models
  else
    docker run --cpuset-cpus="0,2,4,6,8,10,12,14,16,18,20,22,24,26,28,30,32,34,36,38,40,42,44,46" --gpus device=none --rm --net=host -v ${PWD}/$3_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models --model-control-mode=explicit
  fi
else
  if [ $2 = "load" ]; then
    docker run --gpus=1 --rm --net=host -v ${PWD}/$3_repo:/models tritonserver \
      tritonserver --model-repository=/models
  else
    docker run --gpus=1 --rm --net=host -v ${PWD}/$3_repo:/models tritonserver \
      tritonserver --model-repository=/models --model-control-mode=explicit
  fi
fi

