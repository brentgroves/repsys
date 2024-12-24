# **[Use Azure Files Container Storage Interface (CSI) driver in Azure Kubernetes Service (AKS)](https://learn.microsoft.com/en-us/azure/aks/azure-files-csi)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

The Azure Files Container Storage Interface (CSI) driver is a CSI specification-compliant driver used by Azure Kubernetes Service (AKS) to manage the lifecycle of Azure file shares. The CSI is a standard for exposing arbitrary block and file storage systems to containerized workloads on Kubernetes.

By adopting and using CSI, AKS now can write, deploy, and iterate plug-ins to expose new or improve existing storage systems in Kubernetes. Using CSI drivers in AKS avoids having to touch the core Kubernetes code and wait for its release cycles.

To create an AKS cluster with CSI drivers support, see **[Enable CSI drivers on AKS.](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers)**

Note

In-tree drivers refers to the current storage drivers that are part of the core Kubernetes code versus the new CSI drivers, which are plug-ins.

## Azure Files CSI driver new features

In addition to the original in-tree driver features, Azure Files CSI driver supports the following new features:

- Network File System (NFS) version 4.1
- Private endpoint
- Creating large mount of file shares in parallel.

## Use a persistent volume with Azure Files

A persistent volume (PV) represents a piece of storage that's provisioned for use with Kubernetes pods. A PV can be used by one or many pods and can be dynamically or statically provisioned. If multiple pods need concurrent access to the same storage volume, you can use Azure Files to connect by using the Server Message Block (SMB) or NFS protocol. This article shows you how to dynamically create an Azure Files share for use by multiple pods in an AKS cluster. For static provisioning, see **[Manually create and use a volume with an Azure Files share](https://learn.microsoft.com/en-us/azure/aks/azure-csi-files-storage-provision#statically-provision-a-volume)**.

 Note

Please be aware that Azure File CSI driver only permits the mounting of SMB file shares using key-based (NTLM v2) authentication, and therefore does not support the maximum security profile of Azure File share settings. On the other hand, mounting NFS file shares does not require key-based authentication.

With Azure Files shares, there is no limit as to how many can be mounted on a node.

For more information on Kubernetes volumes, see **[Storage options for applications in AKS](https://learn.microsoft.com/en-us/azure/aks/concepts-storage)**.

## Dynamically create Azure Files PVs by using the built-in storage classes

A storage class is used to define how an Azure file share is created. A storage account is automatically created in the **[node resource group](https://learn.microsoft.com/en-us/azure/aks/faq)** for use with the storage class to hold the Azure files share. Choose one of the following **[Azure storage redundancy SKUs](https://learn.microsoft.com/en-us/azure/storage/common/storage-redundancy)** for skuName:

- Standard_LRS: Standard locally redundant storage
- Standard_GRS: Standard geo-redundant storage
- Standard_ZRS: Standard zone-redundant storage
- Standard_RAGRS: Standard read-access geo-redundant storage
- Standard_RAGZRS: Standard read-access geo-zone-redundant storage
- Premium_LRS: Premium locally redundant storage
- Premium_ZRS: Premium zone-redundant storage

Note

Azure Files supports Azure Premium file shares. The minimum file share capacity is 100 GiB. We recommend using Azure Premium file shares instead of Standard file shares because Premium file shares offers higher performance, low-latency disk support for I/O-intensive workloads.

When you use storage CSI drivers on AKS, there are two more built-in StorageClasses that uses the Azure Files CSI storage drivers. The other CSI storage classes are created with the cluster alongside the in-tree default storage classes.

- **azurefile-csi:** Uses Azure Standard Storage to create an Azure file share.
- **azurefile-csi-premium:** Uses Azure Premium Storage to create an Azure file share.
The reclaim policy on both storage classes ensures that the underlying Azure files share is deleted when the respective PV is deleted. The storage classes also configure the file shares to be expandable, you just need to edit the persistent volume claim (PVC) with the new size.

To use these storage classes, create a PVC and respective pod that references and uses them. A PVC is used to automatically provision storage based on a storage class. A PVC can use one of the pre-created storage classes or a user-defined storage class to create an Azure files share for the desired SKU and size. When you create a pod definition, the PVC is specified to request the desired storage.

Create an example PVC and pod that prints the current date into an outfile by running the kubectl apply commands:

```bash
kubectl get sc
NAME                    PROVISIONER          RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
azurefile               file.csi.azure.com   Delete          Immediate              true                   66d
azurefile-csi           file.csi.azure.com   Delete          Immediate              true                   66d
azurefile-csi-premium   file.csi.azure.com   Delete          Immediate              true                   66d
azurefile-premium       file.csi.azure.com   Delete          Immediate              true                   66d
default (default)       disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   66d
managed                 disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   66d
managed-csi             disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   66d
managed-csi-premium     disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   66d
managed-premium         disk.csi.azure.com   Delete          WaitForFirstConsumer   true                   66d

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/azurefile-csi-driver/master/deploy/example/pvc-azurefile-csi.yaml
kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/azurefile-csi-driver/master/deploy/example/nginx-pod-azurefile.yaml
```

The output of the command resembles the following example:

```bash
persistentvolumeclaim/pvc-azurefile created
pod/nginx-azurefile created
```

After the pod is in the running state, you can validate that the file share is correctly mounted by running the following command and verifying the output contains the outfile:

```bash
kubectl exec nginx-azurefile -- ls -l /mnt/azurefile
```

The output of the command resembles the following example:

```bash
total 29
-rwxrwxrwx 1 root root 29348 Aug 31 21:59 outfile
```

Create a custom storage class
The default storage classes suit the most common scenarios, but not all. For some cases, you might want to have your own storage class customized with your own parameters. For example, use the following manifest to configure the mountOptions of the file share.

The default value for fileMode and dirMode is 0777 for Kubernetes mounted file shares. You can specify the different mount options on the storage class object.

Create a file named azure-file-sc.yaml, and paste the following example manifest:

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: my-azurefile
provisioner: file.csi.azure.com
reclaimPolicy: Delete
volumeBindingMode: Immediate
allowVolumeExpansion: true
mountOptions:
  - dir_mode=0640
  - file_mode=0640
  - uid=0
  - gid=0
  - mfsymlinks
  - cache=strict # https://linux.die.net/man/8/mount.cifs
  - nosharesock
parameters:
  skuName: Standard_LRS
```

Create the storage class by running the kubectl apply command:

```bash
kubectl apply -f azure-file-sc.yaml
# The output of the command resembles the following example:
storageclass.storage.k8s.io/my-azurefile created
```

The Azure Files CSI driver supports creating snapshots of persistent volumes and the underlying file shares.

Create a volume snapshot class with the kubectl apply command:
