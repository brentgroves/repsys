# **[MySQL InnoDB Cluster install](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster.html)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## from web site

```bash
kubectl create secret generic mypwds \
        --from-literal=rootUser=root \
        --from-literal=rootHost=% \
        --from-literal=rootPassword="sakila"

kubectl apply -f mycluster.yaml
innodbcluster.mysql.oracle.com/mycluster created
Output looks similar to this:

NAME          STATUS    ONLINE   INSTANCES   ROUTERS   AGE
mycluster     PENDING   0        3           1         10s
Until reaching ONLINE status:


NAME        STATUS   ONLINE   INSTANCES   ROUTERS   AGE
mycluster   ONLINE   3        3           1         2m6s

 kubectl get all                  
NAME                                    READY   STATUS    RESTARTS   AGE
pod/mycluster-0                         2/2     Running   0          3m47s
pod/mycluster-1                         2/2     Running   0          3m47s
pod/mycluster-2                         2/2     Running   0          3m47s
pod/mycluster-router-5758d5b8c9-8xvdz   1/1     Running   0          72s
pod/mysql-0                             1/1     Running   4          16d
pod/nginx-5869d7778c-9qpbk              1/1     Running   5          25d

kubectl get innodbcluster --watch
kubectl get innodbcluster        
NAME        STATUS   ONLINE   INSTANCES   ROUTERS   AGE
mycluster   ONLINE   3        3           1         4m44s

```

To demonstrate, this example connects with MySQL Shell to show the host name:

```bash
kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster --sql
If you don't see a command prompt, try pressing enter.
******

MySQL mycluster SQL> SELECT @@hostname;

+-------------+
| @@hostname  |
+-------------+
| mycluster-0 |
+-------------+

## Azure Issue

Could not get the MySQL Operator to install a MySQL InnoDB cluster on Azure.

## mayastor issue

- Installed a 3 instance MySQL InnoDB cluster using mysql-innodb-mayastor-cluster.yaml. It worked until I rebooted then had a problem like on rephub1_home.

tried deleting pods. 1st pod would not terminate after several minutes. So ran kubectl delete InnoDBCluster mycluster and that worked.

After that disable hugepages and unloaded the nvme driver and use microk8s dynamic storagepath from then on.

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
kubectl delete service/mycluster-np
kubectl get InnoDBCluster --all-namespaces
```

Start the load balancer if using Kind

```bash
scc.sh kind.yaml kind-kind
sudo cloud-provider-kind
```

In this install we are using using kubectl not helm.

## install k8s **[credentials secret](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-simple-kubectl.html)**

**[secret install](../../k8s/secrets/install_credentials_secret.md)** into the innodb namespace

## **[Configure a new MySQL InnoDB Cluster](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-common.html)**

This section covers common options defined while setting up a MySQL InnoDB Cluster. For a full list of options, see **[Table 8.1, “Spec table for InnoDBCluster”](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-properties.html#mysql-operator-spec-innodbcluster)**.

**[PVC tutorial](https://bluexp.netapp.com/blog/cvo-blg-kubernetes-persistent-volume-claims-explained)**

Look in **[mysql-innodb-cluster dir](./mysql-innodb-cluster/)** for different config files.

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
scc.sh kind.yaml kind-kind
pushd .
cd ~/src/repsys/k8s
# pick storage class
kubectl get sc

# create namespace to deploy cluster
kubectl create ns innodb
# switch to desired namespace
kubectl config set-context $(kubectl config current-context) --namespace=innodb

# Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

```bash
kubectl label namespace innodb istio-injection=enabled
```

## **[Setting PersistentVolumeClaim Size](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-common.html)**

Set a MySQL instance's storage configuration. For storing the MySQL Server's Data Directory (datadir), a PersistentVolumeClaim (PVC) is used for each MySQL Server pod. Each PVC follows the naming scheme datadir-{clustername}-[0-9]. A datadirVolumeClaimTemplate template allows setting different options, including size and storage class. For example:

```yaml
  datadirVolumeClaimTemplate:
    storageClassName: innodb-retain
    accessModes: 
      - ReadWriteOnce
    resources:
      requests:
        storage: 40Gi
```

For additional configuration information, see the official **[Storage: Persistent Volumes documentation](https://kubernetes.io/docs/concepts/storage/persistent-volumes/)**. The datadirVolumeClaimTemplate object is set to x-kubernetes-preserve-unknown-fields: true.

## Note

MySQL Operator for Kubernetes currently does not support storage resizing.

```bash
pushd .
cd ~/src/repsys/k8s/mysql-innodb-cluster

kubectl get sc                                        
NAME                 PROVISIONER             RECLAIMPOLICY   VOLUMEBINDINGMODE      ALLOWVOLUMEEXPANSION   AGE
standard (default)   rancher.io/local-path   Delete          WaitForFirstConsumer   false                  31d

# install custom storage class
kubectl apply -f custom_storage_classes/kind_retain.yaml

# pick which storage class

kubectl apply -f ./mysql-innodb-cluster-1-instance-storage-path.yaml

kubectl get pvc,pv

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

mysqlsh root@localhost:3306 --sql --password=""
\quit

```

## Connecting with a node-port

<!-- https://stackoverflow.com/questions/62432961/how-to-use-nodeport-with-kind -->
```bash
# use ClusterIP service yaml to make nodeport svc
# specifically look at the spec selector.
pushd .
cd ~/src/repsys/k8s
kubectl get svc mycluster -o yaml

pushd ~/src/reports/k8s

kubectl apply -f ./nodeport.yaml
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
