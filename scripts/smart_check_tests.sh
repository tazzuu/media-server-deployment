#!/bin/bash
#set -euo pipefail

# Check SMART test history and status for all drives

for drive in $(sudo smartctl --scan | awk '{print $1}'); do
  echo ">>> Getting Test History for: $drive"
  sudo smartctl --log selftest "$drive"
done
