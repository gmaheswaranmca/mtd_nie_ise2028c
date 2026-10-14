#!/bin/bash

set -e

if [ -z "$1" ]; then
    echo "Usage:"
    echo "  ./03_update_base_url.sh http://<BACKEND_PUBLIC_IP>:8000"
    exit 1
fi

BASE_URL="$1"

echo "======================================"
echo " Updating Frontend BASE_URL"
echo "======================================"

cd "$(dirname "$0")/.."

echo "New BASE_URL:"
echo "$BASE_URL"

# Backup config
cp config.js config.js.bak

# Update BASE_URL
sed -i "s|^const BASE_URL = .*|const BASE_URL = \"$BASE_URL\";|" config.js

echo ""
echo "Updated config.js:"
cat config.js

echo ""
echo "Copying updated files to Apache..."

sudo cp index.html config.js /var/www/html/

echo ""
echo "Restarting Apache..."

sudo systemctl restart httpd

echo ""
echo "Apache restarted successfully."

sudo systemctl --no-pager status httpd