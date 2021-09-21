#!/bin/bash

# Add cocotb_helper folder to the path
export PYTHONPATH=$PYTHONPATH:$(pwd)/cocotb_helper/
# Add Python folder to the path
export PYTHONPATH=$PYTHONPATH:$(pwd)/Python/    # this adds the Python folder to the path
cd cocotb_sim
make