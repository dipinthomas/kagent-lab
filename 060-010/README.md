# Lab 060-010: CloudWatch AI Agent with MCP Server Integration

## Overview

This lab demonstrates how to create an AI agent from scratch using the Kagent UI and integrate it with AWS CloudWatch MCP server tools for intelligent log monitoring and analysis.

## Lab Structure

```
060-010/
├── README.md                                    # This file
├── steps/
│   ├── 00-lab-overview.md                      # Lab objectives and overview
│   ├── 00-LAB-PREPARATION-install-minimal-kagent.md  # Prerequisites setup
│   ├── 01-create-agent-from-ui.md              # Create agent via UI
│   └── 02-query-cloudwatch-logs.md             # Test log analysis
└── support-code/
    ├── cloudwatch-mcp-server.yaml              # MCP server configuration
    ├── cloudwatch-agent-example.yaml           # Example agent YAML
    └── setup-cloudwatch-logs.sh                # Log groups setup script
```

## Prerequisites

- Kubernetes cluster with kubectl access
- AWS CLI configured with appropriate permissions
- OpenAI API key for AI functionality
- Basic understanding of CloudWatch and Kubernetes

## Quick Start

1. **Setup Environment**
   ```bash
   # Make setup script executable
   chmod +x support-code/setup-cloudwatch-logs.sh
   
   # Run the setup script
   ./support-code/setup-cloudwatch-logs.sh
   ```

2. **Follow Lab Steps**
   - Start with `steps/00-LAB-PREPARATION-install-minimal-kagent.md`
   - Continue through each numbered step in sequence
   - Complete all validation checkpoints

## Learning Objectives

By completing this lab, you will:
- ✅ Create AI agents using Kagent UI
- ✅ Integrate agents with MCP servers
- ✅ Perform intelligent CloudWatch log analysis
- ✅ Understand AI-powered monitoring workflows
- ✅ Deploy and manage agents in Kubernetes

## Key Components

### CloudWatch MCP Server
- Provides CloudWatch API integration
- Enables log querying and analysis
- Supports metric filter management

### AI Agent
- GPT-4 powered log analysis
- Intelligent pattern recognition
- Automated troubleshooting recommendations

### Sample Data
- 15 CloudWatch log groups
- Realistic application logs
- Error patterns for analysis

## Validation Points

Each step includes validation criteria:
- ✅ Component deployment status
- ✅ Functional testing
- ✅ Expected response validation
- ✅ Error handling verification

## Troubleshooting

Common issues and solutions are documented in each step. Key areas:
- AWS credentials and permissions
- Kubernetes resource status
- MCP server connectivity
- Agent deployment issues

## Support Files

- **setup-cloudwatch-logs.sh**: Automated CloudWatch setup
- **cloudwatch-mcp-server.yaml**: MCP server deployment
- **cloudwatch-agent-example.yaml**: Reference agent configuration

## Duration

Approximately 45-60 minutes for complete lab execution.

## Next Steps

After completing this lab, consider:
- Exploring advanced CloudWatch features
- Creating custom MCP servers
- Building multi-agent workflows
- Implementing production monitoring solutions
