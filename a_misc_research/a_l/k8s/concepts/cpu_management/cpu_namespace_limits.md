# **[Configure Default CPU Requests and Limits for a Namespace](https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

This page shows how to configure default CPU requests and limits for a namespace.

A Kubernetes cluster can be divided into namespaces. If you create a Pod within a namespace that has a default CPU **[limit](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits)**, and any container in that Pod does not specify its own CPU limit, then the **[control plane](https://kubernetes.io/docs/reference/glossary/?all=true#term-control-plane)** assigns the default CPU limit to that container.

Kubernetes assigns a default CPU **[request](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#requests-and-limits)**, but only under certain conditions that are explained later in this page.

## Before you begin

You need to have a Kubernetes cluster, and the kubectl command-line tool must be configured to communicate with your cluster. It is recommended to run this tutorial on a cluster with at least two nodes that are not acting as control plane hosts. If you do not already have a cluster, you can create one by using minikube or you can use one of these Kubernetes playgrounds:

Killercoda
Play with Kubernetes
You must have access to create namespaces in your cluster.

Each node in your cluster must have at least 2 GiB of memory.

If you're not already familiar with what Kubernetes means by 1.0 CPU, read meaning of **[CPU](https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/#meaning-of-cpu)**.

## Create a namespace

Create a namespace so that the resources you create in this exercise are isolated from the rest of your cluster.

```bash
kubectl create namespace default-mem-example
```

## Create a LimitRange and a Pod

Here's a manifest for an example LimitRange. The manifest specifies a default memory request and a default memory limit.

```yaml
apiVersion: v1
kind: LimitRange
metadata:
  name: mem-limit-range
spec:
  limits:
  - default:
      memory: 512Mi
    defaultRequest:
      memory: 256Mi
    type: Container
```

Create the LimitRange in the default-mem-example namespace:

```bash
kubectl apply -f https://k8s.io/examples/admin/resource/memory-defaults.yaml --namespace=default-mem-example
```

Now if you create a Pod in the default-mem-example namespace, and any container within that Pod does not specify its own values for memory request and memory limit, then the control plane applies default values: a memory request of 256MiB and a memory limit of 512MiB.

Here's an example manifest for a Pod that has one container. The container does not specify a memory request and limit.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo
spec:
  containers:
  - name: default-mem-demo-ctr
    image: nginx
```

Create the Pod.

```bash
kubectl apply -f https://k8s.io/examples/admin/resource/memory-defaults-pod.yaml --namespace=default-mem-example
```

View detailed information about the Pod:

```bash
kubectl get pod default-mem-demo --output=yaml --namespace=default-mem-example
```

The output shows that the Pod's container has a memory request of 256 MiB and a memory limit of 512 MiB. These are the default values specified by the LimitRange.

```bash
containers:
- image: nginx
  imagePullPolicy: Always
  name: default-mem-demo-ctr
  resources:
    limits:
      memory: 512Mi
    requests:
      memory: 256Mi
```

Delete your Pod:

```bash
kubectl delete pod default-mem-demo --namespace=default-mem-example
```

What if you specify a container's limit, but not its request?
Here's a manifest for a Pod that has one container. The container specifies a memory limit, but not a request:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo-2
spec:
  containers:
  - name: default-mem-demo-2-ctr
    image: nginx
    resources:
      limits:
        memory: "1Gi"
```

Create the Pod:

```bash
kubectl apply -f https://k8s.io/examples/admin/resource/memory-defaults-pod-2.yaml --namespace=default-mem-example
```

View detailed information about the Pod:

```bash
kubectl get pod default-mem-demo-2 --output=yaml --namespace=default-mem-example
```

The output shows that the container's memory request is set to match its memory limit. Notice that the container was not assigned the default memory request value of 256Mi.

```bash
...
resources:
  limits:
    memory: 1Gi
  requests:
    memory: 1Gi
...
```

What if you specify a container's request, but not its limit?

Here's a manifest for a Pod that has one container. The container specifies a memory request, but not a limit:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: default-mem-demo-3
spec:
  containers:
  - name: default-mem-demo-3-ctr
    image: nginx
    resources:
      requests:
        memory: "128Mi"
```

Create the Pod:

```bash
kubectl apply -f https://k8s.io/examples/admin/resource/memory-defaults-pod-3.yaml --namespace=default-mem-example
```

View the Pod's specification:

```bash
kubectl get pod default-mem-demo-3 --output=yaml --namespace=default-mem-example
```

The output shows that the container's memory request is set to the value specified in the container's manifest. The container is limited to use no more than 512MiB of memory, which matches the default memory limit for the namespace.

```bash
...
resources:
  limits:
    memory: 512Mi
  requests:
    memory: 128Mi
```

**Note:**\
A LimitRange does not check the consistency of the default values it applies. This means that a default value for the limit that is set by LimitRange may be less than the request value specified for the container in the spec that a client submits to the API server. If that happens, the final **Pod will not be scheduleable.** See Constraints on resource limits and requests for more details.

## Motivation for default memory limits and requests

If your namespace has a memory resource quota configured, it is helpful to have a default value in place for memory limit. Here are three of the restrictions that a resource quota imposes on a namespace:

- For every Pod that runs in the namespace, the Pod and each of its containers must have a memory limit. (If you specify a memory limit for every container in a Pod, Kubernetes can infer the Pod-level memory limit by adding up the limits for its containers).
- Memory limits apply a resource reservation on the node where the Pod in question is scheduled. The total amount of memory reserved for all Pods in the namespace must not exceed a specified limit.
- The total amount of memory actually used by all Pods in the namespace must also not exceed a specified limit.

When you add a LimitRange:

If any Pod in that namespace that includes a container does not specify its own memory limit, the control plane applies the default memory limit to that container, and the Pod can be allowed to run in a namespace that is restricted by a memory ResourceQuota.

## Clean up

Delete your namespace:

```bash
kubectl delete namespace default-mem-example
```

Here is a rabbitmq deployment that I needed to lower the CPU limit.

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

View detailed information about the Pod:

```bash
kubectl get pod rabbitmqcluster-sample-server-0 --output=yaml 
...
    resources:
      limits:
        cpu: 100m
        memory: 2Gi
      requests:
        cpu: 100m
        memory: 2Gi
...
```
