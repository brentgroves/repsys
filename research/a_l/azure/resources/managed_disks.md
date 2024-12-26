# **[Introduction to Azure managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Azure managed disks are block-level storage volumes that are managed by Azure and used with Azure Virtual Machines. Managed disks are like physical disks in an on-premises server, but they're virtualized. With managed disks, all you have to do is specify the disk size, specify the disk type, and provision the disk. After you provision the disk, Azure handles the rest.

The available types of managed disks are ultra disks, premium solid-state drives (SSDs), standard SSDs, and standard hard disk drives (HDDs). For information about each disk type, see **[Azure managed disk types](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types)**.

An alternative is to use Azure Elastic SAN as the storage for your virtual machine (VM). With Elastic SAN, you can consolidate the storage for all your workloads into a single storage back end. This choice can be more cost effective if you have many large-scale, I/O-intensive workloads and top-tier databases. To learn more, see **[What is Azure Elastic SAN?](https://learn.microsoft.com/en-us/azure/storage/elastic-san/elastic-san-introduction)**.

## Benefits of managed disks

Let's explore some of the benefits that you gain by using managed disks.

### High durability and availability

Managed disks are designed for 99.999% availability. Managed disks achieve this availability by providing three replicas of your data. If one or even two replicas experience problems, the remaining replicas help ensure persistence of your data and high tolerance against failures.

This architecture has helped Azure consistently deliver high durability for infrastructure as a service (IaaS) disks, with a 0% annualized failure rate. Locally redundant storage (LRS) disks provide at least 99.999999999% (11 9's) of durability over a year. Zone-redundant storage (ZRS) disks provide at least 99.9999999999% (12 9's) of durability over a year.

## Simple and scalable VM deployment

By using managed disks, you can create up to 50,000 VM disks of a type in a subscription per region. You can then create thousands of VMs in a single subscription.

Managed disks increase the scalability of **[virtual machine scale sets](https://learn.microsoft.com/en-us/azure/virtual-machine-scale-sets/overview)**. You can create up to 1,000 VMs in a virtual machine scale set by using an Azure Marketplace image or an Azure Compute Gallery image with managed disks.

## Integration with availability sets

Managed disks are integrated with availability sets to help ensure that the **[disks of VMs in an availability set](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)** are sufficiently isolated from each other to avoid a single point of failure.

Disks are automatically placed in different storage scale units (stamps). If a stamp fails due to hardware or software failure, only the VM instances with disks on those stamps fail.

For example, let's say you have an application running on five VMs, and the VMs are in an availability set. The disks for those VMs aren't all stored in the same stamp. So if one stamp goes down, the other instances of the application continue to run.

## **What is an availability set?**

Availability sets are logical groupings of VMs that reduce the chance of correlated failures bringing down related VMs at the same time. Availability sets place VMs in different fault domains for better reliability. This action is especially beneficial if a region doesn't support availability zones.
