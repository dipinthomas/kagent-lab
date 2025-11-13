# Step 08: Build MCP Server Image

## Overview

Now that your MCP server works locally, it's time to package it as a Docker container image. This makes it portable and ready for deployment to Kubernetes.

## Understanding the Build Command

First, let's explore the build options:

```bash
kmcp build --help
```

### Expected Output

```
Build an MCP server from the current project.

This command will detect the project type and build the appropriate
MCP server Docker image.

Examples:
  kmcp build                    # Build Docker image from current directory
  kmcp build --project-dir ./my-project  # Build Docker image from specific directory

Usage:
  kmcp build [flags]

Flags:
  -h, --help                       help for build
      --kind-load                  Load image into kind cluster (requires kind)
      --kind-load-cluster string   Name of the kind cluster to load image into (default: current cluster)
      --platform string            Target platform (e.g., linux/amd64,linux/arm64)
  -d, --project-dir string         Build directory (default: current directory)
      --push                       Push Docker image to registry
  -t, --tag string                 Docker image tag (alias for --output)

Global Flags:
  -v, --verbose   verbose output
```

## Key Build Flags Explained

### `--project-dir`
Specifies the MCP server project directory to build.

### `--tag` or `-t`
Sets the Docker image name and tag. Format: `registry/image:tag`

Examples:
- `myregistry/mcp-server:v1.0`
- `docker.io/username/crypto-mcp:latest`
- `dipinthomas2003/kmcp-server:bitcoin`

### `--platform`
Specifies the target architecture. Important for cross-platform builds.

Common values:
- `linux/amd64` - For Intel/AMD processors (most cloud environments)
- `linux/arm64` - For ARM processors (Apple Silicon, some cloud instances)
- `linux/amd64,linux/arm64` - Multi-platform build

### `--push`
Automatically pushes the image to a container registry after building.

### `--kind-load`
Loads the image directly into a kind (Kubernetes in Docker) cluster for local testing.

## Quiz

**Question**: Why is the `--platform` flag important when building container images?

**Options**:
- A) It makes the build faster
- B) It determines which programming language to use
- C) It ensures the image is compatible with the target architecture (CPU type)
- D) It sets the Kubernetes version

**Answer: C) It ensures the image is compatible with the target architecture (CPU type)**

The `--platform` flag is crucial because container images must match the CPU architecture where they'll run. For example, if you build on an Apple Silicon Mac (ARM64) but deploy to a cloud server (AMD64), you need to specify `--platform linux/amd64` to ensure compatibility. Without this, you might get "exec format error" when trying to run the container.


## Build Your MCP Server Image

Now, let's build the image. We'll use a specific tag and platform:

```bash
kmcp build --project-dir crypto-price-mcp \
  -t dipinthomas2003/kmcp-server:bitcoin \
  --platform linux/amd64
```

**Note**: Replace `dipinthomas2003` with your Docker Hub username if you plan to push the image.

### What This Command Does

1. **Detects project type**: Recognizes it's a Python MCP server
2. **Creates Dockerfile**: Generates an optimized Dockerfile
3. **Installs dependencies**: Includes all packages from `pyproject.toml`
4. **Copies source code**: Adds your tools and configuration
5. **Builds image**: Creates the Docker image
6. **Tags image**: Names it `dipinthomas2003/kmcp-server:bitcoin`

### Expected Output

```
🔨 Building MCP server image...
📦 Project type: python
🐳 Generating Dockerfile...
🏗️  Building Docker image: dipinthomas2003/kmcp-server:bitcoin
[+] Building 45.2s (12/12) FINISHED
 => [internal] load build definition from Dockerfile
 => [internal] load .dockerignore
 => [internal] load metadata for docker.io/library/python:3.11-slim
 => [1/7] FROM docker.io/library/python:3.11-slim
 => [2/7] WORKDIR /app
 => [3/7] COPY pyproject.toml uv.lock ./
 => [4/7] RUN pip install uv && uv sync
 => [5/7] COPY src/ ./src/
 => [6/7] COPY kmcp.yaml ./
 => [7/7] RUN chmod +x src/main.py
 => exporting to image
 => => exporting layers
 => => writing image sha256:abc123...
 => => naming to dipinthomas2003/kmcp-server:bitcoin

✅ Successfully built image: dipinthomas2003/kmcp-server:bitcoin
```

## Verify the Image

Check that the image was created:

```bash
docker images | grep kmcp-server
```

### Expected Output

```
dipinthomas2003/kmcp-server   bitcoin   abc123def456   2 minutes ago   245MB
```

## Understanding the Image Contents

The built image contains:
- **Base OS**: Debian-based Python slim image
- **Python runtime**: Python 3.11+
- **Dependencies**: `fastmcp`, `requests`, and other packages
- **Your code**: All tools and configuration
- **Entry point**: Configured to run `src/main.py`

## Optional: Push to Registry

If you want to share your image or deploy from a registry:

```bash
docker login  # Login to Docker Hub first
kmcp build --project-dir crypto-price-mcp \
  -t dipinthomas2003/kmcp-server:bitcoin \
  --platform linux/amd64 \
  --push
```

The `--push` flag will automatically push after building.

## Image Naming Best Practices

### Format: `registry/repository:tag`

Examples:
- `docker.io/myuser/mcp-server:v1.0` - Versioned release
- `myregistry.com/team/crypto-mcp:latest` - Latest version
- `ghcr.io/org/mcp-server:sha-abc123` - Git commit SHA

### Tag Strategies

1. **Semantic versioning**: `v1.0.0`, `v1.0.1`
2. **Environment**: `dev`, `staging`, `prod`
3. **Feature**: `bitcoin`, `crypto-prices`, `feature-xyz`
4. **Git SHA**: `sha-abc123` (for traceability)
5. **Latest**: `latest` (always points to newest)

For this lab, we use `bitcoin` as a descriptive feature tag.



## Behind the Scenes

When you run `kmcp build`, it:

1. **Analyzes your project**: Reads `kmcp.yaml` and `pyproject.toml`
2. **Generates Dockerfile**: Creates an optimized multi-stage build
3. **Installs dependencies**: Uses `uv` for fast Python package installation
4. **Copies source code**: Adds only necessary files
5. **Sets entry point**: Configures the container to run your MCP server
6. **Builds image**: Uses Docker BuildKit for efficient building

## Summary

You've successfully built a container image for your MCP server! This image is now portable and can be deployed to any Kubernetes cluster.

**Key Takeaways**:
- ✅ `kmcp build` automates Docker image creation
- ✅ Platform flag ensures architecture compatibility
- ✅ Images can be tagged for versioning and organization
- ✅ Built images contain everything needed to run the MCP server
- ✅ Images can be pushed to registries for sharing

## What's Next?

Now that you have a container image, you'll deploy it to your Kubernetes cluster and make it available to K-Agent.

---

**Next Step**: [Step 09: Deploy MCP Server to Kubernetes](step09.md)
