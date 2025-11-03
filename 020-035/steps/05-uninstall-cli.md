# Step 5: Reset to a clean environment

## IMPORTANT
**This step runs in the background. Students do not need to take any action.**
- Show a spinner or progress indicator while it executes.
- This step is requried only when we plan to reuse the environment to install with helm again



Prepare a pristine state before installing with Helm in the next step.

Cluster cleanup (namespace `kagent`):

```bash
# Uninstall any Helm releases (ignore errors if not present)
helm uninstall kagent -n kagent || true
helm uninstall kagent-crds -n kagent || true

# Delete the namespace to ensure all resources are removed
kubectl delete namespace kagent --wait=false || true
```

Optional: local CLI cleanup (if you installed the CLI earlier and want a fresh start):

```bash
sudo rm -f /usr/local/bin/kagent
rm -rf ~/.kagent
```

Fix kubeconfig permission warnings (optional but recommended on macOS):

```bash
chmod go-r ~/.kube/config
```

Verification:

```bash
kubectl get ns kagent || echo "kagent namespace removed"
which kagent || echo "kagent CLI not present"
```

Next: proceed to the Helm-based installation step.
