# Step 2: Install kagent with kagent CLI

## 1) Pre-check: is the CLI already installed?

```bash
kagent version
```

Expected (if not installed):

```
command not found: kagent
```

## 2) Install the CLI

```bash
curl https://raw.githubusercontent.com/kagent-dev/kagent/refs/heads/main/scripts/get-kagent | bash
```

Example output (truncated):

```
... get-kagent | bash
Downloading https://cr.kagent.dev/v0.7.2/kagent-darwin-arm64
Verifying checksum... Done.
Preparing to install kagent into /usr/local/bin
Password:
kagent installed into /usr/local/bin/kagent
```

## 3) Verify the installation

```bash
kagent version
```

Example output:

```
{"backend_version":"unknown","build_date":"2025-10-30","git_commit":"8062481","kagent_version":"0.7.2"}
```

```bash
kagent --help
```

You should see usage, commands, and flags listed.

```
kagent is a CLI and TUI for kagent

Usage:
  kagent [flags]
  kagent [command]

Available Commands:
  add-mcp     Add an MCP server entry to kagent.yaml
  bug-report  Generate a bug report
  build       Build a Docker images for an agent project
  completion  Generate the autocompletion script for the specified shell
  dashboard   Open the kagent dashboard
  deploy      Deploy an agent to Kubernetes
  get         Get a kagent resource
  help        Help about any command
  init        Initialize a new agent project
  install     Install kagent
  invoke      Invoke a kagent agent
  mcp         MCP (Model Context Protocol) server management
  run         Run agent project locally with docker-compose and launch chat interface
  uninstall   Uninstall kagent
  version     Print the kagent version

Flags:
      --config string          config file (default is $HOME/.kagent/config.yaml) (default "/Users/admin/.kagent/config.yaml")
  -h, --help                   help for kagent
      --kagent-url string      KAgent URL (default "http://localhost:8083")
  -n, --namespace string       Namespace (default "kagent")
  -o, --output-format string   Output format (default "table")
      --timeout duration       Timeout (default 5m0s)
  -v, --verbose                Verbose output

Use "kagent [command] --help" for more information about a command.
```