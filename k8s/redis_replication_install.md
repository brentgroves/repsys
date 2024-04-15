# **[Redis Replication](https://ot-redis-operator.netlify.app/docs/getting-started/replication/)**

## references

<https://ot-redis-operator.netlify.app/docs/getting-started/replication/>

## Replication

Instructions for setting up Redis Replication

Architecture
Redis is an in-memory key-value store that can be used as a database, cache, and message broker. Redis replication is the process of synchronizing data from a Redis leader node to one or more Redis follower nodes.

In Redis replication, the leader node is responsible for receiving write requests and propagating the changes to one or more follower nodes. The follower nodes receive the data changes from the leader and apply them locally, thereby creating a replica of the leader’s dataset.

Redis replication uses asynchronous replication, which means that the leader node does not wait for the follower nodes to apply the changes before sending new updates. Instead, the follower nodes catch up with the leader node as soon as they can, based on the available network bandwidth and the capacity of the hardware.

Redis replication is a powerful feature that enhances the durability and scalability of Redis applications. By using Redis replication, you can distribute the workload across multiple nodes, improve the read performance, and ensure data availability in case of a node failure.

![](https://ot-redis-operator.netlify.app/images/replication-redis.png)

Note: By using Redis Sentinel, you can ensure that your Redis Replication remains available even if one or more nodes go down, improving the resilience and reliability of your application.

## Remove redis replication

```bash
kubectl delete redisReplication redis-replication
```

## YAML Installation

Examples folder has different types of manifests for different scenarios and features. There are these YAML examples present in this directory:

additional_config
advance_config
affinity
disruption_budget
external_service
password_protected
private_registry
probes
redis_monitoring
tls_enabled
upgrade_strategy
A sample manifest for deploying redis replication-cluster:

```yaml
---
apiVersion: redis.redis.opstreelabs.in/v1beta1
kind: RedisReplication
metadata:
  name:  redis-replication
spec:
  clusterSize: 3
  securityContext:
    runAsUser: 1000
    fsGroup: 1000
  kubernetesConfig:
    image: quay.io/opstree/redis:v7.0.5
    imagePullPolicy: IfNotPresent
    resources:
      requests:
        cpu: 101m
        memory: 128Mi
      limits:
        cpu: 101m
        memory: 128Mi
  storage:
    volumeClaimTemplate:
      spec:
        # storageClassName: standard
        accessModes: ["ReadWriteOnce"]
        resources:
          requests:
            storage: 1Gi
```

The yaml manifest can easily get applied by using kubectl.

```bash
pushd .
cd ~/src/repsys/k8s
kubectl apply -f ./redis_replication/replication.yaml
Error from server: error when creating "./redis_replication/replication.yaml": conversion webhook for redis.redis.opstreelabs.in/v1beta1, Kind=RedisReplication failed: Post "https://webhook-service.redis-operator.svc:443/convert?timeout=30s": service "webhook-service" not found

kubectl apply -f ./redis_replication/replication-test.yaml
kubectl get pods                
NAME                                READY   STATUS                       RESTARTS        AGE
postgres-operator-77f6d658c-kkvfj   1/1     Running                      3 (3h11m ago)   3d
mysql-reports31-0                   1/1     Running                      0               3h3m
mycluster-router-6444b6fc88-rrph8   1/1     Running                      13 (3h3m ago)   3d1h
mycluster-0                         2/2     Running                      0               3h3m
mycluster-1                         2/2     Running                      7 (3h9m ago)    3d1h
mycluster-2                         2/2     Running                      0               3h3m
acid-minimal-cluster-1              1/1     Running                      2 (3h11m ago)   3d
acid-minimal-cluster-0              1/1     Running                      2 (3h11m ago)   3d
redis-replication-0                 0/1     CreateContainerConfigError   0               2m15s

```
