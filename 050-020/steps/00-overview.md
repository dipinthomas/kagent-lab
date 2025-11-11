# Lab Overview: Tracing AI Agent Calls with Jaeger

## 🎯 **Learning Objectives**

This hands-on lab focuses on implementing distributed tracing for AI agents using Jaeger and OpenTelemetry. You will learn how to trace calls between AI agents, which is essential for debugging and monitoring agent interactions in production environments.

## 📋 **Lab Structure**

### **Step 1: Generate Jaeger Configuration**
- Create Jaeger Helm values file with proper configuration
- Configure data store and deployment options
- Set up memory-based storage for development

### **Step 2: Install Jaeger**
- Add Jaeger Helm repository
- Deploy Jaeger using Helm chart
- Configure all-in-one deployment for simplicity

### **Step 3: Verify Jaeger Installation**
- Check Jaeger pods and services status
- Ensure proper deployment in jaeger namespace
- Validate service connectivity

### **Step 4: Install Kagent with Tracing**
- Configure Kagent with OpenTelemetry tracing enabled
- Enable k8s-agent and kagent-tools
- Set up OTLP exporter to connect to Jaeger

### **Step 5: Test Agent Tracing**
- Use example k8s-agent for testing
- Generate trace data through agent interactions
- Verify pods are running in kagent namespace

### **Step 6: Access Jaeger UI and Analyze Traces**
- Port forward to Jaeger UI
- Navigate to trace search interface
- Filter and analyze agent traces

