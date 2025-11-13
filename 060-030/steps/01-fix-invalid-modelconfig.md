# Step 1: Fix Agent with Invalid ModelConfig

## Instructions

### 1. Deploy the Broken Agent

Apply the agent with invalid ModelConfig reference:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/broken-agents/01-invalid-modelconfig.yaml
```

### 2. Check Agent Status

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME                         TYPE          READY   ACCEPTED
cloudwatch-log-analyzer-v1   Declarative   False   False
```

Notice: `ACCEPTED=False`

### 3. Diagnose the Problem

Use `kubectl describe` to see the error:

```bash
kubectl describe agent cloudwatch-log-analyzer-v1 -n kagent
```

**Look for the Conditions section:**
```
Conditions:
  Type:     Accepted
  Status:   False
  Reason:   ModelConfigNotFound
  Message:  ModelConfig "default-model-config" not found
```

### 4. Identify Available ModelConfigs

List available ModelConfigs:

```bash
kubectl get modelconfigs -n kagent
```

**Expected Output:**
```
NAME                  AGE
openai-modelconfig    5m
```

### 5. Fix the Agent

Edit the agent YAML to use the correct ModelConfig:

```bash
kubectl edit agent cloudwatch-log-analyzer-v1 -n kagent
```

Change:
```yaml
spec:
  declarative:
    modelConfig: default-model-config  # ❌ Wrong
```

To:
```yaml
spec:
  declarative:
    modelConfig: openai-modelconfig    # ✅ Correct
```

Save and exit.

### 6. Verify the Fix

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME                         TYPE          READY   ACCEPTED
cloudwatch-log-analyzer-v1   Declarative   True    True
```

Both `READY` and `ACCEPTED` should now be `True`.

## Validation Questions

**Q1: Why was the agent not ACCEPTED initially?**
- A) Missing tools
- B) Invalid ModelConfig reference
- C) Missing AWS credentials
- D) Wrong namespace

**Answer:** B

**Q2: What kubectl command helps diagnose why an agent is not ACCEPTED?**

**Answer:** `kubectl describe agent <agent-name> -n kagent`

## Key Takeaways

- ✅ `ACCEPTED=False` indicates a validation or reference error
- ✅ Use `kubectl describe` to see detailed error messages
- ✅ ModelConfig must exist before the agent can be accepted
- ✅ Check the Conditions section for specific error reasons

Proceed to Step 2.
