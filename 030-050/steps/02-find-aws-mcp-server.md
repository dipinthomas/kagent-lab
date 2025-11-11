# Step 1: Find AWS MCP Server

## Overview
This step focuses on understanding the AWS Pricing MCP Server, which provides real-time AWS pricing information and cost analysis capabilities through the Model Context Protocol (MCP).

## Official Documentation
📖 **Reference**: [AWS Pricing MCP Server Documentation](https://awslabs.github.io/mcp/servers/aws-pricing-mcp-server)

## Key Features
- **AWS Pricing Discovery & Information**: Service catalog exploration, pricing attribute discovery, real-time pricing queries
- **Cost Analysis & Planning**: Detailed cost reports, infrastructure project analysis, architecture pattern guidance
- **Natural Language Queries**: Ask questions about AWS pricing in plain English

## Multiple Choice Questions

### 1. What specific AWS IAM permissions are required for the AWS Pricing MCP Server to access the AWS Pricing API?

**A)** `ec2:*` permissions  
**B)** `pricing:*` permissions  
**C)** `s3:GetObject` permissions  
**D)** `iam:ListRoles` permissions  

**Correct Answer: B** - The AWS IAM role or user must have `pricing:*` permissions to access the AWS Pricing API. The server only accesses generally available AWS pricing information and does not retrieve any user-specific data.

### 2. What are the two key environment variables used by the AWS Pricing MCP Server for configuration?

**A)** `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_PROFILE`   
**B)** `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_PROFILE` and `AWS_REGION`  
**C)** `AWS_DEFAULT_REGION` and `AWS_SESSION_TOKEN`  
**D)** `AWS_CONFIG_FILE` and `AWS_CREDENTIALS_FILE`  

**Correct Answer: B** - The two key environment variables are:
- **`AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY` and `AWS_PROFILE` `**: Specifies the AWS profile or env vars to use from your AWS configuration file (defaults to "default")
- **`AWS_REGION`**: Determines the geographically closest AWS Pricing API endpoint for better performance

### 3. What is the main difference between Linux/MacOS and Windows configuration when using uv installation method?

**A)** Windows requires Docker while Linux/MacOS uses native installation  
**B)** Linux/MacOS requires additional security permissions  
**C)** Windows uses `--from` flag and `.exe` extension in the args configuration  
**D)** There is no difference between the platforms  

**Correct Answer: C** - Windows configuration requires:
- **Windows**: `["--from", "awslabs.aws-pricing-mcp-server@latest", "awslabs.aws-pricing-mcp-server.exe"]`
- **Linux/MacOS**: `["awslabs.aws-pricing-mcp-server@latest"]`

### 4. Which installation methods are available for the AWS Pricing MCP Server?

**A)** Only Docker installation  
**B)** Only uv installation  
**C)** Both uv and Docker installation methods  
**D)** npm and pip installation methods  

**Correct Answer: C** - Two installation methods are available:
- **Method 1**: Using uv (⚡ Recommended) - `uvx awslabs.aws-pricing-mcp-server@latest`
- **Method 2**: Using Docker - `docker build -t awslabs/aws-pricing-mcp-server .`

## Prerequisites
1. Install uv from Astral
2. Install Python 3.10 using `uv python install 3.10`
3. Set up AWS credentials with appropriate permissions
4. Configure AWS credentials via `aws configure` or environment variables
