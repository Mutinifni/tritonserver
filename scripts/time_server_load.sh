#!/bin/bash

# Time all different configurations of server loading

time ./scripts/start_and_kill.sh gpu load

time ./scripts/start_and_kill.sh gpu no_load

time ./scripts/start_and_kill.sh cpu load

time ./scripts/start_and_kill.sh cpu no_load
