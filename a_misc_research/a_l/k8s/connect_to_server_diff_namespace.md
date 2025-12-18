# **[How to connect to server in diff namespace](https://stackoverflow.com/questions/37221483/service-located-in-another-namespace)**

If your pod is running in a different namespace than the service how do you connect to it?

I stumbled over the same issue and found a nice solution which does not need any static ip configuration:

You can access a service via it's **[DNS name](https://kubernetes.io/docs/concepts/services-networking/dns-pod-service/)** (as mentioned by you): servicename.namespace.svc.cluster.local

You can use that DNS name to reference it in another namespace via a local service:

```yaml
kind: Service
apiVersion: v1
metadata:
  name: service-y
  namespace: namespace-a
spec:
  type: ExternalName
  externalName: service-y.namespace-b.svc.cluster.local
  ports:
  - port: 80
```

or you can use the FQDN

## Add names of k8s services and pods to hosts file

```bash
sudo nvim /etc/hosts
127.0.0.1 redis-sentinel-master.redis-sentinel.svc.cluster.local
```

```bash
# The redis server is running in the redis-sentinel namespace.
# To connect to your Redis&reg; server:
# First get your password run:

export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)

# Run a Redis&reg; pod that you can use as a client from the default namespace:

kubectl run --namespace default redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.2.4-debian-12-r12 --command -- sleep infinity
pod/redis-client created

Use the following command to attach to the pod:
kubectl exec --tty -i redis-client \
   --namespace default -- bash

# 2. Connect using the Redis&reg; CLI:
# servicename.namespace.svc.cluster.local
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master.redis-sentinel.svc.cluster.local
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-replicas
