#!/bin/bash

REMOTE_HOSTNAME="${1:-https://unsafe-curl.chriscarini.com}"

echo "++++++++++++++++"
echo "+ Testing CURL +"
echo "++++++++++++++++"
curl -s "${REMOTE_HOSTNAME}/safe_file.sh" | sh

echo "++++++++++++++++"
echo "+ Testing WGET +"
echo "++++++++++++++++"
wget -q -O- "${REMOTE_HOSTNAME}/safe_file.sh" | sh
