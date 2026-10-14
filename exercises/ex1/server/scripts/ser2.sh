#!/bin/bash

set -e

echo "======================================"
echo " Starting FastAPI Backend"
echo "======================================"

echo "[1/4] Installing Python..."
sudo dnf install python3 python3-pip -y

echo "[2/4] Installing Python dependencies..."

python3 -m pip install --user fastapi uvicorn sqlalchemy

echo "[3/4] Moving to server directory..."

cd "$(dirname "$0")/.."

echo "[4/4] Starting FastAPI..."

# Stop old Uvicorn process if one exists
pkill -f "uvicorn main:app" 2>/dev/null || true

nohup python3 -m uvicorn main:app \
    --host 0.0.0.0 \
    --port 8000 \
    > app.log 2>&1 &

echo ""
echo "FastAPI started in background."
echo "Port: 8000"
echo "Log: $(pwd)/app.log"
echo ""
echo "Check with:"
echo "    tail -f app.log"