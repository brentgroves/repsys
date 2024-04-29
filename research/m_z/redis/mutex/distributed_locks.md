# **[Distributed Locks in Redis](https://redis.io/docs/latest/develop/use/patterns/distributed-locks/)**

A distributed lock pattern with Redis

Distributed locks are a very useful primitive in many environments where different processes must operate with shared resources in a mutually exclusive way.

There are a number of libraries and blog posts describing how to implement a DLM (Distributed Lock Manager) with Redis, but every library uses a different approach, and many use a simple approach with lower guarantees compared to what can be achieved with slightly more complex designs.

This page describes a more canonical algorithm to implement distributed locks with Redis. We propose an algorithm, called **Redlock**, which implements a DLM which we believe to be safer than the vanilla single instance approach. We hope that the community will analyze it, provide feedback, and use it as a starting point for the implementations or more complex or alternative designs.

Implementations
Before describing the algorithm, here are a few links to implementations already available that can be used for reference.

- Redlock-rb (Ruby implementation). There is also a fork of Redlock-rb that adds a gem for easy distribution.
- RedisQueuedLocks (Ruby implementation).
- Redlock-py (Python implementation).
- Pottery (Python implementation).
- Aioredlock (Asyncio Python implementation).
- Redlock-php (PHP implementation).
- PHPRedisMutex (further PHP implementation).
- cheprasov/php-redis-lock (PHP library for locks).
- rtckit/react-redlock (Async PHP implementation).
- **[Redsync (Go implementation)](https://github.com/go-redsync/redsync)**
- Redisson (Java implementation).
- Redis::DistLock (Perl implementation).
- Redlock-cpp (C++ implementation).
- Redis-plus-plus (C++ implementation).
- Redlock-cs (C#/.NET implementation).
- RedLock.net (C#/.NET implementation). Includes async and lock extension support.
- ScarletLock (C# .NET implementation with configurable datastore).
- Redlock4Net (C# .NET implementation).
- node-redlock (NodeJS implementation). Includes support for lock extension.
- Deno DLM (Deno implementation)
- Rslock (Rust implementation). Includes async and lock extension support.

## Safety and Liveness Guarantees

We are going to model our design with just three properties that, from our point of view, are the minimum guarantees needed to use distributed locks in an effective way.

- Safety property: Mutual exclusion. At any given moment, only one client can hold a lock.
- Liveness property A: Deadlock free. Eventually it is always possible to acquire a lock, even if the client that locked a resource crashes or gets partitioned.
- Liveness property B: Fault tolerance. As long as the majority of Redis nodes are up, clients are able to acquire and release locks.

## Why Failover-based Implementations Are Not Enough

To understand what we want to improve, let’s analyze the current state of affairs with most Redis-based distributed lock libraries.

The simplest way to use Redis to lock a resource is to create a key in an instance. The key is usually created with a limited time to live, using the Redis expires feature, so that eventually it will get released (property 2 in our list). When the client needs to release the resource, it deletes the key.

Superficially this works well, but there is a problem: this is a single point of failure in our architecture. What happens if the Redis master goes down? Well, let’s add a replica! And use it if the master is unavailable. This is unfortunately not viable. By doing so we can’t implement our safety property of mutual exclusion, because Redis replication is asynchronous.

There is a race condition with this model:

1. Client A acquires the lock in the master.
2. The master crashes before the write to the key is transmitted to the replica.
3. The replica gets promoted to master.
4. Client B acquires the lock to the same resource A already holds a lock for. SAFETY VIOLATION!

Sometimes it is perfectly fine that, under special circumstances, for example during a failure, multiple clients can hold the lock at the same time. If this is the case, you can use your replication based solution. Otherwise we suggest to implement the solution described in this document.

## Correct Implementation with a Single Instance

Before trying to overcome the limitation of the single instance setup described above, let’s check how to do it correctly in this simple case, since this is actually a viable solution in applications where a race condition from time to time is acceptable, and because locking into a single instance is the foundation we’ll use for the distributed algorithm described here.

To acquire the lock, the way to go is the following:

```redis
SET resource_name my_random_value NX PX 30000
SET tb_lock 1609 NX PX 30000
```

The command will set the key only if it does not already exist (NX option), with an expire of 30000 milliseconds (PX option). The key is set to a value “my_random_value”. This value must be **unique across all clients and all lock requests**.

Basically the random value is used in order to release the lock in a safe way, with a script that tells Redis: remove the key only if it exists and the value stored at the key is exactly the one I expect to be. This is accomplished by the following Lua script:

```lua
if redis.call("get",KEYS[1]) == ARGV[1] then
    return redis.call("del",KEYS[1])
else
    return 0
end
```

This is important in order to avoid removing a lock that was created by another client. For example a client may acquire the lock, get blocked performing some operation for longer than the lock validity time (the time at which the key will expire), and later remove the lock, that was already acquired by some other client. Using just DEL is not safe as a client may remove another client's lock. With the above script instead every lock is “signed” with a random string, so the lock will be removed only if it is still the one that was set by the client trying to remove it.

What should this random string be? We assume it’s 20 bytes from /dev/urandom, but you can find cheaper ways to make it unique enough for your tasks. For example a safe pick is to seed RC4 with /dev/urandom, and generate a pseudo random stream from that. A simpler solution is to use a UNIX timestamp with microsecond precision, concatenating the timestamp with a client ID. It is not as safe, but probably sufficient for most environments.

The "lock validity time" is the time we use as the key's time to live. It is both the auto release time, and the time the client has in order to perform the operation required before another client may be able to acquire the lock again, without technically violating the mutual exclusion guarantee, which is only limited to a given window of time from the moment the lock is acquired.

## Test Notes

The random key discussed above has the format hhmmss for the following tests.

```bash
SET resource_name my_random_value NX PX 30000
```

## Mutual Exclusion test

```bash
# open a terminal
# To get your password run:
export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)
# 1. Run a Redis&reg; pod that you can use as a client:
kubectl run --namespace redis-sentinel redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.2.4-debian-12-r12 --command -- sleep infinity
pod/redis-client created
# Use the following command to attach to the pod:
kubectl exec --tty -i redis-client \
   --namespace redis-sentinel -- bash
# 2. Connect using the Redis&reg; CLI:
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master
redis-sentinel-master:6379> SET tb_lock 160945 NX PX 30000
OK
# open another terminal and follow all the same steps
redis-sentinel-master:6379> SET tb_lock 161005 NX PX 30000
(nil)
# after 30 seconds
redis-sentinel-master:6379> SET tb_lock 161020 NX PX 30000
OK
```

## Deletion test

```bash
# open a terminal
# To get your password run:
export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)
# 1. Run a Redis&reg; pod that you can use as a client:
kubectl run --namespace redis-sentinel redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.2.4-debian-12-r12 --command -- sleep infinity
pod/redis-client created
# Use the following command to attach to the pod:
kubectl exec --tty -i redis-client \
   --namespace redis-sentinel -- bash
# 2. Connect using the Redis&reg; CLI:
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master
redis-sentinel-master:6379> SET tb_lock 162805 NX PX 30000
OK
redis-sentinel-master:6379> DEL tb_lock
(integer) 1
# open another terminal and follow all the same steps
redis-sentinel-master:6379> SET tb_lock 162815 NX PX 30000
OK
```

So now we have a good way to acquire and release the lock. With this system, reasoning about a non-distributed system composed of a single, always available, instance, is safe. Let’s extend the concept to a distributed system where we don’t have such guarantees.

## **[The Redlock Algorithm](https://redis.io/docs/latest/develop/use/patterns/distributed-locks/)**

In the distributed version of the algorithm we assume we have N Redis masters. Those nodes are totally independent, so we don’t use replication or any other implicit coordination system. We already described how to acquire and release the lock safely in a single instance. We take for granted that the algorithm will use this method to acquire and release the lock in a single instance. In our examples we set N=5, which is a reasonable value, so we need to run 5 Redis masters on different computers or virtual machines in order to ensure that they’ll fail in a mostly independent way.
