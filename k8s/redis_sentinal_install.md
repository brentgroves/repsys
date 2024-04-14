# **[Redis Sentinel]([Sentinel](https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/))

## references

https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/
<https://operatorhub.io/operator/redis-operator>

<https://github.com/ot-container-kit/redis-operator>

<https://ot-redis-operator.netlify.app/>

## **[Architecture](https://ot-redis-operator.netlify.app/docs/getting-started/sentinel/#architecture)**

Redis Sentinel is a tool that provides automatic failover and monitoring for Redis nodes. It works by running separate processes that communicate with each other and with Redis nodes to detect failures, elect a new master node, and configure the other nodes to replicate from the new master. Sentinel can also perform additional tasks such as sending notifications and managing configuration changes. Redis Sentinel is a flexible and robust solution for implementing high availability in Redis.

![](https://ot-redis-operator.netlify.app/images/sentinel-redis.png)

## Remove Redis

```bash
helm uninstall redis-operator -n ot-operators
helm repo remove ot-helm 
helm uninstall redis-sentinel
helm delete ns ot-operators
```

## Helm Installation

In redis sentinel mode, we deploy redis as a single StatefulSet pod that means ease of setup but no complexity, no high availability, and no resilience.

Installation can be easily done via helm command:

## Installation

```bash
pushd .
cd ~/src/repsys/k8s
# Deploy the redis-operator
kubectl get namespaces
kubectl apply -f redis_sentinal/namespace.yaml
helm repo add ot-helm https://ot-container-kit.github.io/helm-charts/

helm install redis-sentinel ot-helm/redis-sentinel \
  --set redissentinel.clusterSize=3  --namespace ot-operators \
  --set redisSentinelConfig.redisReplicationName="redis-replication"

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

## Verify the sentinel redis setup by kubectl command line.

```bash
kubectl get pods -n ot-operators
No resources found in ot-operators namespace.
```

