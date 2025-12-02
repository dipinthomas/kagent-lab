# Step 4: Manual Troubleshooting - HPA Not Scaling

## Overview

In this step, you'll manually troubleshoot why a Horizontal Pod Autoscaler (HPA) cannot scale up to its minimum replica count. This is often caused by ResourceQuota limits.

## Setup Problem 4 ( RUN THIS SCRIPT as part of lab set-up, metrics server is requried for this lab)

Before starting, set up the HPA scaling issue scenario:

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-4.sh
```

This will deploy an HPA with a ResourceQuota that prevents it from scaling to the minimum replicas.

## The Problem

An HPA is configured with `minReplicas=3`, but only 1 pod is running. The HPA wants to scale up but can't. Why?

## Manual Troubleshooting Process

### 1. Check HPA Status

```bash
kubectl get hpa hpa-app -n default
```

**Expected Output:**
```
NAME      REFERENCE            TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
hpa-app   Deployment/hpa-app    <unknown>/80%  3         10        1          5m
```

**Problem Identified**: 
- `MINPODS` is 3 (HPA wants minimum 3 replicas)
- `REPLICAS` is 1 (only 1 pod is running)
- The HPA cannot scale up to meet the minimum

### 2. Describe the HPA

Get detailed information:

```bash
kubectl describe hpa hpa-app -n default
```

**Expected Output:**
```
Name:                                                  hpa-app
Namespace:                                             default
Reference:                                             Deployment/hpa-app
Metrics:                                               ( current / target )
  resource cpu on pods  (as a percentage of request):  <unknown> / 80%
Min replicas:                                          3
Max replicas:                                          10
Deployment pods:                                        1 current / 3 desired
Conditions:
  Type            Status  Reason            Message
  ----            ------  ------            -------
  AbleToScale     False   FailedGetScale   the HPA controller was unable to get the target's current scale
  ScalingActive   False   FailedGetScale   the HPA controller was unable to get the target's current scale
```

**Key Finding**: The HPA shows `1 current / 3 desired` but can't scale.

### 3. Check Deployment Status

Let's see what the deployment is trying to do:

```bash
kubectl get deployment hpa-app -n default
```

**Expected Output:**
```
NAME      READY   UP-TO-DATE   AVAILABLE   AGE
hpa-app   1/3     1            1           5m
```

**Problem**: The deployment wants 3 replicas (`UP-TO-DATE: 1` means only 1 is running).

### 4. Check Deployment Events

```bash
kubectl describe deployment hpa-app -n default
```

**Look for Events section:**

**Expected Output:**
```
Events:
  Type     Reason            Age                From                   Message
  ----     ------            ----               ----                   -------
  Warning  FailedCreate     2m                 replicaset-controller  Error creating: pods "hpa-app-xxx" is forbidden: exceeded quota: hpa-quota, requested: pods=1, used: pods=1, limited: pods=1
```

**Key Finding**: `exceeded quota: hpa-quota, limited: pods=1`

The ResourceQuota is limiting pods to 1!

### 5. Check ResourceQuota

Let's see the ResourceQuota configuration:

```bash
kubectl get resourcequota hpa-quota -n default
```

**Expected Output:**
```
NAME        AGE   REQUEST                                                                   LIMIT
hpa-quota   5m    pods: 1/1, requests.cpu: 500m/1, requests.memory: 512Mi/1Gi              pods: 1/1, limits.cpu: 1000m/2, limits.memory: 1Gi/2Gi
```

**Confirmed**: The ResourceQuota limits pods to 1 (`pods: 1/1`), but the HPA needs 3.

### 6. Describe the ResourceQuota

Get more details:

```bash
kubectl describe resourcequota hpa-quota -n default
```

**Expected Output:**
```
Name:            hpa-quota
Namespace:       default
Resource         Used  Hard
--------         ----  ----
limits.cpu       1000m  2
limits.memory    1Gi    2Gi
pods              1     1
requests.cpu     500m   1
requests.memory  512Mi  1Gi
```

**Problem Confirmed**: 
- `pods: 1/1` means only 1 pod is allowed
- HPA needs 3 pods minimum
- ResourceQuota is blocking the scaling

### 7. Check Pod Status

Let's see what pods exist:

```bash
kubectl get pods -n default -l app=hpa-app
```

**Expected Output:**
```
NAME                       READY   STATUS    AGE
hpa-app-xxx-xxxxx         1/1     Running   5m
```

Only 1 pod is running, and attempts to create more are blocked by the quota.

### 8. Check ReplicaSet Status

```bash
kubectl get replicaset -n default -l app=hpa-app
```

**Expected Output:**
```
NAME                 DESIRED   CURRENT   READY   AGE
hpa-app-xxx          3         1         1       5m
```

**Confirmed**: ReplicaSet wants 3 pods (`DESIRED: 3`) but only has 1 (`CURRENT: 1`).

### 9. Fix the Problem

Update the ResourceQuota to allow more pods:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-resource-quota.yaml
```

Or edit the ResourceQuota directly:

```bash
kubectl edit resourcequota hpa-quota -n default
```

Change:
```yaml
spec:
  hard:
    pods: "1"  # ❌ Too low
```

To:
```yaml
spec:
  hard:
    pods: "10"  # ✅ Allow up to 10 pods
```

### 10. Wait for Scaling

After updating the quota, the deployment should automatically scale:

```bash
kubectl get pods -n default -l app=hpa-app -w
```

**Expected Output:**
```
NAME                       READY   STATUS              AGE
hpa-app-xxx-xxxxx         1/1     Running             5m
hpa-app-xxx-yyyyy         0/1     ContainerCreating   5s
hpa-app-xxx-zzzzz         0/1     ContainerCreating   5s
```

New pods are being created!

### 11. Verify HPA Status

Check the HPA again:

```bash
kubectl get hpa hpa-app -n default
```

**Expected Output:**
```
NAME      REFERENCE            TARGETS         MINPODS   MAXPODS   REPLICAS   AGE
hpa-app   Deployment/hpa-app    45%/80%         3         10        3          6m
```

**Success!** The HPA now has 3 replicas (`REPLICAS: 3`), matching the minimum.

### 12. Verify ResourceQuota

Check the updated quota:

```bash
kubectl get resourcequota hpa-quota -n default
```

**Expected Output:**
```
NAME        AGE   REQUEST                                                                   LIMIT
hpa-quota   6m    pods: 3/10, requests.cpu: 1500m/1, requests.memory: 1536Mi/1Gi          pods: 3/10, limits.cpu: 3000m/2, limits.memory: 3Gi/2Gi
```

Now showing `pods: 3/10` - the quota allows up to 10 pods.

## Time Tracking

**Record your time**: How long did this take? (Typical: 5-7 minutes)

**Total Manual Troubleshooting Time**: ~20-28 minutes

## Quiz Questions

**Question 1**: Why couldn't the HPA scale up to 3 replicas?

**Options**:
- A) HPA configuration was wrong
- B) Deployment had wrong replica count
- C) ResourceQuota was limiting pods to 1
- D) Node had insufficient resources

**Answer: C) ResourceQuota was limiting pods to 1**

The ResourceQuota was the blocker preventing the HPA from creating more pods.

---

**Question 2**: Which command shows ResourceQuota limits?

**Options**:
- A) `kubectl get quota`
- B) `kubectl get resourcequota`
- C) `kubectl describe namespace`
- D) All of the above

**Answer: D) All of the above**

All commands can show ResourceQuota information, with `kubectl get resourcequota` being most direct.

---

**Question 3**: What's the relationship between HPA minReplicas and ResourceQuota pod limits?

**Options**:
- A) They must be equal
- B) ResourceQuota pod limit must be >= HPA minReplicas
- C) HPA minReplicas must be >= ResourceQuota pod limit
- D) They're unrelated

**Answer: B) ResourceQuota pod limit must be >= HPA minReplicas**

If ResourceQuota limits pods to fewer than HPA's minimum, the HPA cannot scale to its minimum.

---

**Question 4**: What information does `kubectl describe hpa` provide that `kubectl get hpa` doesn't?

**Options**:
- A) Current metrics values
- B) Conditions and error messages
- C) Scaling events
- D) All of the above

**Answer: D) All of the above**

The `describe` command provides detailed information including conditions, events, and metrics.

## Key Takeaways

- HPA scaling can be blocked by ResourceQuota
- Troubleshooting requires checking HPA, Deployment, ReplicaSet, and ResourceQuota
- ResourceQuota limits apply at the namespace level
- Multiple resources need to be checked to diagnose scaling issues
- This is a complex multi-resource troubleshooting scenario

## Summary

You've successfully diagnosed and fixed an HPA scaling issue manually. This took approximately **5-7 minutes** and required:
- ✅ Understanding HPA status
- ✅ Checking deployment and ReplicaSet
- ✅ Identifying ResourceQuota limits
- ✅ Understanding the relationship between HPA and ResourceQuota
- ✅ Updating ResourceQuota to allow scaling

**Total manual troubleshooting time for all 4 problems**: ~20-28 minutes

**Congratulations!** You've completed all manual troubleshooting. Now let's see how Kagent solves these same problems in seconds!

---

**Next Step**: [Step 5: Install Kagent](05-install-kagent.md)

