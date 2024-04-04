# MySQL 8.0 Server install

This is an alternative to installing the MySQL InnoDB cluster. It uses a simple stateful set and the mayastor storage class. It is appropriate when you must import a legacy database that does not meet the requirement imposed by InnoDB.

## trouble-shooting

Thank you Father for the troubles that help me to learn valuable lessons!

```bash
# make the database and backup directory on reports31
sudo mkdir /mnt/data
sudo chmod 777 /mnt/data
# deploy 
./mysql_statefulset/mysql-storage-class.yaml
Reporting/prod/k8s/mysql-node/volume/output/volume.yaml
Reporting/prod/k8s/mysql-node/stateful-set/output/stateful-set.yaml
mysql -u root -p -h reports31 --port=30031 < ~/backups/reports31/mysql/2023-10-19-17:29:22.sql.bak
```

## reference

<https://livebook.manning.com/book/kubernetes-in-action/chapter-10/7>
<https://www.howtoforge.com/create-a-statefulset-in-kubernetes/>

## Remove previous installations

```bash
pushd .
cd ~/src/repsys/k8s/mysql-mayastor/

# set kube context
scc.sh reports3.yaml mysql

# delete mysql objects
kubectl delete svc mysql-0
kubectl delete svc mysql
kubectl delete statefulset mysql
kubectl delete pvc mysql-store-mysql-0
kubectl delete pv
kubectl get msp -n mayastor
NAME                      NODE        STATUS   CAPACITY      USED         AVAILABLE
microk8s-reports13-pool   reports13   Online   21449670656   5368709120   16080961536
microk8s-reports12-pool   reports12   Online   21449670656   5368709120   16080961536
microk8s-reports11-pool   reports11   Online   21449670656   5368709120   16080961536

# deploy namespace if not already deployed

cd ~/src/repsys/k8s/mysql-mayastor/stateful-set/output
kubectl apply -f namespace.yaml

# deploy secrets

pushd .
cd ~/src/k8s/secrets/lastpass
kubectl apply -f lastpass.yaml
kubectl get secrets -n mysql
kubectl get secret db-user-pass -o jsonpath='{.data.password}' | base64 --decode

pushd ~/src/Reporting/prod/k8s/mysql-mayastor/stateful-set

# can we have both a cluster ip and nodeport service for a stateful set

app=$1
ordinal=$2
node_port=$3
target_port=$4
target_port_name=$5
size=$6
ver=$7
./sed-mysql-stateful-set-make.sh mysql 0 30051 3306 mysql-port 5Gi 8.0
kubectl kustomize overlay > output/stateful-set.yaml

# deploy the stateful-set

cd output
kubectl apply -f stateful-set.yaml
kubectl describe statefulset mysql
kubectl get pods
kubectl apply -f service.yaml
kubectl get svc

mysql -u root -p -hreports31 --port 3306 < ~/backups/reports31/mysql/database/ETL2023-10-19-18:14:46.sql.bak

mysql -u root -p -hreports31 --port 30031
mysql -u root -p -h127.0.0.1 --port 30031


# validation

kubectl exec statefulset/mysql -it -- /bin/bash
mysql -u root -ppassword
mysql -u root -p
mysql -u root -p -h reports31 --port=30031

# restore datbases from a backup

There was a bug fix in the 2 recreate functions on 2/11 so only use backups created after this date
mysql -u root -p -h reports11 --port=30010 < ~/backups/mysql/2023-02-11-18:08:21.sql.bak
mysql -u root -p -h reports51 --port=30051 < ~/backups/mysql/2023-02-11-18:08:21.sql.bak

# backup all databases

mysqldump -u root -p -h reports31 --port=30031 --column-statistics=0 --add-drop-table --routines --all-databases > ~/backups/mysql/$(/bin/date +\%Y-\%m-\%d-\%R:\%S).sql.bak

# configure mysql client from host node

mysql_config_editor print --all
mysql_config_editor set --login-path=client --host=reports11 --port=30011 --user=root --password
