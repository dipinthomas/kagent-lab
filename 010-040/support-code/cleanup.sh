#!/bin/bash

# Cleanup script for Lab 010-010: The Power of Kagent
# This script removes all test resources created during the lab

set -e

NAMESPACE="default"

echo "Cleaning up lab resources..."

# Delete all lab resources from default namespace
echo "Deleting lab resources from namespace ${NAMESPACE}..."

# Delete deployments
kubectl delete deployment crashloop-app broken-service-deployment memory-hungry-app hpa-app -n ${NAMESPACE} --ignore-not-found=true

# Delete services
kubectl delete svc broken-service -n ${NAMESPACE} --ignore-not-found=true

# Delete HPA
kubectl delete hpa hpa-app -n ${NAMESPACE} --ignore-not-found=true

# Delete ResourceQuota
kubectl delete resourcequota hpa-quota -n ${NAMESPACE} --ignore-not-found=true

# Delete ConfigMap (if created)
kubectl delete configmap app-config -n ${NAMESPACE} --ignore-not-found=true

echo ""
echo "Waiting for resources to be deleted..."
sleep 5

echo ""
echo "Cleanup complete!"
echo ""
echo "Note: Kagent installation in 'kagent' namespace is left intact."
echo "Note: Only lab resources were deleted from the 'default' namespace."
echo "If you want to remove Kagent, run:"
echo "  helm uninstall kagent -n kagent"
echo "  helm uninstall kagent-crds -n kagent"

