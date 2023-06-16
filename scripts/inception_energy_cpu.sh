#!/bin/bash

# Runs the energy monitor on the server that is doing in

./scripts/start.sh cpu load inception > server_create_out.txt 2>&1 & 
          tail --pid=$! -n +1 -F server_create_out.txt | (grep -q -m 1 "Started GRPCInferenceService" && taskset -c 1-47:2 python3 ~cc/client/src/python/examples/image_client.py -m inception_v3 -s INCEPTION ~cc/server/qa/images && sudo fuser -k 8000/tcp)

