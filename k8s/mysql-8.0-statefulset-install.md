# MySQL 8.0 Server install

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
kubectl delete svc mysql-reports31-svc
kubectl delete statefulset mysql-reports31
kubectl delete pvc mysql-reports31-pvc
# deleting the pvc releases the pv and since the pv has persistentVolumeReclaimPolicy set to Retain it is not deleted
kubectl get pv mysql-reports31-pv
```

## Optionally remove pv,sc and database local storage

If you don't remove the /mnt/data directory then when a new mysql server is created it will use the old database. I deleted the pv and pvc before redeploying the volume.yaml and stateful-set.yaml and all the original database data was retained.

```bash
# set kube context
scc.sh reports3.yaml microk8s
kubectl delete sc mysql-storageclass
kubectl get pv mysql-reports31-pv
ssh brent@reports31
sudo rm -rf /mnt/data
```

## setup database directory to be used as pv

```bash
# make the database and backup directory on node MySQL 8.0 server is installed
ssh brent@reports31
sudo mkdir /mnt/data
sudo chmod 777 /mnt/data
```

## deploy k8s secret

```bash
cd ~/src/k8s/secrets

# remove previous secret
kubectl delete secret db-user-pass

# create secret 
kubectl create secret generic db-user-pass \
  --from-file=username=./username.txt \
  --from-file=password=./password.txt \
  --from-file=username2=./username2.txt \
  --from-file=password2=./password2.txt \
  --from-file=username3=./username3.txt \
  --from-file=password3=./password3.txt \
  --from-file=username4=./username4.txt \
  --from-file=password4=./password4.txt \
  --from-file=username5=./username5.txt \
  --from-file=password5=./password5.txt \
  --from-file=username6=./username6.txt \
  --from-file=password6=./password6.txt \
  --from-file=username7=./username7.txt \
  --from-file=password7=./password7.txt \
  --from-file=username8=./username8.txt \
  --from-file=password8=./password8.txt \
  --from-file=username9=./username9.txt \
  --from-file=password9=./password9.txt \
  --from-file=username10=./username10.txt \
  --from-file=password10=./password10.txt \
  --from-file=username11=./username11.txt \
  --from-file=password11=./password11.txt \
  --from-file=MYSQL_HOST=./reports31.txt \
  --from-file=AZURE_DW=./azure_dw_1.txt
# pick 1 host for cluster
  --from-file=MYSQL_HOST=./reports03.txt \
  --from-file=MYSQL_HOST=./reports13.txt \
  --from-file=MYSQL_HOST=./moto.txt \
  --from-file=MYSQL_PORT=./mysql_port.txt \
# choose if azure dw is to be updated 1 means yes.
  --from-file=AZURE_DW=./azure_dw_1.txt
  --from-file=AZURE_DW=./azure_dw_0.txt

# verify secret
kubectl get secrets
kubectl get secret db-user-pass -o jsonpath='{.data}'
kubectl get secret db-user-pass -o jsonpath='{.data.password}' | base64 --decode
```

## deploy mysql_statefulset

```bash
# from the development system
pushd .
cd ~/src/repsys/k8s/mysql_statefulset
# deploy storage-class
kubectl apply -f mysql-storage-class.yaml
# deploy volume
kubectl apply -f ./volume/output/volume.yaml
kubectl apply -f ./stateful-set/output/stateful-set.yaml
# check pvc
kubectl get pvc
NAME                  STATUS   VOLUME               CAPACITY   ACCESS MODES   STORAGECLASS         AGE
mysql-reports31-pvc   Bound    mysql-reports31-pv   20Gi       RWO            mysql-storageclass   29m
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
kubectl exec statefulset/mysql-reports31 -it -- /bin/bash
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
