# Step 09: Deploy MCP Server to Kubernetes

## Overview

Your MCP server is built and containerized. Now it's time to deploy it to your Kubernetes cluster using K-Agent's custom resource definitions (CRDs).

## Understanding MCPServer Resource

K-Agent extends Kubernetes with a custom resource called `MCPServer`. This resource:
- **Manages MCP server lifecycle**: Deployment, scaling, updates
- **Handles networking**: Service discovery and communication
- **Integrates with agents**: Makes tools available to AI agents
- **Provides observability**: Status, logs, and metrics

## Review the Deployment Manifest

We've provided a deployment manifest. Let's examine it:

```bash
cat support-code/mcp-server-deploy.yaml
```

### Manifest Breakdown

```yaml
apiVersion: kagent.dev/v1alpha1
kind: MCPServer
metadata:
  name: my-mcp-server
  namespace: kagent
spec:
  deployment:
    image: dipinthomas2003/kmcp-server:bitcoin
    port: 3000
    cmd: "python"
    args: ["src/main.py"]
  transportType: "stdio"
```

Let's understand each section:

### Metadata Section

```yaml
metadata:
  name: my-mcp-server      # Name of the MCP server
  namespace: kagent         # Namespace where K-Agent is installed
```

- **name**: Identifier for your MCP server (used by agents to reference it)
- **namespace**: Must match where K-Agent is running (typically `kagent`)

### Deployment Specification

```yaml
spec:
  deployment:
    image: dipinthomas2003/kmcp-server:bitcoin  # Container image
    port: 3000                                   # Container port
    cmd: "python"                                # Command to run
    args: ["src/main.py"]                        # Command arguments
```

- **image**: The Docker image you built in the previous step
- **port**: Port the MCP server listens on (default: 3000)
- **cmd**: Entry command (Python interpreter)
- **args**: Script to execute (your MCP server main file)

### Transport Type

```yaml
  transportType: "stdio"
```

MCP supports two transport types:
- **stdio**: Communication via standard input/output (simpler, used here)
- **sse**: Server-Sent Events over HTTP (for web-based scenarios)

For K-Agent integration, `stdio` is the recommended choice.

## Update the Image Name (If Needed)

If you used a different image name or tag when building, update the manifest:

```bash
# Edit the file
nano support-code/mcp-server-deploy.yaml

# Or use sed to replace
sed -i 's|dipinthomas2003/kmcp-server:bitcoin|YOUR_IMAGE_NAME:TAG|g' support-code/mcp-server-deploy.yaml
```

## Deploy to Kubernetes

Apply the manifest to your cluster:

```bash
kubectl apply -f support-code/crypto-price-mcp.yaml
```

### Expected Output

```
mcpserver.kagent.dev/crypto-price-mcp created
```

## Verify the Deployment

### Check MCPServer Resource

```bash
kubectl get mcpserver -n kagent
```

### Expected Output

```
NAME             READY   STATUS    AGE
my-mcp-server    True    Running   30s
```

**Status Meanings**:
- **READY: True** - Server is running and healthy
- **READY: False** - Server is starting or has issues
- **STATUS: Running** - Container is active
- **STATUS: Pending** - Waiting for resources
- **STATUS: Error** - Deployment failed

### Check the Pod

```bash
kubectl get pods -n kagent -l app=my-mcp-server
```

### Expected Output

```
NAME                              READY   STATUS    RESTARTS   AGE
my-mcp-server-7d8f9b5c4-xk2p9    1/1     Running   0          45s
```

### View Server Logs

```bash
kubectl logs -n kagent -l app=my-mcp-server --tail=50
```

### Expected Output

```
🚀 Starting MCP server...
📦 Loading tools from src/tools/
✅ Registered tool: echo
✅ Registered tool: get_crypto_price
🔌 Server running on stdio transport
⏳ Waiting for connections...
```

## Verify Tools are Available

Check the MCPServer details to see registered tools:

```bash
kubectl describe mcpserver crypto-price-mcp -n kagent
```



## Understanding What Happened

When you applied the manifest:

1. **K-Agent controller detected** the new MCPServer resource
2. **Created a Deployment** with your container image
3. **Started a Pod** running your MCP server
4. **Registered tools** by querying the server
5. **Updated status** to reflect readiness
6. **Made tools available** for agents to use

## Behind the Scenes

The K-Agent controller:
- Watches for MCPServer resources
- Manages underlying Kubernetes resources (Deployment, Service)
- Monitors server health
- Exposes tools to the agent framework
- Handles updates and scaling

## Summary

Your custom MCP server is now running in Kubernetes! The tools you built are available for AI agents to use.

**Key Takeaways**:
- ✅ MCPServer is a Kubernetes custom resource
- ✅ K-Agent controller manages MCP server lifecycle
- ✅ Deployment uses your container image
- ✅ Tools are automatically discovered and registered
- ✅ stdio transport enables agent communication

## What's Next?

In the final step, you'll create an AI agent that uses your cryptocurrency price tool to answer natural language queries.

---

**Next Step**: [Step 10: Deploy and Test Crypto Price Agent](step10.md)
