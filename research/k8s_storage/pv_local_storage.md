# K8s Persistent Volume Local Storage

Persistent volumes has a local path key which allows us to specify a path on mounted on the local host.  It also allows a node affinity key to specify exactly which node is used.  To make sure this persistent volume is used by a pvc a storage class is created and specified in the pvc.

## reference

https://kubernetes.io/docs/tasks/configure-pod-container/configure-persistent-volume-storage/

https://microk8s.io/docs/addon-hostpath-storage

## Differences between MicroK8s hostpath and generic local path storage

- In hostpath storage an admin does not have to create the pv.
- In local path storage an admin creates the pv ahead of time.
- 
## Storage Class

```yaml
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: mysql-storageclass
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
```

## Persistent Volume Claim

```yaml
---
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-rephub11-pvc
spec:
  storageClassName: mysql-storageclass
  accessModes:
    - ReadWriteOnce
  volumeMode: Filesystem
  resources:
    requests:
      storage: 20Gi
```

## PersistentVolume

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  labels:
    type: local
  name: mysql-rephub11-pv
spec:
  accessModes:
  - ReadWriteOnce
  capacity:
    storage: 20Gi
  local:
    path: /mnt/mysql
  nodeAffinity:
    required:
      nodeSelectorTerms:
      - matchExpressions:
        - key: kubernetes.io/hostname
          operator: In
          values:
          - rephub11
  persistentVolumeReclaimPolicy: Retain
  storageClassName: mysql-storageclass
  volumeMode: Filesystem
```