# **[Availability sets overview](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

This article provides an overview of the availability features of Azure virtual machines (VMs).

 Note

We recommend that customers choose **[Virtual Machine Scale Sets with flexible orchestration mode](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview)** for high availability with the widest range of features. Virtual Machine Scale Sets:

- Allow VM instances to be centrally managed, configured, and updated.
- Automatically increase or decrease the number of VM instances in response to demand or a defined schedule.
- Availability sets offer only high availability.

## What is an availability set?

Availability sets are logical groupings of VMs that reduce the chance of correlated failures bringing down related VMs at the same time. Availability sets place VMs in different fault domains for better reliability. This action is especially beneficial if a region doesn't support availability zones.

Availability sets offer improved VM-to-VM latencies compared to availability zones, because VMs in an availability set are allocated in closer proximity. Availability sets have fault isolation for many possible failures, to minimize single points of failure and to offer high availability. Availability sets are still susceptible to certain shared infrastructure failures, like datacenter network failures, which can affect multiple fault domains.

For more reliability than availability sets offer, use availability zones. Availability zones have the highest reliability. Each VM is deployed in multiple datacenters to help protect you from loss of power, networking, or cooling in an individual datacenter. If your highest priority is the best reliability for your workload, replicate your VMs across multiple availability zones.
