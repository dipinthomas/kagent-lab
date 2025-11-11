# Lab Overview: AWS MCP Server Integration with Kagent

## 🎯 **Learning Objectives**

This hands-on lab focuses on integrating AWS Model Context Protocol (MCP) servers with Kagent to enable real-time AWS pricing information and cost analysis capabilities. You will learn how to deploy, configure, and validate AWS MCP servers in a Kubernetes environment.

## 📋 **Lab Structure**

### **Step 1: Install Kagent with Minimal Configuration**
- Deploy Kagent via Helm with minimal footprint
- Configure OpenAI provider for AI capabilities  
- Set up basic Kubernetes resources and CRDs
- Access Kagent UI through port-forwarding

### **Step 2: Discover AWS MCP Server**
- Explore AWS Pricing MCP Server documentation
- Understand MCP server capabilities and features
- Learn about AWS permissions and configuration requirements
- Complete multiple-choice assessment questions

### **Step 3: Install AWS MCP Server from UI**
- Deploy AWS Pricing MCP Server through Kagent UI
- Configure AWS credentials and environment variables
- Set up server name, namespace, and package configuration
- Validate successful deployment

### **Step 4: Deploy MCP Server Using Code**
- Create MCP server configuration using YAML manifests
- Update AWS credentials in configuration files
- Apply configurations using `kubectl`
- Validate deployment status and pod health

### **Step 5: MCP Server Validation**
- Verify MCP server tools availability
- Compare CloudWatch vs Pricing MCP server capabilities
- Validate tool counts and functionality
- Confirm successful integration

