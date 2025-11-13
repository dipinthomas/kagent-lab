# Lab 060-040: Deploy a BYO (Bring Your Own) LangGraph Agent

## What You'll Learn

In this lab, you'll deploy a custom LangGraph agent as a **BYO (Bring Your Own)** agent in Kagent. Unlike declarative agents that are defined through Kagent resources with inline system instructions, models, and tools, BYO agents give you full control over agent logic and behavior.

## What is a BYO Agent?

**Bring Your Own (BYO)** agents allow you to integrate custom agents built with frameworks like:
- **LangGraph** (used in this lab)
- **Agent Development Kit (ADK)**
- Any custom agent framework

### Key Differences: Declarative vs BYO

| Aspect | Declarative Agent | BYO Agent |
|--------|------------------|-----------|
| **Definition** | Defined by Kagent CRDs | Custom code in container |
| **Control** | Limited to Kagent features | Full control over logic |
| **Complexity** | Simple workflows | Complex workflows & integrations |
| **Tools** | Inline tool definitions | Custom tool implementations |
| **Protocol** | Native Kagent | A2A (Agent-to-Agent) protocol |

### Why Use BYO Agents?

✅ **Full Control** - Complete control over agent behavior and logic  
✅ **Complex Workflows** - Build sophisticated multi-step workflows  
✅ **External Integrations** - Integrate with any external system or API  
✅ **Framework Flexibility** - Use your preferred agent framework  
✅ **No Decomposition** - No need to break down agent functions into separate resources  

## What You'll Do

In this lab, you will:

1. **Build a Docker image** - Package a LangGraph currency exchange agent
2. **Create API credentials** - Set up Google API key for the agent
3. **Deploy the BYO agent** - Deploy using Kagent Agent CRD with BYO type
4. **Test the agent** - Query currency exchange rates via A2A protocol

## The Currency Exchange Agent

The agent you'll deploy is built with **LangGraph** and can:
- Provide real-time currency exchange rates
- Convert between different currencies
- Answer questions about currency conversions
