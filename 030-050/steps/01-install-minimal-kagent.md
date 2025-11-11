# Step 1: Install Kagent with minimal configuration

Install Kagent via Helm with all agents disabled. This keeps footprint small while enabling you to explore CRDs and ModelConfigs.

```bash
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

To access UI of Kagent we have to port-forward

```bash
kubectl port-forward svc/kagent-ui 8080:8080 -n kagent
```