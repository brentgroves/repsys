# MySQL 8.0 Server statefulset install

This is an alternative to installing the MySQL InnoDB cluster. It uses a simple stateful set and the mayastor storage class. It is appropriate when you must import a legacy database that does not meet the requirement imposed by InnoDB.

Note: There is no ClusterIP service only a NodePort. A ClusterIP service shoulld be created so database can be accessed from only pods running in k8s cluster.

## reference

<https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7>
<https://www.howtoforge.com/create-a-statefulset-in-kubernetes/>

## trouble-shooting

Thank you Father for the troubles that help me to learn valuable lessons!

## Remove previous mysql_statefulset installations

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/

# set kube context
scc.sh reports3.yaml microk8s

# delete mysql objects
kubectl delete svc mysql-rephub11-svc
kubectl delete statefulset mysql-rephub11
kubectl delete pvc mysql-rephub11-pvc
# deleting the pvc releases the pv and since the pv has persistentVolumeReclaimPolicy set to Retain it is not deleted
kubectl get pv mysql-rephub31-pv
```

## Optionally remove pv,sc and database local storage

If you don't remove the /mnt/data directory then when a new mysql server is created it will use the old database. I deleted the pv and pvc before redeploying the volume.yaml and stateful-set.yaml and all the original database data was retained.

```bash
# set kube context
scc.sh reports3.yaml microk8s
kubectl delete sc mysql-storageclass
kubectl get pv mysql-reports31-pv
ssh brent@reports31

```

## setup database directory to be used as pv

```bash
# make the database and backup directory on node MySQL 8.0 server is installed
ssh brent@reports31
sudo mkdir /mnt/mysql
sudo chmod 777 /mnt/mysql
```

## deploy k8s secret

The secret should have been installed previously **[secret install](../../k8s/secrets/create-k8s-secrets.md)**
## deploy mysql_statefulset

# Create a StorageClass

StorageClass helps pods provision persistent volume claims on the node.

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/volume
kubectl apply -f mysql-storage-class.yaml
kubectl get storageclass
popd
```

# create persistent volume and persistent volume claim using sed and kustomization

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/volume
./sed-mysql-vol-updates.sh mysql rephub11  
kubectl kustomize ./templates/ | tee ./output/rephub11.yaml 
kubectl apply -f output/rephub11.yaml

popd .
```

# create a statefulset, ClusterIP, and Nodeport service
```bash
# from the development system
pushd .
cd ~/src/repsys/k8s/mysql_statefulset/stateful-set
# configure yaml for cluster
./sed-mysql-stateful-set-updates.sh mysql rephub11 30031 3306 mysql 8.0
kubectl kustomize ./templates/ | tee ./output/rephub11.yaml 

kubectl apply -f output/rephub11.yaml
kubectl apply -f output/test.yaml

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
mysql -u root -p -h reports31 --port=30031 < ~/backups/reports31/mysql/2023-10-19-17:29:22.sql.bak
```

## validate deployment

```bash
# from statefulset
kubectl exec statefulset/mysql-rephub11 -it -- /bin/bash
mysql -u root -p
# from dev system
mysql -u root -p -h reports31 --port=30031
```

## restore datbases from a backup

There was a bug fix in the 2 recreate functions on 2/11 so only use backups created after this date
mysql -u root -p -h reports11 --port=30010 < ~/backups/mysql/2023-02-11-18:08:21.sql.bak
mysql -u root -p -h reports51 --port=30051 < ~/backups/mysql/2023-02-11-18:08:21.sql.bak

## backup all databases

mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > ~/backups/reports31/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak
