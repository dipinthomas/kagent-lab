# Step 2: Fix Agent with Wrong MCP Server Name

## Scenario
Deploy an agent that references an MCP server with the wrong name. The agent will not be ACCEPTED.

## Instructions

### 1. Clean Up Previous Agent (LAB PRE-REQUISITES automatic)

```bash
kubectl delete agent cloudwatch-log-analyzer-v1 -n kagent
```

### 2. Deploy Agent with Wrong MCP Server Name  

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/broken-agents/02-wrong-mcpserver.yaml
```

### 3. Check Agent Status

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME                         TYPE          READY   ACCEPTED
cloudwatch-log-analyzer-v1   Declarative   True   False
```

Notice: `ACCEPTED=False` again

### 4. Diagnose the Problem

```bash
kubectl describe agent cloudwatch-log-analyzer-v1 -n kagent
```

**Look for the error message:**
```
Conditions:
  Type:     Accepted
  Status:   False
  Reason:   MCPServerNotFound
  Message:  MCPServer "awslabs-aws-cloudwatch-mcp-server-latest" not found
```

### 5. List Available MCP Servers

```bash
kubectl get mcpservers -n kagent
```

**Expected Output:**
```
NAME                   READY   AGE
awslabs-cloudwatch     True    10m
```

Notice the actual name is `awslabs-cloudwatch`, not `awslabs-aws-cloudwatch-mcp-server-latest`.

### 6. Fix the Agent

Edit the agent to use the correct MCP server name:

```bash
kubectl edit agent cloudwatch-log-analyzer-v1 -n kagent
```

Find the tools section and change:
```yaml
tools:
- mcpServer:
    apiGroup: kagent.dev
    kind: MCPServer
    name: awslabs-aws-cloudwatch-mcp-server-latest  # ❌ Wrong
```

To:
```yaml
tools:
- mcpServer:
    apiGroup: kagent.dev
    kind: MCPServer
    name: awslabs-cloudwatch  # ✅ Correct
```

Save and exit.

### 7. Verify the Fix

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME                         TYPE          READY   ACCEPTED
cloudwatch-log-analyzer-v1   Declarative   True    True
```

### 8. Test the Agent (Basic Query)

Try to query CloudWatch log groups:

**Query:** "Can you list all the AWS CloudWatch log groups available in the us-east-1 region?"

**Expected Response:** The agent will attempt to use the CloudWatch tools, but may fail due to missing credentials (we'll fix this in Step 5).

## Validation Questions

**Q1: What was the actual name of the MCP server deployed in the cluster?**

**Answer:** `awslabs-cloudwatch`

**Q2: Why is it important that the MCP server name in the agent spec matches exactly?**
- A) For performance optimization
- B) Kubernetes requires exact name matching for resource references
- C) To enable logging
- D) For security purposes

**Answer:** B

**Q3: Which kubectl command shows all available MCP servers?**

**Answer:** `kubectl get mcpservers -n kagent`

## Key Takeaways

- ✅ MCP server names must match exactly (case-sensitive)
- ✅ Use `kubectl get mcpservers` to find available MCP servers
- ✅ The agent won't be ACCEPTED if it references non-existent resources
- ✅ Always verify resource names before referencing them

Proceed to Step 3.
