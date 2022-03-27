#!/bin/bash

REMOTE_HOSTNAME="${1:-unsafe-curl.chriscarini.com}"

echo "Using hostname: ${REMOTE_HOSTNAME}"

echo "Enter webhost username: " && read WEBHOST_USERNAME

echo "Setup venv in remote machine..."
ssh -T "${REMOTE_HOSTNAME}" << EO_SSH
    pushd "/home/${WEBHOST_USERNAME}/${REMOTE_HOSTNAME}"
    git pull
    source venv/bin/activate
    which python3 pip
    pip install -r requirements.txt
    deactivate
    popd
    touch "/home/${WEBHOST_USERNAME}/${REMOTE_HOSTNAME}/tmp/restart.txt"
EO_SSH
