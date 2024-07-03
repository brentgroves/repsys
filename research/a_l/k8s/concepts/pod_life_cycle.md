# **[pod life cycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Pod Lifecycle

This page describes the lifecycle of a Pod. Pods follow a defined lifecycle, starting in the Pending phase, moving through Running if at least one of its primary containers starts OK, and then through either the Succeeded or Failed phases depending on whether any container in the Pod terminated in failure.

Whilst a Pod is running, the kubelet is able to restart containers to handle some kind of faults. Within a Pod, Kubernetes tracks different container states and determines what action to take to make the Pod healthy again.

In the Kubernetes API, Pods have both a specification and an actual status. The status for a Pod object consists of a set of **[Pod conditions](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-conditions)**. You can also inject custom readiness information into the condition data for a Pod, if that is useful to your application.

## Pod conditions

A Pod has a PodStatus, which has an array of PodConditions through which the Pod has or has not passed. Kubelet manages the following PodConditions:

- **PodScheduled:** the Pod has been scheduled to a node.
- **PodReadyToStartContainers:** (beta feature; enabled by default) the Pod sandbox has been successfully created and networking configured.
- **ContainersReady:** all containers in the Pod are ready.
- **Initialized:** all **[init containers](https://kubernetes.io/docs/concepts/workloads/pods/init-containers/)** have completed successfully.
- **Ready:** the Pod is able to serve requests and should be added to the load balancing pools of all matching Services.

### Pod readiness

FEATURE STATE: Kubernetes v1.14 [stable]
Your application can inject extra feedback or signals into PodStatus: Pod readiness. To use this, set readinessGates in the Pod's spec to specify a list of additional conditions that the kubelet evaluates for Pod readiness.

Readiness gates are determined by the current state of status.condition fields for the Pod. If Kubernetes cannot find such a condition in the status.conditions field of a Pod, the status of the condition is defaulted to "False".

Here is an example:

```yaml
kind: Pod
...
spec:
  readinessGates:
    - conditionType: "www.example.com/feature-1"
status:
  conditions:
    - type: Ready                              # a built in PodCondition
      status: "False"
      lastProbeTime: null
      lastTransitionTime: 2018-01-01T00:00:00Z
    - type: "www.example.com/feature-1"        # an extra PodCondition
      status: "False"
      lastProbeTime: null
      lastTransitionTime: 2018-01-01T00:00:00Z
  containerStatuses:
    - containerID: docker://abcd...
      ready: true
...
```

The Pod conditions you add must have names that meet the Kubernetes label key format.

### Status for Pod readiness

The kubectl patch command does not support patching object status. To set these status.conditions for the Pod, applications and operators should use the PATCH action. You can use a Kubernetes client library to write code that sets custom Pod conditions for Pod readiness.

For a Pod that uses custom conditions, that Pod is evaluated to be ready only when both the following statements apply:

- All containers in the Pod are ready.
- All conditions specified in readinessGates are True.

When a Pod's containers are Ready but at least one custom condition is missing or False, the kubelet sets the Pod's condition to ContainersReady.

### Pod network readiness

During its early development, this condition was named PodHasNetwork.

After a Pod gets scheduled on a node, it needs to be admitted by the kubelet and to have any required storage volumes mounted. Once these phases are complete, the kubelet works with a container runtime (using Container runtime interface (CRI)) to set up a runtime sandbox and configure networking for the Pod. If the PodReadyToStartContainersCondition **[feature gate](https://kubernetes.io/docs/reference/command-line-tools-reference/feature-gates/)** is enabled (it is enabled by default for Kubernetes 1.30), the PodReadyToStartContainers condition will be added to the status.conditions field of a Pod.

The PodReadyToStartContainers condition is set to False by the Kubelet when it detects a Pod does not have a runtime sandbox with networking configured. This occurs in the following scenarios:

- Early in the lifecycle of the Pod, when the kubelet has not yet begun to set up a sandbox for the Pod using the container runtime.
- Later in the lifecycle of the Pod, when the Pod sandbox has been destroyed due to either:
  - the node rebooting, without the Pod getting evicted
  - for container runtimes that use virtual machines for isolation, the Pod sandbox virtual machine rebooting, which then requires creating a new sandbox and fresh container network configuration.

The PodReadyToStartContainers condition is set to True by the kubelet after the successful completion of sandbox creation and network configuration for the Pod by the runtime plugin. The kubelet can start pulling container images and create containers after PodReadyToStartContainers condition has been set to True.

For a Pod with init containers, the kubelet sets the Initialized condition to True after the init containers have successfully completed (which happens after successful sandbox creation and network configuration by the runtime plugin). For a Pod without init containers, the kubelet sets the Initialized condition to True before sandbox creation and network configuration starts.

Pod scheduling readiness
FEATURE STATE: Kubernetes v1.26 [alpha]
See **[Pod Scheduling Readiness](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-scheduling-readiness/)** for more information.

## Container probes

A probe is a diagnostic performed periodically by the kubelet on a container. To perform a diagnostic, the kubelet either executes code within the container, or makes a network request.

## Check mechanisms

There are four different ways to check a container using a probe. Each probe must define exactly one of these four mechanisms:

**exec**\
Executes a specified command inside the container. The diagnostic is considered successful if the command exits with a status code of 0.

**grpc**\
Performs a remote procedure call using gRPC. The target should implement gRPC health checks. The diagnostic is considered successful if the status of the response is SERVING.

## references

The **[ETag](https://en.wikipedia.org/wiki/HTTP_ETag)** or entity tag is part of HTTP, the protocol for the World Wide Web. It is one of several mechanisms that HTTP provides for **Web cache validation**, which allows a client to make conditional requests. This mechanism allows caches to be more efficient and saves bandwidth, as a Web server does not need to send a full response if the content has not changed. ETags can also be used for optimistic concurrency control[1] to help prevent simultaneous updates of a resource from overwriting each other.

An ETag is an opaque identifier assigned by a Web server to a specific version of a resource found at a URL.[2] If the resource representation at that URL ever changes, a new and different ETag is assigned. Used in this manner, ETags are similar to fingerprints and can quickly be compared to determine whether two representations of a resource are the same.

The use of ETags in the HTTP header is optional (not mandatory as with some other fields of the HTTP 1.1 header). The method by which ETags are generated has never been specified in the HTTP specification.

Common methods of ETag generation include using a collision-resistant hash function of the resource's content, a hash of the last modification timestamp, or even just a revision number.

In order to avoid the use of stale cache data, methods used to generate ETags should guarantee (as much as is practical) that each ETag is unique. However, an ETag-generation function could be judged to be "usable", if it can be proven (mathematically) that duplication of ETags would be "acceptably rare", even if it could or would occur.

## **[protobuf encoding](https://medium.com/@yashschandra/an-inner-view-to-protobuf-encoding-e668f37847d5)**

In this article we will see how protocol buffers encodes data to make it more compact (hence smaller) to transmit. This article does not focus on how to use protocol buffers but instead explores what it does under the hood. Code pieces demonstrated here are in python v3 but similar things will be happening in other languages also.

Here we explore encoding of 6 types -int, string, float, double, dict, array. Having understanding of these 6 types should be sufficient to get a fair idea of working protobuf.

### **[Protocol Buffers](./protocol_buffers.md)**

**[Protocol buffers](https://en.wikipedia.org/wiki/Protocol_Buffers)** are Google’s language-neutral, platform-neutral, extensible mechanism for serializing structured data. Just like xml but smaller in size. It is useful in developing programs to communicate with each other over a wire or for storing data.

## Unaggregated discovery

Without discovery aggregation, discovery is published in levels, with the root endpoints publishing discovery information for downstream documents.

A list of all group versions supported by a cluster is published at the /api and /apis endpoints. Example:

```yaml
{
  "kind": "APIGroupList",
  "apiVersion": "v1",
  "groups": [
    {
      "name": "apiregistration.k8s.io",
      "versions": [
        {
          "groupVersion": "apiregistration.k8s.io/v1",
          "version": "v1"
        }
      ],
      "preferredVersion": {
        "groupVersion": "apiregistration.k8s.io/v1",
        "version": "v1"
      }
    },
    {
      "name": "apps",
      "versions": [
        {
          "groupVersion": "apps/v1",
          "version": "v1"
        }
      ],
      "preferredVersion": {
        "groupVersion": "apps/v1",
        "version": "v1"
      }
    },
    ...
}
```

Additional requests are needed to obtain the discovery document for each group version at /apis/<group>/<version> (for example: /apis/rbac.authorization.k8s.io/v1alpha1), which advertises the list of resources served under a particular group version. These endpoints are used by kubectl to fetch the list of resources supported by a cluster.

## OpenAPI interface definition

For details about the OpenAPI specifications, see the OpenAPI documentation.

Kubernetes serves both OpenAPI v2.0 and OpenAPI v3.0. OpenAPI v3 is the preferred method of accessing the OpenAPI because it offers a more comprehensive (lossless) representation of Kubernetes resources. Due to limitations of OpenAPI version 2, certain fields are dropped from the published OpenAPI including but not limited to default, nullable, oneOf.
