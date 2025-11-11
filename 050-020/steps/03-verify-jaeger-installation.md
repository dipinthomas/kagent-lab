# Step 3: Verify Jaeger Installation

## Overview
Verify that Jaeger has been successfully deployed and all components are running properly in the Kubernetes cluster.

## Check Jaeger Pods

Verify that Jaeger pods are running in the jaeger namespace:

```bash
# Check pods in jaeger namespace
kubectl get pods -n jaeger
```

**Expected Output:**
```
NAME                      READY   STATUS    RESTARTS   AGE
 <pod_name>                  1/1     Running   0          2m30s
```

## Check Jaeger Services

Verify that Jaeger services are properly created:

```bash
# Check services in jaeger namespace
kubectl get svc -n jaeger
```

**Expected Output:**
```
NAME                    TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)                                  AGE
jaeger-agent            ClusterIP   None            <none>        5775/UDP,5778/TCP,6831/UDP,6832/UDP      3m
jaeger-collector        ClusterIP   10.96.xxx.xxx   <none>        9411/TCP,14250/TCP,14267/TCP,4317/TCP    3m
jaeger-query            ClusterIP   10.96.xxx.xxx   <none>        16686/TCP,16687/TCP                      3m
```

## Verify Pod Logs

Check the Jaeger pod logs to ensure it's starting correctly:

```bash
# View Jaeger pod logs
kubectl logs -n jaeger <pod_name>
```

**Look for successful startup messages like:**
```
{"level":"info","ts":1699123456.789,"caller":"app/server.go:123","msg":"Starting jaeger-query"}
{"level":"info","ts":1699123456.790,"caller":"app/server.go:145","msg":"Query server started"}
```

## Check Resource Status

Verify all Jaeger resources are healthy:

```bash
# Get all resources in jaeger namespace
kubectl get all -n jaeger
```

## Troubleshooting

If pods are not running, check the following:

### Pod Status Issues
```bash
# Describe pod for detailed information
kubectl describe pod -n jaeger jaeger-0

# Check events in the namespace
kubectl get events -n jaeger --sort-by='.lastTimestamp'
```

### Common Issues
- **ImagePullBackOff**: Check internet connectivity and image availability
- **Pending**: Check node resources and scheduling constraints
- **CrashLoopBackOff**: Check pod logs for application errors

## Validation Checklist

- ✅ Jaeger pod is in `Running` status
- ✅ All services are created with proper ClusterIP assignments
- ✅ Pod logs show successful startup messages
- ✅ No error events in the namespace

## Next Steps
Once Jaeger is verified as running, proceed to Step 4 to install Kagent with tracing enabled.
