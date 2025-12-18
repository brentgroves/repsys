# Status

## **[Back](./status.md)**

## Task Summaries

- Redis TB mutex
- Redis Pub/Sub TB Queue

## Research

- **[Juju](../../../../research/a_l/juju/tutorial.md)**\
  Juju provides a declarative and model-driven way to install, provision, maintain, update, upgrade, and integrate applications on and across Kubernetes containers, Linux containers, virtual machines, and bare metal machines, on public or private cloud.

- **[Mattermost](../../../../research/m_z/mattermost/mattermost.md)** \
  Mattermost is an open-source, self-hostable online chat service with file sharing, search, and integrations. It is designed as an internal chat for organisations and companies, and mostly markets itself as an open-source alternative to Slack and Microsoft Teams. Wikipedia

- **[Redis Distributed Locks (mutex)](../../../../research/m_z/redis/mutex/distributed_locks.md)**\
  We are going to model our design with just three properties that, from our point of view, are the minimum guarantees needed to use distributed locks in an effective way.

  - Safety property: Mutual exclusion. At any given moment, only one client can hold a lock.
  - Liveness property A: Deadlock free. Eventually it is always possible to acquire a lock, even if the client that locked a resource crashes or gets partitioned.
  - Liveness property B: Fault tolerance. As long as the majority of Redis nodes are up, clients are able to acquire and release locks. \

  To acquire the lock, the way to go is the following:

  `SET resource_name my_random_value NX PX 30000` \
  The command will set the key only if it does not already exist (NX option), with an expire of 30000 milliseconds (PX option). The key is set to a value “my_random_value”. This value must be unique across all clients and all lock requests.

- **[Handling Mutexes in Distributed Systems with Redis and Go](../../../../volumes/go/tutorials/redis_sentinel/mutex/tutorial_redis_mutex_go.md)**\

- **[Research Redis Pub/Sub](https://redis.io/docs/latest/develop/interact/pubsub/)**
- Create K8s API tutorial in go
  - **[In-Cluster K8s API access](../../../../volumes/go/tutorials/k8s/in-cluster-client-configuration.md)**
  - **[Out-of-Cluster K8s API access](../../../../volumes/go/tutorials/k8s/out-of-cluster-client-configuration/out-of-cluster-client-configuration.md)**
