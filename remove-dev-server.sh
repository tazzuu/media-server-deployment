#/bin/bash
set -eux

# teardown
multipass delete devserver
multipass purge