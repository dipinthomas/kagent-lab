# Support Code for Lab 010-010: The Power of Kagent

This directory contains all the YAML manifests and scripts needed for the "Before and After" comparison lab.

## Files Overview

### Broken Resources (Problems to Troubleshoot)

1. **`broken-pod.yaml`**
   - Deployment that references a non-existent ConfigMap
   - Causes pods to be in CrashLoopBackOff
   - Used in Step 1

2. **`broken-service.yaml`**
   - Service with selector mismatch
   - Service expects `version=v1`, pods have `version=v2`
   - Used in Step 2

3. **`memory-hungry-pod.yaml`**
   - Deployment with excessive memory requests/limits (2Gi/4Gi)
   - Causes resource exhaustion
   - Used in Step 3

4. **`hpa-deployment.yaml`**
   - Deployment with HPA (minReplicas=3)
   - HPA cannot scale due to ResourceQuota
   - Used in Step 4

5. **`resource-quota.yaml`**
   - ResourceQuota limiting pods to 1
   - Blocks HPA from scaling to 3 replicas
   - Used in Step 4

### Fix Files (Solutions)

1. **`fix-configmap.yaml`**
   - Creates the missing ConfigMap
   - Fixes Problem 1 (CrashLoopBackOff)

2. **`fix-pod-labels.yaml`**
   - Updates deployment labels to match service selector
   - Fixes Problem 2 (Service routing)

3. **`fix-resource-limits.yaml`**
   - Reduces memory requests/limits to reasonable values
   - Fixes Problem 3 (Resource exhaustion)

4. **`fix-resource-quota.yaml`**
   - Increases ResourceQuota pod limit from 1 to 10
   - Fixes Problem 4 (HPA scaling)

### Scripts

1. **`setup-problem-1.sh`**
   - Sets up Problem 1: Pod CrashLoopBackOff
   - Run before Step 1

2. **`setup-problem-2.sh`**
   - Sets up Problem 2: Service routing issue
   - Run before Step 2

3. **`setup-problem-3.sh`**
   - Sets up Problem 3: Resource exhaustion
   - Run before Step 3

4. **`setup-problem-4.sh`**
   - Sets up Problem 4: HPA not scaling
   - Run before Step 4

5. **`setup-broken-cluster.sh`** (Optional)
   - Deploys all broken scenarios at once
   - Convenience script for setting up everything at once
   - Not recommended for first-time lab completion

6. **`cleanup.sh`**
   - Removes all test resources
   - Run at the end of the lab (optional)

## Usage

### Recommended: Setup One Problem at a Time

For the best learning experience, set up each problem before its troubleshooting step:

```bash
# Before Step 1
bash support-code/setup-problem-1.sh

# Before Step 2
bash support-code/setup-problem-2.sh

# Before Step 3
bash support-code/setup-problem-3.sh

# Before Step 4
bash support-code/setup-problem-4.sh
```

### Optional: Setup All at Once

If you prefer to set up all problems at once:

```bash
bash support-code/setup-broken-cluster.sh
```

**Note**: This is optional and not recommended for first-time completion, as it can be overwhelming to see all problems at once.

### Manual Fixes (Steps 1-4)
Each step applies the corresponding fix file:
```bash
# Step 1
kubectl apply -f support-code/fix-configmap.yaml

# Step 2
kubectl apply -f support-code/fix-pod-labels.yaml

# Step 3
kubectl apply -f support-code/fix-resource-limits.yaml

# Step 4
kubectl apply -f support-code/fix-resource-quota.yaml
```

### Cleanup (Optional)
```bash
bash support-code/cleanup.sh
```

## Resource Details

### Namespace
All resources are created in the `default` namespace.

### Resource Names
- Deployment: `crashloop-app` (pods will have hash suffix like `crashloop-app-xxx-xxxxx`)
- Service: `broken-service`
- Deployment: `broken-service-deployment`
- Deployment: `memory-hungry-app`
- Deployment: `hpa-app`
- HPA: `hpa-app`
- ResourceQuota: `hpa-quota`
- ConfigMap: `app-config` (created by fix)

## Notes

- All resources use standard Kubernetes images (nginx:latest)
- Resource limits are intentionally set high/low to demonstrate problems
- The setup script creates resources in order to ensure dependencies are met
- Cleanup script removes the entire namespace for easy cleanup

