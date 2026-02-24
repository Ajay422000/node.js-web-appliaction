#!/bin/bash
set -e

CLUSTER_NAME="nodejs-cluster"
SERVICE_NAME="nodejs-service"
REGION="ap-south-1"

echo "Starting deployment..."

aws ecs update-service \
  --cluster $CLUSTER_NAME \
  --service $SERVICE_NAME \
  --force-new-deployment \
  --region $REGION

echo "Waiting for service to stabilize..."

aws ecs wait services-stable \
  --cluster $CLUSTER_NAME \
  --services $SERVICE_NAME \
  --region $REGION

echo "Deployment successful!"

./scripts/health-check.sh