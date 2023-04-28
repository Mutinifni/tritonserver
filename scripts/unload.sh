#!/bin/bash

# Unload a single model
curl -v -X POST localhost:8000/v2/repository/models/"$1"/unload
