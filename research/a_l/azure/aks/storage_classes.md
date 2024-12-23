# **[Best practices for storage and backups in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/concepts-storage#storage-classes)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

As you create and manage clusters in Azure Kubernetes Service (AKS), your applications often need storage. Make sure you understand pod performance needs and access methods so that you can select the best storage for your application. The AKS node size may impact your storage choices. Plan for ways to back up and test the restore process for attached storage.

This best practices article focuses on storage considerations for cluster operators. In this article, you learn:

- What types of storage are available.
- How to correctly size AKS nodes for storage performance.
- Differences between dynamic and static provisioning of volumes.
- Ways to back up and secure your data volumes.

## Choose the appropriate storage type

Best practice guidance

Understand the needs of your application to pick the right storage. Use high performance, SSD-backed storage for production workloads. Plan for network-based storage when you need multiple concurrent connections.

Applications often require different types and speeds of storage. Determine the most appropriate storage type by asking the following questions.

- Do your applications need storage that connects to individual pods?
- Do your applications need storage shared across multiple pods?
- Is the storage for read-only access to data?
- Will the storage be used to write large amounts of structured data?

The following table outlines the available storage types and their capabilities:

| Use case                                  | Volume plugin | Read/write once | Read-only many | Read/write many | Windows Server container support |
|-------------------------------------------|---------------|-----------------|----------------|-----------------|----------------------------------|
| Shared configuration                      | Azure Files   | Yes             | Yes            | Yes             | Yes                              |
| Structured app data                       | Azure Disks   | Yes             | No             | No              | Yes                              |
| Unstructured data, file system operations | BlobFuse      | Yes             | Yes            | Yes             | No                               |

AKS provides two primary types of secure storage for volumes backed by Azure Disks or Azure Files. Both use the default Azure Storage Service Encryption (SSE) that encrypts data at rest. Disks cannot be encrypted using Azure Disk Encryption at the AKS node level. With Azure Files shares, there is no limit as to how many can be mounted on a node.

Both Azure Files and Azure Disks are available in Standard and Premium performance tiers:

## Premium disks

Backed by high-performance solid-state disks (SSDs).
Recommended for all production workloads.

## Standard disks

Backed by regular spinning disks (HDDs).
Good for archival or infrequently accessed data.

While the default storage tier for the Azure Disk CSI driver is Premium SSD, your custom StorageClass can use Premium SSD, Standard SSD, or Standard HDD.

Understand the application performance needs and access patterns to choose the appropriate storage tier. For more information about Managed Disks sizes and performance tiers, see **[Azure Managed Disks overview](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)**.

## Create and use storage classes to define application needs

Define the type of storage you want using Kubernetes storage classes. The storage class is then referenced in the pod or deployment specification. Storage class definitions work together to create the appropriate storage and connect it to pods.

For more information, see **[Storage classes in AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-storage#storage-classes)**.
