# Step 2: Explore ModelConfig resources

Understand how Kagent uses ModelConfig CRDs to describe providers/models and defaults. Apply example configurations and inspect them.

Questions (answer by reading the YAMLs):
- From `anthropic-modelconfig.yaml`: What `provider` and `model` are configured?
- From `openai-modelconfig.yaml`: Which default request parameters are set (e.g., `temperature`, `maxTokens` or equivalents)?


```bash
# List current ModelConfigs (may be empty initially)
kubectl get modelconfigs -n kagent || true

# Apply example ModelConfigs provided for this lab
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/020-040/support-code

# List again to confirm resources are created
kubectl get modelconfigs -n kagent -o wide

NAME                        PROVIDER         MODEL
anthropic-fast              Anthropic        claude-3-haiku-20240307
anthropic-full-config       Anthropic        claude-3-5-sonnet-20241022
anthropic-minimal           Anthropic        claude-3-5-sonnet-20241022
anthropic-reasoning         Anthropic        claude-3-opus-20240229
azure-openai-ad-auth        AzureOpenAI      gpt-4o
azure-openai-full-config    AzureOpenAI      gpt-4o
azure-openai-gpt35          AzureOpenAI      gpt-35-turbo
azure-openai-minimal        AzureOpenAI      gpt-4o
default-model-config        OpenAI           gpt-4.1-mini
gemini-full-config          Gemini           gemini-2.0-flash-exp
gemini-minimal              Gemini           gemini-2.0-flash-exp
gemini-vertex-creative      GeminiVertexAI   gemini-1.5-pro
gemini-vertex-full-config   GeminiVertexAI   gemini-1.5-pro
gemini-vertex-json          GeminiVertexAI   gemini-1.5-pro
gemini-vertex-minimal       GeminiVertexAI   gemini-1.5-flash
openai-full-config          OpenAI           gpt-4o
openai-minimal              OpenAI           gpt-4o-mini
```

Questions
- In kagent UI, how many models are available?

Optional inspections:
```bash
# Describe a specific ModelConfig (replace NAME with one from the list)
# kubectl describe modelconfig NAME -n kagent

# View the raw YAML of a created resource
# kubectl get modelconfig NAME -n kagent -o yaml
```
