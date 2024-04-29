# **[Handling Mutexes in Distributed Systems with Redis and Go](https://dev.to/jdvert/handling-mutexes-in-distributed-systems-with-redis-and-go-5g0d)**

A mutual exclusion lock (or Mutex which is an abbreviation of Mutual Exclusion) is a very important and sometimes overlooked concept when building a thread-safe access to a system's resources. On top of it being overlooked it can be quite challenging to handle and can lead to race conditions in your system if not done correctly.

In this post I will go over how you can use Redis (a popular and widely used key-value store) to help ensure your Go application has mutex on important operations and resources using **[Redis's implementation of distributed locks](https://redis.io/docs/manual/patterns/distributed-locks/)**.

## **[A Redis Lock Library](https://github.com/go-redsync/redsync)**
