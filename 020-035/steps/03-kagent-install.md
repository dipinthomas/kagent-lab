# Step 3: Install kagent

Run the install command.

```bash
# Create namespace (idempotent)
kubectl create namespace kagent || true

# Install into the kagent namespace
kagent install -n kagent
```

Troubleshooting:
- If you previously installed into another namespace (e.g., default), uninstall first: `kagent uninstall -n default` and rerun the install with `-n kagent`.

output
```
████▒▒▒▒▒▒▒ Installing kagent-crds from oci://ghcr.io/kagent-dev/kagent/helm/

████████▒▒▒ Installing kagent [OpenAI] Using oci://ghcr.io/kagent-dev/kagent/helm/:0.7.2 [providers.default=openAI providers.openAI.apiKey=******** ]
kagent installed successfully
```

Notes:
- Local install: after installing into `kagent` namespace, you can open the dashboard:
  ```
  kagent dashboard
  
  kagent dashboard is available at http://localhost:8082
  Press the Enter Key to stop the port-forward...
  ```
- Remote cluster installs: you may see this message when auto port-forwarding is not possible or the namespace is wrong:
  ```
  Error starting port-forward: failed to establish connection to kagent-controller. error connecting to server. Please run 'install' command first
  ```
  Validate namespace and connectivity:
  - Ensure install used `-n kagent`
  - `kubectl get pods -n kagent`
  - Optional: `kubectl -n kagent port-forward svc/kagent-controller 8083:8083`