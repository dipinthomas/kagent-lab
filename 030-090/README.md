# Lab 030-090: Building and Deploying Custom MCP Servers

## Overview

In this lab, you'll learn how to develop a custom Model Context Protocol (MCP) server from scratch, test it locally, and deploy it to a Kubernetes cluster. You'll then create an AI agent that leverages your custom MCP server to fetch real-time cryptocurrency prices.

## What You'll Build

- **Custom MCP Server**: A Python-based MCP server with a cryptocurrency price lookup tool
- **Local Testing**: Test your MCP server using the MCP Inspector
- **Container Image**: Build and package your MCP server as a Docker image
- **Kubernetes Deployment**: Deploy your MCP server to a K8s cluster
- **AI Agent**: Create an agent that uses your custom tool to answer crypto price queries

## Learning Objectives

By the end of this lab, you will:
- Understand the MCP server development workflow
- Use the `kmcp` CLI to scaffold, build, and deploy MCP servers
- Test MCP tools locally before deployment
- Deploy custom MCP servers to Kubernetes
- Integrate custom tools with K-Agent AI agents

## Prerequisites

- Access to a Kubernetes cluster with K-Agent installed
- Docker installed locally
- Node.js and npm installed (for MCP Inspector)
- Basic understanding of Python
- kubectl configured to access your cluster

## Lab Duration

Approximately 45-60 minutes

## Architecture

```
┌─────────────────────────────────────────────┐
│  K-Agent AI Agent (crypto-price-agent)      │
│  - Processes natural language queries       │
│  - Calls MCP tools via protocol             │
└─────────────────┬───────────────────────────┘
                  │
                  │ MCP Protocol
                  │
┌─────────────────▼───────────────────────────┐
│  Custom MCP Server (my-mcp-server)          │
│  - Exposes get_crypto_price tool            │
│  - Fetches data from CoinGecko API          │
└─────────────────────────────────────────────┘
```
