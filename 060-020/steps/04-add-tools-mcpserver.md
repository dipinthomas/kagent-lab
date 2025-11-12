# Step 04: Add tools (CloudWatch MCP Server)

## Goal
Attach CloudWatch MCP Server tools to the agent.

## Instructions
Under `spec.declarative`, add a `tools` list with one `McpServer` entry referencing the existing MCP server:
- `apiGroup: kagent.dev`
- `kind: MCPServer`
- `name: awslabs-aws-cloudwatch-mcp-server-latest`
- `toolNames:` include the following tools:
  - analyze_log_group
  - analyze_metric
  - cancel_logs_insight_query
  - describe_log_groups
  - execute_log_insights_query
  - get_active_alarms
  - get_alarm_history
  - get_logs_insight_query_results
  - get_metric_data
  - get_metric_metadata
  - get_recommended_metric_alarms

## Expected YAML Snippet
```yaml
spec:
  declarative:
    tools:
    - mcpServer:
        apiGroup: kagent.dev
        kind: MCPServer
        name: awslabs-aws-cloudwatch-mcp-server-latest
        toolNames:
        - analyze_log_group
        - analyze_metric
        - cancel_logs_insight_query
        - describe_log_groups
        - execute_log_insights_query
        - get_active_alarms
        - get_alarm_history
        - get_logs_insight_query_results
        - get_metric_data
        - get_metric_metadata
        - get_recommended_metric_alarms
      type: McpServer
```

Proceed to Step 05.
