# ModelConfig Examples - Support Code

This folder contains comprehensive ModelConfig examples for all major LLM providers supported by kagent.

## Files

- **openai-modelconfig.yaml** - OpenAI (GPT-4, GPT-3.5, etc.)
- **anthropic-modelconfig.yaml** - Anthropic Claude (Opus, Sonnet, Haiku)
- **azure-openai-modelconfig.yaml** - Azure OpenAI Service
- **gemini-modelconfig.yaml** - Google Gemini (direct API and Vertex AI)

## Quick Start

### 1. Create API Key Secrets

```bash
# OpenAI
kubectl create secret generic kagent-openai \
  --from-literal=OPENAI_API_KEY=sk-... \
  -n kagent

# Anthropic
kubectl create secret generic kagent-anthropic \
  --from-literal=ANTHROPIC_API_KEY=sk-ant-... \
  -n kagent

# Azure OpenAI
kubectl create secret generic kagent-azure-openai \
  --from-literal=AZURE_OPENAI_API_KEY=your-azure-key \
  -n kagent

# Google Gemini (AI Studio)
kubectl create secret generic kagent-gemini \
  --from-literal=GEMINI_API_KEY=AIza... \
  -n kagent

# Google Cloud (for Vertex AI)
kubectl create secret generic kagent-gcp \
  --from-file=GCP_SERVICE_ACCOUNT_KEY=./service-account.json \
  -n kagent
```

### 2. Apply a ModelConfig

```bash
# Apply one of the example configs
kubectl apply -f openai-modelconfig.yaml

# Or apply all configs
kubectl apply -f .
```

### 3. Verify

```bash
# List all ModelConfigs
kubectl get modelconfigs -n kagent

# Get details
kubectl get modelconfig <name> -n kagent -o yaml
```

## Provider Comparison

| Provider | Best For | Cost | Speed | Context Window |
|----------|----------|------|-------|----------------|
| **OpenAI GPT-4o** | General purpose, reasoning | $$$ | Fast | 128k |
| **OpenAI GPT-3.5** | Simple tasks, speed | $ | Very Fast | 16k |
| **Anthropic Claude Opus** | Complex reasoning, long context | $$$$ | Medium | 200k |
| **Anthropic Claude Sonnet** | Balanced performance | $$ | Fast | 200k |
| **Anthropic Claude Haiku** | Speed, low cost | $ | Very Fast | 200k |
| **Azure OpenAI** | Enterprise, compliance | $$$ | Fast | varies |
| **Gemini Pro** | Multimodal, large context | $$ | Fast | 2M tokens |
| **Gemini Flash** | Speed, efficiency | $ | Very Fast | 1M tokens |

## Parameter Guide

### Temperature
- **0.0-0.3**: Deterministic, factual, consistent
- **0.4-0.7**: Balanced creativity and consistency (default)
- **0.8-1.0**: Creative, varied, less predictable
- **1.0+**: Very creative, experimental (OpenAI only)

### maxTokens / maxOutputTokens
- Limits response length and cost
- Set based on expected response size
- Remember: tokens ≠ words (roughly 1 token = 0.75 words)

### topP (Nucleus Sampling)
- Alternative to temperature
- **0.1**: Very focused
- **0.5**: Balanced
- **0.9-1.0**: More diverse

### topK (Anthropic/Gemini)
- Limits token selection pool
- **10-20**: Very focused
- **40**: Balanced (default)
- **100+**: More diverse

## Common Use Cases

### Production Chatbot (Balanced)
```yaml
temperature: "0.7"
maxTokens: 1000
topP: "0.9"
```

### Code Generation (Precise)
```yaml
temperature: "0.2"
maxTokens: 4000
topP: "0.95"
```

### Creative Writing (Diverse)
```yaml
temperature: "1.2"
maxTokens: 2000
topP: "0.95"
```

### Data Extraction (Deterministic)
```yaml
temperature: "0.0"
maxTokens: 500
```

## Troubleshooting

### ModelConfig not ready
```bash
kubectl get modelconfig <name> -n kagent -o jsonpath='{.status.conditions}'
```

### Check which agents use a ModelConfig
```bash
kubectl get agents -n kagent -o yaml | grep -A 3 modelConfigRef
```

### Test with different configs
```bash
# Temporarily patch an agent to use a different ModelConfig
kubectl patch agent k8s-agent -n kagent --type='json' \
  -p='[{"op": "replace", "path": "/spec/declarative/modelConfigRef/name", "value": "anthropic-minimal"}]'
```

## Best Practices

1. **Start with defaults** - Use minimal configs, add parameters as needed
2. **Use secrets** - Never hardcode API keys
3. **Test configs** - Try different settings for your use case
4. **Monitor costs** - Higher temperature/maxTokens = higher cost
5. **Namespace configs** - Create task-specific ModelConfigs (e.g., `fast-queries`, `deep-reasoning`)
6. **Version models** - Reference specific model versions in production

## References

- [OpenAI API Docs](https://platform.openai.com/docs/api-reference)
- [Anthropic API Docs](https://docs.anthropic.com/claude/reference)
- [Azure OpenAI Docs](https://learn.microsoft.com/en-us/azure/ai-services/openai/)
- [Gemini API Docs](https://ai.google.dev/docs)
- [Vertex AI Docs](https://cloud.google.com/vertex-ai/docs/generative-ai/model-reference/gemini)
