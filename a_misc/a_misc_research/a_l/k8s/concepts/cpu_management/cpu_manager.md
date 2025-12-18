# **[CPU manager](https://kubernetes.io/blog/2018/07/24/feature-highlight-cpu-manager/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## Feature Highlight: CPU Manager

By Balaji Subramaniam (Intel), Connor Doyle (Intel) | Tuesday, July 24, 2018
This blog post describes the CPU Manager, a beta feature in Kubernetes. The **[CPU manager](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/)** feature enables better placement of workloads in the Kubelet, the Kubernetes node agent, by allocating exclusive CPUs to certain pod containers.

![](https://kubernetes.io/images/blog/2018-07-24-cpu-manager/cpu-manager.png)

## Sounds Good! But Does the CPU Manager Help Me?

It depends on your workload. A single compute node in a Kubernetes cluster can run many pods and some of these pods could be running CPU-intensive workloads. In such a scenario, the pods might contend for the CPU resources available in that compute node. When this contention intensifies, the workload can move to different CPUs depending on whether the pod is throttled and the availability of CPUs at scheduling time. There might also be cases where the workload could be sensitive to context switches. In all the above scenarios, the performance of the workload might be affected.

If your workload is sensitive to such scenarios, then CPU Manager can be enabled to provide better performance isolation by allocating exclusive CPUs for your workload.

CPU manager might help workloads with the following characteristics:

- Sensitive to CPU throttling effects.
- Sensitive to **[context switches](../../../linux/concepts/context_switches.md)**.
- Sensitive to **[processor cache misses](../../../linux/concepts/processor_cache_misses.md)**.
- Benefits from sharing a processor resources (e.g., data and instruction caches).
- Sensitive to **[cross-socket](../../../linux/concepts/cross_socket_memory.md)** memory traffic.
- Sensitive or requires **[hyperthreads](../../../linux/concepts/hyper_threading.md)** from the same physical CPU core.

## Ok! How Do I use it?

Using the CPU manager is simple. First, **[enable CPU manager with the Static policy](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/#cpu-management-policies)** in the Kubelet running on the compute nodes of your cluster. Then configure your pod to be in the **[Guaranteed Quality of Service (QoS)](https://kubernetes.io/docs/tasks/configure-pod-container/quality-service-pod/#create-a-pod-that-gets-assigned-a-qos-class-of-guaranteed)** class. Request whole numbers of CPU cores (e.g., 1000m, 4000m) for containers that need exclusive cores. Create your pod in the same way as before (e.g., kubectl create -f pod.yaml). And voilà, the CPU manager will assign exclusive CPUs to each of container in the pod according to their CPU requests.

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: exclusive-2
spec:
  containers:
  - image: quay.io/connordoyle/cpuset-visualizer
    name: exclusive-2
    resources:
      # Pod is in the Guaranteed QoS class because requests == limits
      requests:
        # CPU request is an integer
        cpu: 2
        memory: "256M"
      limits:
        cpu: 2
        memory: "256M"
```

Pod specification requesting two exclusive CPUs.
