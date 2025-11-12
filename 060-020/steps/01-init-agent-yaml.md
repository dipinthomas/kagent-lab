# Step 01: Initialize Agent YAML (apiVersion/kind/metadata)

## Goal
Create the base Agent YAML with `apiVersion`, `kind`, and `metadata`.

## Instructions
1. Create a working file:
   - Path: `/Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/work/agent.yaml`
2. Add the following fields:
   - `apiVersion: kagent.dev/v1alpha2`
   - `kind: Agent`
   - `metadata.name: cloudwatch-log-analyzer`
   - `metadata.namespace: kagent`

## Validation
- The file exists and is non-empty.
- YAML parses without errors:
```bash
yq e '.' /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/work/agent.yaml >/dev/null
```

## Expected YAML (for this step only)
```yaml
apiVersion: kagent.dev/v1alpha2
kind: Agent
metadata:
  name: cloudwatch-log-analyzer
  namespace: kagent
```

Proceed to Step 02 once this validates.
