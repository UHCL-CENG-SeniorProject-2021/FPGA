#!/bin/bash

export PYTHONPATH=$PYTHONPATH:$(pwd)/Python/    # this adds the Python folder to the path
cd cocotb_sim
make