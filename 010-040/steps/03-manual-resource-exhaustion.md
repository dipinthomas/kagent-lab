# Step 3: Manual Troubleshooting - Resource Exhaustion

## Overview

In this step, you'll manually investigate which pods are consuming excessive resources and causing cluster resource exhaustion. This is critical for maintaining cluster health and performance.

## Setup Problem 3 ( RUN THIS SCRIPT as part of lab set-up)

Before starting, set up the resource exhaustion scenario:

NOTE: Change the resource request based on the node that is available in the lab.

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-3.sh
```

This will deploy a memory-hungry pod consuming excessive resources.

## The Problem

The cluster is running low on resources. You need to identify which pods are consuming the most memory and CPU.

## Manual Troubleshooting Process

### 1. Check Node Resource Usage

First, let's see overall node resource consumption:

```bash
kubectl top nodes
```

**Expected Output:**
```
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
node-1     3500m        87%    8Gi             95%
node-2     1200m        30%    3Gi             40%
```

Node-1 is at 95% memory usage - very high!

### 2. Check Pod Resource Usage

Let's see which pods are consuming the most resources:

```bash
kubectl top pods -n default --sort-by=memory
```

**Expected Output:**
```
NAME                                    CPU(cores)   MEMORY(bytes)
memory-hungry-app-xxx-xxxxx             100m         2.5Gi
broken-service-deployment-xxx-xxxxx     50m          128Mi
crashloop-app-xxx-xxxxx                 10m          64Mi
```

**Found it!** The `memory-hungry-app` pod is using 2.5Gi of memory.

### 3. Describe the Problematic Pod

Get more details about the memory-hungry pod:

```bash
kubectl describe pod -l app=memory-hungry -n default
```

**Look for resource requests and limits:**

**Expected Output:**
```
Name:         memory-hungry-app-xxx-xxxxx
...
Containers:
  app:
    Image:          nginx:latest
    Limits:
      memory:       4Gi
    Requests:
      memory:       2Gi
    ...
```

The pod has high memory requests (2Gi) and limits (4Gi).

### 4. Check Node Events

See if there are any resource-related events:

```bash
kubectl describe node node-1 | grep -A 10 "Events:"
```

**Expected Output:**
```
Events:
  Type     Reason            Age                From               Message
  ----     ------            ----               ----               -------
  Warning  SystemOOMKilled   5m                 kubelet            Pod memory-hungry-app-xxx-xxxxx was OOMKilled
  Warning  Evicted           3m                 kubelet            Pod memory-hungry-app-xxx-xxxxx was evicted due to memory pressure
```

**Confirmed**: The pod has been OOMKilled (Out of Memory killed) and evicted due to memory pressure.

### 5. Check All Namespaces

Let's see resource usage across all namespaces:

```bash
kubectl top pods --all-namespaces --sort-by=memory | head -10
```

**Expected Output:**
```
NAMESPACE                NAME                                    CPU(cores)   MEMORY(bytes)
default     memory-hungry-app-xxx-xxxxx             100m         2.5Gi
kube-system             kube-proxy-xxx                           50m          128Mi
kube-system             coredns-xxx                              20m          64Mi
...
```

The memory-hungry pod is the top consumer.

### 6. Check Deployment Resource Configuration

Let's see the deployment's resource configuration:

```bash
kubectl get deployment memory-hungry-app -n default -o yaml | grep -A 15 "resources:"
```

**Expected Output:**
```yaml
resources:
  requests:
    memory: "2Gi"
    cpu: "500m"
  limits:
    memory: "4Gi"
    cpu: "1000m"
```

The deployment is requesting 2Gi memory and allowing up to 4Gi - very high for a simple app.

### 7. Check Node Capacity

See what the node can actually provide:

```bash
kubectl describe node node-1 | grep -A 5 "Capacity:"
```

**Expected Output:**
```
Capacity:
  cpu:                4
  memory:             8Gi
  pods:               110
Allocatable:
  cpu:                3.5
  memory:             7.5Gi
  pods:               110
```

The node has 7.5Gi allocatable memory, and the memory-hungry pod is using 2.5Gi (33% of the node!).

### 8. Fix the Problem

Reduce the memory requests and limits for the deployment:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-resource-limits.yaml
```

Or patch the deployment:

```bash
kubectl patch deployment memory-hungry-app -n default -p '{"spec":{"template":{"spec":{"containers":[{"name":"app","resources":{"requests":{"memory":"128Mi","cpu":"100m"},"limits":{"memory":"256Mi","cpu":"200m"}}}]}}}}'
```

### 9. Wait for Pod Recreation

The deployment will recreate pods with new resource limits:

```bash
kubectl rollout status deployment/memory-hungry-app -n default
```

### 10. Verify Resource Usage

Check if resource usage has decreased:

```bash
kubectl top pods -n default
```

**Expected Output:**
```
NAME                                    CPU(cores)   MEMORY(bytes)
memory-hungry-app-xxx-xxxxx             50m          180Mi
broken-service-deployment-xxx-xxxxx     50m          128Mi
crashloop-app-xxx-xxxxx                 10m          64Mi
```

**Success!** Memory usage dropped from 2.5Gi to 180Mi.

### 11. Check Node Status Again

```bash
kubectl top nodes
```

**Expected Output:**
```
NAME       CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%
node-1     2000m        50%    4Gi             50%
node-2     1200m        30%    3Gi             40%
```

Node-1 memory usage dropped from 95% to 50%!

## Time Tracking

**Record your time**: How long did this take? (Typical: 5-7 minutes)

## Quiz Questions

**Question 1**: Which command is most useful for identifying resource-hungry pods?

**Options**:
- A) `kubectl get pods`
- B) `kubectl top pods --sort-by=memory`
- C) `kubectl describe pod`
- D) `kubectl logs`

**Answer: B) `kubectl top pods --sort-by=memory`**

This command shows actual resource consumption sorted by memory.

---

**Question 2**: What does OOMKilled mean?

**Options**:
- A) Out of Memory - pod was killed due to exceeding memory limits
- B) Out of Metrics - metrics collection failed
- C) Out of Mode - pod mode is incorrect
- D) Out of Mount - volume mount failed

**Answer: A) Out of Memory - pod was killed due to exceeding memory limits**

OOMKilled means the pod exceeded its memory limit and was terminated by the kernel.

---

**Question 3**: What's the relationship between resource requests and limits?

**Options**:
- A) Requests must equal limits
- B) Limits must be greater than or equal to requests
- C) Requests must be greater than limits
- D) They're unrelated

**Answer: B) Limits must be greater than or equal to requests**

Limits define the maximum resources a pod can use, while requests define what it needs. Limits should be >= requests.

## Key Takeaways

- Resource exhaustion requires checking multiple metrics
- `kubectl top` is essential for resource troubleshooting
- OOMKilled events indicate memory limit violations
- Resource requests/limits should be set appropriately
- High resource usage can affect entire nodes

## Summary

You've successfully identified and fixed a resource exhaustion issue manually. This took approximately **5-7 minutes** and required:
- ✅ Understanding resource metrics
- ✅ Identifying resource-hungry pods
- ✅ Analyzing node capacity
- ✅ Adjusting resource requests/limits

**Total manual troubleshooting time so far**: ~15-21 minutes

---

**Next Step**: [Step 4: Manual Troubleshooting - HPA Not Scaling](04-manual-hpa-scaling.md)

