# MySQL InnoDB Cluster install

## delete the InnoDB Cluster

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

# check on each node default-datadir-mycluster-2-pvc was deleted
ls -alh /var/snap/microk8s/common/default-storage
kubectl get statefulsets
kubectl get pods
kubectl get svc

kubectl get InnoDBCluster --all-namespaces
```

## Deploy using kubectl

To create an InnoDB Cluster with kubectl, first create a secret containing credentials for a new MySQL root user, a secret named 'mypwds' in this example:

```bash
pushd ~/src/reports/k8s/ 
kubectl create secret generic mypwds \
        --from-literal=rootUser=root \
        --from-literal=rootHost=% \
        --from-literal=rootPassword="password"

secret/mypwds created
# verify this
kubectl get secrets
```

## Configure a new MySQL InnoDB Cluster

Use that newly created user to configure a new MySQL InnoDB Cluster. This example's InnoDBCluster definition creates three MySQL server instances and one MySQL Router instance:

```yaml
apiVersion: mysql.oracle.com/v2
kind: InnoDBCluster
metadata:
  name: mycluster
spec:
  secretName: mypwds
  tlsUseSelfSigned: true
  instances: 3
  router:
    instances: 1
```

```bash
kubectl apply -f ./manifests/mysql-innodb-cluster/mysql-innodb-cluster.yaml
innodbcluster.mysql.oracle.com/mycluster created

kubectl get pvc
kubectl get pods
kubectl get svc
NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)                                                           AGE
kubernetes            ClusterIP   10.152.183.1     <none>        443/TCP                                                           19d
mycluster-instances   ClusterIP   None             <none>        3306/TCP,33060/TCP,33061/TCP                                      2m50s
mycluster             ClusterIP   10.152.183.173   <none>        3306/TCP,33060/TCP,6446/TCP,6448/TCP,6447/TCP,6449/TCP,8443/TCP   2m50s

# optional use this select to create a nodeport svc
kubectl get svc mycluster -o yaml

kubectl get statefulsets

kubectl get innodbcluster
NAME        STATUS   ONLINE   INSTANCES   ROUTERS   AGE
mycluster   ONLINE   3        3           1         4m13s
```

**[Setting PersistentVolumeClaim Size](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-innodbcluster-common.html)**

<!-- Set a MySQL instance's storage configuration. For storing the MySQL Server's Data Directory (datadir), a PersistentVolumeClaim (PVC) is used for each MySQL Server pod. Each PVC follows the naming scheme datadir-{clustername}-[0-9]. A datadirVolumeClaimTemplate template allows setting different options, including size and storage class. For example:

  datadirVolumeClaimTemplate:
    accessModes:
      - ReadWriteOnce
    resources:
      requests:
        storage: 40Gi -->

```bash
kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster --sql
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

## check all mysql instances for change
# this pod won't let you connect but the other 2 will
kubectl --namespace default exec -it mycluster-0 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, fixdatadir (init), initconf (init), initmysql (init)
Error from server: error dialing backend: dial tcp 10.1.0.112:10250: i/o timeout

kubectl --namespace default exec -it mycluster-1 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, initconf (init), initmysql (init)
bash-4.4#

bash-4.4# mysqlsh root@localhost --sql
Please provide the password for 'root@localhost': ******
use mysql;
select * from delme;

\quit
exit

kubectl --namespace default exec -it mycluster-2 -- bash
Defaulted container "sidecar" out of: sidecar, mysql, initconf (init), initmysql (init)
bash-4.4#

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

mysql -h127.0.0.1 --port 3306 -uroot -p

# backup all databases
mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /mnt/qnap_avi/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

mysqldump -u root -p -h 10.1.0.118 --port=31008 --column-statistics=0 --add-drop-table --routines --all-databases > /home/brent/backups/db/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

# restore all the databases
mysql -u root -p -h127.0.0.1 --port 3306 < ~/backups/reports31/mysql/2023-10-03-17:15:33.sql.bak

mysql -u root -p -hreports31 --port 3306 < ~/backups/reports31/mysql/database/ETL2023-10-19-18:14:46.sql.bak

mysql -u root -p -hreports31 --port 3306 < ~/backups/reports31/mysql/2023-10-03-17:15:33.sql.bak

mysql -u root -p -hreports31 --port 30031 < ~/backups/reports31/mysql/2023-10-19-17:29:22.sql.bak

```

## Connecting with a node-port

```bash
# use ClusterIP service yaml to make nodeport svc
# specifically look at the spec selector.

pushd ~/src/reports/k8s/manifests/mysql-innodb-cluster
kubectl get svc mycluster -o yaml

pushd ~/src/reports/k8s

kubectl apply -f ./manifests/mysql-innodb-cluster/nodeport.yaml
```

## Connecting with an ingress

```bash
# use ClusterIP service yaml to make nodeport svc
# specifically look at the spec selector.

pushd ~/src/reports/k8s/manifests/mysql-innodb-cluster
kubectl get svc
mycluster                        ClusterIP   10.152.183.245   <none>        3306/TCP,33060/TCP,6446/TCP,6448/TCP,6447/TCP,6449/TCP,6450/TCP,8443/TCP   70m


## Documentation
https://microk8s.io/docs/addon-ingress
Additionally, the ingress addon can be configured to expose TCP and UDP services by editing the nginx-ingress-tcp-microk8s-conf and nginx-ingress-udp-microk8s-conf ConfigMaps respectively, and then exposing the port in the Ingress controller.


kubectl get svc -n ingress                                                                
NAME      TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
ingress   LoadBalancer   10.152.183.234   10.1.0.110    80:30998/TCP,443:31939/TCP   24h

helm upgrade --install ingress-nginx ingress-nginx   --repo https://kubernetes.github.io/ingress-nginx   --namespace ingress-nginx --create-namespace  \
--set controller.replicaCount=2 \
--set tcp.3306="default/mycluster:3306" 

https://www.percona.com/blog/expose-databases-on-kubernetes-with-ingress
<https://dev.mysql.com/doc/mysql-shell/8.0/en/admin-api-overview.html>

Using MySQL AdminAPI
AdminAPI is provided by MySQL Shell. AdminAPI is accessed through the dba global variable and its associated methods. The dba variable's methods provide the operations which enable you to deploy, configure, and administer InnoDB Cluster, InnoDB ClusterSet, and InnoDB ReplicaSet. For example, use the dba.createCluster() method to create an InnoDB Cluster. In addition, AdminAPI supports administration of some MySQL Router related tasks, such as creating or upgrading a user account that works with InnoDB Cluster, InnoDB ClusterSet, and InnoDB ReplicaSet.

MySQL Shell provides two language modes, JavaScript and Python, in addition to a native SQL mode. Throughout this guide MySQL Shell is used primarily in JavaScript mode. When MySQL Shell starts it is in JavaScript mode by default. Switch modes by issuing \js for JavaScript mode, and \py for Python mode. Ensure you are in JavaScript mode by issuing the \js.

Important
MySQL Shell enables you to connect to servers over a socket connection, but AdminAPI requires TCP connections to a server instance. Socket based connections are not supported in AdminAPI.

This section assumes familiarity with MySQL Shell; see MySQL Shell 8.0 for further information. MySQL Shell also provides online help for the AdminAPI. To list all available dba commands, use the dba.help() method. For online help on a specific method, use the general format object.help('methodname'). For example, using JavaScript:

```js
kubectl run --rm -it myshell --image=container-registry.oracle.com/mysql/community-operator -- mysqlsh root@mycluster --js
password

```

## MySQL InnoDB Cluster

**[MySQL InnoDB Cluster](https://dev.mysql.com/doc/mysql-operator/en/mysql-operator-introduction.html)**
Once an InnoDB Cluster (InnoDBCluster) resource is deployed to the Kubernetes API Server, MySQL Operator for Kubernetes creates resources including:

A Kubernetes StatefulSet for the MySQL Server instances.

This manages the Pods and assigns the corresponding storage Volume. Each Pod managed by this StatefulSet runs multiple containers. Several provide a sequence of initialisation steps for preparing the MySQL Server configuration and data directory, and then two containers remain active for operational mode. One of those containers (named 'mysql') runs the MySQL Server itself, and the other (named 'sidecar') is a Kubernetes sidecar responsible for local management of the node in coordination with the operator itself.

A Kubernetes Deployment for the MySQL Routers.

MySQL Routers are stateless services routing the application to the current Primary or a Replica, depending on the application's choice. The operator can scale the number of routers up or down as required by the Cluster's workload.

A MySQL InnoDB Cluster deployment creates these Kubernetes Services:

One service is the name of the InnoDB Cluster. It serves as primary entry point for an application and sends incoming connections to the MySQL Router. They provide stable name in the form '{clustername}.svc.cluster.local' and expose specific ports.

See also Section 3.4, “MySQL InnoDB Cluster Service Explanation” and Chapter 5, Connecting to MySQL InnoDB Cluster.

A second service named '{clustername}-instances' provides stable names to the individual servers. Typically these should not be directly used; instead use the main service to reliably reach the current primary or secondary as needed. However, for maintenance or monitoring purposes, direct access to an instance might be needed. Each pod instance has MySQL Shell installed.

MySQL Operator for Kubernetes creates and manages additional resources that should not be manually modified, including:

A Kubernetes ConfigMap named '{clustername}-initconf' that contains configuration information for the MySQL Servers.

To modify the generated my.cnf configuration file, see Section 3.3, “Manifest Changes for InnoDBCluster”.

A sequence of Kubernetes Secrets with credentials for different parts of the system; names include '{clustername}.backup', '{clustername.privsecrets}', and '{clustername.router}'.

For a list of MySQL accounts (and associated Secrets) created by the operator, see Section 3.5, “MySQL Accounts Created by InnoDBCluster Deployment”.

**![MySQL Operator Architecture](https://dev.mysql.com/doc/mysql-operator/en/images/mysql-operator-architecture.png)**

## Questions about the MySQL InnoDB Cluster install

1. Will it use the Mayastor default storage class. The MySQL InnoDB Cluster operator would not use the Mayastor storage class.

## My experiences

Once I enabled the observability add-on MicroK8s installed the microk8s-hostpath storage class and set it to default also ignoring the mayastor default storage. Now I have two default storage classes and according to the docs <https://kubernetes.io/docs/concepts/storage/storage-classes/>: "If more than one default StorageClass is accidentally set, the newest default is used when the PVC is dynamically provisioned." I presume the Mayastor storage class was not acceptable to the observability add-on so it enabled and set as default the microk8s-hostpath storage class.

## Install using manifests
