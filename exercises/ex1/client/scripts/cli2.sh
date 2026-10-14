#!/bin/bash

set -e

echo "======================================"
echo " Installing Apache HTTPD"
echo "======================================"

echo "[1/4] Installing Apache..."

sudo dnf install httpd -y

echo "[2/4] Starting Apache..."

sudo systemctl start httpd

echo "[3/4] Enabling Apache at boot..."

sudo systemctl enable httpd

echo "[4/4] Deploying frontend files..."

cd "$(dirname "$0")/.."

sudo cp index.html config.js /var/www/html/

echo ""
echo "======================================"
echo " Apache started successfully"
echo "======================================"

sudo systemctl --no-pager status httpd