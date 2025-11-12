# Lab Preparation: Install Minimal Kagent and CloudWatch MCP Server

## Prerequisites Setup

Before starting the main lab, ensure you have the following components installed and configured:

# Step 1: Install Kagent with minimal configuration

Install Kagent via Helm with all agents disabled. This keeps footprint small while enabling you to explore CRDs and ModelConfigs.

```bash

Export OPENAI_API_KEY credentails

# Install CRDs via OCI chart (creates namespace if needed)
helm upgrade --install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
  --namespace kagent \
  --create-namespace

# Install kagent with minimal values from support-code
helm upgrade --install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  --namespace kagent \
  -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/01-values-min.yaml \
  --set providers.default=openAI \
  --set providers.openAI.apiKey=$OPENAI_API_KEY
```
### 2. Install CloudWatch MCP Server

```bash
# Apply CloudWatch MCP server configuration
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/cloudwatch-mcp-server.yaml

# Verify MCP server deployment
kubectl get mcpservers -n kagent
kubectl get pods -n kagent -l app.kubernetes.io/name=mcp-server
```

### 3. Set Up AWS CloudWatch Log Groups

**Note**: Ensure you have AWS credentials configured with appropriate CloudWatch permissions.

```bash
# Run the setup script
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/setup-cloudwatch-logs.sh
```

### 4. Verify Installation

```bash
# Check Kagent pods are running
kubectl get pods -n kagent

# Verify CloudWatch MCP server is ready
kubectl get mcpservers -n kagent -o wide

# Test AWS CloudWatch access
aws logs describe-log-groups --region us-east-1 --max-items 5
```

## Expected Results

After completing the preparation:
- ✅ Kagent is running with minimal configuration
- ✅ CloudWatch MCP server is deployed and ready
- ✅ 15 CloudWatch log groups are created (10 empty + 5 with data)
- ✅ Kagent UI is accessible via port-forward
- ✅ AWS credentials are properly configured
