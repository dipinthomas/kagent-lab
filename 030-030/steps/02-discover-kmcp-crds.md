# Step 2: Discover KMCP CRDs (Already Installed)

## Overview

In this step, we'll discover the KMCP-related Custom Resource Definitions (CRDs) that are automatically installed when you install Kagent 0.7.x or later. These CRDs enable you to manage MCP servers as Kubernetes resources.

## Check Kagent Version

First, let's confirm you're running Kagent 0.7.x or later:

```bash
kagent version
```

### Expected Output

```bash
{"backend_version":"unknown","build_date":"2025-10-30","git_commit":"8062481","kagent_version":"0.7.2"}
```

**Note**: If your version is less than 0.7.x, you would need to install KMCP separately. For this lab, we assume you're using 0.7.x or later.

## Discover KMCP CRDs

Now let's check what KMCP-related CRDs are installed:

```bash
kubectl get crd | grep kmcp
```

### Expected Output

You should see CRDs related to KMCP:

```bash
mcpservers.kmcp.dev                            2025-11-06T10:08:44Z
```

**Note**: The exact CRD name may vary. It could be `mcpservers.kmcp.dev` or `mcpservers.kagent.dev` depending on the Kagent version.

## Check All Kagent CRDs

Let's also see all Kagent-related CRDs to understand the full picture:

```bash
kubectl get crd | grep -E "kagent|kmcp"
```

### Expected Output

```bash
agents.kagent.dev                            2025-11-06T10:08:45Z
mcpservers.kagent.dev                        2025-11-06T10:08:44Z
memories.kagent.dev                          2025-11-06T10:08:43Z
modelconfigs.kagent.dev                      2025-11-06T10:08:43Z
remotemcpservers.kagent.dev                  2025-11-06T10:08:43Z
toolservers.kagent.dev                       2025-11-06T10:08:43Z
```

Notice that `mcpservers.kagent.dev` (or `mcpservers.kmcp.dev`) is listed among the Kagent CRDs, confirming it's bundled.

## Check API Resources

Verify that MCPServer is available as an API resource:

```bash
kubectl api-resources | grep -i mcp
```

### Expected Output

```bash
NAME          SHORTNAMES   APIVERSION              NAMESPACED   KIND
mcpservers    mcp          kagent.dev/v1alpha1    true         MCPServer
```

## Explore the MCPServer CRD

Let's get more details about the MCPServer CRD:

```bash
kubectl get crd mcpservers.kagent.dev -o yaml | head -50
```

Or if it's `mcpservers.kmcp.dev`:

```bash
kubectl get crd mcpservers.kmcp.dev -o yaml | head -50
```

This shows the CRD definition, including the API version, schema, and validation rules.

## Quiz Questions

**Question 1**: What KMCP-related CRD is installed with Kagent 0.7.x?

**Options**:
- A) `mcpservers.kagent.dev` or `mcpservers.kmcp.dev`
- B) `mcpcontrollers.kmcp.dev`
- C) `mcptools.kmcp.dev`
- D) `kmcpconfigs.kmcp.dev`

**Answer: A) `mcpservers.kagent.dev` or `mcpservers.kmcp.dev`**

The MCPServer CRD is the main resource for managing MCP servers in Kubernetes.

---

**Question 2**: True or False: KMCP CRDs are automatically installed when you install Kagent 0.7.x or later.

**Options**:
- A) True
- B) False

**Answer: A) True**

Starting from Kagent version 0.7.x, KMCP CRDs are included in the Kagent package, so no separate installation is needed.

---

**Question 3**: Since which Kagent version are KMCP CRDs included in the package?

**Options**:
- A) 0.5.x
- B) 0.6.x
- C) 0.7.x
- D) 1.0.x

**Answer: C) 0.7.x**

KMCP CRDs became part of the Kagent package starting from version 0.7.x.

---

**Question 4**: What is the API version for MCPServer resources?

**Options**:
- A) `kmcp.dev/v1alpha1`
- B) `kagent.dev/v1alpha1`
- C) `v1`
- D) `apps/v1`

**Answer: B) `kagent.dev/v1alpha1`**

When KMCP is bundled with Kagent, MCPServer resources use the `kagent.dev/v1alpha1` API version.

## Summary

You've discovered that:
- ✅ KMCP CRDs are automatically installed with Kagent 0.7.x+
- ✅ The main CRD is `mcpservers.kagent.dev` (or `mcpservers.kmcp.dev`)
- ✅ MCPServer resources use the `kagent.dev/v1alpha1` API version
- ✅ No separate installation is needed for Kagent 0.7.x+

**Key Takeaways**:
- KMCP is bundled with Kagent, making setup simpler
- The MCPServer CRD enables managing MCP servers as Kubernetes resources
- You can verify CRD installation using `kubectl get crd`

---

**Next Step**: [Step 3: Explore KMCP Controller Components](03-explore-kmcp-controller.md)

