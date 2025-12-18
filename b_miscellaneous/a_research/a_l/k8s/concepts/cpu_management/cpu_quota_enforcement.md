# **[CPU Quota Enforcement](https://news.ycombinator.com/item?id=28352071)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

I'm very excited for the better CFS quota enforcement mechanism in 5.14 (<https://lwn.net/Articles/844976/>).

Kubernetes implements CPU and memory limits for containers (<https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/>). The memory limit works the way you'd expect: there's a memory cgroup, and Linux implements the memory-allocation algorithm based on the memory cgroup's limit and not the total system memory. Wildly-overboard allocations get denied; somewhat-overboard allocations are permitted if you have overcommit turned on, but cause an OOM kill if you try to use all of it. This is at least expected behavior for existing non-Kubernetes applications and (more importantly) for people used to non-Kubernetes application development/deployment: it's just like if you were running on a Linux system with the limited memory.
