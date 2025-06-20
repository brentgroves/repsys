# **[Always On availability group on SQL Server on Azure VMs](https://learn.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-overview?view=azuresql)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

This article introduces Always On availability groups (AG) for SQL Server on Azure Virtual Machines (VMs).

To get started, see the **[availability group tutorial](https://learn.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/availability-group-manually-configure-prerequisites-tutorial-multi-subnet?view=azuresql)**.

Always On availability groups on Azure Virtual Machines are similar to **[Always On availability groups on-premises](https://learn.microsoft.com/en-us/sql/database-engine/availability-groups/windows/always-on-availability-groups-sql-server)**, and rely on the underlying **[Windows Server Failover Cluster](https://learn.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/hadr-windows-server-failover-cluster-overview?view=azuresql)**. However, since the virtual machines are hosted in Azure, there are a few additional considerations as well, such as VM redundancy, and routing traffic on the Azure network.

The following diagram illustrates an availability group for SQL Server on Azure VMs:

![i1](https://learn.microsoft.com/en-us/azure/azure-sql/virtual-machines/windows/media/availability-group-overview/00-endstatesamplenoelb.png?view=azuresql)

It's now possible to lift and shift your availability group solution to SQL Server on Azure VMs using Azure Migrate. See Migrate availability group to learn more.

## VM redundancy

To increase redundancy and high availability, SQL Server VMs should either be in the same **[availability set](https://learn.microsoft.com/en-us/azure/virtual-machines/availability-set-overview)**, or different **[availability zones](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview)**.

Placing a set of VMs in the same availability set protects from outages within a data center caused by equipment failure (VMs within an Availability Set don't share resources) or from updates (VMs within an availability set aren't updated at the same time).

Availability Zones protect against the failure of an entire data center, with each Zone representing a set of data centers within a region. By ensuring resources are placed in different Availability Zones, no data center-level outage can take all of your VMs offline.

When creating Azure VMs, you must choose between configuring Availability Sets vs Availability Zones. An Azure VM can't participate in both.

While Availability Zones may provide better availability than Availability Sets (99.99% vs 99.95%), performance should also be a consideration. VMs within an Availability Set can be placed in a proximity placement group which guarantees they're close to each other, minimizing network latency between them. VMs located in different Availability Zones have greater network latency between them, which can increase the time it takes to synchronize data between the primary and secondary replica(s). This may cause delays on the primary replica as well as increase the chance of data loss in the event of an unplanned failover. It's important to test the proposed solution under load and ensure that it meets SLAs for both performance and availability.
