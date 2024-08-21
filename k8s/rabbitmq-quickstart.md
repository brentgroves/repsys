# **[RabbitMQ Cluster Kubernetes Operator Quickstart](https://www.rabbitmq.com/kubernetes/operator/quickstart-operator)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[github](https://github.com/rabbitmq/cluster-operator)**
- **[Install](https://www.rabbitmq.com/kubernetes/operator/install-operator)**
- **[Using Kubernetes RabbitMQ Cluster Kubernetes Operator](https://www.rabbitmq.com/kubernetes/operator/using-operator)**
- **[examples](https://github.com/rabbitmq/cluster-operator/blob/main/docs/examples)**

## Delete a RabbitMQ Instance

To delete a RabbitMQ service instance, run
kubectl delete rabbitmqcluster INSTANCE

where INSTANCE is the name of your RabbitmqCluster, or use

```bash
kubectl delete rabbitmqcluster INSTANCE
# or
kubectl delete -f INSTANCE.yaml
# ie
kubectl delete -f cluster-operator.yml

```

This is the fastest way to get up and running with a RabbitMQ cluster deployed by the Cluster Operator. More detailed resources are available for installation, usage and API reference.

## Prerequisites

Access to a Kubernetes cluster version 1.19 or above
kubectl configured to access the cluster

## Quickstart Steps

This guide goes through the following steps:

- Install the RabbitMQ Cluster Operator
- Deploy a RabbitMQ Cluster using the Operator
- View RabbitMQ Logs
- Access the RabbitMQ Management UI
- Attach a Workload to the Cluster
- Next Steps

## The kubectl rabbitmq Plugin

Many steps in the quickstart - installing the operator, accessing the Management UI, fetching credentials for the RabbitMQ Cluster, are made easier by the kubectl rabbitmq plugin. While there are instructions to follow along without using the plugin, getting the plugin will make these commands simpler. To install the plugin, look at its **[installation instructions](https://www.rabbitmq.com/kubernetes/operator/install-operator)**.

For extensive documentation on the plugin see the **[kubectl Plugin guide](https://www.rabbitmq.com/kubernetes/operator/kubectl-plugin)**.

## Install the RabbitMQ Cluster Operator

Let's start by installing the latest version of the Cluster Operator. This can be done directly using kubectl apply:

```bash
pushd
cd ~//src/repsys/k8s/rabbitmq
kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
# or you can download it first
curl -L -O https://github.com/rabbitmq/cluster-operator/releases/download/v2.9.0/cluster-operator.yml
kubectl apply -f cluster-operator.yml
# namespace/rabbitmq-system created
# customresourcedefinition.apiextensions.k8s.io/rabbitmqclusters.rabbitmq.com created
# serviceaccount/rabbitmq-cluster-operator created
# role.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-role created
# clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-operator-role created
# rolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-rolebinding created
# clusterrolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-operator-rolebinding created
# deployment.apps/rabbitmq-cluster-operator created
```

The Cluster Operator can also be installed using the kubectl rabbitmq plugin:

```bash
kubectl rabbitmq install-cluster-operator
```

Installing the Cluster Operator creates a bunch of Kubernetes resources. Breaking these down, we have:

a new namespace rabbitmq-system. The Cluster Operator deployment is created in this namespace.

```bash
kubectl get all -n rabbitmq-system
NAME                                             READY   STATUS    RESTARTS   AGE
pod/rabbitmq-cluster-operator-6dcf5746f4-gzl94   1/1     Running   0          71m

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/rabbitmq-cluster-operator   1/1     1            1           71m

NAME                                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/rabbitmq-cluster-operator-6dcf5746f4   1         1         1       71m
```

- a new custom resource rabbitmqclusters.rabbitmq.com. The custom resource allows us to define an API for the creation of RabbitMQ Clusters.

```bash
kubectl get customresourcedefinitions.apiextensions.k8s.io

NAME                                             CREATED AT
...
rabbitmqclusters.rabbitmq.com                    2021-01-14T11:12:26Z
...
```

and some rbac roles. These are required by the Operator to create, update and delete RabbitMQ Clusters.

```yaml
apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
 name: hello-world
```

Submit this using the following command:

```bash
pushd .
cd ~/src/repsys/k8s/rabbitmq
kubectl apply -f helloworld.yaml
# or
# kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/docs/examples/hello-world/rabbitmq.yaml

kubectl edit pv persistence-rabbitmqcluster-sample-server-0
kubectl edit pvc persistence-rabbitmqcluster-sample-server-0
  volumeName: "persistence-rabbitmqcluster-sample-server-0"
```

## **[Local Path Provisioner](https://github.com/rancher/local-path-provisioner)**

Dynamic provisioning the volume using hostPath or local.

- Currently the Kubernetes Local Volume provisioner cannot do dynamic provisioning for the local volumes. **I believe MicroK8s can do

- Local based persistent volumes are an experimental feature (example usage).

If your Pod is stuck in the Pending state, most probably your cluster does not have a Physical Volume Provisioner. This can be verified as the following:

```bash
kubectl get pvc,pod
NAME                               STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistence-hello-world-server-0   Pending                                                     30s
```

In this case, and if this is not a production environment, you might want to install the Local Path Provisioner

Note: On microk8s we don't normally use this local path provisioner but enable hostpath-storage which I believe can do dynamic provisioning. My guess is that the rabbitmq operator does not try but it does create the pvc with the hostpath-storage as a name.

status:
  conditions:

- lastProbeTime: null
    lastTransitionTime: "2024-08-21T21:45:46Z"
    message: '0/1 nodes are available: 1 Insufficient cpu. preemption: 0/1 nodes are
      available: 1 No preemption victims found for incoming pod.'
    reason: Unschedulable
    status: "False"
    type: PodScheduled
  phase: Pending
  qosClass: Burstable

```bash
kubectl apply -f heeloworld-res.yaml
kubectl get rabbitmqclusters.rabbitmq.com
NAME                     ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster-sample   True               True               12m
kubectl logs rabbitmqcluster-sample-server-0
024-08-21 22:05:01.193675+00:00 [info] <0.675.0> Server startup complete; 8 plugins started.
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_prometheus
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_federation
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_peer_discovery_k8s
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_peer_discovery_common
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_management
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_management_agent
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_web_dispatch
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * oauth2_client
2024-08-21 22:05:01.285804+00:00 [info] <0.9.0> Time to start RabbitMQ: 190694 ms

kubectl rabbitmq tail rabbitmqcluster-sample
```

After that, you need to remove and re-create the previously created RabbitMQ Cluster object:

```bash
kubectl delete rabbitmqclusters.rabbitmq.com hello-world
kubectl delete rabbitmqclusters.rabbitmq.com rabbitmqcluster-sample
https://stackoverflow.com/questions/38869673/pod-in-pending-state-due-to-insufficient-cpu
kubectl describe node
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                550m (55%)  200m (20%)
  memory             570Mi (3%)  670Mi (4%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
```
