# Step 4: Install Kagent with Tracing Enabled

## Overview
Install Kagent with OpenTelemetry tracing enabled to connect to the Jaeger instance deployed in the previous steps.

## Prerequisites

Ensure you have your OpenAI API key available:

```bash
# Export your OpenAI API key
export OPENAI_API_KEY="your-api-key-here"

# Verify the key is set
echo $OPENAI_API_KEY
```

## Install Kagent CRDs

First, install the Kagent Custom Resource Definitions:

```bash
# Install Kagent CRDs
helm upgrade --install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
    --namespace kagent \
    --create-namespace
```

## Review Kagent Configuration

The Kagent values file includes tracing configuration:

```bash
# View the Kagent configuration with tracing
cat /Users/admin/Documents/kodekloud/kagent/kagent-lab/050-020/support-code/kagent-values.yaml
```

### Key Tracing Configuration

```yaml
otel:
  tracing:
    enabled: true
    exporter:
      otlp:
        endpoint: http://jaeger-collector.jaeger.svc.cluster.local:4317
```

This configuration:
- Enables OpenTelemetry tracing in Kagent
- Configures OTLP exporter to send traces to Jaeger collector
- Uses the Kubernetes service DNS name for Jaeger collector

## Install Kagent

Deploy Kagent with tracing enabled:

```bash
# Install Kagent with tracing configuration
helm upgrade --install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
    --namespace kagent \
    --set providers.openAI.apiKey=$OPENAI_API_KEY \
    --values /Users/admin/Documents/kodekloud/kagent/kagent-lab/050-020/support-code/kagent-values.yaml
```

## Verify Kagent Installation

Check that Kagent is running properly:

```bash
# Check Kagent pods
kubectl get pods -n kagent

# Check Kagent services
kubectl get svc -n kagent
```

**Expected Output:**
```
NAME                           READY   STATUS    RESTARTS   AGE
kagent-ui-xxx                  1/1     Running   0          2m
k8s-agent-xxx                  1/1     Running   0          2m
kagent-tools-xxx               1/1     Running   0          2m
```

## Verify Tracing Configuration

Check that the tracing configuration is properly applied:

```bash
# Check Kagent deployment for OTEL environment variables
kubectl get deployment -n kagent -o yaml | grep -A 10 -B 5 OTEL
```

Look for environment variables like:
- `OTEL_EXPORTER_OTLP_ENDPOINT`
- `OTEL_SERVICE_NAME`

## Validation Checklist

- ✅ OpenAI API key is properly set
- ✅ Kagent CRDs are installed
- ✅ Kagent pods are running
- ✅ k8s-agent is enabled and running
- ✅ Tracing configuration is applied

## Next Steps
Proceed to Step 5 to test the agent and generate trace data.
