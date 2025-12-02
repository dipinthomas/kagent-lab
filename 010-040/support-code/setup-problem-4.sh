#!/bin/bash

# Setup script for Problem 4: HPA Not Scaling
# This script deploys HPA with ResourceQuota limiting scaling

set -e

NAMESPACE="default"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Problem 4: HPA Not Scaling"
echo "====================================="
echo ""

# Create namespace if it doesn't exist
echo "Using namespace ${NAMESPACE}..."
# Note: default namespace already exists, no need to create it

echo ""
echo "Deploying ResourceQuota (limiting pods to 1)..."
kubectl apply -f ${SCRIPT_DIR}/resource-quota.yaml

echo ""
echo "Deploying HPA with deployment..."
kubectl apply -f ${SCRIPT_DIR}/hpa-deployment.yaml

echo ""
echo "Waiting for resources to be created..."
sleep 5

echo ""
echo "Problem 4 setup complete!"
echo ""
echo "Current state:"
echo "- HPA 'hpa-app' wants minimum 3 replicas but only 1 is running"
echo "- Root cause: ResourceQuota 'hpa-quota' limits pods to 1"
echo ""
echo "You can now proceed to Step 4 to troubleshoot this issue manually."

