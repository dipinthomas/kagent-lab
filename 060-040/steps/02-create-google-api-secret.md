# Step 2: Create Google API Secret

## Overview
Create a Kubernetes secret containing your Google API key. The LangGraph currency agent needs this to access Google's Gemini API for processing requests.

## Prerequisites

You need a valid Google API key with access to the Gemini API.

### How to Get a Google API Key

1. Go to [Google AI Studio](https://aistudio.google.com/app/apikey) or [Google Cloud Console](https://console.cloud.google.com/)
2. Create a new project or select an existing one
3. Enable the **Gemini API**
4. Navigate to **APIs & Services** → **Credentials**
5. Click **Create Credentials** → **API Key**
6. Copy the generated API key

## Instructions

### 1. Set Your Google API Key as an Environment Variable

Replace `your-api-key-here` with your actual Google API key:

```bash
export GOOGLE_API_KEY=your-api-key-here
```

**Example:**
```bash
export GOOGLE_API_KEY=XXXXXX
```

### 2. Verify the Environment Variable

```bash
echo $GOOGLE_API_KEY
```

**Expected Output:**
```
XXXXXX
```

### 3. Create the Kubernetes Secret

```bash
kubectl create secret generic kagent-google \
  -n kagent \
  --from-literal=GOOGLE_API_KEY=$GOOGLE_API_KEY \
  --dry-run=client -o yaml | kubectl apply -f -
```

**Command Breakdown:**
- `kubectl create secret generic kagent-google` - Create a generic secret named `kagent-google`
- `-n kagent` - Create in the `kagent` namespace
- `--from-literal=GOOGLE_API_KEY=$GOOGLE_API_KEY` - Set the key-value pair
- `--dry-run=client -o yaml` - Generate YAML without creating the resource
- `| kubectl apply -f -` - Apply the generated YAML (allows updates if secret exists)

**Expected Output:**
```
secret/kagent-google created
```

Or if the secret already exists:
```
secret/kagent-google configured
```

### 4. Verify the Secret Was Created

```bash
kubectl get secret kagent-google -n kagent
```

**Expected Output:**
```
NAME            TYPE     DATA   AGE
kagent-google   Opaque   1      10s
```

### 5. Verify the Secret Contents (Optional)

```bash
kubectl get secret kagent-google -n kagent -o jsonpath='{.data.GOOGLE_API_KEY}' | base64 -d
echo
```

**Expected Output:**
```
XXXXXX
```

This should match your original API key.


### How the Agent Uses This Secret

The BYO agent YAML references this secret:

```yaml
env:
  - name: GOOGLE_API_KEY
    valueFrom:
      secretKeyRef:
        name: kagent-google      # ← The secret we just created
        key: GOOGLE_API_KEY      # ← The key within the secret
```

When the agent pod starts, Kubernetes injects the `GOOGLE_API_KEY` environment variable with the value from the secret.


## What's Next?

Now that your Google API credentials are securely stored in Kubernetes, you'll:
1. Update the agent YAML with your Docker image
2. Deploy the BYO agent
3. Test the currency exchange functionality
