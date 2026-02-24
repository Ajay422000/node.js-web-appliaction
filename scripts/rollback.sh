#!/bin/bash
set -e

CLUSTER_NAME="nodejs-cluster"
SERVICE_NAME="nodejs-service"
REGION="ap-south-1"

echo "Fetching previous task definition..."

TASK_DEFINITION=$(aws ecs describe-services \
  --cluster $CLUSTER_NAME \
  --services $SERVICE_NAME \
  --region $REGION \
  --query "services[0].taskDefinition" \
  --output text)

PREVIOUS_REVISION=$(echo $TASK_DEFINITION | awk -F: '{print $2-1}')

aws ecs update-service \
  --cluster $CLUSTER_NAME \
  --service $SERVICE_NAME \
  --task-definition nodejs-task:$PREVIOUS_REVISION \
  --region $REGION

echo "Rollback completed!"