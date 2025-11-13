# Lab 060-030: Troubleshoot and Fix Broken Agents

## Overview
This lab teaches you to diagnose and fix common Agent deployment issues through hands-on troubleshooting exercises.

## Lab Structure

```
060-030/
├── README.md                                    # This file
├── steps/
│   ├── 00-lab-overview.md                      # Lab objectives
│   ├── 00-LAB-PREPARATION-setup.md             # Setup with intentional issues
│   ├── 01-fix-invalid-modelconfig.md           # Fix ModelConfig reference
│   ├── 02-fix-wrong-mcpserver-name.md          # Fix MCP server name
│   ├── 03-agent-without-tools.md               # Understand tool importance
│   ├── 04-agent-with-tools-no-credentials.md   # Diagnose credential issues
│   └── 05-fix-mcp-credentials.md               # Fix and verify
└── support-code/
    ├── 01-values-min.yaml                      # Minimal Kagent values
    ├── openai-modelconfig.yaml                 # Custom ModelConfig
    ├── cloudwatch-mcp-server-broken.yaml       # MCP server without creds
    ├── cloudwatch-mcp-server-fixed.yaml        # MCP server template with creds
    ├── setup-cloudwatch-logs.sh                # CloudWatch log groups setup
    └── broken-agents/
        ├── 01-invalid-modelconfig.yaml         # Agent with wrong ModelConfig
        ├── 02-wrong-mcpserver.yaml             # Agent with wrong MCP name
        ├── 03-no-tools.yaml                    # Agent without tools
        └── 04-with-tools.yaml                  # Agent with tools (for Step 4 & 5)
```

## Prerequisites

- Kubernetes cluster with kubectl access
- AWS CLI configured with CloudWatch permissions
- OpenAI API key
- Basic understanding of Kagent concepts

## Quick Start

1. **Setup Environment**
   ```bash
   # Follow preparation steps
   cd steps
   cat 00-LAB-PREPARATION-setup.md
   ```

2. **Work Through Scenarios**
   - Follow steps 01-05 in order
   - Each step introduces a specific issue
   - Diagnose using `kubectl describe`
   - Apply fixes and verify

## Learning Path

### Step 1: Invalid ModelConfig
- **Issue**: Agent references non-existent ModelConfig
- **Status**: ACCEPTED=False
- **Fix**: Update to correct ModelConfig name

### Step 2: Wrong MCP Server Name
- **Issue**: Agent references MCP server with wrong name
- **Status**: ACCEPTED=False
- **Fix**: Update to correct MCP server name

### Step 3: No Tools
- **Issue**: Agent has no tools configured
- **Status**: ACCEPTED=True, READY=True (but limited functionality)
- **Learning**: Tools are required for CloudWatch operations

### Step 4: Missing Credentials
- **Issue**: MCP server has no AWS credentials
- **Status**: ACCEPTED=True, READY=True (but tool calls fail)
- **Learning**: Credentials are required at runtime

### Step 5: Fix Everything
- **Fix**: Add AWS credentials to MCP server
- **Result**: Fully functional CloudWatch agent

## Key Commands

```bash
# Check agent status
kubectl get agents -n kagent

# Diagnose issues
kubectl describe agent <agent-name> -n kagent

# Check MCP servers
kubectl get mcpservers -n kagent

# Check ModelConfigs
kubectl get modelconfigs -n kagent

# View agent logs
kubectl logs -n kagent -l app.kubernetes.io/name=<agent-name>
```

## Validation

After completing all steps:
- ✅ Agent is ACCEPTED=True and READY=True
- ✅ Agent can list CloudWatch log groups
- ✅ Agent can analyze logs and find errors
- ✅ You understand common failure modes

## Duration

Approximately 45-60 minutes

## Difficulty

Intermediate - requires understanding of Kubernetes resources and troubleshooting skills
