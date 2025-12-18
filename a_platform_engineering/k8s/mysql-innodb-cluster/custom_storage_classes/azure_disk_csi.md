# **[Use the Azure Disk Container Storage Interface (CSI) driver in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/azure-disk-csi)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

The Azure Disks Container Storage Interface (CSI) driver is a CSI specification-compliant driver used by Azure Kubernetes Service (AKS) to manage the lifecycle of Azure Disk.

The CSI is a standard for exposing arbitrary block and file storage systems to containerized workloads on Kubernetes. By adopting and using CSI, AKS now can write, deploy, and iterate plug-ins to expose new or improve existing storage systems in Kubernetes. Using CSI drivers in AKS avoids having to touch the core Kubernetes code and wait for its release cycles.

To create an AKS cluster with CSI driver support, see **[Enable CSI driver on AKS](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers)**. This article describes how to use the Azure Disk CSI driver version 1.

Note

Azure Disk CSI driver v2 (preview) improves scalability and reduces pod failover latency. It uses shared disks to provision attachment replicas on multiple cluster nodes and integrates with the pod scheduler to ensure a node with an attachment replica is chosen on pod failover. Azure Disk CSI driver v2 (preview) also provides the ability to fine tune performance. If you're interested in participating in the preview, submit a request: <https://aka.ms/DiskCSIv2Preview>. This preview version is provided without a service level agreement, and you can occasionally expect breaking changes while in preview. The preview version isn't recommended for production workloads. For more information, see Supplemental Terms of Use for Microsoft Azure Previews.

In-tree drivers refers to the current storage drivers that are part of the core Kubernetes code versus the new CSI drivers, which are plug-ins.

## Azure Disk CSI driver features

In addition to in-tree driver features, Azure Disk CSI driver supports the following features:

- Performance improvements during concurrent disk attach and detach
  - In-tree drivers attach or detach disks in serial, while CSI drivers attach or detach disks in batch. There's significant improvement when there are multiple disks attaching to one node.
- Premium SSD v1 and v2 are supported.
  - PremiumV2_LRS only supports None caching mode
- Zone-redundant storage (ZRS) disk support
  - Premium_ZRS, StandardSSD_ZRS disk types are supported. ZRS disk could be scheduled on the zone or non-zone node, without the restriction that disk volume should be co-located in the same zone as a given node. For more information, including which regions are supported, see Zone-redundant storage for managed disks.
- Snapshot
- Volume clone
- Resize disk PV without downtime

Depending on the VM SKU that's being used, the Azure Disk CSI driver might have a per-node volume limit. For some powerful VMs (for example, 16 cores), the limit is 64 volumes per node. To identify the limit per VM SKU, review the Max data disks column for each VM SKU offered. For a list of VM SKUs offered and their corresponding detailed capacity limits, see General purpose virtual machine sizes.

## Use CSI persistent volumes with Azure Disks

A persistent volume (PV) represents a piece of storage that's provisioned for use with Kubernetes pods. A PV can be used by one or many pods and can be dynamically or statically provisioned. This article shows you how to dynamically create PVs with Azure disk for use by a single pod in an AKS cluster. For static provisioning, see **[Create a static volume with Azure Disks](https://learn.microsoft.com/en-us/azure/aks/azure-csi-disk-storage-provision#statically-provision-a-volume)**.

For more information on Kubernetes volumes, see **[Storage options for applications in AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-storage)**.

## Dynamically create Azure Disks PVs by using the built-in storage classes

A storage class is used to define how a unit of storage is dynamically created with a persistent volume. For more information on Kubernetes storage classes, see Kubernetes storage classes.

When you use the Azure Disk CSI driver on AKS, there are two more built-in StorageClasses that use the Azure Disk CSI storage driver. The other CSI storage classes are created with the cluster alongside the in-tree default storage classes.

- **managed-csi:** Uses Azure Standard SSD locally redundant storage (LRS) to create a managed disk. Effective starting with Kubernetes version 1.29, in Azure Kubernetes Service (AKS) clusters deployed across multiple availability zones, this storage class utilizes Azure Standard SSD zone-redundant storage (ZRS) to create managed disks.
- **managed-csi-premium:** Uses Azure Premium LRS to create a managed disk. Effective starting with Kubernetes version 1.29, in Azure Kubernetes Service (AKS) clusters deployed across multiple availability zones, this storage class utilizes Azure Premium zone-redundant storage (ZRS) to create managed disks.

The reclaim policy in both storage classes ensures that the underlying Azure Disks are deleted when the respective PV is deleted. The storage classes also configure the PVs to be expandable. You just need to edit the persistent volume claim (PVC) with the new size.

To use these storage classes, create a PVC and respective pod that references and uses them. A PVC is used to automatically provision storage based on a storage class. A PVC can use one of the pre-created storage classes or a user-defined storage class to create an Azure-managed disk for the desired SKU and size. When you create a pod definition, the PVC is specified to request the desired storage.

Create an example pod and respective PVC by running the kubectl apply command:

```bash
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/azuredisk-csi-driver/master/deploy/example/pvc-azuredisk-csi.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/azuredisk-csi-driver/master/deploy/example/nginx-pod-azuredisk.yaml

persistentvolumeclaim/pvc-azuredisk created
pod/nginx-azuredisk created
```

After the pod is in the running state, run the following command to create a new file called test.txt.

```bash
kubectl exec nginx-azuredisk -- touch /mnt/azuredisk/test.txt
```

To validate the disk is correctly mounted, run the following command and verify you see the test.txt file in the output:

```bash
kubectl exec nginx-azuredisk -- ls /mnt/azuredisk

lost+found
outfile
test.txt
```

## Create a custom storage class

The default storage classes are suitable for most common scenarios. For some cases, you might want to have your own storage class customized with your own parameters. For example, you might want to change the volumeBindingMode class.

You can use a volumeBindingMode: Immediate class that guarantees it occurs immediately once the PVC is created. When your node pools are topology constrained, for example when using availability zones, PVs would be bound or provisioned without knowledge of the pod's scheduling requirements.

To address this scenario, you can use volumeBindingMode: WaitForFirstConsumer, which delays the binding and provisioning of a PV until a pod that uses the PVC is created. This way, the PV conforms and is provisioned in the availability zone (or other topology) that's specified by the pod's scheduling constraints. The default storage classes use volumeBindingMode: WaitForFirstConsumer class.

Create a file named sc-azuredisk-csi-waitforfirstconsumer.yaml, and then paste the following manifest. The storage class is the same as our managed-csi storage class, but with a different volumeBindingMode class.

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: azuredisk-csi-waitforfirstconsumer
provisioner: disk.csi.azure.com
parameters:
  skuname: StandardSSD_LRS
allowVolumeExpansion: true
reclaimPolicy: Delete
volumeBindingMode: WaitForFirstConsumer
```

Create the storage class by running the kubectl apply command and specify your sc-azuredisk-csi-waitforfirstconsumer.yaml file:

```bash
pushd .
cd ~/src/azure/custom_storage_classes
kubectl apply -f mysql_retain.yaml
storageclass.storage.k8s.io/azuredisk-csi-waitforfirstconsumer created

kubectl describe sc mysql-retain                            
Name:            mysql-retain
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"allowVolumeExpansion":true,"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"mysql-retain"},"parameters":{"skuname":"StandardSSD_LRS"},"provisioner":"disk.csi.azure.com","reclaimPolicy":"Retain","volumeBindingMode":"WaitForFirstConsumer"}

Provisioner:           disk.csi.azure.com
Parameters:            skuname=StandardSSD_LRS
AllowVolumeExpansion:  True
MountOptions:          <none>
ReclaimPolicy:         Retain
VolumeBindingMode:     WaitForFirstConsumer
Events:                <none>
```

## Volume snapshots

The Azure Disk CSI driver supports creating snapshots of persistent volumes. As part of this capability, the driver can perform either full or incremental snapshots depending on the value set in the incremental parameter (by default, it's true).

The following table provides details for all of the parameters.
