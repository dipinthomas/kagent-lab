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
