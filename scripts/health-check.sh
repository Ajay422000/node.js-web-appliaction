#!/bin/bash
set -e

URL="http://your-load-balancer-url/health"

echo "Checking application health..."

HTTP_STATUS=$(curl -s -o /dev/null -w "%{http_code}" $URL)

if [ "$HTTP_STATUS" -ne 200 ]; then
  echo "Application health check failed!"
  exit 1
fi

echo "Application is healthy!"