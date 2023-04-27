#!/bin/bash

# Start the server, send it to a text file
# Change how we start it depending on if we want to load models or not, whether we're using gpu

if [ $1 = "cpu" ]; then
  if [ $2 = "load" ]; then
    docker run --gpus device=none --rm --net=host -v ${PWD}/model_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models
  else
    docker run --gpus device=none --rm --net=host -v ${PWD}/model_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models --model-control-mode=explicit
  fi
else
  if [ $2 = "load" ]; then
    docker run --gpus=1 --rm --net=host -v ${PWD}/model_repo:/models tritonserver \
      tritonserver --model-repository=/models
  else
    docker run --gpus=1 --rm --net=host -v ${PWD}/model_repo:/models tritonserver \
      tritonserver --model-repository=/models --model-control-mode=explicit
  fi
fi

