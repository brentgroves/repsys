# **[](https://securitylabs.datadoghq.com/articles/container-security-fundamentals-part-4/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[microk8s](https://stackoverflow.com/questions/69030570/limiting-microk8s-maximum-memory-usage)**

## Container security fundamentals part 4: Cgroups

Managing system resources can be a challenge when multiple processes are running on a host. A single misbehaving program could consume all available resources, causing the entire system to crash. To tackle this problem, Linux relies on control groups (cgroups) to manage each process's access to resources, such as CPU and memory.

