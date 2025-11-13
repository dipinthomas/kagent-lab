# Step 01: Install kmcp CLI

## Overview

The `kmcp` CLI is a command-line tool that streamlines the development, building, and deployment of MCP servers. It provides scaffolding, local testing, and Kubernetes integration capabilities.

## Installation

Run the following command to install `kmcp`:

```bash
curl -fsSL https://raw.githubusercontent.com/kagent-dev/kmcp/refs/heads/main/scripts/get-kmcp.sh | bash
```

### What This Does

The installation script will:
1. Download the latest `kmcp` binary for your platform
2. Install it to `/usr/local/bin` (or your system's binary path)
3. Make it executable
4. Verify the installation

### Expected Output

You should see output similar to:

```
Downloading kmcp...
Installing kmcp to /usr/local/bin...
kmcp installed successfully!
```

## Verify Installation

Confirm that `kmcp` is installed correctly:

```bash
kmcp --help
```

### Expected Output

You should see the help menu:

```
KMCP is a CLI tool for building and managing Model Context Protocol (MCP) servers.

It provides a unified development experience for creating, building, and deploying
MCP servers locally and to Kubernetes clusters.

Usage:
  kmcp [command]

Available Commands:
  add-tool    Add a new MCP tool to your project
  build       Build MCP server as a Docker image
  completion  Generate the autocompletion script for the specified shell
  deploy      Deploy MCP server to Kubernetes
  help        Help about any command
  init        Initialize a new MCP server project
  install     Install the KMCP controller on a Kubernetes cluster
  run         Run MCP server locally
  secrets     Manage project secrets

Flags:
  -h, --help      help for kmcp
  -v, --verbose   verbose output
      --version   version for kmcp

Use "kmcp [command] --help" for more information about a command.
```

## Check Version

You can also check the installed version:

```bash
kmcp --version
```

## Quiz

**Question**: What is the primary purpose of the `kmcp` CLI tool?

**Options**:
- A) To manage Kubernetes clusters
- B) To build and manage Model Context Protocol (MCP) servers
- C) To deploy Docker containers
- D) To monitor AI agent performance


**Answer: B) To build and manage Model Context Protocol (MCP) servers**

The `kmcp` CLI is specifically designed for MCP server development, providing commands for initialization, building, testing, and deployment of MCP servers.


## Summary

You've successfully installed the `kmcp` CLI tool! This tool will be your companion throughout the MCP server development process.

**Key Takeaways**:
- ✅ `kmcp` is the primary tool for MCP server development
- ✅ It provides scaffolding, building, and deployment capabilities
- ✅ The tool integrates with both local development and Kubernetes

---

**Next Step**: [Step 02: Explore kmcp CLI Options](step02.md)
