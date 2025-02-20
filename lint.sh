#!/bin/bash

echo "Running isort..."
isort app.py server_app.fcgi

echo "Running mypy..."
mypy app.py server_app.fcgi

echo "Running flake8..."
flake8 app.py server_app.fcgi

echo "Running black..."
black app.py server_app.fcgi

echo "Done."