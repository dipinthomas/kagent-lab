# Lab 060-040: Deploy a BYO (Bring Your Own) LangGraph Agent

## Overview
Learn how to deploy custom agents built with LangGraph as BYO (Bring Your Own) agents in Kagent. This lab demonstrates the full workflow from building a Docker image to deploying and testing a currency exchange agent.

## Lab Structure

```
060-040/
├── README.md                                    # This file
├── steps/
│   ├── 00-lab-overview.md                      # Lab objectives and BYO concepts
│   ├── 00-LAB-PREPARATION-install-minimal-kagent.md  # Setup Kagent
│   ├── 01-build-docker-image.md                # Build multi-platform image
│   ├── 02-create-google-api-secret.md          # Create API credentials
│   ├── 03-deploy-byo-agent.md                  # Deploy the agent
│   └── 04-test-agent.md                        # Test via A2A protocol and UI
└── support-code/
    ├── 01-values-min.yaml                      # Minimal Kagent configuration
    └── langgraph-agent.yaml                    # BYO agent definition
```

## Prerequisites

- Kubernetes cluster with kubectl access
- Docker with buildx support
- Google API key (Gemini API access)
- Docker Hub account
- Basic understanding of Kagent concepts

## Quick Start

1. **Install Kagent**
   ```bash
   cd steps
   cat 00-LAB-PREPARATION-install-minimal-kagent.md
   ```

2. **Build Docker Image**
   ```bash
   cd /tmp/kagent/python
   docker buildx build . \
     -f samples/langgraph/currency/Dockerfile \
     -t <YOUR_USERNAME>/langgraph-currency:v2 \
     --platform linux/amd64,linux/arm64 \
     --push
   ```

3. **Create Google API Secret**
   ```bash
   export GOOGLE_API_KEY=your-api-key-here
   kubectl create secret generic kagent-google -n kagent \
     --from-literal=GOOGLE_API_KEY=$GOOGLE_API_KEY \
     --dry-run=client -o yaml | kubectl apply -f -
   ```

4. **Deploy Agent**
   ```bash
   kubectl apply -f support-code/langgraph-agent.yaml
   ```

5. **Test Agent**
   ```bash
   kubectl port-forward svc/kagent-controller 8080:8080 -n kagent
   # Open http://localhost:8080 and query: "USD to NZD exchange rate?"
   ```

## What You'll Learn

### BYO Agent Concepts
- **Full Control**: Complete control over agent logic and behavior
- **Framework Flexibility**: Use LangGraph, ADK, or any custom framework
- **A2A Protocol**: Standard agent-to-agent communication
- **Container-Based**: Package agents as Docker images

### Technical Skills
- Building multi-platform Docker images with buildx
- Managing Kubernetes secrets for API credentials
- Deploying custom agents to Kagent
- Testing agents via A2A protocol
- Integrating external APIs (Google Gemini)

## Learning Path

### Step 0: Preparation
- Install Kagent with minimal configuration
- Understand BYO vs Declarative agents
- Prepare Google API credentials

### Step 1: Build Docker Image
- Understand Docker build context
- Build for multiple platforms (amd64/arm64)
- Push to Docker Hub
- Verify multi-platform manifests

### Step 2: Create API Secret
- Create Kubernetes secrets
- Understand secret security best practices
- Reference secrets in agent configuration

### Step 3: Deploy BYO Agent
- Configure BYO agent YAML
- Understand cmd and args fields
- Deploy and verify agent status
- Troubleshoot deployment issues

### Step 4: Test Agent
- Access via A2A protocol
- Query through Kagent UI
- Test currency exchange functionality
- Understand agent capabilities

## Key Concepts

### BYO vs Declarative Agents

| Feature | Declarative | BYO |
|---------|------------|-----|
| **Definition** | Kagent CRDs | Custom container |
| **Control** | Limited | Full |
| **Complexity** | Simple | Complex workflows |
| **Protocol** | Native | A2A |
| **Use Case** | Standard agents | Custom integrations |

### The Currency Exchange Agent

Built with **LangGraph**, this agent:
- Provides real-time currency exchange rates
- Converts between different currencies
- Uses Google Gemini API for processing
- Demonstrates BYO agent capabilities

## Key Commands

```bash
# Build multi-platform image
docker buildx build . -f Dockerfile -t image:tag --platform linux/amd64,linux/arm64 --push

# Create secret
kubectl create secret generic name -n namespace --from-literal=KEY=value

# Deploy agent
kubectl apply -f agent.yaml

# Check agent status
kubectl get agents -n kagent

# View agent logs
kubectl logs -n kagent -l app.kubernetes.io/name=langgraph-agent

# Test A2A endpoint
curl localhost:8083/api/a2a/kagent/langgraph-agent/.well-known/agent.json
```

## Validation

After completing all steps:
- ✅ Multi-platform Docker image built and pushed
- ✅ Google API secret created in Kubernetes
- ✅ BYO agent deployed with READY=True and ACCEPTED=True
- ✅ Agent accessible via A2A protocol
- ✅ Currency exchange queries working correctly

