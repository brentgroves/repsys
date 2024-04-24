# Setup development system

## Add names of k8s services and pods to hosts file

```bash
sudo nvim /etc/hosts
127.0.0.1 redis-sentinel-master.redis-sentinel.svc.cluster.local
```

## setup k8s port-forwarding with kubectl for services app needs

```bash
# To get your password run:
export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)


```bash
# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/
kubectl port-forward --namespace redis-sentinel svc/redis-sentinel-master 6379:6379 
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master.redis-sentinel.svc.cluster.local -p 6379

```

## use k8s go client

For secrets use the go client for development but should work for production also.

<https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md>
