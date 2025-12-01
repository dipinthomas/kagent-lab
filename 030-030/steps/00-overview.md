# Lab 030-030: Discover and Explore KMCP (Bundled with Kagent)

## Overview

In this lab, we'll discover and explore the KMCP (Kubernetes MCP) controller components that are **already bundled** with Kagent 0.7.x and later versions. The KMCP controller is essential for managing MCP servers in a Kubernetes environment, and understanding its components will help you work with custom MCP servers.

**Important Note**: Starting from Kagent version 0.7.x, KMCP CRDs and controller are included in the Kagent package. You do **not** need to install them separately.

## Lab Steps

1. **Step 1: Basic Kagent Setup**
   - Configure a minimal Kagent installation
   - Verify basic functionality
   - Check Kagent version (should be 0.7.x+)

2. **Step 2: Discover KMCP CRDs (Already Installed)**
   - Identify KMCP-related CRDs installed with Kagent
   - Understand what resources are available
   - Learn about the MCPServer custom resource

3. **Step 3: Explore KMCP Controller Components**
   - Locate the KMCP controller in the cluster
   - Check controller pods and deployments
   - Understand the controller's role

4. **Step 4: Understand MCPServer Resource**
   - Explore the MCPServer CRD structure
   - Learn about MCPServer resource fields
   - See an example MCPServer manifest

5. **Step 5: Verify KMCP Integration**
   - Check controller health and logs
   - Verify KMCP resources are functional
   - Understand the integration with Kagent

6. **Step 6: Compare with Standalone Installation (Reference)**
   - Learn about standalone installation (for older versions)
   - Understand when separate installation is needed
   - Compare bundled vs. standalone approaches

## Prerequisites

- Kubernetes cluster access
- kubectl command-line tool installed
- Helm v3.x installed
- Kagent 0.7.x or later installed
- Basic understanding of Kubernetes concepts
- Basic understanding of Custom Resource Definitions (CRDs)

## Expected Duration

- Approximately 30-40 minutes

## Learning Objectives

By completing this lab, you will:
- Understand that KMCP is bundled with Kagent 0.7.x+
- Discover KMCP CRDs and controller components
- Learn about the MCPServer custom resource
- Verify KMCP integration and health
- Understand when separate installation might be needed
- Prepare your knowledge for deploying custom MCP servers
