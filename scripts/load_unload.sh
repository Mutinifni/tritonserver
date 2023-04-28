#!/bin/bash

# Loads and unloads a model from a running triton server

./scripts/load.sh $1
./scripts/unload.sh $1
./scripts/load.sh $1
./scripts/unload.sh $1
