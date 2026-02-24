#!/bin/bash
set -e

echo "Installing Docker..."
sudo apt update
sudo apt install docker.io -y

echo "Installing AWS CLI..."
sudo apt install awscli -y

echo "Installing jq..."
sudo apt install jq -y

echo "Environment setup complete!"