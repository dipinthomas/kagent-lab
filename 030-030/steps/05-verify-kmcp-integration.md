# Step 5: Verify KMCP Integration

## Overview

In this step, we'll verify that KMCP is properly integrated with Kagent and functioning correctly. We'll check controller health, verify resources are accessible, and confirm the integration is working as expected.

## Check Controller Health

First, let's verify the KMCP controller is running and healthy:

```bash
kubectl get pods -n kagent -l app.kubernetes.io/name=kmcp-controller
```

Or check by deployment name:

```bash
kubectl get pods -n kagent | grep kmcp-controller
```

### Expected Output

```bash
NAME                                              READY   STATUS    RESTARTS   AGE
kagent-kmcp-controller-manager-6ff69876bd-w92nn   1/1     Running   0          19m
```

The pod should show:
- **READY**: `1/1` (all containers ready)
- **STATUS**: `Running` (not Pending, Error, or CrashLoopBackOff)

## Check Controller Logs for Errors

Review recent controller logs to ensure there are no errors:

```bash
kubectl logs -n kagent -l app.kubernetes.io/name=kmcp-controller --tail=100 | grep -i error
```

If there are no errors, this command will return nothing, which is good.

## Verify CRD is Accessible

Confirm the MCPServer CRD is accessible via the Kubernetes API:

```bash
kubectl api-resources | grep -i mcp
```

### Expected Output

```bash
NAME          SHORTNAMES   APIVERSION              NAMESPACED   KIND
mcpservers    mcp          kagent.dev/v1alpha1    true         MCPServer
```

This confirms the API server recognizes the MCPServer resource.

## Test CRD Functionality

Try to get MCPServer resources (even if none exist):

```bash
kubectl get mcpserver -n kagent
```

### Expected Output (if no resources)

```bash
No resources found in kagent namespace.
```

This is expected and confirms the CRD is working - if it weren't, you'd get an error like "the server doesn't have a resource type 'mcpserver'".

## Check Controller is Watching Resources

Verify the controller is actively watching for MCPServer resources by checking its logs:

```bash
kubectl logs -n kagent -l app.kubernetes.io/name=kmcp-controller --tail=20
```

Look for messages indicating the controller is running and watching:

```
I1106 10:08:44.123456       1 controller.go:123] Starting KMCP controller
I1106 10:08:44.234567       1 controller.go:145] KMCP controller manager started
I1106 10:08:45.345678       1 controller.go:156] Watching for MCPServer resources
```

## Verify All KMCP-Related Resources

Check all KMCP-related resources in the cluster:

```bash
kubectl get all -n kagent | grep -i kmcp
```

### Expected Output

```bash
NAME                                              READY   STATUS    RESTARTS   AGE
pod/kagent-kmcp-controller-manager-6ff69876bd-w92nn   1/1     Running   0          19m

NAME                              READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/kagent-kmcp-controller-manager    1/1     1            1           19m
```

## Check Controller Service (if exists)

Some controller setups include a service. Check if one exists:

```bash
kubectl get svc -n kagent | grep kmcp
```

## Verify Integration with Kagent

Check that Kagent components can see KMCP resources. List all Kagent-related resources:

```bash
kubectl get all -n kagent
```

You should see both Kagent components and the KMCP controller running together, confirming they're integrated.

## Test MCPServer Resource Creation (Dry Run)

Verify you can create MCPServer resources by doing a dry-run:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-030/support-code/example-mcpserver.yaml --dry-run=client -o yaml
```

### Expected Output

The command should succeed and show the resource that would be created, confirming:
- The CRD is properly installed
- The API server accepts MCPServer resources
- The manifest is valid

## Check Controller Metrics (if available)

If metrics are enabled, check controller metrics:

```bash
kubectl get --raw /apis/metrics.k8s.io/v1beta1/namespaces/kagent/pods | grep kmcp
```

Or check if there's a metrics service:

```bash
kubectl get svc -n kagent | grep metrics
```

## Quiz Questions

**Question 1**: How can you verify the KMCP controller is running and healthy?

**Options**:
- A) Check if the controller pod is in `Running` state with `READY 1/1`
- B) Check if there are MCPServer resources deployed
- C) Check the Kagent UI
- D) All of the above

**Answer: A) Check if the controller pod is in `Running` state with `READY 1/1`**

The most direct way is to check the pod status using `kubectl get pods`.

---

**Question 2**: What does it mean if `kubectl get mcpserver -n kagent` returns "No resources found"?

**Options**:
- A) The CRD is not installed
- B) The controller is not working
- C) No MCPServer resources have been created yet (this is normal)
- D) There's an error

**Answer: C) No MCPServer resources have been created yet (this is normal)**

If the CRD weren't installed, you'd get an error. "No resources found" means the CRD is working, but no MCPServer resources exist yet.

---

**Question 3**: What is the relationship between Kagent and KMCP when they're bundled together?

**Options**:
- A) They are separate systems that don't interact
- B) KMCP controller manages MCP servers that Kagent agents can use
- C) Kagent is a dependency of KMCP
- D) They compete for resources

**Answer: B) KMCP controller manages MCP servers that Kagent agents can use**

The KMCP controller manages MCP server lifecycle, and Kagent agents can discover and use tools from those MCP servers.

---

**Question 4**: True or False: When using Kagent 0.7.x+, you need to install the KMCP controller separately.

**Options**:
- A) True
- B) False

**Answer: B) False**

Starting from Kagent 0.7.x, the KMCP controller is bundled and automatically installed with Kagent.

---

**Question 5**: What command confirms the MCPServer CRD is accessible via the Kubernetes API?

**Options**:
- A) `kubectl get crd mcpservers.kagent.dev`
- B) `kubectl api-resources | grep mcp`
- C) `kubectl get mcpserver`
- D) All of the above

**Answer: D) All of the above**

All three commands help verify the CRD is accessible, though `kubectl api-resources` is the most direct way to confirm API server recognition.

## Summary

You've verified the KMCP integration:
- ✅ Confirmed the controller is running and healthy
- ✅ Verified the CRD is accessible via Kubernetes API
- ✅ Tested MCPServer resource creation (dry-run)
- ✅ Confirmed integration with Kagent components

**Key Takeaways**:
- The KMCP controller runs alongside Kagent in the `kagent` namespace
- You can verify health using standard Kubernetes commands
- The CRD is functional even if no MCPServer resources exist yet
- KMCP and Kagent work together seamlessly when bundled
- All components are ready for deploying MCP servers

---

**Next Step**: [Step 6: Compare with Standalone Installation](06-compare-standalone-installation.md)

