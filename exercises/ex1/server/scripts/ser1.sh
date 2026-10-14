#!/bin/bash

set -e

echo "======================================"
echo " Backend EC2 - Initial Setup"
echo "======================================"

echo "[1/3] Updating Linux..."
sudo dnf update -y

echo "[2/3] Installing Git..."
sudo dnf install git -y

echo "[3/3] Cloning repository..."

cd /home/ec2-user

if [ -d "mtd_nie_ise2028c" ]; then
    echo "Repository already exists."
else
    git clone https://github.com/gmaheswaranmca/mtd_nie_ise2028c.git
fi

echo ""
echo "Backend setup completed."
echo "Repository:"
echo "/home/ec2-user/mtd_nie_ise2028c"