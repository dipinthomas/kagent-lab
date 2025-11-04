# Step 6: Find the tool used by the agent

In this step, you'll invoke the `k8s-agent` to create a Service without a selector and then identify which tool function the agent used by inspecting the streamed JSON.

```bash
# Invoke with streamed JSON output and pretty-print with jq
kagent invoke -n kagent \
  -a k8s-agent \
  -t "create a service ssdfsdflkj in default namespace of type clusterIp without any selector" \
  -S -o json | jq .
```

Goal: Identify the tool name (e.g., `k8s_apply_manifest`).

hint 
## Extract the tool name programmatically (jq)
Because the CLI emits newline-delimited JSON status updates, you can filter for function-call events and print the tool name field. Try the following (they're resilient to slight schema differences):

```bash
# Option A: Extract tool names from status updates
kagent invoke -n kagent -a k8s-agent -t "create a service ssdfsdflkjdipin in default namespace of type clusterIp without any selector" -S -o json \
| jq -r 'select(.status? and .status.message? and .status.message.parts?)
         | .status.message.parts[]?
         | select(.kind=="data" and .data.name!=null)
         | .data.name'
```


If the above commands print a value like:
```
k8s_apply_manifest
```
then you have found the tool the agent used to fulfill your request.

## If jq extraction doesn't match your output
- Manually scan the pretty-printed JSON for a field like `"name": "k8s_apply_manifest"`.
- Different CLI versions may vary slightly in JSON shape; the key detail is the `name` under a `data` part representing the function/tool invocation.

## Questions
- What is the tool name used for this task?
```
