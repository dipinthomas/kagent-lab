# Step 5: Trigger agent from CLI

Use the kagent CLI to invoke the `k8s-agent` and stream responses from the controller.

```bash
# Ensure the controller API is reachable locally
kubectl -n kagent port-forward service/kagent-controller 8083:8083
```

In a separate terminal, invoke the agent:

```bash
# Basic usage with flags (short form shown)
kagent invoke -n kagent \
  -a k8s-agent \
  -t "list all pods in default namespace" \
  -S
```

Examples:
```bash
# Pods in kagent namespace
kagent invoke -n kagent -a k8s-agent -t "list all pods in the kagent namespace" -S

# Kubernetes version
kagent invoke -n kagent -a k8s-agent -t "what is the Kubernetes server version?" -S

# List deployments in kagent
kagent invoke -n kagent -a k8s-agent -t "list deployments in kagent namespace" -S
```


Troubleshooting:
```bash
# 1) If you see: "Task or file is required"
#    Use flags, not positional args: --agent/--task (or -a/-t)

# 2) If you see port-forward errors
#    Try different local port and set URL explicitly
kubectl -n kagent port-forward service/kagent-controller 18083:8083
kagent invoke --kagent-url http://localhost:18083 -n kagent -a k8s-agent -t "list all pods in kagent namespace" -S

# 3) Verify access and current context
kubectl config current-context
kubectl auth can-i create pods/portforward -n kagent
```

Questions
- What response do you get for: "list all pods in the kagent namespace"?
- How would you adjust the command to get output for another namespace?
- Which logs in the controller show the activity for your invocation?
