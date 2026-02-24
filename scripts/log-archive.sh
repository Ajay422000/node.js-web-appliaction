#!/bin/bash
set -e

LOG_DIR="/var/log/nodejs-app"
S3_BUCKET="ajay-log-archive"
DATE=$(date +%Y-%m-%d)

tar -czf logs-$DATE.tar.gz $LOG_DIR

aws s3 cp logs-$DATE.tar.gz s3://$S3_BUCKET/

rm logs-$DATE.tar.gz

echo "Logs archived successfully!"