# Step 8: Install kagent with Helm

Install the kagent Helm chart into the `kagent` namespace using your OpenAI key.

```bash
helm install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  --namespace kagent \
  --set providers.default=openAI \
  --set providers.openAI.apiKey=$OPENAI_API_KEY
```

output

```
Pulled: ghcr.io/kagent-dev/kagent/helm/kagent:0.7.2
Digest: sha256:27fb1e88c5a98b7dd8ff64dc64126960a8df7a42a41340e21be28fb3736f602e
NAME: kagent
LAST DEPLOYED: Tue Nov  4 12:11:12 2025
NAMESPACE: kagent
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
################################################################################
#                            KAGENT DEPLOYED                                  #
################################################################################

Kagent has been successfully deployed to namespace: kagent

ACCESSING THE UI:
  1. Forward the UI service port:
     kubectl -n kagent port-forward service/kagent-ui 8080:8080

  2. Open your browser and visit:
     http://localhost:8080

ACCESSING THE CONTROLLER API:
  kubectl -n kagent port-forward service/kagent-controller 8083:8083
  
  API endpoint: http://localhost:8083/api

DEPLOYED COMPONENTS:
  - Controller: kagent-controller (manages Kubernetes resources)
  - Engine: kagent-engine (AI agent runtime)
  - UI: kagent-ui (web interface)
  - KMCP Controller: kagent-kmcp-manager-controller (manages MCPServer resources)

ENABLED TOOLS:
  - Tool Server: Kagent's Built-in tools
  - grafana-mcp
  - querydoc

ENABLED AGENTS:
  - argo-rollouts-agent
  - cilium-debug-agent
  - cilium-manager-agent
  - cilium-policy-agent
  - helm-agent
  - istio-agent
  - k8s-agent
  - kgateway-agent
  - observability-agent
  - promql-agent

USEFUL COMMANDS:
  # View all kagent resources
  kubectl -n kagent get agents,modelconfigs,toolservers,memories

  # Get agents
  kubectl -n kagent get agents

  # View logs
  kubectl -n kagent logs -l app.kubernetes.io/name=kagent -f

TROUBLESHOOTING:
  - Check pod status: kubectl -n kagent get pods
  - View events: kubectl -n kagent get events --sort-by='.lastTimestamp'
  - Controller logs: kubectl -n kagent logs -l app.kubernetes.io/component=controller -f

DOCUMENTATION:
  Visit https://kagent.dev for comprehensive documentation and examples.

################################################################################
```

Validation (to be performed):

```bash
# 1) Confirm release
helm list -n kagent | grep "\bkagent\b" || echo "kagent release not found"

# 2) Pods should be running
kubectl get pods -n kagent

# 3) Services available
kubectl get svc -n kagent
```
