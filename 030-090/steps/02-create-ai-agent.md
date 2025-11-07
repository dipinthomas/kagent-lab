# Step 2: Create AI Agent for AWS Pricing

In this step, we'll create an AI agent that interfaces with the AWS Pricing MCP server to help users query AWS service pricing information.

## 1. Prerequisites

Ensure the AWS Pricing MCP server is running:
```bash
kubectl get pods -l app=aws-pricing-mcp
```

## 2. Deploy the Agent

Deploy the agent using the configuration in `support-code/pricing-agent.yaml`:

```bash
kubectl apply -f support-code/pricing-agent.yaml
```

This creates an AI agent that can:
- Query AWS service pricing information
- List available service attributes
- Retrieve detailed price lists

## 3. Understanding Available Operations

The agent supports three main operations:

1. **getProducts**
   - Get pricing information for AWS services
   - Supports filtering by service and attributes
   - Example: List available EC2 instance types

2. **getAttributeValues**
   - Retrieve valid values for service attributes
   - Useful for understanding available options
   - Example: List available regions for a service

3. **getPriceList**
   - Get detailed pricing information
   - Supports filtering by service and region
   - Example: Get pricing for specific instance types

## 4. Testing the Agent

Test the agent using kubectl:

```bash
# Check agent status
kubectl get pods -l app=aws-pricing-agent

# Test a product query
kubectl exec -it deploy/aws-pricing-agent -- curl -X POST http://localhost:8080/query \
  -H "Content-Type: application/json" \
  -d '{"query": "Show me available EC2 instance types in us-east-1"}'
```

## 5. Example Queries

Refer to `support-code/example-queries.md` for detailed examples of:
- Product information queries
- Attribute value queries
- Price list queries
- Using filters effectively

## 6. Error Handling

Common error scenarios:
- Invalid region specified
- Service not available in region
- Invalid attribute combinations

The agent will provide clear error messages and suggestions for corrections.

## Next Steps

1. Review the example queries document
2. Try basic product information queries
3. Experiment with filters and attributes
4. Practice complex price list queries
