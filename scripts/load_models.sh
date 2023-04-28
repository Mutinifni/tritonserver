#!/bin/bash

# Load all models in the model repo
# Looks in the model repo provided as first parameter
# Assuming that model repo is in the working directory

for path in "${PWD}/$1"/*
do
  f=$(basename "$path")
  # Load and unload models to get an idea of cold and warm start times
  ./scripts/load_unload.sh $f
done
