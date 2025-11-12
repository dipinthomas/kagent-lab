# Step 05: Add description/type, Apply, and Validate

## Goal
Finish the YAML, apply it to the cluster, and validate the deployment.

## Instructions
1. Under root of `spec`, add the following fields:
   - `description: AI agent for analyzing CloudWatch logs and extracting insights`
   - `type: Declarative`

2. Save the file at:
   - `/Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/work/agent.yaml`

3. Apply the YAML:
```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-020/support-code/work/agent.yaml
```

## Validation
```bash
# Check Agent CR status
kubectl get agents -n kagent


kubectl describe agent cloudwatch-log-analyzer -n kagent | sed -n '1,120p'

# Check Pod
kubectl get pods -n kagent -l app.kubernetes.io/name=cloudwatch-log-analyzer
kubectl logs -n kagent -l app.kubernetes.io/name=cloudwatch-log-analyzer --tail=100
```

## Expected Outcome
- Agent resource `cloudwatch-log-analyzer` is created in namespace `kagent`.
- One agent pod is Running.
- The agent can access the CloudWatch MCP server tools.


