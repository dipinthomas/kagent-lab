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
