# **[Container security fundamentals part 4: Cgroups](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-4/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[microk8s](https://stackoverflow.com/questions/69030570/limiting-microk8s-maximum-memory-usage)**

## Container security fundamentals part 4: Cgroups

Managing system resources can be a challenge when multiple processes are running on a host. A single misbehaving program could consume all available resources, causing the entire system to crash. To tackle this problem, Linux relies on control groups (cgroups) to manage each process's access to resources, such as CPU and memory.

Docker and other containerization tools use cgroups to restrict the resources that containers can use, which can help avoid "noisy neighbor" issues. This is particularly helpful when working with Kubernetes, as workloads from multiple applications frequently share resources on the same host.

In this post, we will take a closer look at cgroups and explore how they ensure that each process has access to the resources it requires to operate efficiently. We will also cover several security aspects of cgroups, including how you can use cgroups to reduce the risk of denial-of-service attacks and **manage containers' access to specific devices on a host**.

A **DoS** attack is usually carried out by flooding a targeted machine or resource with unnecessary requests. The goal is to overload the system and prevent some or all legitimate requests from being fulfilled.

## cgroups v1 and v2

It's worth noting that two versions of cgroups might be utilized on a given host, depending on the Linux distribution and version. Control group v2 provides management benefits over the original implementation and is required for certain container features, such as rootless containers.

**Rootless containers** refers to the ability for an unprivileged user to create, run and otherwise manage containers.

Control group v2 was initially introduced in version 4.5 of the Linux kernel in 2016, but it only recently became the default in some distributions. To determine which version(s) are running on a host, you can verify the mounted filesystems. For instance, if you execute the command mount | grep cgroup on an Ubuntu 20.04 host, you will see one line for "cgroup2" and several for "cgroup," indicating that both systems are installed.

From Ubuntu 22.04 desktop:

```bash
mount | grep cgroup
cgroup2 on /sys/fs/cgroup type cgroup2 (rw,nosuid,nodev,noexec,relatime)
```

**Linux /sys filesystem**\
The /sys filesystem on Linux complements /proc, by providing a lot of (non-process related) detailed information about the in-kernel status to userspace. More traditional Unix systems locate this information in sysctl calls.

Since cgroup v2 is the version that is used in recent Linux distributions, we will focus on v2 in the remainder of our examples.

## Cgroups basics

There are several ways to examine the cgroups that are used on a Linux host. One option is to use the /proc filesystem to view the cgroups that are being used for a specific process (for instance, the bash shell of the running user).

Executing the command cat /proc/[PID]/cgroup will reveal the cgroup "slice" and "scope" to which the process belongs (slices and scopes are utilized to organize cgroups and processes). In the following example, we first used ps -fC bash to obtain the process ID of our shell. We then used that process ID to discover the cgroup session that it employs.
