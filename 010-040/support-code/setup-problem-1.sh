#!/bin/bash

# Setup script for Problem 1: Pod CrashLoopBackOff
# This script deploys a pod with missing ConfigMap

set -e

NAMESPACE="default"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Setting up Problem 1: Pod CrashLoopBackOff"
echo "=========================================="
echo ""

# Create namespace if it doesn't exist
echo "Using namespace ${NAMESPACE}..."
# Note: default namespace already exists, no need to create it

echo ""
echo "Deploying broken pod (missing ConfigMap)..."
kubectl apply -f ${SCRIPT_DIR}/broken-pod.yaml

echo ""
echo "Waiting for pod to be created..."
sleep 3

echo ""
echo "Problem 1 setup complete!"
echo ""
echo "Current state:"
echo "- Deployment 'crashloop-app' has pods in CrashLoopBackOff state"
echo "- Root cause: Missing ConfigMap 'app-config'"
echo ""
echo "Check the pod status:"
kubectl get pods -n default -l app=crashloop-app
echo ""
echo "You can now proceed to Step 1 to troubleshoot this issue manually."

