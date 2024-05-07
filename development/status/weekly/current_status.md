# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## NEXT

- **[Test k8s.io from within Cluster](https://github.com/kubernetes/client-go/blob/master/examples/in-cluster-client-configuration/main.go)**
  - read database passwords from k8s secret and write to k8s log.
- Remove password from mutex tutorial.

- **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**

## Project List

- **[Report System](../../../projects/report_system/report_system.md)**
- **[Observability System](../../../projects/observability_system/observability_system.md)**

## Development

- **[Setup Development System](../../report_system/setup_dev_system/setup_dev_system.md)**
- **[All Software MindMap](../../report_system/all_sw_mindmap.md)**
- **[All Software Gantt](../../report_system/all_sw_gantt.md)**
- **[Report Creation Sequence Diagram](../../report_system/report_creation_sequece_diagram.md)**
- **[Trial Balance Runner Flow Chart](../../report_system/trial_balance_runner_flow_chart.md)**
- **[Task List](../../report_system/task_list.md)**
- **[Requester Mockup](../../report_system/requester_mockup/requester_mockup.md)**

## Task Tutorials & Notes

- **[Handling Mutexes in Distributed Systems with Redis and Go](../../../volumes/go/tutorials/redis_sentinel/mutex/tutorial_redis_mutex_go.md)**
- **[In-Cluster K8s API access](../../../volumes/go/tutorials/k8s/in_cluster_client_configuration/in-cluster-client-configuration.md)**
- **[Out-of-Cluster K8s API access](../../../volumes/go/tutorials/k8s/out-of-cluster-client-configuration/out-of-cluster-client-configuration.md)**

## Research

- **[Minio Object Storage](../../../research/m_z/minio/minio.md)**\
  Object storage is accessed via a REST API call. Using POST, PUT, GET to an HTTP endpoint, you can create, read, update and delete (the famous CRUD operations) your blobs of data.

- **[Juju](../../../research/a_l/juju/tutorial.md)**\
  Juju provides a declarative and model-driven way to install, provision, maintain, update, upgrade, and integrate applications on and across Kubernetes containers, Linux containers, virtual machines, and bare metal machines, on public or private cloud.

- **[Multipass](../../../research/m_z/multipass/multipass.md)**
Multipass is a tool to generate cloud-style Ubuntu VMs quickly on Linux, macOS, and Windows. It gives you a simple but powerful CLI that allows you to quickly access an Ubuntu command line or create your own local mini-cloud.

- **[Mattermost](../../../research/m_z/mattermost/mattermost.md)** \
  Mattermost is an open-source, self-hostable online chat service with file sharing, search, and integrations. It is designed as an internal chat for organisations and companies, and mostly markets itself as an open-source alternative to Slack and Microsoft Teams. Wikipedia

- **[Redis Distributed Locks (mutex)](../../../research/m_z/redis/mutex/distributed_locks.md)**\
  We are going to model our design with just three properties that, from our point of view, are the minimum guarantees needed to use distributed locks in an effective way.

  - Safety property: Mutual exclusion. At any given moment, only one client can hold a lock.
  - Liveness property A: Deadlock free. Eventually it is always possible to acquire a lock, even if the client that locked a resource crashes or gets partitioned.
  - Liveness property B: Fault tolerance. As long as the majority of Redis nodes are up, clients are able to acquire and release locks. \

  To acquire the lock, the way to go is the following:

  `SET resource_name my_random_value NX PX 30000` \
  The command will set the key only if it does not already exist (NX option), with an expire of 30000 milliseconds (PX option). The key is set to a value “my_random_value”. This value must be unique across all clients and all lock requests.
