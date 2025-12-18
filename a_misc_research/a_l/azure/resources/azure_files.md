# **[Azure Files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-introduction)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Azure Files offers fully managed file shares in the cloud that are accessible via the industry standard Server Message Block (SMB) protocol, Network File System (NFS) protocol, and Azure Files REST API. Azure file shares can be mounted concurrently by cloud or on-premises deployments. SMB Azure file shares are accessible from Windows, Linux, and macOS clients. NFS Azure file shares are accessible from Linux clients. Additionally, SMB Azure file shares can be cached on Windows servers with Azure File Sync for fast access near where the data is being used.

Here are some videos on common use cases for Azure Files:

- **[Replace your file server with a serverless Azure file share](https://youtu.be/H04e9AgbcSc)**
- **[Getting started with FSLogix profile containers on Azure Files in Azure Virtual Desktop leveraging AD authentication](https://www.youtube.com/embed/9S5A1IJqfOQ)**

To get started using Azure Files, see Quickstart: **[Create and use an Azure file share](https://learn.microsoft.com/en-us/azure/storage/files/storage-how-to-use-files-portal)**.

## Why Azure Files is useful

You can use Azure file shares to:

- Replace or supplement on-premises file servers:
Use Azure Files to replace or supplement traditional on-premises file servers or network-attached storage (NAS) devices. Popular operating systems such as Windows, macOS, and Linux can directly mount Azure file shares wherever they are in the world. SMB Azure file shares can also be replicated with Azure File Sync to Windows servers, either on-premises or in the cloud, for performance and distributed caching of the data. With Azure Files AD Authentication, SMB Azure file shares can work with Active Directory Domain Services (AD DS) hosted on-premises for access control.

- "Lift and shift" applications:
Azure Files makes it easy to "lift and shift" applications to the cloud that expect a file share to store file application or user data. Azure Files enables both the "classic" lift and shift scenario, where both the application and its data are moved to Azure, and the "hybrid" lift and shift scenario, where the application data is moved to Azure Files, and the application continues to run on-premises.

- Simplify cloud development:
You can use Azure Files to simplify new cloud development projects. For example:

  - Shared application settings:
    A common pattern for distributed applications is to have configuration files in a centralized location where they can be accessed from many application instances. Application instances can load their configuration through the Azure Files REST API, and humans can access them by mounting the share locally.

  - Diagnostic share:
    An Azure file share is a convenient place for cloud applications to write their logs, metrics, and crash dumps. Logs can be written by the application instances via the File REST API, and developers can access them by mounting the file share on their local machine. This enables great flexibility, as developers can embrace cloud development without having to abandon any existing tooling they know and love.

  - Dev/Test/Debug:
    When developers or administrators are working on VMs in the cloud, they often need a set of tools or utilities. Copying such utilities and tools to each VM can be a time consuming exercise. By mounting an Azure file share locally on the VMs, a developer and administrator can quickly access their tools and utilities, no copying required.

    - Containerization:
    You can also use Azure file shares as persistent volumes for stateful containers. Containers deliver "build once, run anywhere" capabilities that enable developers to accelerate innovation. For the containers that access raw data at every start, a shared file system is required to allow these containers to access the file system no matter which instance they run on.

## **[Azure Files Pricing](https://azure.microsoft.com/en-us/pricing/details/storage/files/)**

### Provisioned v2

In a provisioned model, the primary costs of the Azure file share are based on the amount of storage, IOPS, and throughput you provision when you create or update your file share, regardless of how much you use. With the provisioned v2 billing model, you have the ability to separately provision storage, IOPS, and throughput, although we will recommend IOPS and throughput provisioning to you based on the amount of provisioned storage you select. For more information on the provisioned v2 billing model, see **[understanding the provisioned v2 billing model](https://go.microsoft.com/fwlink/?linkid=2286278&clcid=0x409)**.

### Provisioned storage

The maximum storage size of the file share, specified in GiB. You are charged for the storage you’ve provision regardless of what you use. Provisioned storage can be changed after share creation.

$0.0073 per provisioned GiB per month

### Provisioned IOPS

The maximum IOPS, or transactions per second, of the file share. You are charged for the IOPS you’ve provisioned regardless of how many IOs you use. Provisioned IOPS can be changed after share creation.

$0.0402 per provisioned IO per sec per month

### Provisioned throughput

The maximum amount of data that can be transferred per second of the file share. You are charged for the throughput you’ve provisioned regardless of what you use. Provisioned throughput can be changed after share creation.

$0.0599 per provisioned MiB per sec per month
