# Install MySQL stateful-set

## reference

- **[k8s book](https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7)**
- **[stateful set](https://www.howtoforge.com/create-a-statefulset-in-kubernetes/)**

## remove mysql deployment

```bash
pushd .
cd ~/src/repsys/k8s/mysql_statefulset
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
mkdir -p ~/backups/repsys11/mysql
sudo chmod 777 ~/backups
```

## Make a fresh backup of mysql dw if needed

```bash
mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > /home/brent/backups/reports31/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

```

## Create a StorageClass

StorageClass helps pods provision persistent volume claims on the node.

```bash
ssh ubuntu@k8sn211
# will fail with directory 755 ok
sudo mkdir /mnt/data

pushd .
cd ~/src/repsys/k8s/mysql_statefulset

kubectl get nodes --show-labels

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
service/mysql-svc created
statefulset.apps/mysql created

kubectl describe svc mysql-svc
kubectl describe statefulset mysql

# validation

kubectl exec statefulset/mysql -it -- /bin/bash
mysql -u root -ppassword

## restore datbases from a backup

```bash
# Command 'mysql' not found, but can be installed with:
sudo apt install mysql-client-core-8.0     # version 8.0.41-0ubuntu0.24.04.1
mysql -u root -p -h k8sn211 --port=30031 < ~/src/backups/reports31/mysql/2024-04-09-13:33:19.sql.bak
mysql -u root -p -h k8sn211 --port=30031
# verify
use ETL;
select * from script;

```
