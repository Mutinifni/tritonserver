#!/bin/bash

./build.py --enable-gpu --enable-logging --enable-metrics --enable-stats --enable-gpu-metrics --enable-cpu-metrics --backend tensorflow2 --backend onnxruntime --backend pytorch --endpoint=http --endpoint=grpc
