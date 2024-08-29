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
kubectl get rabbitmqclusters.rabbitmq.com
NAME                     ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster-sample   True               True               7d22h

kubectl delete rabbitmqcluster rabbitmqcluster-sample
kubectl delete rabbitmqcluster INSTANCE

# or
kubectl delete -f INSTANCE.yaml
# ie
kubectl delete -f cluster-operator.yml

```

This is the fastest way to get up and running with a RabbitMQ cluster deployed by the Cluster Operator. More detailed resources are available for installation, usage and API reference.

## Note

CPU limits need to be set before I could get this to work. But I only had a 1 node, 2 cpu cluster, with outer pods running so I will try again.

## Prerequisites

Access to a Kubernetes cluster version 1.19 or above
kubectl configured to access the cluster

## **[Resource Limit Note](https://stackoverflow.com/questions/38869673/pod-in-pending-state-due-to-insufficient-cpu)**

RabbitMQ has default resource requirements but microk8s has limits less than these requirements.

Some reading material:

<https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/#specify-a-cpu-request-and-a-cpu-limit>

<https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/#create-a-limitrange-and-a-pod>

<https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#how-pods-with-resource-limits-are-run>

<https://cloud.google.com/blog/products/gcp/kubernetes-best-practices-resource-requests-and-limits>

I recently had this same issue. After some research, I found that GKE has a default LimitRange with CPU requests limit set to 100m.

You can validate this by running ```kubectl get limitrange -o=yaml```. It's going to display something like this:

```yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: LimitRange
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"LimitRange","metadata":{"annotations":{},"name":"limits","namespace":"default"},"spec":{"limits":[{"defaultRequest":{"cpu":"100m"},"type":"Container"}]}}
    creationTimestamp: 2017-11-16T12:15:40Z
    name: limits
    namespace: default
    resourceVersion: "18741722"
    selfLink: /api/v1/namespaces/default/limitranges/limits
    uid: dcb25a24-cac7-11e7-a3d5-42010a8001b6
  spec:
    limits:
    - defaultRequest:
        cpu: 100m
      type: Container
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
```

**[Yes](https://www.reddit.com/r/kubernetes/comments/191n7ci/cpu_use_higher_than_requests/)**, when you say request, you're defining what is the minimum CPU that the app will need in order to function, so you're requesting a minimum allocation that cannot be violated (your app is guaranteed requests CPU); not setting a hard limit. If your app makes use of more than that, and there is spare CPU left over after all pods are calculated, then your app is allowed to use that but if another app spins up and takes some away then your app will lose access to the excess capacity.

This is a bit of an over simplification, I admit. But should help you to understand better. I highly recommend the robusta.dev article entitled "For the Love of God, Stop Using CPU Limits on Kubernetes (Updated)", which was

```bash
kubectl describe node
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests      Limits
  --------           --------      ------
  cpu                650m (65%)    300m (30%)
  memory             2618Mi (16%)  2718Mi (17%)
  ephemeral-storage  0 (0%)        0 (0%)
  hugepages-1Gi      0 (0%)        0 (0%)
  hugepages-2Mi      0 (0%)        0 (0%)
Non-terminated Pods:          (8 in total)
  Namespace                   Name                                          CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                          ------------  ----------  ---------------  -------------  ---
  default                     mysql-0                                       0 (0%)        0 (0%)      0 (0%)           0 (0%)         42d
  default                     rabbitmqcluster-sample-server-0               100m (10%)    100m (10%)  2Gi (12%)        2Gi (12%)      7d
  default                     test-nginx                                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         7d23h
  kube-system                 calico-kube-controllers-796fb75cc-5pzgd       0 (0%)        0 (0%)      0 (0%)           0 (0%)         48d
  kube-system                 calico-node-s8bsn                             250m (25%)    0 (0%)      0 (0%)           0 (0%)         23h
  kube-system                 coredns-5986966c54-whdsr                      100m (10%)    0 (0%)      70Mi (0%)        170Mi (1%)     48d
  kube-system                 hostpath-provisioner-7c8bdf94b8-nhqc5         0 (0%)        0 (0%)      0 (0%)           0 (0%)         8d
  rabbitmq-system             rabbitmq-cluster-operator-6dcf5746f4-gzl94    200m (20%)    200m (20%)  500Mi (3%)       500Mi (3%)     7d3h


```

```yaml
apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
  name: rabbitmqcluster-sample
spec:
  resources:
    requests:
      cpu: 100m
      memory: 2Gi
    limits:
      cpu: 100m
      memory: 2Gi
```

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
cd ~/src/repsys/k8s/rabbitmq
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
  name: rabbitmqcluster-sample
spec:
  resources:
    requests:
      cpu: 100m
      memory: 2Gi
    limits:
      cpu: 100m
      memory: 2Gi
```

Submit this using the following command:

```bash
pushd .
cd ~/src/repsys/k8s/rabbitmq
kubectl apply -f helloworld-res.yaml
# or
# kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/docs/examples/hello-world/rabbitmq.yaml

```

## resource limit issue

if you don't specify resource limits this is the error you get.

In this case, and if this is not a production environment, you might want to install the Local Path Provisioner

Note: On microk8s we don't normally use this local path provisioner but enable hostpath-storage which I believe can do dynamic provisioning. My guess is that the rabbitmq operator does not try but it does create the pvc with the hostpath-storage as a name.

```bash
kubectl logs rabbitmqcluster-sample-server-0
# or 
kubectl edit pvc persistence-rabbitmqcluster-sample-server-0

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
```

## deploy rabbitmq instance

```bash
kubectl apply -f heloworld-res.yaml
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
