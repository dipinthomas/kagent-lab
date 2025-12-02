# Step 2: Manual Troubleshooting - Service Routing Issue

## Overview

In this step, you'll manually troubleshoot a service that exists but isn't routing traffic to any pods. This is a common networking issue in Kubernetes.

## Setup Problem 2 ( RUN THIS SCRIPT as part of lab set-up)

Before starting, set up the broken service scenario:

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-2.sh
```

This will deploy a service with a selector mismatch, preventing it from routing traffic.

## The Problem

A service named `broken-service` exists, but when you try to access it, there's no response. The service has no endpoints.

Command to test 

```
kubectl run test-pod --image=curlimages/curl --rm -i --restart=Never -n default -- curl -s http://broken-service:80
```

## Manual Troubleshooting Process

### 1. Check Service Status

```bash
kubectl get svc broken-service -n default
```

**Expected Output:**
```
NAME             TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)   AGE
broken-service   ClusterIP   10.96.123.45    <none>        80/TCP    5m
```

The service exists, but let's check if it has endpoints.

### 2. Check Service Endpoints

```bash
kubectl get endpoints broken-service -n default
```

**Expected Output:**
```
NAME             ENDPOINTS   AGE
broken-service   <none>      5m
```

**Problem Identified**: The service has **no endpoints**, meaning no pods are matching the service selector.

### 3. Check the Service Selector

Let's see what labels the service is looking for:

```bash
kubectl get svc broken-service -n default -o yaml | grep -A 5 "selector:"
```

**Expected Output:**
```yaml
selector:
  app: web-app
  version: v1
```

The service is looking for pods with labels `app=web-app` and `version=v1`.

### 4. Check What Pods Exist

```bash
kubectl get pods -n default --show-labels
```

**Expected Output:**
```
NAME                                    READY   STATUS    AGE   LABELS
broken-service-deployment-xxx-xxxxx    1/1     Running   3m    app=web-app,version=v2
```

**Problem Found**: The pod has label `version=v2`, but the service selector requires `version=v1`!

### 5. Describe the Service

Get more details:

```bash
kubectl describe svc broken-service -n default
```

**Expected Output:**
```
Name:              broken-service
Namespace:         default
Selector:          app=web-app,version=v1
Type:              ClusterIP
IP:                10.96.123.45
Port:              <unset>  80/TCP
TargetPort:        80/TCP
Endpoints:         <none>
Events:            <none>
```

**Confirmed**: The service selector doesn't match any pods.

### 6. Check the Deployment

Let's see what labels the deployment is creating:

```bash
kubectl get deployment broken-service-deployment -n default -o yaml | grep -A 10 "labels:"
```

**Expected Output:**
```yaml
labels:
  app: web-app
  version: v2
```

The deployment creates pods with `version=v2`, but the service expects `version=v1`.

### 7. Fix the Problem

We have two options:
- **Option A**: Update the service selector to match existing pods
- **Option B**: Update the deployment labels to match the service selector

Let's fix the deployment labels to match the service:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-pod-labels.yaml
```

Or patch the deployment:

```bash
kubectl patch deployment broken-service-deployment -n default -p '{"spec":{"template":{"metadata":{"labels":{"version":"v1"}}}}}'
```

### 8. Wait for Pods to Update

The deployment will recreate pods with correct labels:

```bash
kubectl rollout status deployment/broken-service-deployment -n default
```

### 9. Verify the Fix

Check endpoints again:

```bash
kubectl get endpoints broken-service -n default
```

**Expected Output:**
```
NAME             ENDPOINTS                    AGE
broken-service   10.244.1.5:80,10.244.1.6:80   1m
```

**Success!** The service now has endpoints and can route traffic.

### 10. Test the Service

Wait a moment for the pods to be fully ready, then test the service:

```bash
# Wait for pods to be ready
kubectl wait --for=condition=ready pod -l app=web-app,version=v1 -n default --timeout=60s

# Test the service
kubectl run test-pod --image=curlimages/curl --rm -i --restart=Never -n default -- curl -s http://broken-service:80
```

**Note**: If you see a connection error, wait a few more seconds for the service endpoints to be fully registered, then try again.

**Expected Output:**
```
<!DOCTYPE html>
<html>
<head>
<title>Welcome to nginx!</title>
...
</head>
<body>
<h1>Welcome to nginx!</h1>
...
</body>
</html>
```

The service is now responding! You've successfully fixed the routing issue.

## Time Tracking

**Record your time**: How long did this take? (Typical: 5-7 minutes)

## Quiz Questions

**Question 1**: Why wasn't the service routing traffic?

**Options**:
- A) Service port was wrong
- B) Pod labels didn't match service selector
- C) Service type was incorrect
- D) Network policy was blocking traffic

**Answer: B) Pod labels didn't match service selector**

---

**Question 2**: Which command shows service endpoints?

**Options**:
- A) `kubectl get svc`
- B) `kubectl get endpoints`
- C) `kubectl describe svc`
- D) All of the above

**Answer: D) All of the above**

All commands provide endpoint information, but `kubectl get endpoints` is most direct.

---

**Question 3**: What's the relationship between service selectors and pod labels?

**Options**:
- A) They must be identical
- B) Pod labels must include all selector key-value pairs
- C) Selectors must include all pod labels
- D) They're unrelated

**Answer: B) Pod labels must include all selector key-value pairs**

For a pod to be selected by a service, the pod's labels must match all key-value pairs in the service selector.

## Key Takeaways

- Services route traffic based on label selectors
- No endpoints = selector mismatch
- Troubleshooting requires checking both service selectors and pod labels
- Label mismatches are common in multi-version deployments

## Summary

You've successfully diagnosed and fixed a service routing issue manually. This took approximately **5-7 minutes** and required:
- ✅ Understanding service selectors
- ✅ Checking pod labels
- ✅ Identifying label mismatches
- ✅ Fixing labels or selectors

**Total manual troubleshooting time so far**: ~10-14 minutes

---

**Next Step**: [Step 3: Manual Troubleshooting - Resource Exhaustion](03-manual-resource-exhaustion.md)

