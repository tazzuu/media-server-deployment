#!/bin/bash
set -euo pipefail

multipass info devserver --format json | jq -r .info.devserver.ipv4[0]