# Lab 020-035: Install kagent (CLI and Helm)

Short lab covering two install methods: CLI (good for local) and Helm (preferred for prod/repeatable).

## Prerequisites
- kubeconfig and cluster access (`kubectl`)
- macOS shell with `curl`, `kubectl`
- `OPENAI_API_KEY` available

## Steps
0. [Lab overview](./steps/00-lab-overview.md)
1. [Export API key](./steps/01-export-api-key.md)
2. [Install kagent CLI](./steps/02-install-kagent-cli.md)
3. [Install to cluster with CLI (-n kagent)](./steps/03-kagent-install.md)
4. [Validate installation](./steps/04-validate-installation.md)
5. [Reset to a clean environment](./steps/05-uninstall-cli.md)
6. [Install CRDs with Helm](./steps/06-install-crds-helm.md)
7. [Export OpenAI key (for Helm path)](./steps/07-export-openai-key.md)
8. [Install kagent with Helm](./steps/08-install-kagent-helm.md)
9. [Uninstall Helm installation](./steps/09-uninstall-helm.md)

Notes:
- Use namespace `kagent` for cluster resources.
- Port-forward messages after install can be normal; validate pods/services if unsure.