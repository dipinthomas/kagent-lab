# Step 5: Fix MCP Server Credentials

## Scenario
Add AWS credentials to the CloudWatch MCP server so the agent can successfully query CloudWatch log groups.

## Instructions

### 1. Prepare AWS Credentials

Ensure you have valid AWS credentials. You can check with:

If this works, your credentials are configured.

### 2. Get Your AWS Credentials

```bash
# Get Access Key ID
aws configure get aws_access_key_id

# Get Secret Access Key
aws configure get aws_secret_access_key
```

### 3. Update MCP Server Configuration

Edit the MCP server YAML file:

```bash
vi /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/cloudwatch-mcp-server-fixed.yaml
```

Update the `env` section with your credentials:

```yaml
env:
  AWS_ACCESS_KEY_ID: "YOUR_ACCESS_KEY_HERE"
  AWS_REGION: us-east-1
  AWS_SECRET_ACCESS_KEY: "YOUR_SECRET_KEY_HERE"
```

### 4. Apply the Updated MCP Server

```bash
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/cloudwatch-mcp-server-fixed.yaml
```

### 5. Verify MCP Server Update

```bash
kubectl get mcpserver awslabs-cloudwatch -n kagent -o yaml | grep -A 5 "env:"
```

You should see your credentials (they will be visible in the YAML).

### 6. Restart the Agent (If Needed)

⚠️ **Important Note:** If you encounter a "session terminated" error when testing the agent, delete and recreate it:

```bash
# Delete the agent
kubectl delete agent cloudwatch-log-analyzer-v1 -n kagent

# Recreate the agent
kubectl apply -f /Users/admin/Documents/kodekloud/kagent/kagent-lab/060-030/support-code/broken-agents/04-with-tools.yaml
```

Wait for the agent pod to be Running:

```bash
kubectl get pods -n kagent -l app.kubernetes.io/name=cloudwatch-log-analyzer-v1
```

### 7. Test the Agent

Now send the query again:

**Query:** "Get the list of AWS CloudWatch log groups in the us-east-1 region."

**Expected Response:**
The agent should successfully list all CloudWatch log groups:

```
Here are the CloudWatch log groups in the us-east-1 region:

**Lambda Functions (Empty):**
- /aws/lambda/test-function-1
- /aws/lambda/test-function-2
- /aws/lambda/test-function-3
- /aws/lambda/test-function-4
- /aws/lambda/test-function-5
- /aws/lambda/test-function-6
- /aws/lambda/test-function-7
- /aws/lambda/test-function-8
- /aws/lambda/test-function-9
- /aws/lambda/test-function-10

**EC2 Applications (With Data):**
- /aws/ec2/application-1
- /aws/ec2/application-2
- /aws/ec2/application-3
- /aws/ec2/application-4
- /aws/ec2/application-5

Total: 15 log groups found.
```

### 8. Verify Full Functionality

Try a more complex query:

**Query:** "Analyze the log group /aws/ec2/application-1 and show me any ERROR messages."

The agent should now be able to retrieve and analyze the logs successfully.

## Validation Questions

**Q1: After adding credentials, is the agent able to list all log groups?**
- A) Yes
- B) No

**Answer:** A (Yes)

**Q2: Why was restarting the agent sometimes necessary?**

**Answer:** When the MCP server configuration changes (especially credentials), the agent's connection to the MCP server may need to be re-established. Deleting and recreating the agent ensures a fresh connection with the updated credentials.

**Q3: Where are the AWS credentials stored in this setup?**
- A) In the Agent spec
- B) In the MCP Server spec
- C) In a Kubernetes Secret
- D) In the agent pod directly

**Answer:** B (In the MCP Server spec's env section)

## Security Best Practice

⚠️ **Important:** In production environments, you should:
- Use Kubernetes Secrets to store credentials
- Use IAM roles for service accounts (IRSA) instead of hardcoded credentials
- Enable encryption at rest for secrets
- Rotate credentials regularly

Example with Secrets:
```yaml
env:
  AWS_ACCESS_KEY_ID:
    valueFrom:
      secretKeyRef:
        name: aws-credentials
        key: access-key-id
  AWS_SECRET_ACCESS_KEY:
    valueFrom:
      secretKeyRef:
        name: aws-credentials
        key: secret-access-key
```

## Key Takeaways

- ✅ MCP servers need proper credentials to access external services
- ✅ Credentials are configured in the MCP server spec, not the agent spec
- ✅ Updating MCP server credentials may require agent restart
- ✅ Always use Kubernetes Secrets for credentials in production
- ✅ Test with simple queries first, then move to complex operations

## Troubleshooting Common Issues

**Issue:** "Session terminated" error
**Solution:** Delete and recreate the agent to establish a fresh connection

**Issue:** "Access Denied" errors
**Solution:** Verify AWS credentials have CloudWatch read permissions

**Issue:** Agent still can't access CloudWatch
**Solution:** Check MCP server pod logs:
```bash
kubectl logs -n kagent -l app=awslabs-cloudwatch --tail=50
```

## Lab Complete! 🎉

You've successfully:
- ✅ Fixed invalid ModelConfig references
- ✅ Corrected MCP server name mismatches
- ✅ Understood the role of tools in agents
- ✅ Diagnosed and fixed credential issues
- ✅ Deployed a fully functional CloudWatch agent

Your agent can now query and analyze AWS CloudWatch logs!
