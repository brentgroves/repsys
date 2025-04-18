# **[CPU and memory resources](https://www.keycloak.org/high-availability/concepts-memory-and-cpu-sizing)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Status](../../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../../README.md)**

## references

- **[guides](https://www.keycloak.org/guides)**
- **[quarkus](https://www.mastertheboss.com/keycloak/getting-started-with-keycloak-powered-by-quarkus/)**
- **[k8s without operator](https://www.keycloak.org/getting-started/getting-started-kube)**

## Concepts for sizing CPU and memory resources

Understand these concepts to avoid resource exhaustion and congestion

Use this as a starting point to size a product environment. Adjust the values for your environment as needed based on your load tests.

## Performance recommendations

- Performance will be lowered when scaling to more Pods (due to additional overhead) and using a cross-datacenter setup (due to additional traffic and operations).
- Increased cache sizes can improve the performance when Keycloak instances running for a longer time. This will decrease response times and reduce IOPS on the database. - Still, those caches need to be filled when an instance is restarted, so do not set resources too tight based on the stable state measured once the caches have been filled.

Use these values as a starting point and perform your own load tests before going into production.

**[IOPS](../../../m_z/storage/iops.md)** is a measure of a storage device's read/write speed. It refers to the number of input/output (I/O) operations the device can complete in a second.

## Summary

- The used CPU scales linearly with the number of requests up to the tested limit below.
- The used memory scales linearly with the number of active sessions up to the tested limit below.

## Recommendations

- The base memory usage for an inactive Pod is 1000 MB of RAM.
- For each 100,000 active user sessions, add 500 MB per Pod in a three-node cluster (tested with up to 200,000 sessions).
This assumes that each user connects to only one client. Memory requirements increase with the number of client sessions per user session (not tested yet).
- In containers, Keycloak allocates 70% of the memory limit for **[heap based memory](../../application_architecture/memory/heap_memory.md)**. It will also use approximately 300 MB of non-heap-based memory. To calculate the requested memory, use the calculation above. As memory limit, subtract the non-heap memory from the value above and divide the result by 0.7.
- For each 45 password-based user logins per second, 1 vCPU per Pod in a three-node cluster (tested with up to 300 per second).
Keycloak spends most of the CPU time hashing the password provided by the user, and it is proportional to the number of hash iterations.
- For each 500 client credential grants per second, 1 vCPU per Pod in a three node cluster (tested with up to 2000 per second).
Most CPU time goes into creating new TLS connections, as each client runs only a single request.
- For each 350 refresh token requests per second, 1 vCPU per Pod in a three-node cluster (tested with up to 435 refresh token requests per second).
- Leave 200% extra head-room for CPU usage to handle spikes in the load. This ensures a fast startup of the node, and sufficient capacity to handle failover tasks like, for example, re-balancing **[Infinispan](../../application_architecture/memory/Infinispan.md)** caches, when one node fails. Performance of Keycloak dropped significantly when its Pods were throttled in our tests.

## Calculation example

Target size:

- 50,000 active user sessions
- 45 logins per seconds
- 500 client credential grants per second
- 350 refresh token requests per second

## Limits calculated

- CPU requested: 3 vCPU
(45 logins per second = 1 vCPU, 500 client credential grants per second = 1 vCPU, 350 refresh token = 1 vCPU)
- CPU limit: 9 vCPU
(Allow for three times the CPU requested to handle peaks, startups and failover tasks)
- Memory requested: 1250 MB
(1000 MB base memory plus 250 MB RAM for 50,000 active sessions)
- Memory limit: 1360 MB
(1250 MB expected memory usage minus 300 non-heap-usage, divided by 0.7)

## Persistent user sessions

When using persistent sessions, Keycloak will use less memory as it will keep only a subset of sessions in memory. At the same time it will use more CPU resources to communicate with the database, and it will use a lot more CPU and write IO on the database to keep the session information up to date.

A performance test showed the following per 100 requests/second that update the database (login, logout, refresh token), tested up to 300 requests per second:

- 0.25 vCPU on each Pod in a 3-node Keycloak cluster.
- 0.25 CPU and 800 WriteIOPS on a Aurora PostgreSQL multi-AZ database base on a db.t4g.large instance type.

The average latency of the requests increased by 20-40 ms when running on an Aurora PostgreSQL multi-AZ database with a single reader instance on another AZ. The latency is expected to be lower when running in a single AZ or non-replicated database.

The **[Single-AZ RDS database instance](https://www.pluralsight.com/blog/cloud/rds-instances-single-multi-az-cluster)** is the simplest database configuration, and consists of a single database instance within a single availability zone.

The Multi-AZ RDS instance consists of a DB instance plus a single standby DB instance in a separate Availability Zone.  This configuration provides high availability and failover support via Amazon failover technology.

## Reference architecture

The following setup was used to retrieve the settings above to run tests of about 10 minutes for different scenarios:

- OpenShift 4.14.x deployed on AWS via ROSA.
- Machinepool with m5.4xlarge instances.
- Keycloak deployed with the Operator and 3 pods in a high-availability setup with two sites in active/passive mode.
- OpenShift’s reverse proxy running in passthrough mode were the TLS connection of the client is terminated at the Pod.
- Database Amazon Aurora PostgreSQL in a multi-AZ setup, with the writer instance in the availability zone of the primary site.
- Default user password hashing with Argon2 and 5 hash iterations and minimum memory size 7 MiB as recommended by **[OWASP](https://cheatsheetseries.owasp.org/cheatsheets/Password_Storage_Cheat_Sheet.html#argon2id)**.
- Client credential grants don’t use refresh tokens (which is the default).
- Database seeded with 100,000 users and 100,000 clients.
- Infinispan local caches at default of 10,000 entries, so not all clients and users fit into the cache, and some requests will need to fetch the data from the database.
- All sessions in distributed caches as per default, with two owners per entries, allowing one failing Pod without losing data.
