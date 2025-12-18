# **[Linux CPUSets](https://www.kernel.org/doc/Documentation/cgroup-v1/cpusets.txt)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

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
