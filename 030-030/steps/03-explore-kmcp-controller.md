# Step 3: Explore KMCP Controller Components

## Overview

In this step, we'll locate and explore the KMCP controller components that are running in your cluster. When KMCP is bundled with Kagent, the controller runs in the `kagent` namespace alongside other Kagent components.

## Locate KMCP Controller Pods

Let's find the KMCP controller pods in the kagent namespace:

```bash
kubectl get pods -n kagent | grep kmcp
```

### Expected Output

You should see pods related to the KMCP controller:

```bash
kagent-kmcp-controller-manager-6ff69876bd-w92nn   1/1     Running   0          19m
```

The pod name typically includes `kmcp-controller` or `kmcp-controller-manager`.

## Check All Pods in Kagent Namespace

Let's see all pods to understand the full Kagent deployment:

```bash
kubectl get pods -n kagent
```

### Expected Output

```bash
NAME                                              READY   STATUS    RESTARTS   AGE
kagent-controller-7d8f9b5c4-xk2p9                 1/1     Running   0          20m
kagent-kmcp-controller-manager-6ff69876bd-w92nn   1/1     Running   0          19m
kagent-tools-65d979fcf7-x6xbh                     1/1     Running   0          18m
k8s-agent-7d8f9b5c4-abc123                          1/1     Running   0          17m
```

Notice the `kagent-kmcp-controller-manager` pod running alongside other Kagent components.

## Check KMCP Controller Deployment

Let's examine the deployment that manages the controller:

```bash
kubectl get deployment -n kagent | grep kmcp
```

### Expected Output

```bash
NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
kagent-kmcp-controller-manager    1/1     1            1           19m
```

## Describe the Controller Deployment

Get more details about the controller deployment:

```bash
kubectl describe deployment kagent-kmcp-controller-manager -n kagent
```

This shows:
- Replicas and status
- Image used
- Resource requests/limits
- Selectors and labels

## Check Controller Logs

View the controller logs to see what it's doing:

```bash
kubectl logs -n kagent -l app.kubernetes.io/name=kmcp-controller --tail=50
```

Or if the label is different:

```bash
kubectl logs -n kagent -l control-plane=controller-manager --tail=50 | grep -i kmcp
```

### Expected Output

You might see logs like:
```
I1106 10:08:44.123456       1 controller.go:123] Starting KMCP controller
I1106 10:08:44.234567       1 controller.go:145] KMCP controller manager started
I1106 10:08:45.345678       1 reconciler.go:67] Reconciling MCPServer...
```

## Check Controller Service Account

The controller needs a service account with appropriate permissions:

```bash
kubectl get serviceaccount -n kagent | grep kmcp
```

## Verify Controller is Watching Resources

Check if the controller is actively managing resources:

```bash
kubectl get mcpserver -n kagent
```

Even if there are no MCPServer resources yet, the command should work (returning "No resources found" or an empty list), which confirms the CRD and controller are functional.

## Check Controller Image

See what image the controller is using:

```bash
kubectl get deployment kagent-kmcp-controller-manager -n kagent -o jsonpath='{.spec.template.spec.containers[0].image}'
```

### Expected Output

```bash
ghcr.io/kagent-dev/kmcp/controller:latest
```

Or it might be part of a combined Kagent image.

## Quiz Questions

**Question 1**: What namespace is the KMCP controller running in when bundled with Kagent?

**Options**:
- A) `kmcp-system`
- B) `kagent`
- C) `default`
- D) `kube-system`

**Answer: B) `kagent`**

When KMCP is bundled with Kagent, the controller runs in the same `kagent` namespace as other Kagent components.

---

**Question 2**: How many KMCP-related pods are typically running in the kagent namespace?

**Options**:
- A) 0 (controller is external)
- B) 1 (controller-manager pod)
- C) 2 (controller and operator)
- D) 3 (controller, operator, and webhook)

**Answer: B) 1 (controller-manager pod)**

The KMCP controller typically runs as a single controller-manager pod.

---

**Question 3**: What is the typical name pattern for the KMCP controller deployment?

**Options**:
- A) `kmcp-controller`
- B) `kagent-kmcp-controller-manager`
- C) `kmcp-operator`
- D) `mcp-controller`

**Answer: B) `kagent-kmcp-controller-manager`**

The deployment is typically named `kagent-kmcp-controller-manager` when bundled with Kagent.

---

**Question 4**: What is the primary purpose of the KMCP controller?

**Options**:
- A) To manage Kubernetes clusters
- B) To manage MCP server lifecycle in Kubernetes
- C) To monitor AI agent performance
- D) To deploy Docker containers

**Answer: B) To manage MCP server lifecycle in Kubernetes**

The KMCP controller watches for MCPServer resources and manages their deployment, scaling, and lifecycle in the Kubernetes cluster.

## Summary

You've explored the KMCP controller components:
- ✅ Located the controller pod in the `kagent` namespace
- ✅ Identified the controller deployment
- ✅ Checked controller logs and status
- ✅ Verified the controller is running and functional

**Key Takeaways**:
- The KMCP controller runs alongside Kagent components in the `kagent` namespace
- The controller watches for MCPServer resources and manages their lifecycle
- You can monitor the controller through standard Kubernetes commands
- The controller is automatically deployed when you install Kagent 0.7.x+

---

**Next Step**: [Step 4: Understand MCPServer Resource](04-understand-mcpserver-resource.md)

