# **[Azure managed disk Pricing](https://azure.microsoft.com/en-us/pricing/details/managed-disks/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

Premium SSD
Premium SSDs are high-performance Solid-State Drive (SSD) based Storage designed to support I/O intensive workloads with significantly high throughput and low latency. With Premium SSDs, you can provision a persistent disk and configure its size and performance characteristics.

The total cost of Premium SSDs depends on the size and number of the disks, and will be affected by the number of outbound data transfers. These disk sizes provide different input/output operations per sec (IOPS), throughput caps, and monthly price per GiB. Premium SSDs are supported on various virtual machine sizes and options, including DS-series, DSv2-series, FS-series, and GS-series - to run your workloads. Premium SSDs support both locally-redundant storage (LRS) and zone-redundant storage (ZRS) options. Please refer to Azure Storage replication page for more details on redundancy options. Premium SSDs with ZRS are currently generally available in select regions with more regional availability to come. To see ZRS pricing, please select ZRS as a redundancy option in the drop-down. When using Azure shared disks on Premium SSDs, each additional mount of disk is charged per month based on the disk size. Shared disk pricing is the same for either LRS or ZRS option.

## Snapshots

You can store full snapshots and images for Premium SSDs on Standard storage. You can choose between locally redundant (LRS) and zone redundant (ZRS) snapshot options. These snapshots and images are charged at $0.05/GB per month for both Standard LRS and ZRS options based on the used portion of the disk. For example, if you create a snapshot of a managed disk with provisioned capacity of 64 GB and actual used data size of 10 GB, snapshot will be billed only for the used data size of 10 GB. If you choose to store them on Premium SSDs Managed Disk storage, you’ll be charged at $0.12/GB per month.

You can store incremental snapshots for Premium SSDs only on Standard storage. They are charged at $0.05/GB per month for both Standard LRS and ZRS snapshot options of the storage occupied by the delta changes since the last snapshot. For example, you are using a managed disk with provisioned size of 128 GB and used size of 100 GB. The first incremental snapshot is billed only for the used size of 100 GB. 20 GB of data is added on the disk before you created the second snapshot. Now, the second incremental snapshot is billed for only 20 GB.

Azure confidential VMs offer a new and enhanced opt-in disk encryption scheme called confidential disk encryption. This scheme protects all critical partitions of the disk. It also binds disk encryption keys to the virtual machine's TPM and makes the protected disk content accessible only to the VM. More information on confidential OS disk encryption can be found here - Confidential OS Disk Encryption. This encryption scheme carries a charge in addition to the disk price.

| Premium SSD Managed Disks | Redundancy | Price per GiB per Month |
|---------------------------|------------|-------------------------|
| Premium SSD Managed Disks | LRS        | $0.01825                |
| Premium SSD Managed Disks | ZRS        | $0.02701                |
