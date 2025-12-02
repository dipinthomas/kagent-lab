#!/bin/bash

# Setup script for Problem 2: Service Not Routing Traffic
# This script deploys a service with selector mismatch

set -e

NAMESPACE="default"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Problem 2: Service Not Routing Traffic"
echo "=================================================="
echo ""

# Create namespace if it doesn't exist
echo "Using namespace ${NAMESPACE}..."
# Note: default namespace already exists, no need to create it

echo ""
echo "Deploying broken service (selector mismatch)..."
kubectl apply -f ${SCRIPT_DIR}/broken-service.yaml

echo ""
echo "Waiting for resources to be created..."
sleep 5

echo ""
echo "Problem 2 setup complete!"
echo ""
echo "Current state:"
echo "- Service 'broken-service' exists but has no endpoints"
echo "- Root cause: Service selector expects version=v1, but pods have version=v2"
echo ""
echo "You can now proceed to Step 2 to troubleshoot this issue manually."

