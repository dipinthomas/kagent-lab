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
  -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-050/support-code/01-values-min.yaml \
  --set providers.default=openAI \
  --set providers.openAI.apiKey=$OPENAI_API_KEY
```

Install Cositng MCP server

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-070/support-code/pricing-mcp-sever.yaml

NOTE: Please make sure proper credentials are added to the MCP server
```

Lab Validation

```bash
MCP pods should be running
```

