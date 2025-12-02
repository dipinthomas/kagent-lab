# Step 1: Manual Troubleshooting - Pod CrashLoopBackOff

## Overview

In this step, you'll manually troubleshoot a pod that's stuck in `CrashLoopBackOff` state. This is one of the most common Kubernetes issues you'll encounter in production.

## Setup Problem 1 ( RUN THIS SCRIPT as part of lab set-up)
Before starting, set up the broken pod scenario:

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-1.sh
```

This will deploy a deployment with a missing ConfigMap, causing its pods to crash.

## The Problem , this is the prompt for the students to troubleshoot.

A deployment named `crashloop-app` has pods that keep crashing. Let's find out why.

## Manual Troubleshooting Process

### 1. Check Pod Status

```bash
kubectl get pods -n default
```

**Expected Output:**
```
NAME                              READY   STATUS             RESTARTS   AGE
crashloop-app-xxx-xxxxx           0/1     CrashLoopBackOff   5          2m
```

The pod is clearly in `ContainerCreating` state, meaning it starts, crashes, and Kubernetes keeps trying to restart it.

**Note**: The pod name will have a hash suffix (e.g., `crashloop-app-7d8f9b5c4-xk2p9`) because it's created by a Deployment.

### 2. Describe the Pod

Get detailed information about the pod. First, get the exact pod name:

```bash
POD_NAME=$(kubectl get pods -n default -l app=crashloop-app -o jsonpath='{.items[0].metadata.name}')
kubectl describe pod $POD_NAME -n default
```

Or use the label selector directly:

```bash
kubectl describe pod -l app=crashloop-app -n default
```

**Look for these sections:**
- **Events**: Shows what happened during pod lifecycle
- **Conditions**: Current pod conditions
- **Volumes**: Mounted volumes and ConfigMaps

**Expected Output (Events section):**
```
Events:
  Type     Reason     Age                From               Message
  ----     ------     ----               ----               -------
  Normal   Scheduled  2m                 default-scheduler  Successfully assigned default/crashloop-app-xxx-xxxxx to node-1
  Warning  Failed     2m                 kubelet           Error: configmap "app-config" not found
  Normal   Pulled     2m                 kubelet           Container image "nginx:latest" pulled successfully
  Warning  Failed     2m                 kubelet           Error: configmap "app-config" not found
```

**Key Finding**: The error message shows `configmap "app-config" not found`

### 3. Check Pod Logs

Even though the pod is crashing, we can check logs from the last attempt:

```bash
kubectl logs -l app=crashloop-app -n default
```

**Expected Output:**
```
Error from server (BadRequest): container "app" in pod "crashloop-app-xxx-xxxxx" is waiting to start: trying and failing to pull image
```

Or you might see application-specific errors. The `describe` output is usually more informative.

### 4. Check the Deployment Manifest

Let's see what the deployment is trying to mount. Check the deployment spec:

```bash
kubectl get deployment crashloop-app -n default -o yaml | grep -A 15 "volumes:"
```

Or check the pod directly:

```bash
kubectl get pod -l app=crashloop-app -n default -o yaml | grep -A 10 "volumes:"
```

**Expected Output:**
```yaml
volumes:
- name: config
  configMap:
    name: app-config
```

The pod is trying to mount a ConfigMap named `app-config` that doesn't exist.

### 5. Verify ConfigMap Doesn't Exist

```bash
kubectl get configmap app-config -n default
```

**Expected Output:**
```
Error from server (NotFound): configmaps "app-config" not found
```

**Confirmed**: The ConfigMap `app-config` is missing.

### 6. Fix the Problem

Create the missing ConfigMap:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-configmap.yaml
```

Or create it manually:

```bash
kubectl create configmap app-config -n default \
  --from-literal=APP_ENV=production \
  --from-literal=APP_DEBUG=false
```

### 7. Verify the Fix

Wait a few seconds and check the pod status:

```bash
kubectl get pods -n default
```

**Expected Output:**
```
NAME                              READY   STATUS    RESTARTS   AGE
crashloop-app-xxx-xxxxx           1/1     Running   0          30s
```

**Success!** The pod is now running. You can also check the deployment:

```bash
kubectl get deployment crashloop-app -n default
```

**Expected Output:**
```
NAME            READY   UP-TO-DATE   AVAILABLE   AGE
crashloop-app   1/1     1            1           5m
```

The deployment now shows `READY: 1/1`, meaning the pod is running successfully.

## Time Tracking

**Record your time**: How long did this take? (Typical: 5-7 minutes)

## Quiz Questions

**Question 1**: What was the root cause of the CrashLoopBackOff?

**Options**:
- A) Pod image pull failure
- B) Missing ConfigMap
- C) Insufficient memory
- D) Wrong namespace

**Answer: B) Missing ConfigMap**

---

**Question 2**: Which kubectl command is most useful for diagnosing CrashLoopBackOff?

**Options**:
- A) `kubectl get pods`
- B) `kubectl describe pod`
- C) `kubectl logs`
- D) `kubectl top pod`

**Answer: B) `kubectl describe pod`**

The `describe` command shows events and conditions that reveal the root cause.

---

**Question 3**: How many steps did you need to diagnose this issue manually?

**Options**:
- A) 2-3 steps
- B) 4-6 steps
- C) 7-10 steps
- D) More than 10 steps

**Answer: B) 4-6 steps**

You needed to check status, describe pod, check logs, verify ConfigMap, and fix it.

## Key Takeaways

- CrashLoopBackOff requires multiple kubectl commands to diagnose
- The `describe` command is crucial for seeing events
- Missing ConfigMaps/Secrets are common causes
- Manual troubleshooting requires deep kubectl knowledge

## Summary

You've successfully diagnosed and fixed a CrashLoopBackOff issue manually. This took approximately **5-7 minutes** and required:
- ✅ Understanding pod statuses
- ✅ Reading kubectl describe output
- ✅ Identifying missing resources
- ✅ Creating the missing ConfigMap

**In the next steps**, you'll troubleshoot more issues manually, then see how Kagent solves all of them in seconds!

---

**Next Step**: [Step 2: Manual Troubleshooting - Service Routing Issue](02-manual-service-routing.md)

