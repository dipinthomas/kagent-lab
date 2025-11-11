# Step 1: Generate Jaeger Configuration Values

## Overview
Generate Helm values file for Jaeger deployment. This configuration sets up Jaeger in all-in-one mode, which is ideal for development and testing environments.

## Jaeger Configuration Components

The values file includes several key components:

- **provisionDataStore**: Controls whether to provision external data stores like Cassandra or Elasticsearch
- **allInOne**: Enables single-pod deployment containing collector, query, and agent components
- **storage**: Configures trace storage backend (memory-based for development)
- **agent/collector/query**: Individual component controls (disabled in all-in-one mode)

## Create Jaeger Values File

The Jaeger values file is already provided in the support-code directory:

```bash
# View the Jaeger configuration
cat /Users/admin/Documents/kodekloud/kagent/kagent-lab/050-020/support-code/jaeger.yaml
```

## Key Configuration Details

### All-in-One Mode
```yaml
allInOne:
  enabled: true
```
This runs collector, query, and agent in a single pod, simplifying deployment for development.

### Memory Storage
```yaml
storage:
  type: memory
```
Uses in-memory storage for traces. Note: Traces will be lost when the pod restarts.

### Data Store Configuration
```yaml
provisionDataStore:
  cassandra: false
```
Disables external data store provisioning since we're using memory storage.

## Reference
- **Official Jaeger Helm Charts**: [GitHub Repository](https://github.com/jaegertracing/helm-charts/tree/main)
- **Jaeger Documentation**: [Official Docs](https://www.jaegertracing.io/docs/)

## Next Steps
Proceed to Step 2 to install Jaeger using this configuration.
