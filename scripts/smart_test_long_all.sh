#!/bin/bash
set -euo pipefail

# run long test for all drives
for drive in $(sudo smartctl --scan | awk '{print $1}'); do
  echo "Starting long test on $drive..."
  sudo smartctl -t long "$drive"
done


# check test status with sudo smartctl -a /dev/sdX
