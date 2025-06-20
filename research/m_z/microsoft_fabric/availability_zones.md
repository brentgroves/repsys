# **[What are availability zones?](https://learn.microsoft.com/en-us/azure/reliability/availability-zones-overview?tabs=azure-cli)**

**[Current Status](../../../a_status/current_tasks.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

Many **[Azure regions](https://learn.microsoft.com/en-us/azure/reliability/regions-overview)** provide availability zones, which are separated groups of datacenters within a region. Each availability zone has independent power, cooling, and networking infrastructure, so that if one zone experiences an outage, then regional services, capacity, and high availability are supported by the remaining zones.

Availability zones are typically separated by several kilometers, and usually are within 100 kilometers. This distance means they're close enough to have low-latency connections to other availability zones through a high-performance network. However, they're far enough apart to reduce the likelihood that more than one will be affected by local outages or weather.

Datacenter locations are selected by using rigorous vulnerability risk assessment criteria. This process identifies all significant datacenter-specific risks and considers shared risks between availability zones.

The following diagram shows several example Azure regions. Regions 1 and 2 support availability zones, and regions 3 and 4 don't have availability zones.

![i1](https://learn.microsoft.com/en-us/azure/reliability/media/regions-availability-zones.png)

To see which regions support availability zones, see **[List of Azure regions](https://learn.microsoft.com/en-us/azure/reliability/regions-list)**.

## What is the difference between a datacenter and an availability zone?

An availability zone is a logical grouping of one or more physically separate datacenters within a region. Each availability zone is built in a way that if something goes wrong in one (like a power outage or network issue), the others keep working. A single datacenter doesn’t offer this level of protection on its own.

## Types of availability zone support

Azure services can provide two types of availability zone support: zone-redundant and zonal. Each service might support one or both types. When designing your reliability strategy, make sure that you understand how each service in your workload supports availability zones.

**Zone-redundant deployments:** Zone-redundant resources are replicated or distributed across multiple availability zones automatically. For example, zone-redundant data services replicate the data across multiple zones so that a failure in one zone doesn't affect the availability of the data. For some services you can select the set of zones that your resource uses, while in other services Microsoft selects the zones.

With zone-redundant deployments, Microsoft manages spreading requests across zones and the replication of data across zones. If an outage occurs in an availability zone, Microsoft manages failover to another zone automatically.

**Zonal deployments:** A zonal resource is deployed to a single, self-selected availability zone. This approach doesn't provide a resiliency benefit, but it helps you to achieve more stringent latency or performance requirements. For example, virtual machines, managed disks, and standard IP addresses can be deployed zonally to the same zone.

To improve the resiliency of zonal resources, you need to design an architecture with separate resources in multiple availability zones within the region, but Microsoft doesn't manage the process for you. If an outage occurs in an availability zone, you're responsible for failover to another zone.

When you use configure a resource to be zone redundant, or if you use multiple instances of a zonal resource in different availabilty zones, then your resource is considered to be zone-resilient: that is, it's resilient to the outage of a single availability zone.

Some services don't use availability zones until you configure them to do so. If you don't explicitly configure a service for availability zone support, it's called a nonzonal or regional deployment. Resources configured in this way might be placed in any availability zone in the region, and might be moved. If any availability zone in the region experiences an outage, non-zonal resources might be in the affected zone and could experience downtime.

 Important

Some services may have extra requirements to meet for availability zone support. For example, some may only support availability zones for certain tiers or SKUs, or in a subset of Azure regions.
