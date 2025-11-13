# Step 3: Deploy the BYO Agent

## Overview
Deploy the LangGraph currency exchange agent as a BYO (Bring Your Own) agent in Kagent using the Docker image you built.

## Instructions

### 1. Review the Agent YAML

First, let's examine the BYO agent configuration:

```bash
cat /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-040/support-code/langgraph-agent.yaml
```

**Expected Content:**
```yaml
apiVersion: kagent.dev/v1alpha2
kind: Agent
metadata:
  name: langgraph-agent
  namespace: kagent
spec:
  description: This is LangGraph currency agent.
  type: BYO
  byo:
    deployment:
      image: <YOUR_DOCKERHUB_USERNAME>/langgraph-currency:v2
      cmd: uv
      args:
        - run
        - samples/langgraph/currency/currency/cli.py
      env:
        - name: GOOGLE_API_KEY
          valueFrom:
            secretKeyRef:
              name: kagent-google
              key: GOOGLE_API_KEY
```

### 2. Update the Image Reference

**Important**: Update the `image` field with your Docker Hub username and image tag!

Open the file in your editor:

```bash
vi /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-040/support-code/langgraph-agent.yaml
```


### 3. Understanding the BYO Agent Spec

Let's break down the key fields:

#### **Type: BYO**
```yaml
type: BYO
```
This tells Kagent this is a "Bring Your Own" agent, not a declarative agent.

#### **Deployment Configuration**
```yaml
byo:
  deployment:
    image: <username>/langgraph-currency:v2
```
Specifies the container image containing your custom agent.

#### **Environment Variables**
```yaml
env:
  - name: GOOGLE_API_KEY
    valueFrom:
      secretKeyRef:
        name: kagent-google
        key: GOOGLE_API_KEY
```
Injects the Google API key from the Kubernetes secret into the container.

### 4. Deploy the Agent

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-040/support-code/langgraph-agent.yaml
```

**Expected Output:**
```
agent.kagent.dev/langgraph-agent created
```

### 5. Verify Agent Status

```bash
kubectl get agents -n kagent
```

**Expected Output:**
```
NAME              TYPE   READY   ACCEPTED
langgraph-agent   BYO    True    True
```

Wait until both `READY` and `ACCEPTED` are `True`. This may take 30-60 seconds.

### 6. Check the Agent Pod

```bash
kubectl get pods -n kagent -l app.kubernetes.io/name=langgraph-agent
```

**Expected Output:**
```
NAME                               READY   STATUS    RESTARTS   AGE
langgraph-agent-xxxxxxxxxx-xxxxx   1/1     Running   0          1m
```

### 7. View Agent Logs

```bash
kubectl logs -n kagent -l app.kubernetes.io/name=langgraph-agent --tail=50
```

**Expected Output:**
```
INFO:root:Logging configured with level: INFO
INFO:kagent.adk.cli:Starting KAgent
INFO:     Started server process [1]
INFO:     Waiting for application startup.
INFO:     Application startup complete.
INFO:     Uvicorn running on http://0.0.0.0:8080 (Press CTRL+C to quit)
```

The agent should be running without errors.


## Validation

✅ Agent YAML updated with your Docker image  
✅ Agent deployed successfully  
✅ Agent status shows READY=True and ACCEPTED=True  
✅ Agent pod is running  
✅ Agent logs show successful startup  

## What's Next?

Now that your BYO agent is deployed and running, you'll:
1. Access the agent via the A2A protocol
2. Test currency exchange queries
3. Explore the agent's capabilities through the Kagent UI
