# rephub1 Cluster

## MySQL 8.0 server stateful set

Did not use Mayastor or Microk8s storage-path dynamic storage instead used the following pv and everything works well.
```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: mysql-rephub11-pvc
spec:
  accessModes:
  - ReadWriteOnce
  resources:
    requests:
      storage: 20Gi
  storageClassName: mysql-storageclass
  volumeMode: Filesystem

```
## MySQL InnoDB Cluster

Created a 3 instance cluster with storageClassName: mayastor and 2 of the 3 nodes entered CrashLoop.
