# **[Understanding etcd in Kubernetes: A Beginner's Guide](https://blog.kubesimplify.com/understanding-etcd-in-kubernetes-a-beginners-guide)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[Azure Secrets are encrypted](https://learn.microsoft.com/en-us/azure/aks/concepts-security#kubernetes-secrets)**
- **[Azure encryption at rest](https://learn.microsoft.com/en-us/azure/security/fundamentals/encryption-atrest)**

Etcd is a key-value data store used to store and manage the critical information that distributed systems need. It provides a reliable way of storing the configuration data. In this post, we will see a close look at etcd, why it is needed, and how to access its contents in Kubernetes.

## **What is etcd?**

Etcd is an open-source distributed key-value store that is used to store and manage the information that distributed systems need for their operations. It stores the configuration data, state data, and metadata in Kubernetes.

The name “etcd” comes from a naming convention within the Linux directory structure: In UNIX, all system configuration files for a single system are contained in a folder called “/etc;” “d” stands for “distributed.”

## **Why Kubernetes needs a data store?**

We know that Kubernetes is an orchestration tool whose tasks involve managing application container workloads, their configuration, deployments, service discovery, load balancing, scheduling, scaling, and monitoring, and many more tasks which might spread across multiple machines across many locations. Kubernetes needs to maintain coordination between all the components involved.

But to achieve that reliable coordination, k8s needs a data source that can help with the information about all the components, their required configuration, state data, etc. That data store must provide a consistent, single source of truth at any given point in time. In Kubernetes, that job is done by etcd. etcd is the data store used to create and maintain the version of the truth.

## But why etcd?

As it sounds, it is not a small task to act as a single point of truth for application workload. But what makes etcd worth using?

- **Fully replicated:** Every node in an etcd cluster has access to the full data store.
- **Highly available:** etcd is designed to have no single point of failure and gracefully tolerate hardware failures and network partitions.
- **Reliably consistent:** Every data ‘read’ returns the latest data ‘write’ across all clusters.
- **Fast:** etcd has been benchmarked at 10,000 writes per second.
- **Secure:** etcd supports automatic Transport Layer Security (TLS) and optional secure socket layer (SSL) client certificate authentication.

![e](https://cdn.hashnode.com/res/hashnode/image/upload/v1674021412467/b99977b9-189d-4810-ac4d-f4306cffccef.png?auto=compress,format&format=webp)

Image from etcd.io

In general, etcd is deployed as a cluster spread across multiple nodes. It is recommended for a cluster to contain an odd number of nodes, and at least three are required for production environments.

So if we have multiple etcd nodes, how the data consistency will be maintained?

etcd is built on the **[Raft consensus algorithm](https://raft.github.io/)** to ensure data storage consistency across all nodes in a cluster for a fault-tolerant distributed system.

## Raft consensus algorithm

In the raft algorithm, the data consistency is maintained via the leader, which will replicate the data to other nodes in a cluster called followers.

The leader accepts requests from clients/users, then will forward them to followers. Once the majority of followers sent back an entry made acknowledgment, the leader writes the entry. If followers crash, the leader retries until all followers store the data consistently.

If a follower fails to receive a message from the leader, a new election for the leader will be conducted.

You can find great animation explaining about raft algorithm here: <http://thesecretlivesofdata.com/raft/>

## Etcd and Kubernetes in action

In the Kubernetes cluster, etcd is deployed as pods on the control plane. To add a level of security and resiliency, it can also be deployed as an external cluster.

For this post, I am using the kind cluster. When kind is used to install the cluster, it will also install etcd as pod in the kube-system namespace.

![et](https://cdn.hashnode.com/res/hashnode/image/upload/v1674131011242/c90e9197-6de5-4a16-be19-a2834982a01c.png?auto=compress,format&format=webp)

## Interact with etcd

The following command helps to interact with the etcd-kind-control-plane pod through kubectl exec. And ETCDCTL_API is the API version through which we want to interact with etcd --cacert, --key and --cert is for TLS certificates that we will get from executing the describe command present above and get / --prefix --keys-only will give all the keys present in etcd.
