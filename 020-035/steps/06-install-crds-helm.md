# Step 6: Install the kagent Helm chart CRDs

Install the CustomResourceDefinitions via Helm.

```bash
helm install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
  --namespace kagent \
  --create-namespace
```

Validation (to be performed):

```bash
# 1) Check the Helm release exists
helm list -n kagent | grep kagent-crds || echo "kagent-crds release not found"
```
output

```
kagent-crds     kagent          1               2025-11-04 12:07:35.432739 +1300 NZDT   deployed        kagent-crds-0.7.2
```

