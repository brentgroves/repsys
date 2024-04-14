# **[Redis Operator](https://ot-redis-operator.netlify.app/docs/installation/installation/)**

## references

## Uninstall

## Remove Redis

```bash
helm uninstall redis-operator -n ot-operators
helm repo remove ot-helm 
helm delete ns ot-operators
```

## Installation

Instructions for installation of Redis Operator.
Redis Operator is developed as CRD(Custom Resource Definition) to deploy and manage Redis in standalone/cluster mode. So CRD is an amazing feature of Kubernetes which allows us to create our own resources and APIs in Kubernetes. For further information about CRD, please go through the official documentation.

There are four different Objects available under redis.redis.opstreelabs.in/v1beta1:

- Redis
- Redis Cluster
- Redis Replication
- Redis Sentinel

For **[OperatorHub installation](https://operatorhub.io/operator/redis-operator):

So for deploying the redis-operator and setup we need a Kubernetes cluster 1.18+ and that’s it. Let’s deploy the redis operator first.

The easiest way to install a redis operator is using Helm chart. The operator helm chart is developed on the helm=>3.0.0 version. The **[values.yaml](https://github.com/OT-CONTAINER-KIT/helm-charts/blob/main/charts/redis-operator/values.yaml)** can be modified.

## Helm Installation

```bash
helm repo add ot-helm https://ot-container-kit.github.io/helm-charts/
helm install redis-operator ot-helm/redis-operator --namespace ot-operators
NAME: redis-operator
LAST DEPLOYED: Sun Apr 14 13:22:32 2024
NAMESPACE: ot-operators
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

## Installation Validation
Instructions for validating installation of Operator
To confirm Redis Operator is up and running, run the following command:

```bash
kubectl describe --namespace ot-operators pods
```

It should describe one pod created in the ot-operators namespace, with no error messages or status. All Conditions sections should look like this:

Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True

## The operator pod should be in a RUNNING state:

```bash
kubectl get pods -n ot-operators 
NAME                             READY   STATUS    RESTARTS   AGE
redis-operator-c7d844dd4-n57c9   1/1     Running   0          2m41s
```

That’s it!

Now with Redis Operator installed, you can utilise its Custom Resource Definitions to create resources of type Redis, RedisCluster and more!

## Getting Started

Instructions for getting started on Redis and Redis cluster setup
The redis operator supports below deployment strategies for redis:-

- Cluster setup
- Standalone setup
- Replication setup
- Sentinel setup

## Replication setup

In Redis replication, the leader node is responsible for receiving write requests and propagating the changes to one or more follower nodes. The follower nodes receive the data changes from the leader and apply them locally, thereby creating a replica of the leader’s dataset.

![](https://ot-redis-operator.netlify.app/images/replication-redis.png)

## Standalone

Redis standalone is a single process-based redis pod that can manage your keys inside it. Multiple applications can consume this redis with a Kubernetes endpoint or service. Since this standalone setup is running inside Kubernetes, the auto-heal feature will be automatically part of it. The only drawback of a standalone setup is that it doesn’t stand on the high availability principle.

![](https://ot-redis-operator.netlify.app/images/standalone-redis.png)

## Sentinel

Redis Sentinel is a tool that provides automatic failover and monitoring for Redis nodes. It works by running separate processes that communicate with each other and with Redis nodes to detect failures, elect a new master node, and configure the other nodes to replicate from the new master. Sentinel can also perform additional tasks such as sending notifications and managing configuration changes. Redis Sentinel is a flexible and robust solution for implementing high availability in Redis.

![](https://ot-redis-operator.netlify.app/images/sentinel-redis.png)