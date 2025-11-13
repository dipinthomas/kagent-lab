# Step 00: Lab Overview

## Introduction

Welcome to the Custom MCP Server Development lab! In this hands-on lab, you'll experience the complete lifecycle of building, testing, and deploying a custom Model Context Protocol (MCP) server.

## What is an MCP Server?

An MCP (Model Context Protocol) server is a standardized way to expose tools and capabilities that AI agents can use. Think of it as a plugin system for AI agents - you build the tools, and agents can discover and use them automatically.

## The Problem We're Solving

Imagine you want your AI agent to answer questions like:
- "What's the current price of Bitcoin?"
- "How much is Ethereum worth in USD?"
- "Compare the prices of BTC and ETH"

Without a custom tool, the agent would be limited to its training data (which is outdated) or would need to search the web. With a custom MCP server, you can give the agent direct access to real-time cryptocurrency price data.

## Lab Journey

Here's what you'll accomplish in this lab:

### 1. **Local Development** (Steps 1-7)
- Install the `kmcp` CLI tool
- Scaffold a new Python MCP server project
- Add a custom tool that fetches crypto prices from CoinGecko API
- Test your tool locally using MCP Inspector

### 2. **Containerization** (Step 8)
- Build your MCP server as a Docker image
- Understand platform-specific builds

### 3. **Kubernetes Deployment** (Steps 9-10)
- Deploy your MCP server to a K8s cluster
- Create an AI agent that uses your custom tool
- Test end-to-end by asking natural language questions

## Why This Matters

This lab demonstrates how K-Agent extends beyond pre-built tools. You can:
- **Create domain-specific tools** for your organization
- **Integrate with internal APIs** and services
- **Build reusable capabilities** that multiple agents can leverage
- **Maintain control** over tool behavior and data access

## Real-World Applications

The pattern you'll learn applies to many scenarios:
- **DevOps**: Tools for checking deployment status, scaling services
- **Finance**: Real-time stock prices, portfolio analysis
- **Customer Support**: Ticket lookup, knowledge base search
- **Infrastructure**: Cloud resource management, cost analysis

## Expected Outcome

By the end of this lab, you'll have:
- ✅ A working custom MCP server deployed to Kubernetes
- ✅ An AI agent that can fetch real-time cryptocurrency prices
- ✅ Understanding of the MCP development workflow
- ✅ Skills to build your own custom tools


## Let's Begin!

In the next step, you'll install the `kmcp` CLI tool, which is your primary interface for MCP server development.

---

**Ready?** Proceed to [Step 01: Install kmcp CLI](step01.md)
