#!/bin/bash

# Loads and unloads a model from a running triton server

curl -v -X POST localhost:8000/v2/repository/models/"$1"/load
curl -v -X POST localhost:8000/v2/repository/models/"$1"/unload
curl -v -X POST localhost:8000/v2/repository/models/"$1"/load
curl -v -X POST localhost:8000/v2/repository/models/"$1"/unload
