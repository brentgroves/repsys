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

### 3 instance microk8s storage path
mysql-innodb-cluster-3-instance-storage-path.yaml
worked well

### 3 instance mayastor storage
mysql-innodb-mayastor-cluster.yaml
2 of the 3 nodes entered CrashLoop.

## Postgres

manifests/postgres-20g-manifest.yaml
Failed with hugepage enabled.

```bash
kubectl logs "$(kubectl get pod -l name=postgres-operator --output='name')"
time="2024-04-12T00:50:21Z" level=error msg="failed to create cluster: pod labels error: still failing after 200 retries" cluster-name=default/acid-minimal-cluster pkg=cluster worker=0
time="2024-04-12T00:50:21Z" level=error msg="could not create cluster: pod labels error: still failing after 200 retries" cluster-name=default/acid-minimal-cluster pkg=controller worker=0

kubectl describe postgresql                        
Name:         acid-minimal-cluster
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  acid.zalan.do/v1
Kind:         postgresql
Metadata:
  Creation Timestamp:  2024-04-12T00:39:04Z
  Generation:          1
  Resource Version:    710082
  UID:                 67b4b327-163c-453d-82eb-379eff8faba6
Spec:
  Databases:
    Foo:                zalando
  Number Of Instances:  2
  Postgresql:
    Version:  15
  Prepared Databases:
    Bar:
  Team Id:  acid
  Users:
    foo_user:
    Zalando:
      superuser
      createdb
  Volume:
    Size:  20Gi
Status:
  Postgres Cluster Status:  CreateFailed
Events:
  Type     Reason  Age   From               Message
  ----     ------  ----  ----               -------
  Warning  Create  19s   postgres-operator  could not create cluster: pod labels error: still failing after 200 retries
```