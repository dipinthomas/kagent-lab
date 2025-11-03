# Step 9: Uninstall Helm installation

Remove kagent deployed via Helm.

```bash
helm uninstall kagent -n kagent || true
```

Validation (to be performed):

```bash
# 1) Confirm release is gone
helm list -n kagent | grep "\bkagent\b" || echo "kagent release removed"

# 2) Remaining resources overview (should reduce)
kubectl get all -n kagent || true
```

Note:
- CRDs installed by `kagent-crds` remain cluster-wide. To remove them too:

```bash
helm uninstall kagent-crds -n kagent || true
kubectl get crd | grep kagent.dev || echo "kagent.dev CRDs removed"
```
