#!/bin/bash

# Setup script for Problem 3: Resource Exhaustion
# This script deploys a memory-hungry pod

set -e

NAMESPACE="default"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Problem 3: Resource Exhaustion"
echo "========================================="
echo ""

# Create namespace if it doesn't exist
echo "Using namespace ${NAMESPACE}..."
# Note: default namespace already exists, no need to create it

echo ""
echo "Deploying memory-hungry pod..."
kubectl apply -f ${SCRIPT_DIR}/memory-hungry-pod.yaml

echo ""
echo "Waiting for pod to be created..."
sleep 5

echo ""
echo "Problem 3 setup complete!"
echo ""
echo "Current state:"
echo "- Deployment 'memory-hungry-app' is consuming excessive memory (2.5Gi)"
echo "- Root cause: Pod has very high memory requests (2Gi) and limits (4Gi)"
echo ""
echo "You can now proceed to Step 3 to troubleshoot this issue manually."

