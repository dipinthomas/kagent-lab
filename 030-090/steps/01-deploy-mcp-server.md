# Step 1: Deploy AWS Pricing MCP Server

In this step, we'll deploy the AWS Pricing MCP server using KMCP. This server provides pricing information for AWS services through a standardized MCP interface.

## 1. Install KMCP Controller

First, install the KMCP controller in your cluster:

```bash
# Create namespace for KMCP
kubectl create namespace kmcp-system

# Install KMCP controller
kmcp install
```

## 2. Setup RBAC

Create necessary RBAC permissions:

```bash
kubectl apply -f- <<EOF
apiVersion: v1
kind: ServiceAccount
metadata:
  name: mcp-server
  namespace: default
---
apiVersion: rbac.authorization.k8s.io/v1
kind: Role
metadata:
  name: mcp-server
  namespace: default
rules:
- apiGroups: ["", "apps"]
  resources: ["pods", "services"]
  verbs: ["get", "list", "watch"]
---
apiVersion: rbac.authorization.k8s.io/v1
kind: RoleBinding
metadata:
  name: mcp-server
  namespace: default
subjects:
- kind: ServiceAccount
  name: mcp-server
  namespace: default
roleRef:
  kind: Role
  name: mcp-server
  apiGroup: rbac.authorization.k8s.io
EOF
```

## 3. Deploy the MCP Server

Apply the MCP server manifest:

```bash
kubectl apply -f support-code/mcp-server.yaml
```

This creates:
- MCP server deployment
- Service for API access
- Configuration for stdio transport

## 3. Verify the Deployment

Check if the MCP server is running:

```bash
kubectl get pods -l app=my-mcp-server
kubectl logs -l app=my-mcp-server
```

## 4. Test the MCP Server

You can test the MCP server by listing its available resources:

```bash
kubectl exec -it deploy/my-mcp-server -- curl localhost:3000/resources
```

## Next Steps

Once the MCP server is successfully deployed, you can proceed to interact with it using the MCP protocol.
