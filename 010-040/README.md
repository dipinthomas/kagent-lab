# Lab 010-010: The Power of Kagent - Before and After

## Overview

This opening lab demonstrates the **power of AI-powered Kubernetes troubleshooting** by comparing traditional manual methods with Kagent's intelligent problem-solving capabilities.

## 🎯 Learning Objectives

By completing this lab, you will:
- Experience the pain points of manual Kubernetes troubleshooting (20-28 minutes)
- See how Kagent dramatically reduces troubleshooting time (2-3 minutes)
- Understand common Kubernetes problems and their solutions
- Get excited about what you'll learn in the course
- Appreciate the value of AI-powered operations

## 📊 The Problems We'll Solve

1. **Pod CrashLoopBackOff** - Missing ConfigMap
2. **Service Not Routing Traffic** - Selector/label mismatch
3. **Resource Exhaustion** - Memory-hungry pods
4. **HPA Not Scaling** - ResourceQuota blocking scaling

## ⏱️ Time Comparison

| Approach | Time Required | Skills Needed |
|----------|---------------|---------------|
| **Manual Troubleshooting** | 20-28 minutes | kubectl expertise, log parsing, networking, resource management |
| **Kagent AI-Powered** | 2-3 minutes | Natural language queries |
| **Time Savings** | **~90%** | |

## 📋 Lab Structure

```
010-010/
├── README.md                          # This file
├── steps/
│   ├── 00-lab-overview.md            # Lab introduction
│   ├── 00-lab-setup.md               # Deploy broken cluster
│   ├── 01-manual-pod-crashloop.md    # Manual: Pod issue
│   ├── 02-manual-service-routing.md  # Manual: Service issue
│   ├── 03-manual-resource-exhaustion.md  # Manual: Resource issue
│   ├── 04-manual-hpa-scaling.md     # Manual: HPA issue
│   ├── 05-install-kagent.md         # Install Kagent
│   ├── 06-kagent-solutions.md       # Solve all with Kagent
│   └── 07-reflection-preview.md     # Reflection & preview
└── support-code/
    ├── README.md                     # Support code documentation
    ├── setup-broken-cluster.sh       # Setup script
    ├── cleanup.sh                    # Cleanup script
    ├── broken-pod.yaml               # Problem 1: Deployment with missing ConfigMap
    ├── fix-configmap.yaml           # Fix for Problem 1
    ├── broken-service.yaml           # Problem 2: Selector mismatch
    ├── fix-pod-labels.yaml           # Fix for Problem 2
    ├── memory-hungry-pod.yaml         # Problem 3: Resource exhaustion
    ├── fix-resource-limits.yaml      # Fix for Problem 3
    ├── hpa-deployment.yaml           # Problem 4: HPA + ResourceQuota
    ├── resource-quota.yaml           # Problem 4: Limiting quota
    └── fix-resource-quota.yaml       # Fix for Problem 4
```

## ✅ Prerequisites

- Kubernetes cluster access with `kubectl` configured
- Basic understanding of Kubernetes concepts (pods, services, deployments, HPA)
- OpenAI API key (for Kagent)
- Helm v3.x installed (for Kagent installation)

## 🚀 Quick Start

1. **Setup Broken Cluster**
   ```bash
   bash support-code/setup-broken-cluster.sh
   ```

2. **Follow Steps 1-4**: Manual troubleshooting (20-28 minutes)

3. **Install Kagent** (Step 5): Quick installation

4. **Solve with Kagent** (Step 6): All problems in 2-3 minutes

5. **Reflect** (Step 7): Compare approaches and preview course

## 📚 Step-by-Step Guide

### Step 0: Lab Setup
Deploy all broken scenarios to the cluster.

### Steps 1-4: Manual Troubleshooting
Work through each problem manually:
- Diagnose using kubectl commands
- Identify root causes
- Apply fixes
- Track time taken

### Step 5: Install Kagent
Quick installation of Kagent with k8s-agent enabled.

### Step 6: Kagent Solutions
Solve all 4 problems using natural language queries.

### Step 7: Reflection
Compare approaches and preview course content.

## 🧹 Cleanup

After completing the lab, clean up test resources:

```bash
bash support-code/cleanup.sh
```

This removes all lab resources from the `default` namespace but leaves Kagent installation intact.

## ⏰ Expected Duration

- **Manual Troubleshooting**: 20-28 minutes
- **Kagent Setup**: 5 minutes
- **Kagent Solutions**: 2-3 minutes
- **Reflection**: 5 minutes
- **Total Lab Time**: ~35-40 minutes

## 🎓 Key Takeaways

- Manual troubleshooting requires deep kubectl knowledge and time
- Kagent provides 90% time savings with natural language queries
- AI-powered troubleshooting is comprehensive and accurate
- The same problems solved manually in 20-28 minutes take 2-3 minutes with Kagent

## 🔗 Next Steps

After completing this lab:
- **Lab 020-035**: Install Kagent (detailed installation)
- **Lab 020-040**: Explore Kagent components
- **Lab 030-XXX**: MCP servers and tools
- **Lab 060-XXX**: Agent development

## 📝 Notes

- This lab is designed as an opening/introductory lab
- It demonstrates value before diving into technical details
- All problems are intentionally broken for learning purposes
- Time tracking is important to see the value proposition

---

**Ready to experience the power of Kagent?** Start with [Step 0: Lab Setup](steps/00-lab-setup.md)

