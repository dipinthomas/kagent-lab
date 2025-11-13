# Step 1: Build and Push Docker Image

## Overview
Build a multi-platform Docker image containing the LangGraph currency exchange agent and push it to Docker Hub.

## Why Multi-Platform Builds?

Building for both `linux/amd64` and `linux/arm64` ensures your agent works on:
- **AMD64**: Intel/AMD processors (most cloud providers, standard servers)
- **ARM64**: Apple Silicon (M1/M2/M3), AWS Graviton, and other ARM-based systems

## Instructions

### 1. Navigate to the Workspace Root

The Dockerfile expects to be built from the workspace root because it copies multiple directories:

```bash
cd kagent-lab/060-040/support-code/agents
```

### 2. Build and Push the Multi-Platform Image

**Important**: Replace `dipinthomas2003` with your Docker Hub username!

```bash

docker buildx build . -f samples/langgraph/currency/Dockerfile -t <replace-with-your-dockerhub-username>/langgraph-currency:latest  --platform linux/amd64,linux/arm64  --push  

```


**Command Breakdown:**
- `.` - Build context (current directory: `/tmp/kagent/python`)
- `-f samples/langgraph/currency/Dockerfile` - Path to Dockerfile
- `-t <username>/langgraph-currency:latest` - Image name and tag
- `--platform linux/amd64,linux/arm64` - Build for both architectures
- `--push` - Push to Docker Hub after building


## Validation

✅ Docker image built successfully for both platforms  
✅ Image pushed to Docker Hub  
✅ `docker buildx imagetools inspect` shows both amd64 and arm64 manifests  
✅ You have noted your Docker Hub username and image tag for the next step

## What's Next?

Now that your agent is packaged as a Docker image, you'll:
1. Create a Kubernetes secret with your Google API key
2. Deploy the BYO agent using the image you just built
3. Test the agent via the A2A protocol
