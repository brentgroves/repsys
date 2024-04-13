# MySQL 8.0 Server statefulset install

This is an alternative to installing the MySQL InnoDB cluster. It uses a simple stateful set and the mayastor storage class. It is appropriate when you must import a legacy database that does not meet the requirement imposed by InnoDB.

Note: There is no ClusterIP service only a NodePort. A ClusterIP service shoulld be created so database can be accessed from only pods running in k8s cluster.

## reference

<https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7>
<https://www.howtoforge.com/create-a-statefulset-in-kubernetes/>

## trouble-shooting

Thank you Father for the troubles that help me to learn valuable lessons!

## Remove previous service and statefulset

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/

# set kube context

scc.sh reports3.yaml microk8s
scc.sh rephub1_home.yaml microk8s 

# set environment variables
svc="mysql-reports31-svc"
ss="mysql-reports31"
svc="mysql-rephub11-svc"
ss="mysql-rephub11"

kubectl delete svc $svc
kubectl delete statefulset $ss

```

## Optionally delete pvc, pv, sc, and database local storage

If you don't remove the /mnt/mysql directory then when a new mysql server is created it will retain the old database, passwords, users, etc. I deleted the pv and pvc before redeploying the volume.yaml and stateful-set.yaml and all the original database data was retained.

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/

# set kube context
scc.sh reports3.yaml microk8s
scc.sh rephub1_home.yaml microk8s 

# set environment variables
pvc="mysql-reports31-pvc"
pv="mysql-reports31-pv"
sc="mysql-storageclass"
pvc="mysql-rephub11-pvc"
pv="mysql-rephub11-pv"

kubectl delete pvc $pvc
# deleting the pvc releases the pv and since the pv has persistentVolumeReclaimPolicy set to Retain it is not deleted
kubectl delete pv $pv
kubectl delete sc $sc

node="reports31"
node="rephub11"
ssh brent@$node
sudo rm -rf /mnt/mysql


```

## setup database directory to be used as local pv

```bash
# make the database and backup directory on node MySQL 8.0 server is installed
node="reports31"
node="rephub11"
ssh brent@$node
sudo mkdir /mnt/mysql
sudo chmod 777 /mnt/mysql
exit
```

## deploy db_credentials k8s secret

The secret should have been installed previously **[secret install](./db_credentials/db_credentials.md)**

## deploy mysql_statefulset

## Create a StorageClass

Create a no provisioner StorageClass. This will help link the manually created pv to the pvc.

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/volume
kubectl apply -f mysql-storageclass.yaml
kubectl describe sc mysql-storageclass 
Name:            mysql-storageclass
IsDefaultClass:  No
Annotations:     kubectl.kubernetes.io/last-applied-configuration={"allowVolumeExpansion":true,"apiVersion":"storage.k8s.io/v1","kind":"StorageClass","metadata":{"annotations":{},"name":"mysql-storageclass"},"provisioner":"kubernetes.io/no-provisioner","volumeBindingMode":"WaitForFirstConsumer"}

Provisioner:           kubernetes.io/no-provisioner
Parameters:            <none>
AllowVolumeExpansion:  True
MountOptions:          <none>
ReclaimPolicy:         Delete
VolumeBindingMode:     WaitForFirstConsumer
Events:                <none>
popd
```

```yaml
# probably could add a reclaim policy of retain 
# instead of having to specify it in the pv yaml.
kind: StorageClass
apiVersion: storage.k8s.io/v1
metadata:
  name: mysql-storageclass
provisioner: kubernetes.io/no-provisioner
volumeBindingMode: WaitForFirstConsumer
allowVolumeExpansion: true
```

## create persistent volume and persistent volume claim using sed and kustomization

I used mostly sed to configure the yaml for a particular node but as I learn more about kustomization this may change.

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/volume
./sed-mysql-vol-updates.sh mysql rephub11  
kubectl kustomize ./templates/ | tee ./output/rephub11.yaml 
kubectl apply -f output/rephub11.yaml
kubectl get pvc,pv
popd .
```

## create a statefulset, ClusterIP, and Nodeport service

```bash
# from the development system
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/stateful-set
# configure yaml for cluster
./sed-mysql-stateful-set-updates.sh mysql rephub11 30031 3306 mysql 8.0
kubectl kustomize ./templates/ | tee ./output/rephub11.yaml 

kubectl apply -f output/rephub11.yaml

kubectl describe svc mysql-rephub11-svc
kubectl describe statefulset mysql-rephub11


# check if running
kubectl get all                           
NAME                    READY   STATUS    RESTARTS   AGE
pod/mysql-reports31-0   1/1     Running   0          32m

NAME                          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/kubernetes            ClusterIP   10.152.183.1     <none>        443/TCP          2d
service/mysql-reports31-svc   NodePort    10.152.183.243   <none>        3306:30031/TCP   32m

NAME                               READY   AGE
statefulset.apps/mysql-reports31   1/1     32m

# Optionally import backup data.
mysql -u root -p -h reports31 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak
```

## validate deployment

```bash
# from statefulset
node=rephub31
ss=mysql-reports31
node=rephub11
ss=mysql-rephub11
kubectl exec statefulset/$ss -it -- /bin/bash
mysql -u root -p
# from dev system
mysql -u root -p -h $node --port=30031

```

## restore datbases from a backup

There was a bug fix in the 2 recreate functions on 2/11/2023 and sometime around 2024/01/09 so only use backups created after this date
mysql -u root -p -h reports31 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak

mysql -u root -p -h reports51 --port=30051 < ~/backups/mysql/2023-02-11-18:08:21.sql.bak

## backup all databases

mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > ~/src/backups/reports31/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak
