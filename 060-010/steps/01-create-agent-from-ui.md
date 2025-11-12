# Step 1: Login to UI and Create CloudWatch AI Agent

## Objective
Create an AI agent from scratch using the Kagent UI and integrate it with CloudWatch MCP server tools for log analysis capabilities.

## Prerequisites
- Kagent UI is accessible at `http://localhost:8080`
- CloudWatch MCP server is deployed and running
- AWS credentials are configured

## Step-by-Step Instructions

### 1. Access Kagent Dashboard

```bash
# Ensure port-forward is active
kubectl port-forward -n kagent svc/kagent-ui 8080:80
```

Open your browser and navigate to: `http://localhost:8080`

### 2. Navigate to Agent Creation

1. **Login to Kagent Dashboard**
   - Open `http://localhost:8080` in your browser
   - You should see the Kagent main dashboard

2. **Access Agent Management**
   - Click on **"Agents"** in the left navigation menu
   - Click **"Create Agent"** or **"+ New Agent"** button
   ![alt text](image.png)

### 3. Configure Basic Agent Settings

Fill in the following agent configuration:

**Basic Information:**
- **Agent Name**: `cloudwatch-log-analyzer`
- **Namespace**: `kagent` (default)
- **Type**: `Declarative`
- **Description**: `AI agent for analyzing CloudWatch logs and extracting insights`

**Agent Instructions** (add this in the agent configuration):
```
You are a CloudWatch log analysis expert. Your role is to help users analyze AWS CloudWatch logs, identify patterns, troubleshoot issues, and extract meaningful insights from log data.

Key capabilities:
- Query and filter CloudWatch log groups and streams
- Analyze log patterns and identify anomalies
- Create metric filters for monitoring
- Provide troubleshooting recommendations
- Generate summaries and reports from log data

Always provide clear, actionable insights and explain your analysis process.
```

**Model Configuration:**
- **selected the default provider available**

### 4. Add CloudWatch MCP Server Tools

In the **Tools Configuration** section:

1. **Click "Add Tool & Agents"**
2. **Select Tool Type**: `kagent/awslabs-aws-cloudwatch-mcp-server-latest`
   
4. **Select CloudWatch Tools** select all available tools
5. **Click "save selections"**
6. **Click "Create Agent"**
   

### 5. Validate Agent Deployment

#### Check Agent Status in UI
- Navigate back to the **Agents** page
- Verify `cloudwatch-log-analyzer` appears in the list
- Status should show as **"Running"** or **"Ready"**

#### Validate via kubectl
```bash
# Check agent deployment
kubectl get agents -n kagent

# Verify agent pod is running
kubectl get pods -n kagent -l app.kubernetes.io/name=cloudwatch-log-analyzer

# Check agent logs
kubectl logs -n kagent -l app.kubernetes.io/name=cloudwatch-log-analyzer
```

Expected output:
```
NAME                     READY   STATUS    RESTARTS   AGE
cloudwatch-log-analyzer-xxx   1/1     Running   0          2m
```

### 9. Test Agent Connectivity

#### Quick Test via UI
1. Navigate to the **Chat** or **Test** section in the UI
2. Select your `cloudwatch-log-analyzer` agent
3. Send a simple test message: `"Hello, can you help me analyze CloudWatch logs?"`

#### Expected Response
The agent should respond with something like:
```
Hello! I'd be happy to help you analyze your CloudWatch logs. Could you please provide more details on what specific logs or log groups you'd like to analyze? Also, let me know if you have a particular time range, patterns, errors, or issues you want to focus on. This will help me assist you better.
```

## Lab Validation Checklist

- ✅ Agent `cloudwatch-log-analyzer` is created in Kagent UI
- ✅ Agent pod is running in Kubernetes
- ✅ CloudWatch MCP server tools are properly configured
- ✅ Agent responds to basic test queries
- ✅ No error messages in agent logs


## Next Steps

Once your agent is successfully deployed and validated, proceed to **Step 2** to test CloudWatch log querying capabilities.
