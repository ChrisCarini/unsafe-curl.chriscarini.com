#!/bin/bash

REMOTE_HOSTNAME="unsafe-curl.chriscarini.com"

echo "Enter webhost username: " && read WEBHOST_USERNAME

echo "Setup venv in local machine..."
python3 -m venv venv
source venv/bin/activate
pip install -r requirements.txt

echo "Copy files over to remote machine..."
./copy.sh "${REMOTE_HOSTNAME}"

echo "Setup venv in remote machine..."
ssh -T "${REMOTE_HOSTNAME}" << EO_SSH
    pushd "/home/${WEBHOST_USERNAME}/${REMOTE_HOSTNAME}"
    which python3
    python3 -m venv venv
    source venv/bin/activate
    which pip
    pip install -r requirements.txt
    deactivate
    popd
EO_SSH

deactivate