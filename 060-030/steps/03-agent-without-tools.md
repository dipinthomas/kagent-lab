# Step 3: Deploy Agent Without Tools

## Scenario
Deploy an agent without any tools configured. The agent will be ACCEPTED and READY, but won't be able to perform CloudWatch operations.

## Instructions

### 1. Clean Up Previous Agent (LAB PRE-REQUISITES automatic)

```bash
kubectl delete agent cloudwatch-log-analyzer-v1 -n kagent
kubectl delete -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/broken-agents/03-no-tools.yaml
```

### 2. Deploy Agent Without Tools 

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/broken-agents/03-no-tools.yaml
```

### 3. Check Agent Status

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME                         TYPE          READY   ACCEPTED
cloudwatch-log-analyzer-v1   Declarative   True    True
```

Notice: Both `READY=True` and `ACCEPTED=True` ✅

### 4. Verify Agent Pod is Running

```bash
kubectl get pods -n kagent -l app.kubernetes.io/name=cloudwatch-log-analyzer-v1
```

**Expected Output:**
```
NAME                                          READY   STATUS    RESTARTS   AGE
cloudwatch-log-analyzer-v1-xxxxxxxxxx-xxxxx   1/1     Running   0          30s
```

### 5. Test the Agent

Send a query to the agent asking it to list CloudWatch log groups.

**Query:** "Get the list of AWS CloudWatch log groups in the us-east-1 region, using tools available to you."

**Expected Response:**
The agent will respond but **cannot** actually list the log groups because it has no tools to interact with CloudWatch. It might say something like:

```
Sorry, I don't have direct access to AWS tools or your AWS environment to execute commands on your behalf. However, I can guide you step-by-step on how to get the list of AWS CloudWatch log groups in the us-east-1 region using AWS CLI or SDK.
```

Or it might provide generic information about CloudWatch without actual data.

## Validation Questions

**Q1: Is the agent able to list all the log groups?**
- A) Yes
- B) No

**Answer:** B (No)

**Q2: Why can't the agent list the CloudWatch log groups?**
- A) The agent is not running
- B) The agent has no tools configured
- C) AWS credentials are missing
- D) The MCP server is down

**Answer:** B

**Q3: Even though the agent cannot perform CloudWatch operations, why is it still ACCEPTED and READY?**

**Answer:** The agent's configuration is valid (correct ModelConfig, no invalid references), and the pod is running successfully. Tools are optional for agent acceptance—the agent just won't have any special capabilities without them.

### 6. Fix the agent and add tools required

Solution uncomment tools section and apply the agent again. 

    # ❌ NO TOOLS CONFIGURED - Agent will be accepted but can't access CloudWatch
    # tools:
    # - mcpServer:
    #     apiGroup: kagent.dev
    #     kind: MCPServer
    #     name: awslabs-cloudwatch  # ✅ Correct MCP server name
    #     toolNames:
    #     - analyze_log_group
    #     - analyze_metric
    #     - cancel_logs_insight_query
    #     - describe_log_groups
    #     - execute_log_insights_query
    #     - get_active_alarms
    #     - get_alarm_history
    #     - get_logs_insight_query_results
    #     - get_metric_data
    #     - get_metric_metadata
    #     - get_recommended_metric_alarms
    #   type: McpServer



## Key Takeaways

- ✅ An agent can be ACCEPTED and READY without tools
- ✅ Tools are what give agents their special capabilities
- ✅ Without tools, agents can only use their base LLM knowledge
- ✅ Tools must be explicitly configured in the agent spec
- ✅ The agent's systemMessage describes capabilities, but tools enable them

## Understanding the Difference

| Aspect | Without Tools | With Tools |
|--------|---------------|------------|
| Agent Status | ACCEPTED=True, READY=True | ACCEPTED=True, READY=True |
| Pod Status | Running | Running |
| Can answer questions | Yes (using LLM knowledge) | Yes (using LLM knowledge) |
| Can query AWS CloudWatch | ❌ No | ✅ Yes |
| Can access real-time data | ❌ No | ✅ Yes |

Proceed to Step 4.
