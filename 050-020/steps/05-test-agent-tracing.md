# Step 5: Test Agent Tracing

## Overview
Use the k8s-agent to generate trace data that will be sent to Jaeger for analysis. This step demonstrates how agent interactions are captured and traced.

## List Available Agents

First, check what agents are available in the kagent namespace:

```bash
# Get list of agents
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME        TYPE          READY   ACCEPTED
k8s-agent   Declarative   True    True
```

## Check Agent Pods

Verify that the agent pods are running:

```bash
# Get all pods in kagent namespace
kubectl get pods -n kagent
```

Look for pods related to the k8s-agent:
```
NAME                           READY   STATUS    RESTARTS   AGE
k8s-agent-xxx-xxx              1/1     Running   0          5m
kagent-ui-xxx-xxx              1/1     Running   0          5m
kagent-tools-xxx-xxx           1/1     Running   0          5m
```

## Access Kagent UI

To interact with the k8s-agent and generate traces, access the Kagent UI:

```bash
# Port forward to Kagent UI
kubectl port-forward svc/kagent-ui 8080:8080 -n kagent
```

Open your browser and navigate to: `http://localhost:8080`

## Generate Trace Data

Interact with the k8s-agent through the UI to generate trace data:

1. **Navigate to the Agents section** in the Kagent UI
2. **Select the k8s-agent** from the available agents
3. **Send a test query** to the agent, such as:
   - "List all pods in the all namespace"
   - "Get deployment status in kagent namespace"


## Example Agent Interactions

Try these sample queries to generate different types of traces:

### Query 1: List Pods
```
Show me all pods in the kagent namespace
```

### Query 2: Get Deployments
```
List all deployments across all namespaces
```

### Query 3: Check Services
```
What services are running in the kube-system namespace?
```

## Monitor Agent Logs

While testing, monitor the agent logs to see trace generation:

```bash
# Follow k8s-agent logs
kubectl logs -f -n kagent -l app.kubernetes.io/name=k8s-agent
```

Look for log entries related to:
- OpenTelemetry trace exports
- Agent execution traces
- OTLP endpoint connections


## Next Steps
Proceed to Step 6 to access the Jaeger UI and analyze the generated traces.
