# Step 5: Deploy Bitcoin MCP Server to Kubernetes

In this step, we'll build and deploy the Bitcoin Price MCP server to a Kubernetes cluster.

## 1. Build the Docker Image

First, build the Docker image using `kmcp`:

```bash
# Build the image
kmcp build --project-dir my-mcp-server -t dipinthomas2003/bitcoin-price-mcp
```

This command:
- Builds the Docker image using the project's Dockerfile
- Tags it with the specified name
- Prepares it for Kubernetes deployment

## 2. Deploy to Kubernetes

Create the MCP server deployment:

```bash
kubectl apply -f- <<EOF
apiVersion: kagent.dev/v1alpha1
kind: MCPServer
metadata:
  name: my-mcp-server
spec:
  deployment:
    image: "dipinthomas2003/bitcoin-price-mcp"
    port: 3000
    cmd: "python"
    args: ["src/main.py"]
  transportType: "stdio"
EOF
```

## 3. Verify the Deployment

Check that everything is running:

```bash
# Check pod status
kubectl get pods

# Check logs
kubectl logs -l app=my-mcp-server

# Check the service
kubectl get svc my-mcp-server
```

## 4. Test the Deployed Server

Test the deployed MCP server:

```bash
# Port-forward the service
kubectl port-forward svc/my-mcp-server 3000:3000

# In another terminal, test the API
curl -X POST http://localhost:3000/tools/get_crypto_price \
  -H "Content-Type: application/json" \
  -d '{"symbol": "bitcoin", "currency": "usd"}'
```

## 5. Understanding the Deployment

Key components:
- **MCPServer Resource**: Defines how the server runs in K8s
- **Deployment**: Manages the pod lifecycle
- **Service**: Exposes the MCP server
- **Transport Type**: Uses STDIO for communication

## 6. Monitoring and Maintenance

Keep an eye on:
1. Pod status and restarts
2. Resource usage
3. API response times
4. Error logs

## Common Issues and Solutions

1. **Image Pull Errors**
   - Verify image name and tag
   - Check container registry access

2. **Pod Startup Issues**
   - Check pod logs
   - Verify environment variables
   - Check resource limits

3. **Connection Issues**
   - Verify service is running
   - Check port configurations
   - Test network policies

## Next Steps

After successful deployment:
1. Monitor the server's performance
2. Set up logging and metrics
3. Configure auto-scaling if needed
4. Implement backup and recovery procedures
