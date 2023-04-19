#!/bin/bash

# Start and instantly kill a server, likely for timing purposes

# Start the server, send it to a text file, kill it when reading "Started GRPCInferenceService"
# Change how we start it depending on if we want to load models or not, whether we're using gpu
if [ $1 = "cpu" ]; then
  if [ $2 = "load" ]; then
    echo "Loading all models on cpu"
    docker run --gpus device=none --rm --net=host -v ${PWD}/model_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models > server_create_out.txt 2>&1 & 
          tail --pid=$! -n +1 -F server_create_out.txt | (grep -q -m 1 "Started GRPCInferenceService" && kill $!)
  else
    echo "Not loading models on cpu"
    docker run --gpus device=none --rm --net=host -v ${PWD}/model_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models --model-control-mode=explicit > server_create_out.txt 2>&1 & 
          tail --pid=$! -n +1 -F server_create_out.txt | (grep -q -m 1 "Started GRPCInferenceService" && kill $!)
  fi
else
  if [ $2 = "load" ]; then
    echo "Loading all models on gpu"
    docker run --gpus=1 --rm --net=host -v ${PWD}/model_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models > server_create_out.txt 2>&1 & 
          tail --pid=$! -n +1 -F server_create_out.txt | (grep -q -m 1 "Started GRPCInferenceService" && kill $!)
  else
    echo "Not loading models on gpu"
    docker run --gpus=1 --rm --net=host -v ${PWD}/model_repo_cpu:/models tritonserver \
      tritonserver --model-repository=/models --model-control-mode=explicit > server_create_out.txt 2>&1 & 
          tail --pid=$! -n +1 -F server_create_out.txt | (grep -q -m 1 "Started GRPCInferenceService" && kill $!)
  fi
fi

# Kill the server running on the port
sudo fuser -k 8000/tcp

# Remove the port
rm server_create_out.txt
