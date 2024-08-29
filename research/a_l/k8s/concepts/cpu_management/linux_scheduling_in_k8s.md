# **[Linux scheduling in Kubernetes](https://www.datadoghq.com/blog/kubernetes-cpu-requests-limits/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

In a previous blog post, we explained how containers’ CPU and memory requests can affect how they are scheduled. We also introduced some of the effects CPU and memory limits can have on applications, assuming that CPU limits were enforced by the Completely Fair Scheduler (CFS) quota.

In this post, we are going to dive a bit deeper into CPU and share some general recommendations for specifying CPU requests and limits. We will also explore the differences between using the default policy (CFS quota) and the CPU Manager’s static policy. We are not going to consider memory resources in this post.

Note: Node allocation and usage graphs represent a percentage of the CPU time usage, not a timeline. For simplicity, in the allocation graphs, we assume that there are no CPU reservations for Kubernetes and system components (kubelet, kube-proxy, the container runtime, etc.), unless explicitly stated. For the purpose of this post, we also assume that 1 core is equal to 1 vCPU. Many cloud instances run in hyperthreading mode, meaning that 1 core is equal to 2 vCPU.

## **[Hyper Threading](https://www.intel.com/content/www/us/en/gaming/resources/hyper-threading.html#:~:text=Intel%C2%AE%20Hyper%2DThreading%20Technology%20is%20a%20hardware%20innovation%20that,execution%20contexts%20per%20physical%20core.)**

Hyperthreading is a hardware technology that allows a single processor core to behave like two logical processors. This means that each physical core can run multiple threads, which allows more work to be done in parallel. For example, an Intel 10900K with 10 cores will display a total of 20 CPU threads.

## Linux scheduling in Kubernetes

The CPU Manager is a feature that was introduced in beta in Kubernetes v1.10 and moved to stable in v1.26. This feature allows you to use **[Linux CPUSets](https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.txt)** instead of the CFS to assign CPUs to workloads.

By default, the CPU Manager policy is set to none, which means that the Linux CFS, Completely Fair Scheduler, and CFS quota are responsible for assigning and limiting CPU resources in Kubernetes. Alternatively, you can set the CPU Manager policy to static to give containers exclusive access to specific cores. The mode that will best suit your requirements depends on the nature of your workload. These two modes differ greatly in their approaches to CPU allocation and limiting, so we will be covering both separately in this post.

Before going any further, it is important to clarify that Kubernetes considers CPU to be a compressible resource. This means that even if a node is suffering from CPU pressure, the kubelet won’t evict pods, regardless of their Quality of Service class—but some (or all) of the containers on that node will be throttled. Later in this post, we will walk through metrics that can be helpful for troubleshooting application performance issues that may be related to throttling.

## The CPU Manager’s default policy (none)

In this section, we will cover how containers’ CPU requests and limits correlate to how the CFS assigns CPU time to those containers in the default CPU Manager policy. We will also explore how you can reduce the risk of throttling and use metrics to debug potential CPU-related application issues.

## CPU requests

The Kubernetes scheduler takes each container’s CPU request into consideration when placing pods on specific nodes. This was explained in detail in a previous post, so we won’t be covering it again here.

In the case of node pressure, the CFS uses CPU requests to proportionally assign CPU time to containers. To illustrate how this works, let’s walk through an example. For the purpose of this example, we will assume that none of our containers have set CPU limits, so there isn’t a ceiling on how much CPU they can use, as long as there is still node capacity.

Let’s say we have a single node with 1 CPU core and three pods (each of which have one container and one thread) that are requesting 200, 400, and 200 millicores (m) of CPU, respectively. The scheduler is able to place them all on the node because the sum of requests is less than 1 CPU core:

![](https://imgix.datadoghq.com/img/blog/kubernetes-cpu-requests-limits/kubernetes-cpu-requests-limits-diagram-1-final.png?auto=format&fit=max&w=847)

For any time slice of 100 ms, pod 1 is guaranteed to have 20 ms of CPU time, pod 2 is guaranteed to have 40 ms of CPU time, and pod 3 is guaranteed to have 20 ms of CPU time. But if the pods are not using these CPU cycles, these numbers don’t mean anything—any pod scheduled on the node could use them. For example, in a time slice of 100 ms, this scenario is possible:

## **[Linux CPUSets](https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.txt)**

Cpusets provide a mechanism for assigning a set of CPUs and Memory
Nodes to a set of tasks.   In this document "Memory Node" refers to
an on-line node that contains memory.

Cpusets constrain the CPU and Memory placement of tasks to only
the resources within a task's current cpuset.  They form a nested
hierarchy visible in a virtual file system.  These are the essential
hooks, beyond what is already present, required to manage dynamic
job placement on large systems.

Cpusets use the generic cgroup subsystem described in
Documentation/cgroup-v1/cgroups.txt.

Requests by a task, using the sched_setaffinity(2) system call to
include CPUs in its CPU affinity mask, and using the mbind(2) and
set_mempolicy(2) system calls to include Memory Nodes in its memory
policy, are both filtered through that task's cpuset, filtering out any
CPUs or Memory Nodes not in that cpuset.  The scheduler will not
schedule a task on a CPU that is not allowed in its cpus_allowed
vector, and the kernel page allocator will not allocate a page on a
node that is not allowed in the requesting task's mems_allowed vector.

User level code may create and destroy cpusets by name in the cgroup
virtual file system, manage the attributes and permissions of these
cpusets and which CPUs and Memory Nodes are assigned to each cpuset,
specify and query to which cpuset a task is assigned, and list the
task pids assigned to a cpuset.

1.2 Why are cpusets needed ?
----------------------------

The management of large computer systems, with many processors (CPUs),
complex memory cache hierarchies and multiple Memory Nodes having
non-uniform access times (NUMA) presents additional challenges for
the efficient scheduling and memory placement of processes.

Frequently more modest sized systems can be operated with adequate
efficiency just by letting the operating system automatically share
the available CPU and Memory resources amongst the requesting tasks.

But larger systems, which benefit more from careful processor and
memory placement to reduce memory access times and contention,
and which typically represent a larger investment for the customer,
can benefit from explicitly placing jobs on properly sized subsets of
the system.

This can be especially valuable on:

    * Web Servers running multiple instances of the same web application,
    * Servers running different applications (for instance, a web server
      and a database), or
    * NUMA systems running large HPC applications with demanding
      performance characteristics.

These subsets, or "soft partitions" must be able to be dynamically
adjusted, as the job mix changes, without impacting other concurrently
executing jobs. The location of the running jobs pages may also be moved
when the memory locations are changed.

The kernel cpuset patch provides the minimum essential kernel
mechanisms required to efficiently implement such subsets.  It
leverages existing CPU and Memory Placement facilities in the Linux
kernel to avoid any additional impact on the critical scheduler or
memory allocator code.
