# Lab Preparation: Setup Environment with Custom Configuration

## Goal
Install Kagent with a custom ModelConfig and deploy a CloudWatch MCP server without credentials (intentionally broken for learning).

## Step 1: Install Kagent with Minimal Configuration

```bash
# Export OpenAI API key
export OPENAI_API_KEY="your-openai-api-key-here"

# Install CRDs via OCI chart (creates namespace if needed)
helm upgrade --install kagent-crds oci://ghcr.io/kagent-dev/kagent/helm/kagent-crds \
  --namespace kagent \
  --create-namespace

# Install kagent with minimal values
helm upgrade --install kagent oci://ghcr.io/kagent-dev/kagent/helm/kagent \
  --namespace kagent \
  -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/01-values-min.yaml \
  --set providers.default=openAI \
  --set providers.openAI.apiKey=$OPENAI_API_KEY
```

## Step 2: Create Custom ModelConfig

Create a ModelConfig named `openai-modelconfig` (different from the default):

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/openai-modelconfig.yaml
```

Verify:
```bash
kubectl get modelconfigs -n kagent
```

Expected output should include `openai-modelconfig`.

## Step 3: Deploy CloudWatch MCP Server (Without Credentials)

Deploy the MCP server with an intentionally different name and no AWS credentials:

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/cloudwatch-mcp-server-broken.yaml
```

Verify:
```bash
kubectl get mcpservers -n kagent
```

Expected: MCP server named `awslabs-cloudwatch` (not the full name).

## Step 4: Set Up AWS CloudWatch Log Groups

Run the setup script to create sample log groups:

```bash
bash /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/setup-cloudwatch-logs.sh
```

Verify:
```bash
aws logs describe-log-groups --region us-east-1 --max-items 5
```

## Expected Results

After preparation:
- ✅ Kagent is running with minimal configuration
- ✅ Custom ModelConfig `openai-modelconfig` exists
- ✅ CloudWatch MCP server `awslabs-cloudwatch` is deployed (without credentials)
- ✅ 15 CloudWatch log groups are created
- ✅ Ready to start troubleshooting exercises

## Important Notes

⚠️ **Intentional Issues for Learning:**
- ModelConfig name is `openai-modelconfig` (not `default-model-config`)
- MCP server name is `awslabs-cloudwatch` (not `awslabs-aws-cloudwatch-mcp-server-latest`)
- MCP server has no AWS credentials configured

These issues are intentional and will be fixed during the lab exercises.
