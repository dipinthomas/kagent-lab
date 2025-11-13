# Kagent Quiz

## Section 020-035

**1. What are the two primary methods for installing kagent mentioned in the lab?**

A) Docker and npm
B) kagent CLI and Helm
C) Binary download and source compilation
D) Ansible and Terraform

**Answer: B**

**2. Which command is used to verify the installation of the kagent CLI?**

A) `kagent status`
B) `kagent --version`
C) `kagent version`
D) `kagent info`

**Answer: C**

**3. When installing kagent into a specific namespace using the CLI, which flag should be used?**

A) `--namespace kagent`
B) `-n kagent`
C) `--ns kagent`
D) Both A and B

**Answer: D**

**4. After installing kagent, which command can be used to check the status of the kagent pods in the `kagent` namespace?**

A) `kubectl get pods -n default`
B) `kubectl get pods -n kagent`
C) `kubectl get all -n kagent`
D) `kagent get pods`

**Answer: B**

**5. How do you uninstall a kagent release deployed via Helm in the `kagent` namespace?**

A) `helm delete kagent -n kagent`
B) `helm remove kagent -n kagent`
C) `helm uninstall kagent -n kagent`
D) `kubectl delete helm kagent -n kagent`

**Answer: C**

## Section 020-040

**1. What is the purpose of installing kagent with a minimal configuration?**

A) To install all agents and tools for a full-featured setup.
B) To keep the footprint small while allowing exploration of CRDs and ModelConfigs.
C) To only install the kagent CLI without any cluster components.
D) To set up a production-ready environment.

**Answer: B**

**2. What is the role of the `ModelConfig` CRD in kagent?**

A) To configure network policies for agents.
B) To define which AI models and providers kagent can use.
C) To manage storage for kagent's memory.
D) To set up logging and monitoring for the kagent controller.

**Answer: B**

**3. After enabling the built-in tools in kagent, which deployment should be present in the `kagent` namespace?**

A) `kagent-agents`
B) `kagent-tools`
C) `kagent-models`
D) `kagent-dashboard`

**Answer: B**

**4. When the `k8s-agent` is enabled, what can you do in the kagent UI?**

A) Only view the list of available models.
B) Select the `k8s-agent` and check its details, including the model config it uses.
C) Only see the logs of the kagent controller.
D) Configure the Kubernetes cluster settings.

**Answer: B**

**5. Which `kagent` CLI command is used to invoke an agent and stream its response?**

A) `kagent run`
B) `kagent exec`
C) `kagent invoke`
D) `kagent trigger`

**Answer: C**

**6. When invoking the `k8s-agent` to create a Kubernetes resource, how can you identify the specific tool function used by the agent?**

A) By checking the agent's logs in the UI.
B) By inspecting the streamed JSON output for a function-call event and its `name` field.
C) By running `kubectl describe agent`.
D) By looking at the Kubernetes events in the namespace.

**Answer: B**

**7. What are the two main components of an AI agent in kagent?**

A) A Dockerfile and a Kubernetes deployment
B) Agent instructions and tools
C) A public and a private key
D) A user interface and a database

**Answer: B**

**8. What is the purpose of agent instructions?**

A) To define the agent's hardware requirements.
B) To provide a list of users who can interact with the agent.
C) To define the agent's behavior, role, and capabilities.
D) To specify the programming language the agent is written in.

**Answer: C**

**9. What are tools in the context of a kagent agent?**

A) Functions that the agent can use to interact with its environment.
B) The IDE used to develop the agent.
C) The monitoring and logging services for the agent.
D) The version control system for the agent's code.

**Answer: A**

**10. How can one agent use another agent in kagent?**

A) By sending an email to the other agent.
B) By referencing the other agent as a tool.
C) By calling a special API endpoint.
D) This is not a supported feature.

**Answer: B**

**11. What is the protocol that allows kagent to use external tools?**

A) HTTP
B) gRPC
C) MCP (Model Context Protocol)
D) TCP

**Answer: C**

## Section 030-030, 050, 070, 090


**1. After installing Kagent CRDs, which of the following CRDs would you expect to see when running `kubectl get crd | grep kagent`?**

A) Only agents.kagent.dev and modelconfigs.kagent.dev
B) agents.kagent.dev, mcpservers.kagent.dev, memories.kagent.dev, modelconfigs.kagent.dev, remotemcpservers.kagent.dev, toolservers.kagent.dev
C) Only mcpservers.kagent.dev and toolservers.kagent.dev
D) kagent.dev, agents.dev, modelconfigs.dev

**Answer: B**

**2. What specific AWS IAM permissions are required for the AWS Pricing MCP Server to access the AWS Pricing API?**

A) `ec2:*` permissions  
B) `pricing:*` permissions  
C) `s3:GetObject` permissions  
D) `iam:ListRoles` permissions  

**Answer: B**

**3. Which of the following tools is available in the AWS Pricing MCP Server?**

A) `get_ec2_instances`  
B) `get_pricing_service_codes`  
C) `list_s3_buckets`  
D) `create_cloudwatch_alarm`  

**Answer: B**

**4. What is the main difference between Linux/MacOS and Windows configuration when using uv installation method for AWS Pricing MCP Server?**

A) Windows requires Docker while Linux/MacOS uses native installation  
B) Linux/MacOS requires additional security permissions  
C) Windows uses `--from` flag and `.exe` extension in the args configuration  
D) There is no difference between the platforms  

**Answer: C**

**5. Which installation methods are available for the AWS Pricing MCP Server?**

A) Only Docker installation  
B) Only uv installation  
C) Both uv and Docker installation methods  
D) npm and pip installation methods  

**Answer: C**

**6. What command is used to install the KMCP controller in the cluster?**

A) `kubectl install kmcp`
B) `helm install kmcp`
C) `kmcp install`
D) `docker install kmcp`

**Answer: C**

**7. When deploying an MCP server using KMCP, what resources are typically created?**

A) Only a pod and service
B) MCP server deployment, service for API access, and configuration for stdio transport
C) Just a deployment with no additional resources
D) A deployment, service, ingress, and configmap

**Answer: B**

**8. How do you verify that an MCP server deployment is running correctly?**

A) `kubectl get pods -l app=my-mcp-server` and `kubectl logs -l app=my-mcp-server`
B) `helm status mcp-server`
C) `docker ps | grep mcp`
D) `curl localhost:3000/health`

**Answer: A**

**9. What are the three main operations supported by the AWS Pricing AI agent?**

A) getProducts, getAttributeValues, getPriceList
B) listServices, getPrices, calculateCosts
C) queryPricing, filterResults, exportData
D) getInstances, getRegions, getCosts

**Answer: A**

**10. Which command is used to add the Jaeger Helm repository?**

A) `helm repo add jaegertracing https://jaegertracing.github.io/helm-charts`
B) `helm add repo jaeger https://jaegertracing.io/charts`
C) `kubectl apply -f jaeger-repo.yaml`
D) `helm install jaeger-repo`

**Answer: A**

**11. How do you access the Jaeger UI after deployment?**

A) `kubectl port-forward svc/jaeger-query -n jaeger 16686:16686` then navigate to http://localhost:16686
B) `kubectl expose deployment jaeger --port=16686 --type=LoadBalancer`
C) `helm get notes jaeger -n jaeger`
D) `curl http://jaeger-query.jaeger:16686`

**Answer: A**

**12. When analyzing traces in Jaeger, what do spans with names like `llm.request.functions.8.name` represent?**

A) Individual function calls made by the AI agent, tool invocations, and Kubernetes API operations
B) Network requests to external APIs
C) Database query operations
D) Authentication and authorization events

**Answer: A**

## Section 050-020

**1. What is the purpose of the `provisionDataStore` configuration in the Jaeger Helm values file?**

A) Controls whether to provision external data stores like Cassandra or Elasticsearch
B) Sets up the Jaeger query interface
C) Configures the OTLP endpoint
D) Enables trace collection

**Answer: A**

**2. When analyzing openai.chat traces in Jaeger, what does the `gen_ai.prompt.0.content` span represent?**

A) The full prompt that was passed to OpenAI
B) The response from OpenAI
C) The function call execution time
D) The error handling process

**Answer: A**

## Section 060 - CloudWatch & BYO Agents

### Lab 060-010: CloudWatch AI Agent with MCP Server Integration

**1. What is the primary purpose of the CloudWatch MCP Server in this lab?**

A) To monitor Kubernetes cluster metrics
B) To enable AI agents to query and analyze AWS CloudWatch logs
C) To deploy CloudWatch agents to EC2 instances
D) To create CloudWatch dashboards

**Answer: B**

**2. Which environment variables are required for the CloudWatch MCP Server to authenticate with AWS?**

A) AWS_KEY and AWS_SECRET
B) AWS_ACCESS_KEY_ID, AWS_SECRET_ACCESS_KEY, and AWS_REGION
C) AWS_CREDENTIALS and AWS_ZONE
D) AWS_TOKEN and AWS_ENDPOINT

**Answer: B**

**3. What tool does the CloudWatch agent use to retrieve actual log events from log streams?**

A) `analyze_log_group`
B) `describe_log_groups`
C) `get_log_events`
D) `execute_log_insights_query`

**Answer: C**

**4. When querying for ERROR messages in CloudWatch logs, why might the agent return "no logs present" even when logs exist?**

A) The agent doesn't have the correct tools configured
B) The time window specified is too narrow or outside the log retention period
C) The AWS credentials are invalid
D) The MCP server is not running

**Answer: B**

### Lab 060-020: Build CloudWatch Agent via YAML

**5. What is the correct order of building an Agent YAML file step-by-step?**

A) tools → systemMessage → metadata → modelConfig
B) apiVersion/kind → metadata → spec.declarative.modelConfig → systemMessage → tools
C) systemMessage → tools → metadata → apiVersion
D) modelConfig → tools → description → metadata

**Answer: B**

**6. In the Agent YAML, what does the `spec.declarative.stream` field control?**

A) The number of concurrent requests
B) Whether responses are streamed in real-time
C) The log stream to monitor
D) The network bandwidth allocation

**Answer: B**

**7. Which field in the Agent YAML specifies which MCP server tools the agent can use?**

A) `spec.declarative.tools`
B) `spec.tools.mcpServer`
C) `spec.declarative.mcpServers`
D) `spec.toolServers`

**Answer: A**

### Lab 060-030: Troubleshoot and Fix Broken Agents

**8. What does `ACCEPTED=False` in the agent status typically indicate?**

A) The agent pod is not running
B) The agent spec has validation errors or invalid references
C) The agent is out of memory
D) The agent is processing too many requests

**Answer: B**

**9. What does `READY=False` in the agent status typically indicate?**

A) The agent YAML has syntax errors
B) The ModelConfig doesn't exist
C) The agent deployment or pod has issues
D) The MCP server name is wrong

**Answer: C**

**10. Can an agent be ACCEPTED=True and READY=True without any tools configured?**

A) No, tools are required for acceptance
B) Yes, but the agent won't have any special capabilities
C) No, the agent will fail validation
D) Yes, and it will automatically inherit default tools

**Answer: B**

**11. If an agent has tools configured but the MCP server has empty AWS credentials, what will happen?**

A) The agent will be ACCEPTED=False
B) The agent will be READY=False
C) The agent will be ACCEPTED=True and READY=True, but tool calls will fail with authentication errors
D) The agent pod will crash immediately

**Answer: C**

**12. Which kubectl command is most useful for diagnosing why an agent is not ACCEPTED?**

A) `kubectl get agents`
B) `kubectl logs agent-pod`
C) `kubectl describe agent <agent-name>`
D) `kubectl get pods`

**Answer: C**

**13. What should you do if you see a "session terminated" error after updating MCP server credentials?**

A) Restart the Kubernetes cluster
B) Delete and recreate the agent
C) Update the ModelConfig
D) Increase the agent replicas

**Answer: B**

### Lab 060-040: Deploy a BYO (Bring Your Own) LangGraph Agent

**14. What does BYO stand for in the context of Kagent agents?**

A) Build Your Own
B) Bring Your Own
C) Bootstrap Your Operations
D) Backup Your Objects

**Answer: B**

**15. What is the main difference between a Declarative agent and a BYO agent?**

A) BYO agents are faster
B) Declarative agents give you full control over logic
C) BYO agents give you full control over agent logic and behavior
D) There is no difference

**Answer: C**

**16. What protocol do BYO agents use to communicate with Kagent?**

A) HTTP REST API
B) gRPC
C) A2A (Agent-to-Agent) protocol
D) WebSocket

**Answer: C**

**17. What endpoint can you curl to verify a BYO agent is accessible via A2A protocol?**

A) `/api/agent/status`
B) `/health`
C) `/.well-known/agent.json`
D) `/api/v1/agent`

**Answer: C**

**18. Which field in the BYO agent spec references the Docker image to use?**

A) `spec.byo.image`
B) `spec.byo.deployment.image`
C) `spec.deployment.container.image`
D) `spec.image`

**Answer: B**




# Lab 030-090: Quiz Questions

This document contains all quiz questions from the lab steps for easy reference and assessment.

---

## Step 01: Install kmcp CLI

**Question**: What is the primary purpose of the `kmcp` CLI tool?

**Options**:
- A) To manage Kubernetes clusters
- B) To build and manage Model Context Protocol (MCP) servers
- C) To deploy Docker containers
- D) To monitor AI agent performance

**Answer**: B) To build and manage Model Context Protocol (MCP) servers

**Explanation**: The `kmcp` CLI is specifically designed for MCP server development, providing commands for initialization, building, testing, and deployment of MCP servers.

---

## Step 02: Explore kmcp CLI Options

**Question**: Which `kmcp` command would you use to test your MCP server locally before deploying to Kubernetes?

**Options**:
- A) `kmcp test`
- B) `kmcp run`
- C) `kmcp start`
- D) `kmcp deploy --local`

**Answer**: B) `kmcp run`

**Explanation**: The `kmcp run` command starts your MCP server locally, allowing you to test it with tools like MCP Inspector before deploying to Kubernetes. This is a crucial step in the development workflow to catch issues early.

---

## Step 03: Create MCP Server Scaffold

**Question**: What is the purpose of the `kmcp.yaml` file in an MCP server project?

**Options**:
- A) It contains the Python source code for tools
- B) It's the main configuration file for the MCP server project
- C) It stores test cases for the tools
- D) It's used only for deployment to Kubernetes

**Answer**: B) It's the main configuration file for the MCP server project

**Explanation**: The `kmcp.yaml` file is the central configuration file that contains project metadata, tool configurations, environment variables, and deployment settings. It's used throughout the development lifecycle, not just for deployment.

---

## Step 05: Add New Tool to MCP Server

**Question**: What is the purpose of the `@mcp.tool()` decorator in an MCP server?

**Options**:
- A) It makes the function run faster
- B) It registers the function as an MCP tool that can be called by agents
- C) It adds error handling to the function
- D) It converts the function to asynchronous code

**Answer**: B) It registers the function as an MCP tool that can be called by agents

**Explanation**: The `@mcp.tool()` decorator is essential for exposing a Python function as an MCP tool. Without this decorator, the function would just be a regular Python function and wouldn't be discoverable or callable through the MCP protocol.

---

## Step 06: Implement Crypto Price Tool

**Question**: Why is it important to include detailed docstrings in MCP tool functions?

**Options**:
- A) Docstrings make the code run faster
- B) AI agents read docstrings to understand what the tool does and how to use it
- C) Docstrings are only for human developers
- D) Docstrings are required by Python syntax

**Answer**: B) AI agents read docstrings to understand what the tool does and how to use it

**Explanation**: Docstrings are crucial in MCP tools because AI agents use them to understand the tool's purpose, parameters, and expected outputs. A well-written docstring helps the agent decide when and how to use the tool. This is different from regular code where docstrings are primarily for human developers.

---

## Step 08: Build MCP Server Image

**Question**: Why is the `--platform` flag important when building container images?

**Options**:
- A) It makes the build faster
- B) It determines which programming language to use
- C) It ensures the image is compatible with the target architecture (CPU type)
- D) It sets the Kubernetes version

**Answer**: C) It ensures the image is compatible with the target architecture (CPU type)

**Explanation**: The `--platform` flag is crucial because container images must match the CPU architecture where they'll run. For example, if you build on an Apple Silicon Mac (ARM64) but deploy to a cloud server (AMD64), you need to specify `--platform linux/amd64` to ensure compatibility. Without this, you might get "exec format error" when trying to run the container.

---

## Bonus Questions

### Question 7: MCP Protocol Understanding

**Question**: What does MCP stand for and what is its primary purpose?

**Options**:
- A) Model Configuration Protocol - for configuring AI models
- B) Model Context Protocol - for standardizing how AI agents access tools and data
- C) Machine Control Protocol - for controlling machine learning pipelines
- D) Multi-Cloud Platform - for deploying across cloud providers

**Answer**: B) Model Context Protocol - for standardizing how AI agents access tools and data

**Explanation**: MCP (Model Context Protocol) is a standardized protocol that enables AI agents to discover and use tools, access data sources, and interact with external systems in a consistent way.

---

### Question 8: Tool Selection

**Question**: How does an AI agent decide which tool to use when answering a user query?

**Options**:
- A) It randomly selects from available tools
- B) It always uses the first tool in the list
- C) It uses the LLM to analyze the query and match it with tool descriptions
- D) The user must explicitly specify which tool to use

**Answer**: C) It uses the LLM to analyze the query and match it with tool descriptions

**Explanation**: AI agents use the underlying language model to understand the user's intent, review available tool descriptions (from docstrings), and intelligently select the most appropriate tool(s) to answer the query. This is why clear, descriptive docstrings are so important.

---

### Question 9: Error Handling

**Question**: Why is comprehensive error handling important in MCP tools?

**Options**:
- A) It makes the code look more professional
- B) It prevents tool failures from breaking the entire agent
- C) It's required by the MCP specification
- D) It makes the tool run faster

**Answer**: B) It prevents tool failures from breaking the entire agent

**Explanation**: Comprehensive error handling ensures that when a tool encounters an issue (API timeout, invalid input, etc.), it returns a meaningful error message instead of crashing. This allows the agent to gracefully handle the error and potentially try alternative approaches or inform the user about the issue.

---

### Question 10: Real-World Applications

**Question**: Which of the following is NOT a good use case for custom MCP tools?

**Options**:
- A) Fetching real-time data from external APIs
- B) Querying internal databases and systems
- C) Replacing the AI model's reasoning capabilities
- D) Automating DevOps tasks like deployments

**Answer**: C) Replacing the AI model's reasoning capabilities

**Explanation**: MCP tools are designed to extend an agent's capabilities by providing access to external data and actions, not to replace the AI model's core reasoning abilities. Tools should handle specific tasks (API calls, data retrieval, actions) while the AI model handles understanding, reasoning, and decision-making.
