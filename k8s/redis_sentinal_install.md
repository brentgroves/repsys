# **[Redis Sentinel](https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/)

## **[High availability with Redis Sentinel](https://redis.io/docs/latest/operate/oss_and_stack/management/sentinel/)**

High availability for non-clustered Redis

Redis Sentinel provides high availability for Redis when not using Redis Cluster.

Redis Sentinel also provides other collateral tasks such as monitoring, notifications and acts as a configuration provider for clients.

This is the full list of Sentinel capabilities at a macroscopic level (i.e. the big picture):

Monitoring. Sentinel constantly checks if your master and replica instances are working as expected.
Notification. Sentinel can notify the system administrator, or other computer programs, via an API, that something is wrong with one of the monitored Redis instances.
Automatic failover. If a master is not working as expected, Sentinel can start a failover process where a replica is promoted to master, the other additional replicas are reconfigured to use the new master, and the applications using the Redis server are informed about the new address to use when connecting.
Configuration provider. Sentinel acts as a source of authority for clients service discovery: clients connect to Sentinels in order to ask for the address of the current Redis master responsible for a given service. If a failover occurs, Sentinels will report the new address.

## references

<https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/>
<https://operatorhub.io/operator/redis-operator>

<https://github.com/ot-container-kit/redis-operator>

<https://ot-redis-operator.netlify.app/>

## **[Architecture](https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/#architecture)**

Redis Sentinel is a tool that provides automatic failover and monitoring for Redis nodes. It works by running separate processes that communicate with each other and with Redis nodes to detect failures, elect a new master node, and configure the other nodes to replicate from the new master. Sentinel can also perform additional tasks such as sending notifications and managing configuration changes. Redis Sentinel is a flexible and robust solution for implementing high availability in Redis.

![](https://ot-redis-operator.netlify.app/images/sentinel-redis.png)

## Remove Redis

```bash
helm uninstall redis-sentinel -n ot-operators
```

## Helm Installation

In redis sentinel mode, we deploy redis as a single StatefulSet pod that means ease of setup but no complexity, no high availability, and no resilience.

Installation can be easily done via helm command:

## Installation

```bash
pushd .
cd ~/src/repsys/k8s

helm install redis-sentinel ot-helm/redis-sentinel \
  --set redissentinel.clusterSize=3  --namespace ot-operators \
  --set redisSentinelConfig.redisReplicationName="redis-replication"
...
NAME: redis-sentinel
LAST DEPLOYED: Sun Apr 14 12:46:30 2024
NAMESPACE: ot-operators
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## Verify the sentinel redis setup by kubectl command line

```bash
kubectl get pods -n ot-operators
NAME                             READY   STATUS    RESTARTS   AGE
redis-operator-c7d844dd4-n57c9   1/1     Running   0          17m
redis-sentinel-sentinel-0        1/1     Running   0          2m25s
redis-sentinel-sentinel-1        1/1     Running   0          2m6s
redis-sentinel-sentinel-2        1/1     Running   0          105s```
```

## YAML Installation

Use this method when you need more controll over the configuration of the cluster.

**[Examples](https://github.com/OT-CONTAINER-KIT/redis-operator/tree/master/example)** folder has different types of manifests for different scenarios and features. There are these YAML examples present in this directory:

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
A basic sample manifest for sentinel redis:

```yaml
---
apiVersion: redis.redis.opstreelabs.in/v1beta1
kind: RedisSentinel
metadata:
  name: redis-sentinel
spec:
  clusterSize: 3
  securityContext:
    runAsUser: 1000
    fsGroup: 1000
  redisSentinelConfig: 
    redisReplicationName : redis-replication
  kubernetesConfig:
    image: quay.io/opstree/redis-sentinel:v7.0.12 
    imagePullPolicy: IfNotPresent
    resources:
      requests:
        cpu: 101m
        memory: 128Mi
      limits:
        cpu: 101m
        memory: 128Mi
```

The yaml manifest can easily get applied by using kubectl.

```bash
kubectl apply -f sentinel.yaml
```

## **[Failover Testing](https://ot-redis-operator.netlify.app/docs/getting-started/failover-testing/)**

Instructions for testing the failover of Redis cluster
For cluster setup, testing can be performed to validate the failover functionality of Redis. In the failover testing, we can set some random keys inside the redis cluster and then delete one or two pods from the redis cluster. At that particular time, we can make some calls to redis for fetching the key to observing its failover mechanism of it.

Before failover testing, we have to write some dummy data inside the Redis cluster, we can write the dummy data using the redis-cli.

```bash
kubectl exec -it redis-cluster-leader-0 -n ot-operators \
    -- redis-cli -c set tony stark
```
