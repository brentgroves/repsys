# Setup development system

- Add names of k8s services and pods to hosts file.
- setup k8s port-forwarding with kubectl for services app needs.

```bash
# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/
kubectl port-forward --namespace redis-sentinel svc/redis-sentinel-master 6379:6379 
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379

```
