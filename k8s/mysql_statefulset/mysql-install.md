# Install MySQL stateful-set

## reference

- **[k8s book](https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7)**
- **[stateful set](https://www.howtoforge.com/create-a-statefulset-in-kubernetes/)**

## remove mysql deployment

```bash
scc.sh repsys11c2n1.yaml microk8s
kubectl delete svc mysql-svc
kubectl delete statefulset mysql-ss
kubectl delete pvc mysql-pvc
kubectl delete pv mysql-pv
```

## login to k8s node to install mysql

```bash
ssh brent@repsys11
multipass shell repsys-c2-n1
```

## make the backup directory if needed

```bash
ssh brent@reports-alb
mkdir ~/backups/reports31/mysql
sudo chmod 777 ~/backups
```

## ftp a current dw backup if desired

```bash
lftp brent@alb-ubu
mirror -c /home/brent/backups /home/brent/backups
mirror -c server/source_dir client/target_dir
exit
```

## Make a fresh backup of mysql dw if needed

```bash
mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > /home/brent/backups/reports31/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak
```

## Create a StorageClass

StorageClass helps pods provision persistent volume claims on the node.

```bash
kubectl apply -f mysql-storage-class.yaml
kubectl get storageclass
```

## create persistent volume and persistent volume claim using sed and kustomization

```bash
cd  ~/src/repsys/k8s/mysql_statefulset
cat volume.yaml
# https://medium.com/@bingorabbit/mux-propagate-to-all-panes-9d2bfb969f01 
# create persistent volume
kubectl apply -f volume.yaml
kubectl describe pv mysql-pv
kubectl describe pvc mysql-pvc

# deploy the stateful-set

cd  ~/src/repsys/k8s/mysql_statefulset
kubectl apply -f stateful-set.yaml
statefulset.apps/mysql-repsys11-c2-n1 created

kubectl describe svc mysql-svc
kubectl describe statefulset mysql-ss

# validation

kubectl exec statefulset/mysql -it -- /bin/bash
mysql -u root -ppassword

## restore datbases from a backup

```bash
mysql -u root -p -h repsys11_c2_n1 --port=30031 < ~/backups/reports31/mysql/2024-07-16-17:57:41.sql.bak
```

mysql -u root -p -h reports11 --port=30011 < ~/backups/db/2022-10-18-06:10:01.sql.bak

mysql -u root -p -h reports31 --port=30031 < ~/backups/db/2022-10-18-06:10:01.sql.bak

mysql -u root -p -h reports12 --port=31009 < ~/backups/db/2022-10-18-06:10:01.sql.bak

mysql -u root -p -h alb-ubu --port=30101 < ~/backups/db/2022-10-18-06:10:01.sql.bak

mysql -u root -p -h avi-ubu --port=30102 < ~/backups/db/2022-10-18-06:10:01.sql.bak

mysql -u root -p -h frt-ubu --port=30103 < ~/backups/db/2022-10-18-06:10:01.sql.bak
