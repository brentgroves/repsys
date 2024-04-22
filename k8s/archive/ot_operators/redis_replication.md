# **[Replication](https://ot-redis-operator.netlify.app/docs/getting-started/replication/)**

Instructions for setting up Redis Replication

## references

<https://ot-redis-operator.netlify.app/docs/configuration/redisreplication/>

## Architecture

Redis is an in-memory key-value store that can be used as a database, cache, and message broker. Redis replication is the process of synchronizing data from a Redis leader node to one or more Redis follower nodes.

In Redis replication, the leader node is responsible for receiving write requests and propagating the changes to one or more follower nodes. The follower nodes receive the data changes from the leader and apply them locally, thereby creating a replica of the leader’s dataset.

Redis replication uses asynchronous replication, which means that the leader node does not wait for the follower nodes to apply the changes before sending new updates. Instead, the follower nodes catch up with the leader node as soon as they can, based on the available network bandwidth and the capacity of the hardware.

Redis replication is a powerful feature that enhances the durability and scalability of Redis applications. By using Redis replication, you can distribute the workload across multiple nodes, improve the read performance, and ensure data availability in case of a node failure.

![](https://ot-redis-operator.netlify.app/images/replication-redis.png)

Note: By using Redis Sentinel, you can ensure that your Redis Replication remains available even if one or more nodes go down, improving the resilience and reliability of your application.

## Helm Installation

For redis replication setup we can use helm command with the reference of replication helm chart and additional properties:

```bash
helm install redis-replication ot-helm/redis-replication --set redisreplication.clusterSize=3 --namespace ot-operators
...
NAME: redis-replication
LAST DEPLOYED: Tue Mar 21 22:47:44 2023
NAMESPACE: ot-operators
STATUS: deployed
REVISION: 1
TEST SUITE: None
```

Verify the replication-cluster by checking the pod status of pods.

```bash
kubectl get pods -n ot-operators
...
NAME                  READY   STATUS    RESTARTS   AGE
redis-replication-0   1/1     Running   0          2m23s
redis-replication-1   1/1     Running   0          99s
redis-replication-2   1/1     Running   0          59s
```

If all the pods are in the running, then we can check the health of the redis replication-cluster by using redis-cli. Here by default the 0th index redis pod is promoted to master.
