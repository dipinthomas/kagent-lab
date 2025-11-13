# Step 4: Deploy Agent With Tools (But No MCP Credentials)

## Scenario
Deploy an agent with CloudWatch tools configured, but the MCP server has no AWS credentials. The agent will be ACCEPTED and READY, but tool calls will fail.

## Instructions

### 1. Clean Up Previous Agent (LAB PRE-REQUISITES automatic)

```bash
kubectl delete agent cloudwatch-log-analyzer-v1 -n kagent
```

### 2. Deploy Agent With Tools

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/broken-agents/04-with-tools.yaml
```

This agent has the tools section uncommented and properly configured.

### 3. Check Agent Status

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME                         TYPE          READY   ACCEPTED
cloudwatch-log-analyzer-v1   Declarative   True    True
```

### 4. Verify Tools Are Configured

```bash
kubectl describe agent cloudwatch-log-analyzer-v1 -n kagent | grep -A 15 "Tools:"
```

You should see the CloudWatch tools listed.

### 5. Test the Agent

Send a query to the agent:

**Query:** "Get the list of AWS CloudWatch log groups in the us-east-1 region."

**Expected Response:**
The agent will attempt to use the CloudWatch tools, but the operation will fail with an error related to AWS credentials. You might see:

```
I attempted to retrieve the CloudWatch log groups, but encountered an authentication error. 
The AWS credentials appear to be missing or invalid.

Error: Unable to locate credentials. You can configure credentials by running "aws configure".
```

Or similar credential-related error messages.

### 6. Check MCP Server Configuration

```bash
kubectl get mcpserver awslabs-cloudwatch -n kagent -o yaml | grep -A 5 "env:"
```

**Expected Output:**
```yaml
env:
  AWS_ACCESS_KEY_ID: ""
  AWS_REGION: us-east-1
  AWS_SECRET_ACCESS_KEY: ""
```

Notice the credentials are empty.

## Validation Questions

**Q1: Is the agent able to list all the log groups?**
- A) Yes
- B) No

**Answer:** B (No)

**Q2: Why is the agent unable to list the log groups?**
- A) Wrong tools configured
- B) Log groups not present in AWS
- C) Error due to missing credentials in MCP server
- D) Agent is not running

**Answer:** C

**Q3: What is the difference between this scenario and Step 3?**

**Answer:** In Step 3, the agent had no tools at all. In this step, the agent has tools configured, but the underlying MCP server lacks AWS credentials to authenticate with CloudWatch.

**Q4: Why is the agent still ACCEPTED=True and READY=True despite the credential issue?**

**Answer:** The agent's configuration is valid, and the pod is running. The credential issue is a runtime problem with the MCP server, not a configuration problem with the agent itself.

## Key Takeaways

- ✅ Tools alone are not enough—the MCP server needs proper credentials
- ✅ Agent can be READY even if its tools can't function
- ✅ Credential errors appear at runtime when tools are invoked
- ✅ MCP servers need environment variables (AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY) to access AWS services
- ✅ Always check MCP server configuration when tools fail

## Troubleshooting Flow

```
Agent Query → Agent calls tool → MCP Server attempts AWS API call → ❌ Fails (no credentials)
```

Proceed to Step 5 to fix the credentials.
