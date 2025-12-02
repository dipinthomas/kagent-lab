# Step 0: Lab Setup - Deploy Broken Cluster State

## Overview

In this step, we'll deploy a Kubernetes cluster with 4 intentional problems. These represent common real-world issues you'll troubleshoot manually, then solve instantly with Kagent.

**Important**: Each problem will be set up individually before its corresponding troubleshooting step. This allows you to focus on one issue at a time and avoid confusion.

## Lab Setup Approach

Instead of deploying all problems at once, we'll set them up one by one:

1. **Before Step 1**: Set up Problem 1 (Pod CrashLoopBackOff)
2. **Before Step 2**: Set up Problem 2 (Service routing issue)
3. **Before Step 3**: Set up Problem 3 (Resource exhaustion)
4. **Before Step 4**: Set up Problem 4 (HPA not scaling)

This approach ensures you:
- Focus on one problem at a time
- Don't get overwhelmed with multiple issues
- Can clean up after each problem if needed
- Have a clear progression through the lab

## Quick Reference

Each step will remind you to run the appropriate setup script, but here's a quick reference:

- **Problem 1**: `bash support-code/setup-problem-1.sh`
- **Problem 2**: `bash support-code/setup-problem-2.sh`
- **Problem 3**: `bash support-code/setup-problem-3.sh`
- **Problem 4**: `bash support-code/setup-problem-4.sh`

## Optional: Deploy All at Once

If you prefer to set up all problems at once (for convenience), you can use:

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-broken-cluster.sh
```

**Note**: This is optional. The recommended approach is to set up each problem individually before its troubleshooting step.

### What This Script Does

The script will:
1. Use the `default` namespace (already exists)
2. Deploy a deployment with missing ConfigMap (Problem 1)
3. Deploy a service with selector mismatch (Problem 2)
4. Deploy a memory-hungry pod (Problem 3)
5. Deploy HPA with ResourceQuota limiting scaling (Problem 4)

### Expected Output

```bash
Using namespace default...

Deploying broken deployment (missing ConfigMap)...
deployment/crashloop-app created

Deploying broken service (selector mismatch)...
service/broken-service created
deployment/broken-service-deployment created

Deploying memory-hungry pod...
deployment/memory-hungry-app created

Deploying HPA with ResourceQuota issue...
deployment/hpa-app created
horizontalpodautoscaler.autoscaling/hpa-app created
resourcequota/hpa-quota created

Setup complete! All broken scenarios deployed.
```

## Verify Broken State

Let's quickly check that all problems are present:

```bash
# Check the namespace
kubectl get namespace default

# Check pods (should see CrashLoopBackOff)
kubectl get pods -n default

# Check services
kubectl get svc -n default

# Check HPA
kubectl get hpa -n default
```

### Expected Observations

You should see:
- **Deployment with pods in CrashLoopBackOff**: `crashloop-app`
- **Service with no endpoints**: `broken-service` (0/0 endpoints)
- **Memory-hungry pod**: `memory-hungry-app-*` consuming resources
- **HPA not scaling**: `hpa-app` HPA shows desired < minReplicas

## Time Tracking

**Start your timer now!** We'll track how long manual troubleshooting takes vs. Kagent.

## What's Next?

You're now ready to start manual troubleshooting. Each problem will take approximately 5-7 minutes to diagnose and fix manually.

---

**Next Step**: [Step 1: Manual Troubleshooting - Pod CrashLoopBackOff](01-manual-pod-crashloop.md)

