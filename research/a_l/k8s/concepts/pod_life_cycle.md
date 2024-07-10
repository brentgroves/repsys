# **[pod life cycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Pod Lifecycle

This page describes the lifecycle of a Pod. Pods follow a defined lifecycle, starting in the Pending phase, moving through Running if at least one of its primary containers starts OK, and then through either the Succeeded or Failed phases depending on whether any container in the Pod terminated in failure.

Like individual application containers, Pods are considered to be relatively ephemeral (rather than durable) entities. Pods are created, assigned a unique ID (UID), and scheduled to run on nodes where they remain until termination (according to restart policy) or deletion. If a Node dies, the Pods running on (or scheduled to run on) that node are marked for deletion. The control plane marks the Pods for removal after a timeout period.

## Pod lifetime

Whilst a Pod is running, the kubelet is able to restart containers to handle some kind of faults. Within a Pod, Kubernetes tracks different container **[states](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-states)** and determines what action to take to make the Pod healthy again.

In the Kubernetes API, Pods have both a specification and an actual status. The status for a Pod object consists of a set of **[Pod conditions](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-conditions)**. You can also inject custom readiness information into the condition data for a Pod, if that is useful to your application.

Pods are only scheduled once in their lifetime; assigning a Pod to a specific node is called **binding**, and the process of selecting which node to use is called **scheduling**. Once a Pod has been scheduled and is bound to a node, Kubernetes tries to run that Pod on the node. The Pod runs on that node until it stops, or until the Pod is terminated; if Kubernetes isn't able start the Pod on the selected node (for example, if the node crashes before the Pod starts), then that particular Pod never starts.

You can use **[Pod Scheduling Readiness](https://kubernetes.io/docs/concepts/scheduling-eviction/pod-scheduling-readiness/)** to delay scheduling for a Pod until all its scheduling gates are removed. For example, you might want to define a set of Pods but only trigger scheduling once all the Pods have been created.

## Pods and fault recovery

If one of the containers in the Pod fails, then Kubernetes may try to restart that specific container. Read **[How Pods handle problems with containers](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#container-restarts)** to learn more.

Pods can however fail in a way that the cluster cannot recover from, and in that case Kubernetes does not attempt to heal the Pod further; instead, Kubernetes deletes the Pod and relies on other components to provide automatic healing.

If a Pod is scheduled to a node and that node then fails, the Pod is treated as unhealthy and Kubernetes eventually deletes the Pod. A Pod won't survive an eviction due to a lack of resources or Node maintenance.

Kubernetes uses a higher-level abstraction, called a controller, that handles the work of managing the relatively disposable Pod instances.

A given Pod (as defined by a UID) is never "rescheduled" to a different node; instead, that Pod can be replaced by a new, near-identical Pod. If you make a replacement Pod, it can even have same name (as in .metadata.name) that the old Pod had, but the replacement would have a different .metadata.uid from the old Pod.

Kubernetes does not guarantee that a replacement for an existing Pod would be scheduled to the same node as the old Pod that was being replaced.

## Associated lifetimes

When something is said to have the same lifetime as a Pod, such as a volume, that means that the thing exists as long as that specific Pod (with that exact UID) exists. If that Pod is deleted for any reason, and even if an identical replacement is created, the related thing (a volume, in this example) is also destroyed and created anew.

![](https://kubernetes.io/images/docs/pod.svg)

Figure 1.
A multi-container Pod that contains a file puller sidecar and a web server. The Pod uses an **[ephemeral emptyDir](https://kubernetes.io/docs/concepts/storage/volumes/#emptydir)** volume for shared storage between the containers.

## emptyDir

For a Pod that defines an emptyDir volume, the volume is created when the Pod is assigned to a node. As the name says, the emptyDir volume is initially empty. All containers in the Pod can read and write the same files in the emptyDir volume, though that volume can be mounted at the same or different paths in each container. When a Pod is removed from a node for any reason, the data in the emptyDir is deleted permanently.

## Pod phase

A Pod's status field is a PodStatus object, which has a phase field.

The phase of a Pod is a simple, high-level summary of where the Pod is in its lifecycle. The phase is not intended to be a comprehensive rollup of observations of container or Pod state, nor is it intended to be a comprehensive state machine.

The number and meanings of Pod phase values are tightly guarded. Other than what is documented here, nothing should be assumed about Pods that have a given phase value.

Here are the possible values for phase:

| Value     | Description                                                                                                                                                                                                                                                        |
|-----------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Pending   | The Pod has been accepted by the Kubernetes cluster, but one or more of the containers has not been set up and made ready to run. This includes time a Pod spends waiting to be scheduled as well as the time spent downloading container images over the network. |
| Running   | The Pod has been bound to a node, and all of the containers have been created. At least one container is still running, or is in the process of starting or restarting.                                                                                            |
| Succeeded | All containers in the Pod have terminated in success, and will not be restarted.                                                                                                                                                                                   |
| Failed    | All containers in the Pod have terminated, and at least one container has terminated in failure. That is, the container either exited with non-zero status or was terminated by the system, and is not set for automatic restarting.                               |
| Unknown   | For some reason the state of the Pod could not be obtained. This phase typically occurs due to an error in communicating with the node where the Pod should be running.                                                                                            |

**Note:**\
When a Pod is being deleted, it is shown as Terminating by some kubectl commands. This Terminating status is not one of the Pod phases. A Pod is granted a term to terminate gracefully, which defaults to 30 seconds. You can use the flag --force to terminate a Pod by force.

Since Kubernetes 1.27, the kubelet transitions deleted Pods, except for static Pods and force-deleted Pods without a finalizer, to a terminal phase (Failed or Succeeded depending on the exit statuses of the pod containers) before their deletion from the API server.

If a node dies or is disconnected from the rest of the cluster, Kubernetes applies a policy for setting the phase of all Pods on the lost node to Failed.

## Container states

As well as the **[phase](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/#pod-phase)** of the Pod overall, Kubernetes tracks the state of each container inside a Pod. You can use container lifecycle hooks to trigger events to run at certain points in a container's lifecycle.

Once the scheduler assigns a Pod to a Node, the kubelet starts creating containers for that Pod using a container runtime. There are three possible container states: Waiting, Running, and Terminated.

To check the state of a Pod's containers, you can use kubectl describe pod <name-of-pod>. The output shows the state for each container within that Pod.

Each state has a specific meaning:

**Waiting**\
If a container is not in either the Running or Terminated state, it is Waiting. A container in the Waiting state is still running the operations it requires in order to complete start up: for example, pulling the container image from a container image registry, or applying Secret data. When you use kubectl to query a Pod with a container that is Waiting, you also see a Reason field to summarize why the container is in that state.

**Running**\
The Running status indicates that a container is executing without issues. If there was a postStart hook configured, it has already executed and finished. When you use kubectl to query a Pod with a container that is Running, you also see information about when the container entered the Running state.

**Terminated**\
A container in the Terminated state began execution and then either ran to completion or failed for some reason. When you use kubectl to query a Pod with a container that is Terminated, you see a reason, an exit code, and the start and finish time for that container's period of execution.

If a container has a preStop hook configured, this hook runs before the container enters the Terminated state.

## How Pods handle problems with containers

Kubernetes manages container failures within Pods using a restartPolicy defined in the Pod spec. This policy determines how Kubernetes reacts to containers exiting due to errors or other reasons, which falls in the following sequence:

**Initial crash:** Kubernetes attempts an immediate restart based on the Pod restartPolicy.
**Repeated crashes:** After the initial crash Kubernetes applies an exponential backoff delay for subsequent restarts, described in restartPolicy. This prevents rapid, repeated restart attempts from overloading the system.
**CrashLoopBackOff state:** This indicates that the backoff delay mechanism is currently in effect for a given container that is in a crash loop, failing and restarting repeatedly.
**Backoff reset:** If a container runs successfully for a certain duration (e.g., 10 minutes), Kubernetes resets the backoff delay, treating any new crash as the first one.

In practice, a CrashLoopBackOff is a condition or event that might be seen as output from the kubectl command, while describing or listing Pods, when a container in the Pod fails to start properly and then continually tries and fails in a loop.

In other words, when a container enters the crash loop, Kubernetes applies the exponential backoff delay mentioned in the Container restart policy. This mechanism prevents a faulty container from overwhelming the system with continuous failed start attempts.

The CrashLoopBackOff can be caused by issues like the following:

- Application errors that cause the container to exit.
- Configuration errors, such as incorrect environment variables or missing configuration files.
- Resource constraints, where the container might not have enough memory or CPU to start properly.
- Health checks failing if the application doesn't start serving within the expected time.
- Container liveness probes or startup probes returning a Failure result as mentioned in the probes section.

To investigate the root cause of a CrashLoopBackOff issue, a user can:

- **Check logs:** Use kubectl logs <name-of-pod> to check the logs of the container. This is often the most direct way to diagnose the issue causing the crashes.
- **Inspect events:** Use kubectl describe pod <name-of-pod> to see events for the Pod, which can provide hints about configuration or resource issues.
- **Review configuration:** Ensure that the Pod configuration, including environment variables and mounted volumes, is correct and that all required external resources are available.
- **Check resource limits:** Make sure that the container has enough CPU and memory allocated. Sometimes, increasing the resources in the Pod definition can resolve the issue.
- **Debug application:** There might exist bugs or misconfigurations in the application code. Running this container image locally or in a development environment can help diagnose application specific issues.

## references

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
