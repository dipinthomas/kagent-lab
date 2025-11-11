# Step 1: update aws credentials

Update aws credentials in the mcp server yaml file /Users/admin/Documents/kodekloud/kagent/kagent-lab/030-050/support-code/mcp-server.yaml

# step 2: apply yaml file

apply the yaml file using kubectl apply -f mcp-server.yaml

# lab validation 
check the mcp server is running using kubectl get mcpserver & status should be true
check the mcp server is running using kubectl get pods & pod should be in running state




