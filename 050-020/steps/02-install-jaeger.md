# Step 2: Install Jaeger Using Helm

## Overview
Install Jaeger tracing system using the official Helm chart with the configuration values created in the previous step.

## Add Jaeger Helm Repository

First, add the official Jaeger Helm repository:

```bash
# Add Jaeger Helm repository
helm repo add jaegertracing https://jaegertracing.github.io/helm-charts

# Update Helm repositories to get latest charts
helm repo update
```

## Install Jaeger

Deploy Jaeger using Helm with the values file:

```bash
# Install Jaeger in the jaeger namespace
helm upgrade --install jaeger jaegertracing/jaeger \
  --namespace jaeger \
  --create-namespace \
  --history-max 3 \
  --values /Users/admin/Documents/kodekloud/kagent/kagent-lab/050-020/support-code/jaeger.yaml
```

## Command Explanation

- `--namespace jaeger`: Creates and uses the `jaeger` namespace
- `--create-namespace`: Automatically creates the namespace if it doesn't exist
- `--history-max 3`: Limits Helm release history to 3 revisions
- `--values`: Specifies the custom values file for configuration

## Expected Output

You should see output similar to:
```
Release "jaeger" does not exist. Installing it now.
NAME: jaeger
LAST DEPLOYED: [timestamp]
NAMESPACE: jaeger
STATUS: deployed
REVISION: 1
```

## Verify Installation

Check that the Helm release was installed successfully:

```bash
# Check Helm releases
helm list -n jaeger

# Verify the release status
helm status jaeger -n jaeger
```

## Next Steps
Proceed to Step 3 to verify that Jaeger pods and services are running correctly.
