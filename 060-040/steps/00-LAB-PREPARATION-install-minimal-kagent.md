# Lab Preparation: Install Minimal Kagent

## Overview
Set up the Kagent platform with minimal configuration to support BYO agents.

## Instructions

### 1. Install Kagent with Minimal Configuration

```bash
helm install kagent oci://ghcr.io/kagent-dev/charts/kagent \
  --namespace kagent \
  --create-namespace \
  --values /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-040/support-code/01-values-min.yaml \
  --wait
```

**Expected Output:**
```
NAME: kagent
LAST DEPLOYED: [timestamp]
NAMESPACE: kagent
STATUS: deployed
REVISION: 1
```

### 2. Verify Kagent Installation

```bash
kubectl get pods -n kagent
```

**Expected Output:**
```
NAME                                 READY   STATUS    RESTARTS   AGE
kagent-controller-xxxxxxxxxx-xxxxx   1/1     Running   0          1m
```

### 3. Verify Kagent Controller Service

```bash
kubectl get svc -n kagent
```

**Expected Output:**
```
NAME                 TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)             AGE
kagent-controller    ClusterIP   10.x.x.x        <none>        8080/TCP,8083/TCP   1m
```

The `kagent-controller` service exposes:
- **Port 8080**: Kagent UI and API
- **Port 8083**: A2A (Agent-to-Agent) protocol endpoint

### 4. Copy Required Agent Files

The lab requires agent source code and configuration files. These are already prepared in the support-code directory:

```bash
ls -la /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-040/support-code/
```

**Expected Files:**
- `01-values-min.yaml` - Minimal Kagent configuration
- `langgraph-agent.yaml` - BYO agent definition
- `agents/` - LangGraph agent source code

## What's Next?

You're now ready to:
1. Build the LangGraph currency agent Docker image
2. Create Google API credentials
3. Deploy the BYO agent
4. Test currency exchange queries

## Important Notes

### Google API Key Required

This lab requires a **Google API key** for the currency exchange agent to function. You'll create a Kubernetes secret with this key in the next steps.

To obtain a Google API key:
1. Go to [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the required APIs (Gemini API)
4. Create credentials (API Key)
5. Copy the API key for use in this lab

### Multi-Platform Docker Builds

This lab uses `docker buildx` to build images for both AMD64 and ARM64 architectures, ensuring compatibility across different platforms (Intel/AMD and Apple Silicon).

## Validation

✅ Kagent controller pod is running  
✅ Kagent controller service is available  
✅ Support code files are accessible  
✅ You have a Google API key ready
