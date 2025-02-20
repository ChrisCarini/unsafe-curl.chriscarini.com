#!/bin/bash

echo "Setup venv in remote machine..."
which python3 pip
virtualenv venv
ln -s venv/bin/activate activate
source activate
which python3 pip
pip install -r requirements.txt
deactivate