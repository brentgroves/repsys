# **[Handling Mutexes in Distributed Systems with Redis and Go](https://dev.to/jdvert/handling-mutexes-in-distributed-systems-with-redis-and-go-5g0d)**

A mutual exclusion lock (or Mutex which is an abbreviation of Mutual Exclusion) is a very important and sometimes overlooked concept when building a thread-safe access to a system's resources. On top of it being overlooked it can be quite challenging to handle and can lead to race conditions in your system if not done correctly.

In this post I will go over how you can use Redis (a popular and widely used key-value store) to help ensure your Go application has mutex on important operations and resources using **[Redis's implementation of distributed locks](https://redis.io/docs/manual/patterns/distributed-locks/)**.

## How does Redis support distributed locks

Redis supports distributed locks through the use of its SET command. When used with certain options, the SET command can be used to implement a locking algorithm (ideally you make the key something unique so only 1 thread/request can have the lock at once like a user id for example).

The idea is the SET command used will only succeed if the given key does not already exist in Redis, effectively creating a lock. Once the lock is acquired, other processes will be unable to acquire the lock since they are unable to set that same key being used as described in the distributed locks page.

To release the lock, the process that acquired the lock can use the DEL command to delete the Redis key. Once the key is deleted, the lock is released and other processes can acquire the lock if they need to by setting the key again.

## Implementing distributed locks in Go using Redis

In this example we will use the Redis client library github.com/go-redis/redis which is a common library many developers use to interact with a Redis instance in Go.

## Setup to debug

# debug redis on k8s

## add FQDN to /etc/hosts file

pod.namespace.svc.cluster.local

redis-sentinel-master.redis-sentinel.svc.cluster.local
**Please be patient while the chart is being deployed**

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

## Creating the project

```bash
pushd .
mkdir -p ~/src/repsys/volumes/go/tutorials/redis_sentinel/mutex
cd ~/src/repsys/volumes/go/tutorials/redis_sentinel/mutex
go mod init mutex
pushd .
cd ~/src/repsys
go work use ./volumes/go/tutorials/redis_sentinel/mutex
dirs -v
pushd +X # where X is 0 based number from the bottom of dirs -v entries
go get github.com/redis/go-redis/v9
go: added github.com/cespare/xxhash/v2 v2.2.0
go: added github.com/dgryski/go-rendezvous v0.0.0-20200823014737-9f7001d12a5f
go: added github.com/redis/go-redis/v9 v9.5.1

```
