# Step 6: Solve All Problems with Kagent

## Overview

Now for the exciting part! You'll solve all 4 problems using Kagent's AI-powered k8s-agent. The same issues that took 20-28 minutes manually will be solved in 2-3 minutes.

## Access the Kagent Agent

You can interact with Kagent via:
- **UI**: http://localhost:8080 (if port-forwarded)
- **CLI**: Using `kagent` CLI tool
- **API**: Direct API calls

For this lab, we'll use the UI or CLI. Let's start with the CLI.

### Port-Forward to Kagent (if not already done) [GIVE A TAB for studnets]

```bash
kubectl port-forward svc/kagent-ui -n kagent 8080:8080
```

## Problem 1: Pod CrashLoopBackOff - Solved with Kagent

# LAB Set-up: Run the script again to break the lab

```
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-1.sh
```

### Query Kagent

Ask Kagent about the crashing deployment/pod:

```bash
kagent query "Why are the pods from deployment crashloop-app in namespace default in CrashLoopBackOff state?"
```

Or via UI using agent kagent/k8s-agent, send the query: **"Why are the pods from deployment crashloop-app in namespace default in CrashLoopBackOff state?"**

send the query: **"create the configmap "app-config" with emptu data if required and perform a rolling start of the deployment in defualt namespace**"

### Expected Response

Kagent will:
1. Check deployment and pod status
2. Analyze pod events
3. Identify the missing ConfigMap
4. Provide the solution

**Response Example:**
```
The deployment "crashloop-app" in the default namespace is configured to mount a ConfigMap volume named "config" which refers to a ConfigMap called "app-config". This ConfigMap is marked as non-optional, meaning the pod cannot start without it.

However, the only ConfigMap currently present in the default namespace is "kube-root-ca.crt" which is unrelated.

The absence of the required ConfigMap "app-config" is causing the pods to fail volume mount and preventing them from running.

Recommendation and next steps:

Create or restore the ConfigMap named "app-config" in the default namespace with the expected configuration data.
Once the ConfigMap is available, the pods should be able to mount it and start successfully.
You can verify pod status changes and logs after the ConfigMap creation.
Would you like me to help you generate a ConfigMap manifest for "app-config" or proceed with other diagnostics?
```

image.png
**Time taken**: ~30 seconds (vs 5-7 minutes manually)

### Apply the Fix

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-configmap.yaml
```

---

## Problem 2: Service Not Routing Traffic - Solved with Kagent 

## Run this script as a lab set-up
```
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-2.sh
```
### Query Kagent [Provide this to the students]
 
```bash
kagent query "Why isn't the service broken-service in namespace default routing traffic to any pods?"
```

Or via UI: **"Why isn't the service broken-service in namespace default routing traffic to any pods?"**

### Expected Response

Kagent will:
1. Check service endpoints
2. Compare service selector with pod labels
3. Identify the label mismatch
4. Provide the fix

**Response Example:**
```
The two pods "broken-service-deployment-d94978f47-2l5n4" and "broken-service-deployment-d94978f47-jn26j" both have the labels:

app: web-app
version: v2
However, the service selector is:

app=web-app
version=v1
Because the pods have version=v2, they do not match the service's selector version=v1 and thus are not included as endpoints for the service.

This mismatch in labels is why the service is not routing traffic to any pods.

Next, I can review the deployment or pod template manifest to see if the service selector or pod labels are incorrectly set and suggest an approach to fix the version label mismatch. Would you like me to proceed with inspecting the deployment or pod template?
```

### Query Kagent [Provide this to the students]

via UI: **"Update service broken-service labels to match as per the deployment "**


### Query Kagent [Provide this to the students, validate fix]

via UI: **"Check the status of service now and fetch the service endpoint IP's"**

**Time taken**: ~30 seconds (vs 5-7 minutes manually)

### Apply the Fix

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-pod-labels.yaml
```

---

## Problem 3: Resource Exhaustion - Solved with Kagent

## Run this script as a lab set-up
```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-3.sh
```



### Query Kagent

```bash
kagent query "Which pods in namespace default are consuming the most memory?"
```

Or via UI: **"Which pods in namespace default are consuming the most memory?"**

### Expected Response

Kagent will:
1. Check resource usage across all pods
2. Identify the memory-hungry pod
3. Analyze resource requests/limits
4. Provide recommendations

**Response Example:**
```
The pod memory-hungry-app-xxx-xxxxx is consuming 2.5Gi of memory, which is 33% of the node's capacity.

Current resource configuration:
- Requests: memory=2Gi, cpu=500m
- Limits: memory=4Gi, cpu=1000m

This is excessive for a simple application. Recommended limits:
- Requests: memory=128Mi, cpu=100m
- Limits: memory=256Mi, cpu=200m

Solution: Update the deployment resource limits.
```

**Time taken**: ~30 seconds (vs 5-7 minutes manually)

### Apply the Fix

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-resource-limits.yaml
```

---

## Problem 4: HPA Not Scaling - Solved with Kagent

## Setup Problem 4 ( RUN THIS SCRIPT as part of lab set-up, metrics server is requried for this lab)

Before starting, set up the HPA scaling issue scenario:

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/setup-problem-4.sh
```


### Query Kagent

```bash
kagent query "Why is the HPA hpa-app in namespace default not scaling to its minimum of 3 replicas? It's currently at 1 replica."
```

Or via UI: **"Why is the HPA hpa-app in namespace default not scaling to its minimum of 3 replicas? It's currently at 1 replica."**

### Expected Response

Kagent will:
1. Check HPA status and desired vs current replicas
2. Check deployment and ReplicaSet status
3. Identify ResourceQuota limits
4. Explain the relationship and provide solution

**Response Example:**
```
The HPA hpa-app cannot scale to 3 replicas because of a ResourceQuota limit.

Current situation:
- HPA minReplicas: 3
- Current replicas: 1
- ResourceQuota hpa-quota limits pods to: 1

The ResourceQuota is blocking the HPA from creating additional pods.

Solution: Update the ResourceQuota to allow at least 3 pods (preferably 10 for HPA maxReplicas):
kubectl patch resourcequota hpa-quota -n default \
  -p '{"spec":{"hard":{"pods":"10"}}}'
```

**Time taken**: ~30 seconds (vs 5-7 minutes manually)

### Apply the Fix

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/010-010/support-code/fix-resource-quota.yaml
```

---

## Time Comparison

Let's compare the time taken:

| Problem | Manual Time | Kagent Time | Savings |
|---------|-------------|-------------|---------|
| Pod CrashLoopBackOff | 5-7 min | ~30 sec | ~90% |
| Service Routing | 5-7 min | ~30 sec | ~90% |
| Resource Exhaustion | 5-7 min | ~30 sec | ~90% |
| HPA Scaling | 5-7 min | ~30 sec | ~90% |
| **Total** | **20-28 min** | **~2 min** | **~90%** |

## Quiz Questions

**Question 1**: How long did it take Kagent to solve all 4 problems?

**Options**:
- A) 5-10 minutes
- B) 2-3 minutes
- C) 10-15 minutes
- D) Same as manual

**Answer: B) 2-3 minutes**

Kagent solved all 4 problems in approximately 2-3 minutes total.

---

**Question 2**: What's the main advantage of using Kagent for troubleshooting?

**Options**:
- A) It's free
- B) Natural language queries, instant analysis, comprehensive checks
- C) It doesn't need kubectl
- D) It works offline

**Answer: B) Natural language queries, instant analysis, comprehensive checks**

Kagent allows you to ask questions in natural language and provides instant, comprehensive analysis.

---

**Question 3**: What percentage of time did you save using Kagent?

**Options**:
- A) 50%
- B) 70%
- C) 90%
- D) 100%

**Answer: C) 90%**

Kagent reduced troubleshooting time from 20-28 minutes to 2-3 minutes, saving approximately 90% of the time.

---

**Question 4**: Which problem was most complex to diagnose manually?

**Options**:
- A) Pod CrashLoopBackOff
- B) Service Routing
- C) Resource Exhaustion
- D) HPA Scaling (ResourceQuota)

**Answer: D) HPA Scaling (ResourceQuota)**

The HPA/ResourceQuota issue required understanding multiple resources (HPA, Deployment, ReplicaSet, ResourceQuota) and their relationships.

## Key Takeaways

- ✅ Kagent solves complex troubleshooting in seconds
- ✅ Natural language queries are intuitive
- ✅ Kagent checks multiple resources automatically
- ✅ Comprehensive analysis with actionable solutions
- ✅ 90% time savings compared to manual troubleshooting

## Summary

You've now experienced the power of Kagent! The same 4 problems that took **20-28 minutes** to troubleshoot manually were solved in **2-3 minutes** using Kagent's AI-powered k8s-agent.

**Key Benefits**:
- Natural language queries (no need to remember kubectl commands)
- Instant analysis across multiple resources
- Actionable solutions with explanations
- Dramatic time savings (90%)

---

**Next Step**: [Step 7: Reflection & Course Preview](07-reflection-preview.md)

