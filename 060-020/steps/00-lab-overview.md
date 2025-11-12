# Lab 060-020: Build a CloudWatch Agent via YAML (Step-by-Step)

## 🎯 Goal
Create a complete Kagent `Agent` by incrementally building the YAML, validating after each step, and ending with a fully working CloudWatch log analysis agent that uses the CloudWatch MCP server tools.

## 🧰 What You Will Do
- Author an Agent CRD YAML from scratch in stages.
- Add `declarative.modelConfig` and streaming.
- Add a structured `systemMessage` (agent instructions).
- Attach CloudWatch MCP Server tools to the agent.
- Finalize metadata (`description`, `type`) and deploy.

## ✅ Prerequisites
- Lab 060-010 (or equivalent) completed: Kagent installed, CloudWatch MCP server deployed, and sample CloudWatch logs available.
- This directory contains the reference final output:
  - `support-code/agent-template.yaml` (final expected YAML for reference)

## 🧭 Lab Flow
1. Step 01: Initialize YAML with apiVersion/kind/metadata
2. Step 02: Add `declarative.modelConfig` and `stream`
3. Step 03: Add `systemMessage`
4. Step 04: Add `tools` (CloudWatch MCP Server)
5. Step 05: Add `description` and `type`
6. Step 06: Apply and validate
