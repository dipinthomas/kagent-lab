# Step 5: Install Kagent (Quick Setup)

## Overview

Now that you've experienced manual troubleshooting, let's install Kagent so you can see how it solves the same problems in seconds.

## Prerequisites Check

Before installing, ensure you have:
- Kubernetes cluster access
- `kubectl` configured
- `helm` v3.x installed
- OpenAI API key ready

## Quick Installation  [RUN THIS DURING LAB SET-UP and GIVE a TAB to Open the kagent UI]

We'll do a minimal Kagent installation. For detailed installation instructions, see Lab 020-035.

### 1. Export OpenAI API Key

```bash
export OPENAI_API_KEY="your-api-key-here"
```

### 2. Install Kagent CRDs

```bash
helm install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
  --namespace kagent \
  --create-namespace
```

### 3. Install Kagent

```bash
helm install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  --namespace kagent \
  --set providers.default=openAI \
  --set providers.openAI.apiKey=$OPENAI_API_KEY \
  --set agents.k8s-agent.enabled=true \
  --set kagent-tools.enabled=true
```

### 4. Verify Installation

Wait for pods to be ready:

```bash
kubectl get pods -n kagent -w
```

**Expected Output:**
```
NAME                              READY   STATUS    RESTARTS   AGE
kagent-controller-xxx-xxxxx       1/1     Running   0          2m
kagent-k8s-agent-xxx-xxxxx        1/1     Running   0          2m
kagent-tools-xxx-xxxxx            1/1     Running   0          2m
```

Press `Ctrl+C` to stop watching once all pods are `Running`.

### 5. Access Kagent UI (Optional)

Port-forward to access the UI:

```bash
kubectl port-forward svc/kagent-controller -n kagent 8080:8080
```

Then open http://localhost:8080 in your browser.

## Alternative: Use Existing Installation

If you already have Kagent installed from a previous lab, you can skip this step and proceed to the next.

## What's Next?

Now that Kagent is installed, you're ready to see it solve all 4 problems we manually troubleshooted. The same issues that took you 20-28 minutes to fix manually will be solved in 2-3 minutes with Kagent!

---

**Next Step**: [Step 6: Solve All Problems with Kagent](06-kagent-solutions.md)

