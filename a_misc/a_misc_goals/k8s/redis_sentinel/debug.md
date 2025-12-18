# debug redis on k8s

## add FQDN to /etc/hosts file

pod.namespace.svc.cluster.local

redis-sentinel-master.redis-sentinel.svc.cluster.local
** Please be patient while the chart is being deployed **

Redis&reg; can be accessed on the following DNS names from within your cluster:

    redis-sentinel-master.redis-sentinel.svc.cluster.local for read/write operations (port 6379)
    redis-sentinel-replicas.redis-sentinel.svc.cluster.local for read-only operations (port 6379)



To get your password run:

export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)

To connect to your Redis&reg; server:

1. Run a Redis&reg; pod that you can use as a client:

kubectl run --namespace redis-sentinel redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.2.4-debian-12-r12 --command -- sleep infinity
pod/redis-client created

Use the following command to attach to the pod:

kubectl exec --tty -i redis-client \
   --namespace redis-sentinel -- bash

2. Connect using the Redis&reg; CLI:
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-replicas

To connect to your database from outside the cluster execute the following commands:
