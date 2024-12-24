# **[Storage classes](https://learn.microsoft.com/en-us/azure/aks/azure-disk-csi)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

To specify different tiers of storage, such as premium or standard, you can create a storage class.

A storage class also defines a reclaim policy. When you delete the persistent volume, the reclaim policy controls the behavior of the underlying Azure Storage resource. The underlying resource can either be deleted or kept for use with a future pod.

For clusters using Azure Container Storage, you'll see an additional storage class called acstor-<storage-pool-name>. An internal storage class is also created.

For clusters using **[Container Storage Interface (CSI) drivers](https://learn.microsoft.com/en-us/azure/aks/csi-storage-drivers)**, the following extra storage classes are created:

| Storage class          | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           |
|------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| managed-csi            | Uses Azure Standard SSD locally redundant storage (LRS) to create a managed disk. The reclaim policy ensures that the underlying Azure Disk is deleted when the persistent volume that used it is deleted. The storage class also configures the persistent volumes to be expandable. You can edit the persistent volume claim to specify the new size. Effective starting with Kubernetes version 1.29, in Azure Kubernetes Service (AKS) clusters deployed across multiple availability zones, this storage class utilizes Azure Standard SSD zone-redundant storage (ZRS) to create managed disks. |
| managed-csi-premium    | Uses Azure Premium locally redundant storage (LRS) to create a managed disk. The reclaim policy again ensures that the underlying Azure Disk is deleted when the persistent volume that used it is deleted. Similarly, this storage class allows for persistent volumes to be expanded. Effective starting with Kubernetes version 1.29, in Azure Kubernetes Service (AKS) clusters deployed across multiple availability zones, this storage class utilizes Azure Premium zone-redundant storage (ZRS) to create managed disks.                                                                      |
| azurefile-csi          | Uses Azure Standard storage to create an Azure file share. The reclaim policy ensures that the underlying Azure file share is deleted when the persistent volume that used it is deleted.                                                                                                                                                                                                                                                                                                                                                                                                             |
| azurefile-csi-premium  | Uses Azure Premium storage to create an Azure file share. The reclaim policy ensures that the underlying Azure file share is deleted when the persistent volume that used it is deleted.                                                                                                                                                                                                                                                                                                                                                                                                              |
| azureblob-nfs-premium  | Uses Azure Premium storage to create an Azure Blob storage container and connect using the NFS v3 protocol. The reclaim policy ensures that the underlying Azure Blob storage container is deleted when the persistent volume that used it is deleted.                                                                                                                                                                                                                                                                                                                                                |
| azureblob-fuse-premium | Uses Azure Premium storage to create an Azure Blob storage container and connect using BlobFuse. The reclaim policy ensures that the underlying Azure Blob storage container is deleted when the persistent volume that used it is deleted.                                                                                                                                                                                                                                                                                                                                                           |

Unless you specify a storage class for a persistent volume, the default storage class is used. Ensure volumes use the appropriate storage you need when requesting persistent volumes.

## Important

Starting with Kubernetes version 1.21, AKS uses CSI drivers by default, and CSI migration is enabled. While existing in-tree persistent volumes continue to function, starting with version 1.26, AKS will no longer support volumes created using in-tree driver and storage provisioned for files and disk.

The default class will be the same as managed-csi.

Effective starting with Kubernetes version 1.29, when you deploy Azure Kubernetes Service (AKS) clusters across multiple availability zones, AKS now utilizes zone-redundant storage (ZRS) to create managed disks within built-in storage classes. ZRS ensures synchronous replication of your Azure managed disks across multiple Azure availability zones in your chosen region. This redundancy strategy enhances the resilience of your applications and safeguards your data against datacenter failures.

However, it's important to note that zone-redundant storage (ZRS) comes at a higher cost compared to locally redundant storage (LRS). If cost optimization is a priority, you can create a new storage class with the skuname parameter set to LRS. You can then use the new storage class in your Persistent Volume Claim (PVC).

You can create a storage class for other needs using kubectl. The following example uses premium managed disks and specifies that the underlying Azure Disk should be retained when you delete the pod:

```yaml
apiVersion: storage.k8s.io/v1
kind: StorageClass
metadata:
  name: managed-premium-retain
provisioner: disk.csi.azure.com
parameters:
  skuName: Premium_ZRS
reclaimPolicy: Retain
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
```

AKS reconciles the default storage classes and will overwrite any changes you make to those storage classes.

For more information about storage classes, see StorageClass in Kubernetes.

## Persistent volume claims

A persistent volume claim (PVC) requests storage of a particular storage class, access mode, and size. The Kubernetes API server can dynamically provision the underlying Azure Storage resource if no existing resource can fulfill the claim based on the defined storage class.

The pod definition includes the volume mount once the volume has been connected to the pod.

![pvc](https://learn.microsoft.com/en-us/azure/aks/media/concepts-storage/aks-storage-persistent-volume-claim.png)

Once an available storage resource has been assigned to the pod requesting storage, the persistent volume is bound to a persistent volume claim. Persistent volumes are mapped to claims in a 1:1 mapping.

The following example YAML manifest shows a persistent volume claim that uses the managed-premium storage class and requests an Azure Disk that is 5Gi in size:

```bash
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: azure-managed-disk
spec:
  accessModes:
  - ReadWriteOnce
  storageClassName: managed-premium-retain
  resources:
    requests:
      storage: 5Gi
```

When you create a pod definition, you also specify:

- The persistent volume claim to request the desired storage.
- The volume mount for your applications to read and write data.

The following example YAML manifest shows how the previous persistent volume claim can be used to mount a volume at /mnt/azure:

```yaml
kind: Pod
apiVersion: v1
metadata:
  name: nginx
spec:
  containers:
    - name: myfrontend
      image: mcr.microsoft.com/oss/nginx/nginx:1.15.5-alpine
      volumeMounts:
      - mountPath: "/mnt/azure"
        name: volume
  volumes:
    - name: volume
      persistentVolumeClaim:
        claimName: azure-managed-disk
```

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
```
