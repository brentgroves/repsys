# **[Storage options for applications in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/concepts-storage)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

Applications running in Azure Kubernetes Service (AKS) might need to store and retrieve data. While some application workloads can use local, fast storage on unneeded, emptied nodes, others require storage that persists on more regular data volumes within the Azure platform.

Multiple pods might need to:

- Share the same data volumes.
- Reattach data volumes if the pod is rescheduled on a different node.

You also might need to collect and store sensitive data or application configuration information into pods.

This article introduces the core concepts that provide storage to your applications in AKS:

- Volumes
- Persistent volumes
- Storage classes
- Persistent volume claims

![v](https://learn.microsoft.com/en-us/azure/aks/media/concepts-storage/aks-storage-concept.png)

## Default OS disk sizing

When you create a new cluster or add a new node pool to an existing cluster, the number for vCPUs by default determines the OS disk size. The number of vCPUs is based on the VM SKU. The following table lists the default OS disk size for each VM SKU:

| VM SKU Cores (vCPUs) | Default OS Disk Tier | Provisioned IOPS | Provisioned Throughput (Mbps) |
|----------------------|----------------------|------------------|-------------------------------|
| 1 - 7                | P10/128G             | 500              | 100                           |
| 8 - 15               | P15/256G             | 1100             | 125                           |
| 16 - 63              | P20/512G             | 2300             | 150                           |
| 64+                  | P30/1024G            | 5000             | 200                           |

```bash
az aks create \
    --resource-group $RESOURCE_GROUP \
    --name $CLUSTER \
    --node-count 1 \
    --enable-aad \
    --node-vm-size Standard_D8_v3 \
    --aad-admin-group-object-ids $ADM_GROUP_ID \
    --enable-addons azure-keyvault-secrets-provider \
    --generate-ssh-keys  
```

## D-Series

General purpose compute
The D-series Azure VMs offer a combination of vCPUs, memory, and temporary storage able to meet the requirements associated with most production workloads.

- Our current cluster uses one **[Standard_D8_v3](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes/general-purpose/dv3-series?tabs=sizebasic)** VM which has 8 vCPU and 32 GB ram.

<!-- Standard_D8_v3 -->
| instance | vCPU | RAM    | Temp Storage | Pay as you go   | 1 year savings plan          | 3 year savings plan          | Spot                        |
|----------|------|--------|--------------|-----------------|------------------------------|------------------------------|-----------------------------|
| D8v3     | 8    | 32 GiB | 200 GiB      | $280.3200/month | $193.4208/month ~31% savings | $131.7504/month ~53% savings | $39.2448/month ~85% savings |

The Dv3 virtual machines are hyper-threaded general-purpose VMs based on the 2.3 GHz Intel® XEON ® E5-2673 v4 (Broadwell) processor. They can achieve 3.5 GHz with Intel Turbo Boost Technology 2.0.

 Important

Default OS disk sizing is only used on new clusters or node pools when Ephemeral OS disks aren't supported and a default OS disk size isn't specified. The default OS disk size might impact the performance or cost of your cluster. You can't change the OS disk size after cluster or node pool creation. This default disk sizing affects clusters or node pools created on July 2022 or later.

## Ephemeral OS disk

By default, Azure automatically replicates the operating system disk for a virtual machine to Azure Storage to avoid data loss when the VM is relocated to another host. However, since containers aren't designed to have local state persisted, this behavior offers limited value while providing some drawbacks. These drawbacks include, but aren't limited to, slower node provisioning and higher read/write latency.

By contrast, ephemeral OS disks are stored only on the host machine, just like a temporary disk. With this configuration, you get lower read/write latency, together with faster node scaling and cluster upgrades.

 Note

When you don't explicitly request **[Azure managed disks](https://learn.microsoft.com/en-us/azure/virtual-machines/managed-disks-overview)** for the OS, AKS defaults to ephemeral OS if possible for a given node pool configuration.

Size requirements and recommendations for ephemeral OS disks are available in the Azure VM documentation. The following are some general sizing considerations:

- If you chose to use the AKS default VM size Standard_DS2_v2 SKU with the default OS disk size of 100 GiB, the default VM size supports ephemeral OS, but only has 86 GiB of cache size. This configuration would default to managed disks if you don't explicitly specify it. If you do request an ephemeral OS, you receive a validation error.

- If you request the same Standard_DS2_v2 SKU with a 60-GiB OS disk, this configuration would default to ephemeral OS. The requested size of 60 GiB is smaller than the maximum cache size of 86 GiB.

- If you select the Standard_D8s_v3 SKU with 100-GB OS disk, this VM size supports ephemeral OS and has 200 GiB of cache space. If you don't specify the OS disk type, the node pool would receive ephemeral OS by default.

## Customer-managed keys

You can manage encryption for your ephemeral OS disk with your own keys on an AKS cluster. For more information, see Use Customer Managed key with Azure disk on AKS.

## Volumes

Kubernetes typically treats individual pods as ephemeral, disposable resources. Applications have different approaches available to them for using and persisting data. A volume represents a way to store, retrieve, and persist data across pods and through the application lifecycle.

Traditional volumes are created as Kubernetes resources backed by Azure Storage. You can manually create data volumes to be assigned to pods directly or have Kubernetes automatically create them. Data volumes can use: **[Azure Disk](https://learn.microsoft.com/en-us/azure/virtual-machines/disks-types)**, **[Azure Files](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-planning)**, **[Azure NetApp Files](https://learn.microsoft.com/en-us/azure/azure-netapp-files/azure-netapp-files-service-levels)**, or **[Azure Blobs](https://learn.microsoft.com/en-us/azure/storage/common/storage-account-overview)**.

Note

Depending on the VM SKU you're using, the Azure Disk CSI driver might have a per-node volume limit. For some high performance VMs (for example, 16 cores), the limit is 64 volumes per node. To identify the limit per VM SKU, review the Max data disks column for each VM SKU offered. For a list of VM SKUs offered and their corresponding detailed capacity limits, see **[General purpose virtual machine sizes](https://learn.microsoft.com/en-us/azure/virtual-machines/sizes-general)**.

To help determine best fit for your workload between Azure Files and Azure NetApp Files, review the information provided in the article **[Azure Files and Azure NetApp Files comparison](https://learn.microsoft.com/en-us/azure/storage/files/storage-files-netapp-comparison)**.

## Azure Disk

Use Azure Disk to create a Kubernetes DataDisk resource. Disks types include:

Premium SSDs (recommended for most workloads)
Ultra disks
Standard SSDs
Standard HDDs

Because an Azure Disk is mounted as ReadWriteOnce, it's only available to a single node. For storage volumes accessible by pods on multiple nodes simultaneously, use Azure Files.

## Azure Files

Use **[Azure Files](https://learn.microsoft.com/en-us/azure/aks/azure-files-csi)** to mount a Server Message Block (SMB) version 3.1.1 share or Network File System (NFS) version 4.1 share. Azure Files let you share data across multiple nodes and pods and can use:

- Azure Premium storage backed by high-performance SSDs
- Azure Standard storage backed by regular HDDs

## Azure NetApp Files

- Ultra Storage
- Premium Storage
- Standard Storage

## Azure Blob Storage

Use Azure Blob Storage to create a blob storage container and mount it using the NFS v3.0 protocol or BlobFuse.

Block blobs
