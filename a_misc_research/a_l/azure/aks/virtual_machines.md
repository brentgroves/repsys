# **[Virtual Machine series](https://azure.microsoft.com/en-us/pricing/details/virtual-machines/series/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## D-Series

General purpose compute
The D-series Azure VMs offer a combination of vCPUs, memory, and temporary storage able to meet the requirements associated with most production workloads.

- Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

<!-- Standard_D8_v3 -->
| instance | vCPU | RAM    | Temp Storage | Pay as you go   | 1 year savings plan          | 3 year savings plan          | Spot                        |
|----------|------|--------|--------------|-----------------|------------------------------|------------------------------|-----------------------------|
| D8v3     | 8    | 32 GiB | 200 GiB      | $280.3200/month | $193.4208/month ~31% savings | $131.7504/month ~53% savings | $39.2448/month ~85% savings |

The Dv3 virtual machines are hyper-threaded general-purpose VMs based on the 2.3 GHz Intel® XEON ® E5-2673 v4 (Broadwell) processor. They can achieve 3.5 GHz with Intel Turbo Boost Technology 2.0.

The Dv4 and Ddv4 virtual machines are based on a custom Intel® Xeon® Platinum 8272CL processor, which runs at a base speed of 2.5Ghz and can achieve up to 3.4Ghz all core turbo frequency. The Dd v4 virtual machine sizes feature fast, large local SSD storage (up to 2,400 GiB) and are well suited for applications that benefit from low latency, high-speed local storage. The Dv4 virtual machine sizes do not have any temporary storage.

The Dv5 and Ddv5 series virtual machines feature the 3rd Generation Intel® Xeon® Platinum 8370C (Ice Lake) processor in a hyper-threaded configuration. They can scale up to 96 vCPUs with configurations similar to the Dv4 and Ddv4 series VMs.

The Dav4 and Dasv4 Azure VM-series provide up to 96 vCPUs, 384 GiBs of RAM and 2,400 GiBs of SSD-based temporary storage and feature the AMD EPYC™ 7452 processor.

The Dasv5 and Dadsv5-series virtual machines are based on the 3rd Generation AMD EPYC™ 7763v (Milan) processor. This processor can achieve a boosted maximum frequency of 3.5GHz. The VM series provide sizes with (Dadsv5) and without local temporary storage (Dasv5), and a better value proposition for most general-purpose workloads compared to the prior Dav4 and Dasv4 generation.

The Dpsv5 and Dpdsv5 VM series feature the Ampere Altra 64-bit Multi-Core Arm-based processor operating at up to 3.0GHz frequency. The Ampere Altra processor was engineered for scale-out cloud environments and can deliver efficient performance to reduce overall environmental impact. The Dplsv5 and Dpldsv5 VM sizes offer one of the lowest price points of entry within the general-purpose Azure Virtual Machines portfolio, and provide 2GiBs per vCPU delivering a compelling value proposition for many general-purpose Linux workloads that do not require larger amounts of RAM per vCPU.

The Ds, Dds, Das, Dads, Dps, Dpds, Dpls, and Dplds VM series support Azure Premium SSDs and Ultra Disk storage depending on regional availability.

Example workloads include many enterprise-grade applications, e-commerce systems, web front ends, desktop virtualization solutions, customer relationship management applications, entry-level and mid-range databases, application servers, gaming servers, media servers, and more...

 D-Series
starting from
$41.61 /per month
Pricing Windows VMs
Pricing Linux VMs
