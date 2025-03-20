#!/bin/bash
set -euxo pipefail

VM_NAME=devserver
SSH_KEY=dev-key.pub
THIS_DIR="$(dirname ${BASH_SOURCE})"
UBUNTU_VERSION="24.04"

multipass launch "${UBUNTU_VERSION}" \
  --name "${VM_NAME}" \
  --memory 8G \
  --cpus "$(( $(nproc) / 2 ))" \
  --disk 100G \
  --cloud-init "${THIS_DIR}/cloud-init.yaml"

cat "${SSH_KEY}" | multipass exec "${VM_NAME}" -- tee -a .ssh/authorized_keys

multipass info "${VM_NAME}"

