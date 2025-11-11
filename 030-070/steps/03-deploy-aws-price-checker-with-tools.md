# step 0: Find the list of tools available in the pricing mcp server

login to kagent dashboard and find the list of tools available in the pricing mcp server. Below is the expected answer. 

- get_pricing_service_codes
- get_pricing_service_attributes
- get_pricing_attribute_values
- get_pricing
- get_price_list_urls
- generate_cost_report

# step2: Update agent with tools

Following section to be added to  /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-070/support-code/with_tool_aws-price-checker.yaml

    tools:
    - mcpServer:
        apiGroup: kagent.dev
        kind: MCPServer
        name: awslabs-aws-pricing-mcp-server-latest
        toolNames:
        - get_pricing_service_codes
        - get_pricing_service_attributes
        - get_pricing_attribute_values
        - get_pricing
        - get_price_list_urls
        - generate_cost_report
      type: McpServer
  description: aws price checker api
  type: Declarative


# step 1: Deploy price checker agent

kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-070/support-code/with_tool_aws-price-checker.yaml

# step 2: validate the agent

ensure pod like "aws-price-check-759558d984-62npw" is running

# step 3: Query the agent with below question

Prompt query as below:

"what is the cost of on-demand g4dn.16xlarge ec2 instance, linux operating system and shared-instance tenancy in us-east-1 and ap-southeast-2 ?"


![agent+mcp](image-1.png)


