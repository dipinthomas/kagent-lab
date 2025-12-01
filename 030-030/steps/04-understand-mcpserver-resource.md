# Step 4: Understand MCPServer Resource

## Overview

In this step, we'll explore the MCPServer custom resource in detail. The MCPServer resource is how you define and manage MCP servers in Kubernetes. Understanding its structure is essential for deploying custom MCP servers.

## Describe the MCPServer CRD

Let's examine the MCPServer Custom Resource Definition to understand its structure:

```bash
kubectl describe crd mcpservers.kagent.dev
```

Or if it's `mcpservers.kmcp.dev`:

```bash
kubectl describe crd mcpservers.kmcp.dev
```

### Expected Output

You'll see information about:
- API version and group
- Scope (Namespaced or Cluster-scoped)
- Schema with required and optional fields
- Validation rules
- Status subresource

## Get CRD Schema Details

For more detailed schema information:

```bash
kubectl get crd mcpservers.kagent.dev -o yaml | grep -A 100 "spec:" | head -80
```

This shows the full schema definition with all available fields.

## Review Example MCPServer Manifest

Let's look at an example MCPServer resource. Check the support-code directory:

```bash
cat /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-030/support-code/example-mcpserver.yaml
```

### Example MCPServer Structure

```yaml
apiVersion: kagent.dev/v1alpha1
kind: MCPServer
metadata:
  name: example-mcp-server
  namespace: kagent
spec:
  deployment:
    image: ghcr.io/example/mcp-server:latest
    port: 3000
    cmd: "python"
    args: ["src/main.py"]
    env:
      - name: API_KEY
        value: "your-api-key"
  transportType: "stdio"
```

## Understand MCPServer Fields

Let's break down the key fields:

### Metadata Section
- **name**: Unique identifier for the MCP server
- **namespace**: Namespace where the server will run (typically `kagent`)

### Spec Section

#### deployment
- **image**: Container image for the MCP server
- **port**: Port the server listens on (default: 3000)
- **cmd**: Command to run (e.g., "python", "node")
- **args**: Arguments to pass to the command
- **env**: Environment variables (optional)

#### transportType
- **stdio**: Communication via standard input/output (recommended for Kagent)
- **sse**: Server-Sent Events over HTTP (for web-based scenarios)

## Check Current MCPServer Resources

See if there are any MCPServer resources already deployed:

```bash
kubectl get mcpserver -n kagent
```

Or using the short name:

```bash
kubectl get mcp -n kagent
```

### Expected Output (if none exist)

```bash
No resources found in kagent namespace.
```

This is normal if you haven't deployed any MCP servers yet.

## Try Creating a Dry-Run MCPServer

Let's see what happens when we try to create an MCPServer (without actually creating it):

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-030/support-code/example-mcpserver.yaml --dry-run=client
```

### Expected Output

```bash
mcpserver.kagent.dev/example-mcp-server created (dry run)
```

This confirms the CRD is working and the manifest is valid.

## Explore MCPServer Status

When an MCPServer is deployed, it has a status section. Let's understand what status fields are available:

```bash
kubectl explain mcpserver.status
```

Or check the CRD for status fields:

```bash
kubectl get crd mcpservers.kagent.dev -o jsonpath='{.spec.versions[0].schema.openAPIV3Schema.properties.status}'
```

## Quiz Questions

**Question 1**: What is the API version for MCPServer resources when KMCP is bundled with Kagent?

**Options**:
- A) `kmcp.dev/v1alpha1`
- B) `kagent.dev/v1alpha1`
- C) `v1`
- D) `apps/v1`

**Answer: B) `kagent.dev/v1alpha1`**

When KMCP is bundled with Kagent, MCPServer resources use the `kagent.dev/v1alpha1` API version.

---

**Question 2**: What is the purpose of the MCPServer custom resource?

**Options**:
- A) To define Kubernetes deployments
- B) To define and manage MCP servers in Kubernetes
- C) To configure AI models
- D) To manage secrets

**Answer: B) To define and manage MCP servers in Kubernetes**

The MCPServer resource allows you to declaratively define MCP servers and have the KMCP controller manage their lifecycle.

---

**Question 3**: Which transport type is recommended for MCP servers used with Kagent?

**Options**:
- A) `http`
- B) `stdio`
- C) `grpc`
- D) `websocket`

**Answer: B) `stdio`**

The `stdio` transport type (standard input/output) is recommended for MCP servers integrated with Kagent, as it provides a simpler communication model.

---

**Question 4**: What happens when you create an MCPServer resource?

**Options**:
- A) Nothing, you need to manually deploy it
- B) The KMCP controller automatically creates a Deployment and Pod
- C) It only validates the configuration
- D) It creates a ConfigMap

**Answer: B) The KMCP controller automatically creates a Deployment and Pod**

The KMCP controller watches for MCPServer resources and automatically creates the necessary Kubernetes resources (Deployment, Pod, Service) to run the MCP server.

---

**Question 5**: True or False: You can create MCPServer resources without installing anything additional when using Kagent 0.7.x+.

**Options**:
- A) True
- B) False

**Answer: A) True**

Since KMCP is bundled with Kagent 0.7.x+, the MCPServer CRD is already available, and you can create MCPServer resources immediately after installing Kagent.

## Summary

You've learned about the MCPServer resource:
- ✅ Understood the MCPServer CRD structure
- ✅ Reviewed example MCPServer manifests
- ✅ Learned about key fields (deployment, transportType)
- ✅ Verified the CRD is functional

**Key Takeaways**:
- MCPServer is a Kubernetes custom resource for managing MCP servers
- The KMCP controller automatically manages the lifecycle of MCPServer resources
- MCPServer resources use `kagent.dev/v1alpha1` API version when bundled
- The `stdio` transport type is recommended for Kagent integration
- You can create MCPServer resources declaratively using YAML

---

**Next Step**: [Step 5: Verify KMCP Integration](05-verify-kmcp-integration.md)

