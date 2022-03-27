#!/bin/bash

REMOTE_HOSTNAME="${1:-unsafe-curl.chriscarini.com}"

echo "Enter webhost username: " && read WEBHOST_USERNAME

echo "Setup venv in local machine..."
python3 -m venv venv
ln -s venv/bin/activate activate
source activate
pip install -r requirements.txt
pre-commit install

echo "Setup venv in remote machine..."
ssh -T "${REMOTE_HOSTNAME}" << EO_SSH
    pushd "/home/${WEBHOST_USERNAME}/${REMOTE_HOSTNAME}"
    git clone https://github.com/ChrisCarini/unsafe-curl.chriscarini.com.git .
    which python3
    python3 -m venv venv
    source venv/bin/activate
    which python3 pip
    pip install -r requirements.txt
    deactivate
    popd
EO_SSH

deactivate