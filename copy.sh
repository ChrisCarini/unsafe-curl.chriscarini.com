#!/bin/bash

REMOTE_HOSTNAME="${1:-unsafe-curl.chriscarini.com}"

echo "Using hostname: ${REMOTE_HOSTNAME}"

echo "Syncing local files to remote..."
rsync -arvz --exclude=venv --exclude=.git --exclude=.idea ./ "${REMOTE_HOSTNAME}:~/${REMOTE_HOSTNAME}"

echo "Kicking the service..."
ssh -T "${REMOTE_HOSTNAME}" "touch ~/${REMOTE_HOSTNAME}/tmp/restart.txt"