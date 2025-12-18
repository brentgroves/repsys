# **[redis bitnami install](https://github.com/bitnami/charts/blob/main/bitnami/redis-cluster/README.md))**

Bitnami package for Redis(R) Cluster
Redis(R) is an open source, scalable, distributed in-memory cache for applications. It can be used to store and serve data in the form of strings, hashes, lists, sets and sorted sets.

Overview of Redis® Cluster

Disclaimer: Redis is a registered trademark of Redis Ltd. Any rights therein are reserved to Redis Ltd. Any use by Bitnami is for referential purposes only and does not indicate any sponsorship, endorsement, or affiliation between Redis Ltd.

TL;DR

```bash
helm install my-release oci://registry-1.docker.io/bitnamicharts/redis-cluster
```

Looking to use Redisreg; Cluster in production? Try VMware Tanzu Application Catalog, the enterprise edition of Bitnami Application Catalog.

## Introduction

This chart bootstraps a Redis® deployment on a Kubernetes cluster using the Helm package manager.

Bitnami charts can be used with Kubeapps for deployment and management of Helm Charts in clusters.

Choose between Redis® Helm Chart and Redis® Cluster Helm Chart
You can choose any of the two Redis® Helm charts for deploying a Redis® cluster. While Redis® Helm Chart will deploy a master-slave cluster using Redis® Sentinel, the Redis® Cluster Helm Chart will deploy a Redis® Cluster with sharding. The main features of each chart are the following:

|                                            Redis®                                            |                                            Redis® Cluster                                            |
|:--------------------------------------------------------------------------------------------:|:----------------------------------------------------------------------------------------------------:|
| Supports multiple databases                                                                  | Supports only one database. Better if you have a big dataset                                         |
| Single write point (single master)                                                           | Multiple write points (multiple masters)                                                             |
| ![](https://github.com/bitnami/charts/raw/main/bitnami/redis-cluster/img/redis-topology.png) | ![](https://github.com/bitnami/charts/raw/main/bitnami/redis-cluster/img/redis-cluster-topology.png) |

Prerequisites

- Kubernetes 1.23+
- Helm 3.8.0+
- PV provisioner support in the underlying infrastructure

## Installing the Chart

To install the chart with the release name my-release:

```bash
helm install my-release oci://REGISTRY_NAME/REPOSITORY_NAME/redis-cluster

Note: You need to substitute the placeholders REGISTRY_NAME and REPOSITORY_NAME with a reference to your Helm chart registry and repository. For example, in the case of Bitnami, you need to use REGISTRY_NAME=registry-1.docker.io and REPOSITORY_NAME=bitnamicharts.


helm install my-release oci://registry-1.docker.io/bitnamicharts/redis-cluster

Pulled: registry-1.docker.io/bitnamicharts/redis-cluster:10.0.2
Digest: sha256:191325c28e2f115a00499d7f968f24c87d1b25b9dd1888718e861826e156e414
NAME: my-release
LAST DEPLOYED: Mon Apr 22 14:59:57 2024
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: redis-cluster
CHART VERSION: 10.0.2
APP VERSION: 7.2.4** Please be patient while the chart is being deployed **
```

## To get your password run

```bash
export REDIS_PASSWORD=$(kubectl get secret --namespace "default" my-release-redis-cluster -o jsonpath="{.data.redis-password}" | base64 -d)
D01eMYpbZZ
```

You have deployed a Redis&reg; Cluster accessible only from within you Kubernetes Cluster.INFO: The Job to create the cluster will be created.To connect to your Redis&reg; cluster:

1. Run a Redis pod that you can use as a client:

```bash
kubectl run --namespace default my-release-redis-cluster-client --rm --tty -i --restart='Never' \
 --env REDIS_PASSWORD=$REDIS_PASSWORD \
--image docker.io/bitnami/redis-cluster:7.2.4-debian-12-r12 -- bash
```

2. Connect using the Redis&reg; CLI:

```bash
redis-cli -c -h my-release-redis-cluster -a $REDIS_PASSWORD
```

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:

- redis.resources
- updateJob.resources
+info <https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/>

The command deploys Redis® on the Kubernetes cluster in the default configuration. The **[Parameters](https://github.com/bitnami/charts/blob/main/bitnami/redis-cluster/README.md#parameters)** section lists the parameters that can be configured during installation.

NOTE: if you get a timeout error waiting for the hook to complete increase the default timeout (300s) to a higher one, for example:

helm install --timeout 600s myrelease oci://REGISTRY_NAME/REPOSITORY_NAME/redis-cluster
Note: You need to substitute the placeholders REGISTRY_NAME and REPOSITORY_NAME with a reference to your Helm chart registry and repository. For example, in the case of Bitnami, you need to use REGISTRY_NAME=registry-1.docker.io and REPOSITORY_NAME=bitnamicharts. Tip: List all releases using helm list

## Persistence

By default, the chart mounts a Persistent Volume at the /bitnami path. The volume is created using dynamic volume provisioning.

If persistence is disabled, an emptyDir volume is used. This is only recommended for testing environments because the required information included in the nodes.conf file is missing. This file contains the relationship between the nodes and the cluster. For example, if any node is down or faulty, when it starts again, it is a self-proclaimed master and also acts as an independent node outside the main cluster as it doesn't have the necessary information to connect to it.

To reconnect the failed node, run the following:

See nodes.sh

$ cat /bitnami/redis/data/nodes.sh
declare -A host_2_ip_array=([redis-node-0]="192.168.192.6" [redis-node-1]="192.168.192.2" [redis-node-2]="192.168.192.4" [redis-node-3]="192.168.192.5" [redis-node-4]="192.168.192.3" [redis-node-5]="192.168.192.7" )
Run redis-cli and run CLUSTER MEET to any other node in the cluster. Now the node has connected to the main cluster.

$ REDISCLI_AUTH=bitnami redis-cli
127.0.0.1:6379> cluster meet 192.168.192.7 6379
OK

## summary

could not set values for cluster

```bash
pushd .
cd ~/src/repsys/k8s/redis_bitnami
kubectl config set-context --current --namespace=redis-bitnami
kubectl apply -f redis_cluster.yaml
kubectl exec -it redis-cluster-0 -- redis-cli
kubectl exec -n redis-bitnami -it redis-cluster-0 -- redis-cli 
127.0.0.1:6379> set tony stark
(error) CLUSTERDOWN Hash slot not served
127.0.0.1:6379> 
```

<https://github.com/bitnami/charts/tree/main/bitnami/redis>

## Redis and Helm Installation

To simplify the Redis deployment process, we will be using Helm, a package manager for Kubernetes applications. Install Helm following the official documentation.

Next, add the Bitnami Helm chart repository by executing the following command:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
```

## Update the Helm chart repositories

```bash
helm repo update
```

Now that both Kubernetes and Helm are properly installed and configured, you're ready to deploy Redis onto your Kubernetes cluster.

## Create a new namespace

Important: Each namespace can only contain one Redis Enterprise cluster. Multiple RECs with different operator versions can coexist on the same Kubernetes cluster, as long as they are in separate namespaces.

Throughout this guide, each command is applied to the namespace in which the Redis Enterprise cluster operates.

```bash
kubectl create namespace redis-bitnami
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-bitnami
```

## Scaling Redis in a Kubernetes Cluster

Horizontal Scaling with Redis Cluster

Horizontal scaling is the process of increasing the capacity of your system by adding more nodes to it. When it comes to Redis, this scaling approach can be achieved using Redis Cluster. Redis Cluster provides a distributed implementation that automatically shards data across multiple nodes, ensuring high availability and performance.

To get started with Redis Cluster in Kubernetes, you need to create a StatefulSet configuration file that deploys the desired number of Redis instances. You can use the following example as a starting point:

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
  name: redis-cluster
spec:
  serviceName: redis-cluster
  replicas: 6
  selector:
    matchLabels:
      app: redis-cluster
  template:
    metadata:
      labels:
        app: redis-cluster
    spec:
      containers:
      - name: redis
        image: redis:6.2.5
        command: ["redis-server"]
        args: ["/conf/redis.conf"]
        env:
        - name: REDIS_CLUSTER_ANNOUNCE_IP
          valueFrom:
            fieldRef:
              fieldPath: status.podIP
        ports:
        - containerPort: 6379
          name: client
        - containerPort: 16379
          name: gossip
        volumeMounts:
        - name: conf
          mountPath: /conf
        - name: data
          mountPath: /data
  volumeClaimTemplates:
  - metadata:
      name: data
    spec:
      accessModes: [ "ReadWriteOnce" ]
      resources:
        requests:
          storage: 1Gi
```

## Configuring Master and Slave Nodes

To provide high availability in a Redis Cluster, it's essential to have master and slave nodes. In case a master node fails, a slave node can automatically take over its responsibilities.

To configure the master and slave nodes, you need to create a ConfigMap that contains the Redis configuration file (redis.conf). This file will be mounted in all Redis instances deployed by the StatefulSet. Update your StatefulSet manifest to include the ConfigMap:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: redis-cluster-configmap
data:
  redis.conf: |-
    cluster-enabled yes
    cluster-require-full-coverage no
    cluster-node-timeout 15000
    cluster-config-file /data/nodes.conf
    cluster-migration-barrier 1
    appendonly yes
    protected-mode no
    bind 0.0.0.0
    port 6379
---

# StatefulSet Definition From Earlier Example
```

## deploy redis-cluster

```bash
pushd .
cd ~/src/repsys/k8s/redis_bitnami
kubectl config set-context --current --namespace=redis-bitnami
kubectl apply -f redis_cluster.yaml
kubectl exec -it redis-cluster-0 -- redis-cli
kubectl exec -n redis-bitnami -it redis-cluster-0 -- redis-cli 
127.0.0.1:6379> set tony stark
(error) CLUSTERDOWN Hash slot not served
127.0.0.1:6379> 
```

## Shard Distribution and Fault Tolerance

In a Redis Cluster, data is divided into shards, with each shard being managed by a master node and one or more slave nodes. The default number of shards in a Redis Cluster is 16384. When deploying your cluster, you should ensure an even distribution of these shards across the master nodes for optimal performance and fault tolerance.

After deploying your Redis Cluster on Kubernetes using the provided manifest examples, you can use the following command to check the status of your cluster:

```bash
kubectl exec -it redis-cluster-0 -- redis-cli --cluster check :6379
```

This command will show you the shard distribution, as well as the health of your master and slave nodes. By configuring the Redis Cluster properly and monitoring its performance, you can ensure your application has the scalability it needs to succeed.

## Vertical Scaling

In the context of Redis on Kubernetes, vertical scaling involves augmenting the resources (CPU, RAM) allocated to your Redis pods. Redis is an in-memory data store, meaning that all the data resides in the memory (RAM). As such, the memory allocated to the pod that Redis runs on is particularly significant. Vertical scaling can enhance your Redis instance's capability to handle larger datasets and serve more requests per second.

Understanding Vertical Scaling with Redis
Redis, being a single-threaded application, can't take full advantage of multiple CPU cores for processing commands. However, vertical scaling can still be beneficial to a certain extent, especially when it comes to handling larger datasets. Increasing the RAM for your Redis pod allows Redis to store more data. If your workload is CPU-intensive, boosting the CPU allocation could expedite certain operations, like saving data to disk, even though it won't directly accelerate command execution.

If you're looking for a Redis API compatible solution that supports vertical scaling, have a look at Dragonfly.

Implementing Vertical Scaling
To implement vertical scaling, you would increase the size of the Kubernetes pod that Redis is running in. This is typically accomplished in the pod specification, where you would specify the resource requests and limits for the pod. Here is an example:

apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:

- name: redis
    image: redis:6.2.5
    resources:
      requests:
        cpu: '0.5'
        memory: '1Gi'
      limits:
        cpu: '1'
        memory: '2Gi'
In this example, the Redis pod is initially requesting 0.5 CPU cores and 1Gi of memory, with a limit of 1 CPU core and 2Gi of memory. To vertically scale this, you might increase the requests and limits for both CPU and memory as per your needs.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: redis
spec:
  containers:
  - name: redis
    image: redis:6.2.5
    resources:
      requests:
        cpu: '1'
        memory: '2Gi'
      limits:
        cpu: '2'
        memory: '4Gi'
```
