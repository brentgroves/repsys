# **[MySQL InnoDB Cluster install](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster.html)**

**![MySQL Operator Architecture](https://dev.mysql.com/doc/mysql-operator/en/images/mysql-operator-architecture.png)**

## delete previous InnoDB Cluster

```bash
# Note: If you delete the cluster while its in the pending state you may need to uninstall microk8s completely to get things working again.
kubectl get InnoDBCluster --all-namespaces
NAMESPACE   NAME        STATUS    ONLINE   INSTANCES   ROUTERS   AGE
default     mycluster   PENDING   0        3           1         34m

kubectl delete InnoDBCluster mycluster
innodbcluster.mysql.oracle.com "mycluster" deleted

kubectl delete pvc datadir-mycluster-0
kubectl delete pvc datadir-mycluster-1
kubectl delete pvc datadir-mycluster-2

# If using microk8s host-storage check on each node default-datadir-mycluster-2-pvc was deleted
ls -alh /var/snap/microk8s/common/default-storage
kubectl get statefulsets
kubectl get pods
kubectl get svc

kubectl get InnoDBCluster --all-namespaces
```

In this install we are using using kubectl not helm.

## deploy db_credentials k8s secret

The secret should have been installed previously **[secret install](./db_credentials/db_credentials.md)**

## **[Configure a new MySQL InnoDB Cluster](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-common.html)**

This section covers common options defined while setting up a MySQL InnoDB Cluster. For a full list of options, see **[Table 8.1, “Spec table for InnoDBCluster”](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-properties.html#mysql-operator-spec-innodbcluster)**.

**[PVC tutorial](https://bluexp.netapp.com/blog/cvo-blg-kubernetes-persistent-volume-claims-explained)**

Look in **[mysql-innodb-cluster dir](./mysql-innodb-cluster/mysql-innodb-mayastor-cluster.yaml)** for different config files.

Sample with alot of options:

```yaml
apiVersion: mysql.oracle.com/v2
kind: InnoDBCluster
metadata:
  name: mycluster
spec:
  secretName: mypwds
  tlsUseSelfSigned: true
  instances: 3
  version: 8.3.0
  router:
    instances: 1
    version: 8.3.0
  datadirVolumeClaimTemplate:
    accessModes: 
      - ReadWriteOnce
    resources:
      requests:
        storage: 20Gi
  initDB:
    clone:
      donorUrl: mycluster-0.mycluster-instances.another.svc.cluster.local:3306
      rootUser: root
      secretKeyRef:
        name: mypwds
  mycnf: |
    [mysqld]
    max_connections=162
```

```bash
pushd .
cd ~/src/repsys/k8s
# pick which storage class
## for mayastor
kubectl apply -f ./mysql-innodb-cluster/mysql-innodb-mayastor-cluster.yaml
## for the default dynamic storage
kubectl apply -f ./mysql-innodb-cluster/mysql-innodb-cluster.yaml
innodbcluster.mysql.oracle.com/mycluster created

## check for mayastor
kubectl get pvc
datadir-mycluster-0   Bound    pvc-1a262320-9efc-43f9-9dd1-1d5962effa87   20Gi       RWO            mayastor             18s
datadir-mycluster-2   Bound    pvc-ccb319cc-b559-4cda-814a-145444dfc627   20Gi       RWO            mayastor             18s
datadir-mycluster-1   Bound    pvc-1f720e57-c92a-4b0e-85aa-d785a5af8de5   20Gi       RWO            mayastor             18s
kubectl get diskpool -n mayastor

# Optionally observe the process by watching the innodbcluster type for the default namespace:
kubectl get innodbcluster --watch
NAME        STATUS   ONLINE   INSTANCES   ROUTERS   AGE
mycluster   ONLINE   3        3           1         9m17s

kubectl get pods
kubectl get svc
NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                           AGE
kubernetes            ClusterIP   10.152.183.1     <none>        443/TCP                                                           19d
mycluster-instances   ClusterIP   None             <none>        3306/TCP,33060/TCP,33061/TCP                                      2m50s
mycluster             ClusterIP   10.152.183.173   <none>        3306/TCP,33060/TCP,6446/TCP,6448/TCP,6447/TCP,6449/TCP,8443/TCP   2m50s

kubectl get diskpool -n mayastor

kubectl get statefulsets

kubectl get innodbcluster
NAME        STATUS   ONLINE   INSTANCES   ROUTERS   AGE
mycluster   ONLINE   3        3           1         4m13s
```

To demonstrate, this example connects with MySQL Shell to show the host name:

```bash
kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster --sql
If you don't see a command prompt, try pressing enter.
password

use mysql;
CREATE TABLE delme (
 report_key int NOT NULL,
 name varchar(100) NULL,
 datasource_key varchar(100) null,
 CONSTRAINT PK_report PRIMARY KEY (report_key)
);

insert into delme
values (100,'Trial Balance','dsk1')
,(101,'Daily Metrics','dsk2');

select * from delme;
\quit
```

## check all mysql instances for change

```bash
kubectl --namespace default exec -it mycluster-0 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, fixdatadir (init), initconf (init), initmysql (init)

bash-4.4# mysqlsh root@localhost --sql
Please provide the password for 'root@localhost': ******
use mysql;
select * from delme;

\quit
exit

kubectl --namespace default exec -it mycluster-1 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, initconf (init), initmysql (init)
bash-4.4# mysqlsh root@localhost --sql
Please provide the password for 'root@localhost': ******
use mysql;
select * from delme;

\quit
exit


kubectl --namespace default exec -it mycluster-2 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, initconf (init), initmysql (init)
bash-4.4# mysqlsh root@localhost --sql
Please provide the password for 'root@localhost': ******
use mysql;
select * from delme;

\quit
exit
```

## Connecting with port-forwarding

**[Connecting with port-forwarding](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-connecting-port-forwarding.html)**

```bash
kubectl port-forward service/mycluster 3306

Forwarding from 127.0.0.1:3306 -> 6446
Forwarding from [::1]:3306 -> 6446

```

## Connecting with a node-port

```bash
# use ClusterIP service yaml to make nodeport svc
# specifically look at the spec selector.
pushd .
cd ~/src/repsys/k8s
kubectl get svc mycluster -o yaml

pushd ~/src/reports/k8s

kubectl apply -f ./mysql-innodb-cluster/nodeport.yaml
```

## old method to backup/restore mysql

Can only use this if the mysql database meets the requirement of mysql InnoDB.  I believe this means the tables have to have a primary key.

```bash
mysql -h127.0.0.1 --port 3306 -uroot -p < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak
ERROR 3098 (HY000) at line 1092: The table does not comply with the requirements by an external plugin.

# restore from backup
mysql -u root -p -h reports31 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak

# backup all databases
mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /mnt/qnap_avi/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /home/brent/src/backups/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

# restore all the databases
mysql -u root -p -h127.0.0.1 --port 3306 < ~/src/backups/reports31/mysql/2023-10-03-17:15:33.sql.bak

mysql -u root -p -h reports31 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak

```

## **[Recommended method to backup/restore mysql](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-backups.html)**
