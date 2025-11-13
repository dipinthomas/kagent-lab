# Lab 020-040: Overview - Progressive K-Agent Configuration

## Introduction

Welcome to Lab 020-040! This lab takes you through a **progressive installation and configuration** of K-Agent, starting from a minimal setup and gradually enabling features. You'll learn how K-Agent's components work together and understand the relationship between ModelConfigs, Tools, and Agents.

## What You'll Learn

By the end of this lab, you will:

1. ✅ Install K-Agent with minimal configuration
2. ✅ Understand ModelConfig CRDs and how they define AI models
3. ✅ Enable and explore built-in tools
4. ✅ Deploy and interact with AI agents
5. ✅ Use the K-Agent CLI to invoke agents
6. ✅ Identify which tools agents use to complete tasks

## Lab Philosophy: Progressive Enablement

Unlike installing everything at once, this lab uses a **step-by-step approach**:

```
Minimal Install → Add ModelConfigs → Enable Tools → Enable Agents → CLI Interaction
```

This progression helps you:
- **Understand each component** before adding the next
- **See the UI change** as you enable features
- **Troubleshoot effectively** by isolating components
- **Learn dependencies** between K-Agent resources

## Lab Architecture

### Starting Point (Step 1)
```
┌─────────────────────────────────────┐
│  K-Agent Minimal Installation       │
│  - Controller (CRDs only)           │
│  - UI (for visualization)           │
│  - 1 ModelConfig (default)          │
│  - No Tools                         │
│  - No Agents                        │
└─────────────────────────────────────┘
```

### After Tools (Step 3)
```
┌─────────────────────────────────────┐
│  K-Agent with Tools                 │
│  - Controller                       │
│  - UI                               │
│  - Multiple ModelConfigs            │
│  - 8 Built-in Tools ✓               │
│  - No Agents (yet)                  │
└─────────────────────────────────────┘
```

### Final State (Step 4+)
```
┌─────────────────────────────────────┐
│  Full K-Agent Setup                 │
│  - Controller                       │
│  - UI                               │
│  - Multiple ModelConfigs            │
│  - 8 Built-in Tools                 │
│  - k8s-agent ✓                      │
│  - CLI Access ✓                     │
└─────────────────────────────────────┘
```

## Key Concepts

### 1. ModelConfig CRD
**What**: Custom Resource Definition that describes AI models and their configuration

**Purpose**: 
- Define which LLM provider to use (OpenAI, Anthropic, Gemini, etc.)
- Specify model name (gpt-4o, claude-3-5-sonnet, etc.)
- Set default parameters (temperature, max tokens, etc.)

**Example**: `openai-minimal` ModelConfig uses OpenAI's `gpt-4o-mini` model

### 2. Tools
**What**: Capabilities that agents can use to perform actions

**Purpose**:
- Extend agent abilities beyond text generation
- Interact with external systems (Kubernetes, Grafana, etc.)
- Query documentation and knowledge bases

**Examples in this lab**:
- `k8s_list_pods` - List Kubernetes pods
- `k8s_apply_manifest` - Apply Kubernetes manifests
- `grafana_query` - Query Grafana metrics
- `querydoc` - Search documentation

### 3. Agents
**What**: AI-powered assistants that use models and tools to complete tasks

**Purpose**:
- Process natural language queries
- Decide which tools to use
- Execute multi-step workflows
- Return formatted responses

**Example in this lab**: `k8s-agent` - Kubernetes management assistant


## Key Takeaways

1. **Progressive configuration** helps understand component relationships
2. **ModelConfigs** define which AI models agents use
3. **Tools** extend agent capabilities beyond text generation
4. **Agents** orchestrate tools and models to complete tasks
5. **Helm** provides production-ready, repeatable deployments
6. **Both UI and CLI** have their use cases

