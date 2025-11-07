# Step 1: Basic Kagent Setup

In this step, we'll set up a minimal Kagent installation to prepare for KMCP controller deployment.


## 2. Deploy Basic Kagent

Apply the minimal Kagent configuration:

```bash
helm install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
  --namespace kagent \
  --create-namespace
```

# 3. Check the CRDS

```bash
kubectl  get crd | grep kagent                                               
```

Output:

```bash
agents.kagent.dev                            2025-11-06T10:08:45Z
mcpservers.kagent.dev                        2025-11-06T10:08:44Z
memories.kagent.dev                          2025-11-06T10:08:43Z
modelconfigs.kagent.dev                      2025-11-06T10:08:43Z
remotemcpservers.kagent.dev                  2025-11-06T10:08:43Z
toolservers.kagent.dev                       2025-11-06T10:08:43Z
```

# 4. Install kagent

```bash
helm install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  --namespace kagent \
  -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/020-040/support-code/04-values-enable-agents.yaml \
  --set providers.default=openAI \
  --set providers.openAI.apiKey=$OPENAI_API_KEY
```

## 5. Verify Installation

Check that Kagent is running:

```bash
# Check pods
kubectl  get remotemcpservers -A
```

Output:

```bash
NAMESPACE   NAME                 PROTOCOL          URL                                   ACCEPTED
kagent      kagent-tool-server   STREAMABLE_HTTP   http://kagent-tools.kagent:8084/mcp   False
```

## 6. Check kagent version 

```bash
kagent version
```

Output:

```bash
{"backend_version":"unknown","build_date":"2025-10-30","git_commit":"8062481","kagent_version":"0.7.2"}
```

NOTE: kmcp CRD's are part of kagent package since version 0.7.X. If you are using an older version, you need to install kmcp CRD's separately.