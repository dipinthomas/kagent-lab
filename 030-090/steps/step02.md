# Step 02: Explore kmcp CLI Options

## Overview

Before diving into development, let's explore the `kmcp` CLI commands and understand what each one does. This will give you a mental map of the MCP development workflow.

## Available Commands

Run the help command to see all available options:

```bash
kmcp --help
```

Let's break down each command:

### 1. `kmcp init`

**Purpose**: Initialize a new MCP server project

Creates a scaffolded project with:
- Project structure and directories
- Configuration files
- Sample tools
- Dependencies management

**Example**:
```bash
kmcp init python my-mcp-server
```

### 2. `kmcp add-tool`

**Purpose**: Add a new tool to an existing MCP server project

Generates:
- Tool implementation file
- Tool registration code
- Test templates

**Example**:
```bash
kmcp add-tool my_tool --project-dir ./my-mcp-server
```

### 3. `kmcp run`

**Purpose**: Run MCP server locally for testing

Features:
- Starts the MCP server on your local machine
- Enables testing with MCP Inspector
- Hot-reload during development

**Example**:
```bash
kmcp run --project-dir ./my-mcp-server
```

### 4. `kmcp build`

**Purpose**: Build MCP server as a Docker image

Capabilities:
- Creates containerized version of your server
- Supports multi-platform builds
- Can push to container registries
- Can load into kind clusters

**Example**:
```bash
kmcp build --project-dir ./my-mcp-server -t myregistry/mcp-server:v1
```

### 5. `kmcp deploy`

**Purpose**: Deploy MCP server to Kubernetes

Features:
- Generates Kubernetes manifests
- Deploys to specified namespace
- Configures service and networking

**Example**:
```bash
kmcp deploy --project-dir ./my-mcp-server
```

### 6. `kmcp secrets`

**Purpose**: Manage project secrets

Use cases:
- Store API keys
- Manage credentials
- Configure environment variables

### 7. `kmcp install`

**Purpose**: Install the KMCP controller on a Kubernetes cluster

Required for:
- Running MCP servers in Kubernetes
- Managing MCP server lifecycle
- Enabling agent-to-server communication

## The Development Workflow

Here's how these commands work together:

```
1. kmcp init          → Create project scaffold
2. kmcp add-tool      → Add custom tools
3. kmcp run           → Test locally
4. kmcp build         → Build container image
5. kmcp deploy        → Deploy to Kubernetes
```

## Exploring Command Help

Each command has detailed help. Try exploring:

```bash
kmcp init --help
kmcp build --help
kmcp deploy --help
```

## Quiz

**Question**: Which `kmcp` command would you use to test your MCP server locally before deploying to Kubernetes?

**Options**:
- A) `kmcp test`
- B) `kmcp run`
- C) `kmcp start`
- D) `kmcp deploy --local`


**Answer: B) `kmcp run`**

The `kmcp run` command starts your MCP server locally, allowing you to test it with tools like MCP Inspector before deploying to Kubernetes. This is a crucial step in the development workflow to catch issues early.


## Key Insights

Understanding the `kmcp` workflow:

1. **Scaffolding First**: Always start with `kmcp init` to get the right project structure
2. **Iterative Development**: Use `kmcp run` frequently during development
3. **Build Once, Deploy Many**: The `kmcp build` command creates portable container images
4. **Kubernetes Native**: The tool is designed for K8s deployment from the start

## Summary

You now understand the complete `kmcp` command suite and how they fit together in the MCP development lifecycle.

**Key Takeaways**:
- ✅ `kmcp` provides end-to-end MCP server development tools
- ✅ The workflow is: init → add-tool → run → build → deploy
- ✅ Local testing with `kmcp run` is essential before deployment
- ✅ Each command has detailed help available

---

**Next Step**: [Step 03: Create MCP Server Scaffold](step03.md)
