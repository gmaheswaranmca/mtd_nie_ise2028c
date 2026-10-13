#!/bin/bash

set -e

# Install Python if not already installed
sudo dnf install python3 python3-pip -y

# Go to the server directory
cd "$(dirname "$0")/.."

# Install dependencies
python3 -m pip install --user fastapi uvicorn sqlalchemy

# Start FastAPI in the background
nohup python3 -m uvicorn main:app \
    --host 0.0.0.0 \
    --port 8000 \
    > app.log 2>&1 &

echo "FastAPI started on port 8000"