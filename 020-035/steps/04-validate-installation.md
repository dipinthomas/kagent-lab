# Step 4: Validate kagent installation

Suggested checks:

```bash
# Check kagent CLI is available
kagent version

# Check k8s resources in kagent namespace
kubectl get pods -n kagent
kubectl get svc -n kagent

```

Example outputs:

```bash
$ kubectl get pods -n kagent
NAME                                              READY   STATUS    RESTARTS   AGE
argo-rollouts-conversion-agent-7b65964bd4-mdpgg   1/1     Running   0          18m
cilium-debug-agent-55456d5d78-2r6ct               1/1     Running   0          18m
cilium-manager-agent-84c4799d89-tnbph             1/1     Running   0          18m
cilium-policy-agent-6b95898df5-tj8f6              1/1     Running   0          18m
helm-agent-74f88695d6-vc6df                       1/1     Running   0          18m
istio-agent-7dc66dd995-ncstt                      1/1     Running   0          18m
k8s-agent-859d99c5c5-5whvg                        1/1     Running   0          18m
kagent-controller-5778f95587-6vclk                1/1     Running   0          19m
kagent-grafana-mcp-7b9695f6ff-xfdz8               1/1     Running   0          19m
kagent-kmcp-controller-manager-6ff69876bd-w92nn   1/1     Running   0          19m
kagent-querydoc-744d47b95b-zrm7r                  1/1     Running   0          19m
kagent-tools-6d6695c5-f2kcf                       1/1     Running   0          19m
kagent-ui-6c56d787f6-9szkp                        1/1     Running   0          19m
kgateway-agent-76b8969b88-gfjvf                   1/1     Running   0          18m
observability-agent-6f457dbff6-97ppv              1/1     Running   0          18m
promql-agent-54f6ff9465-tj4tj                     1/1     Running   0          18m

$ kubectl get svc -n kagent
NAME                                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
argo-rollouts-conversion-agent                   ClusterIP   172.20.253.238   <none>        8080/TCP   18m
cilium-debug-agent                               ClusterIP   172.20.58.68     <none>        8080/TCP   18m
cilium-manager-agent                             ClusterIP   172.20.107.238   <none>        8080/TCP   18m
cilium-policy-agent                              ClusterIP   172.20.109.12    <none>        8080/TCP   18m
helm-agent                                       ClusterIP   172.20.57.14     <none>        8080/TCP   18m
istio-agent                                      ClusterIP   172.20.28.245    <none>        8080/TCP   18m
k8s-agent                                        ClusterIP   172.20.19.188    <none>        8080/TCP   18m
kagent-controller                                ClusterIP   172.20.1.188     <none>        8083/TCP   19m
kagent-grafana-mcp                               ClusterIP   172.20.210.99    <none>        8000/TCP   19m
kagent-kmcp-controller-manager-metrics-service   ClusterIP   172.20.116.50    <none>        8443/TCP   19m
kagent-querydoc                                  ClusterIP   172.20.165.194   <none>        8080/TCP   19m
kagent-tools                                     ClusterIP   172.20.28.90     <none>        8084/TCP   19m
kagent-ui                                        ClusterIP   172.20.68.242    <none>        8080/TCP   19m
kgateway-agent                                   ClusterIP   172.20.114.234   <none>        8080/TCP   18m
observability-agent                              ClusterIP   172.20.216.231   <none>        8080/TCP   18m
promql-agent                                     ClusterIP   172.20.35.70     <none>        8080/TCP   18m
```

Ask questions to  like

- how many pods are running in kagent namespace?
- how many services are running in kagent namespace?
- how many CRDs are installed?

Troubleshooting:
- If resources were installed in another namespace (e.g., default), run `kagent uninstall -n default`, then reinstall with `kagent install -n kagent`.
- If you see "address already in use" on port 8083, run `lsof -i :8083` to find the process, or port-forward to 8084 and use `--kagent-url http://localhost:8084`.
