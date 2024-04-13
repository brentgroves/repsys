# Zalando Postgres Operator Helm deployment

## Hugepage issue

This article says it's very important but because of a sys bus error we can not enable hugepages.
<https://www.percona.com/blog/why-linux-hugepages-are-super-important-for-database-servers-a-case-with-postgresql/>
<https://stackoverflow.com/questions/67941955/kubernetes-postgres-bus-error-core-dumped>

Since we cannot use Mayastor and I have not tried rock ceph or minio opted to enable hostpath-storage as the default storage class.

## Delete Postgres Cluster and Operator

<https://postgres-operator.readthedocs.io/en/latest/quickstart/>

```bash

Delete a Postgres cluster
To delete a Postgres cluster simply delete the postgresql custom resource.

kubectl delete postgresql acid-minimal-cluster
This should remove the associated StatefulSet, database Pods, Services and Endpoints. The PersistentVolumes are released and the PodDisruptionBudget is deleted. Secrets however are not deleted and backups will remain in place.

When deleting a cluster while it is still starting up or got stuck during that phase it can happen that the postgresql resource is deleted leaving orphaned components behind. This can cause troubles when creating a new Postgres cluster. For a fresh setup you can delete your local minikube or kind cluster and start again.



# wait until kubectl get postgresql // shows failed
kubectl delete postgresql acid-minimal-cluster

kubectl get deployments
NAME                READY   UP-TO-DATE   AVAILABLE   AGE
postgres-operator   1/1     1            1           28m
kubectl delete deployment postgres-operator 

kubectl get serviceaccount
kubectl delete serviceaccount postgres-operator 
kubectl delete serviceaccount postgres-pod 

kubectl get clusterrole

kubectl delete clusterrole postgres-operator 
kubectl delete clusterrole postgres-pod 

kubectl get clusterrolebinding
kubectl delete clusterrolebinding postgres-operator 

kubectl get svc
kubectl delete svc postgres-operator 
kubectl delete svc acid-minimal-cluster-0-np

kubectl delete svc acid-minimal-cluster        
kubectl delete svc acid-minimal-cluster-repl  
kubectl delete endpoint acid-minimal-cluster-config  

```

<https://postgres-operator.readthedocs.io/en/latest/quickstart/>
<https://github.com/zalando/postgres-operator/blob/master/docs/user.md>

<https://thedatabaseme.de/2022/03/26/backup-to-s3-configure-zalando-postgres-operator-backup-with-wal-g/>
<https://thedatabaseme.de/2022/03/20/i-do-it-on-my-own-then-self-hosted-s3-object-storage-with-minio-and-docker/>

## Deployment options

The Postgres Operator can be deployed in the following ways:

Manual deployment
Kustomization
Helm chart
Manual deployment setup on Kubernetes
The Postgres Operator can be installed simply by applying yaml manifests. Note, we provide the /manifests directory as an example only; you should consider adjusting the manifests to your K8s environment (e.g. namespaces).

## First, clone the repository and change to the directory

```bash
pushd .
cd ~/src/reports/k8s/

## don't do this again just once
git clone https://github.com/zalando/postgres-operator.git

cd ~/src/repsys/k8s/postgres-operator

# apply the manifests in the following order

kubectl create -f manifests/configmap.yaml  # configuration
configmap/postgres-operator created
kubectl create -f manifests/operator-service-account-rbac.yaml  # identity and permissions
serviceaccount/postgres-operator created
clusterrole.rbac.authorization.k8s.io/postgres-operator created
clusterrolebinding.rbac.authorization.k8s.io/postgres-operator created
clusterrole.rbac.authorization.k8s.io/postgres-pod created
kubectl create -f manifests/postgres-operator.yaml  # deployment
deployment.apps/postgres-operator created
kubectl create -f manifests/api-service.yaml  # operator API to be used by UI
kubectl get pod -l name=postgres-operator 
NAME                                READY   STATUS    RESTARTS       AGE
postgres-operator-57f67f997-tcmt6   1/1     Running   1 (2m6s ago)   2m12s
# create a Postgres cluster
kubectl create -f manifests/minimal-postgres-manifest.yaml
kubectl create -f manifests/postgres-5g-manifest.yaml
kubectl create -f manifests/postgres-20g-manifest.yaml

postgresql.acid.zalan.do/acid-minimal-cluster created

# check the deployed cluster
kubectl get postgresql 
NAME                   TEAM   VERSION   PODS   VOLUME   CPU-REQUEST   MEMORY-REQUEST   AGE    STATUS
acid-minimal-cluster   acid   15        2      1Gi                                     2m8s   Running
# I got an error after reinstalling a cluster after deleting a failed cluster creation attempt when hugepages were enabled.
kubectl logs "$(kubectl get pod -l name=postgres-operator --output='name')"
time="2023-10-23T20:29:35Z" level=error msg="could not create cluster: could not create master endpoint: could not create master endpoint: endpoints \"acid-minimal-cluster\" already exists" cluster-name=default/acid-minimal-cluster pkg=controller worker=0


# check created database pods
kubectl get pods -l application=spilo -L spilo-role
acid-minimal-cluster-0   1/1     Running   0          2m35s   master
acid-minimal-cluster-1   1/1     Running   0          118s    replica
# check created service resources
kubectl get svc -l application=spilo -L spilo-role
NAME                          TYPE        CLUSTER-IP      EXTERNAL-IP   PORT(S)    AGE     SPILO-ROLE
acid-minimal-cluster          ClusterIP   10.152.183.62   <none>        5432/TCP   2m54s   master
acid-minimal-cluster-repl     ClusterIP   10.152.183.48   <none>        5432/TCP   2m54s   replica
acid-minimal-cluster-config   ClusterIP   None            <none>        <none>     2m13s 

```

## Connect to the Postgres cluster via psql

<https://access.crunchydata.com/documentation/postgres-operator/5.3>
<https://postgres-operator.readthedocs.io/en/latest/user/#connect-to-postgresql>
<https://github.com/kubernetes/kubectl/issues/1169>
<https://github.com/CrunchyData/postgres-operator/issues/3547>

You can create a port-forward on a database pod to connect to Postgres. See the user guide for instructions. With minikube it's also easy to retrieve the connections string from the K8s service that is pointing to the master pod:

Connect to PostgreSQL
With a port-forward on one of the database pods (e.g. the master) you can connect to the PostgreSQL database from your machine. Use labels to filter for the master pod of our test cluster.

```bash
# get name of master pod of acid-minimal-cluster
export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)
echo $PGMASTER 
acid-minimal-cluster-0

# set up port forward
kubectl port-forward $PGMASTER 6432:5432 -n default

# Open another CLI and connect to the database using e.g. the psql client. When connecting with a manifest role like foo_user user, read its password from the K8s secret which was generated when creating acid-minimal-cluster. As non-encrypted connections are rejected by default set SSL mode to require:

export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)

# secret name format
{username}.{clustername}.credentials.postgresql.acid.zalan.do

export PGSSLMODE=require # for nodeport
export PGSSLMODE=disable # for port forwarding
psql -U postgres -h localhost -p 6432
psql -U postgres -h rephub11 -p 30351
# create database with postgres user
create database zalando;
# create tables and manage database with manifest user
export PGPASSWORD=$(kubectl get secret zalando.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)
psql -U zalando -h localhost -p 6432
psql -U zalando -h rephub11 -p 30351

psql (16.0 (Ubuntu 16.0-1.pgdg22.04+1), server 15.2 (Ubuntu 15.2-1.pgdg22.04+1))
SSL connection (protocol: TLSv1.3, cipher: TLS_AES_256_GCM_SHA384, compression: off)
Type "help" for help.

# some psql commands 
\q # quit - if ssl connection this will cause portwording to end abruptly
\l # list database
\c zalando; # connect database

# some tables to test access to db.
CREATE TABLE cars (
  brand VARCHAR(255),
  model VARCHAR(255),
  year INT
);

INSERT INTO cars (brand, model, year)
VALUES ('Ford', 'Mustang', 1964);

select * from cars;

# connect to database using dbeaver connection string
connecting-to-a-postgresql-database-with-gos-database-sql-package/>

# the rules allow connecting without ssl for 127.0.0.1 only
select * from pg_hba_file_rules();
host      | {all}         | {all}       | 127.0.0.1 | 255.255.255.255                         | md5
# the rules require ssl for all other ips
hostssl   | {all}         | {all}       | all       |                                         | md5

## I don't think dbeaver accepts the password in the connection string because it prompts for it.  Same with ssl

# create nodeport service

cd ~/src/repsys/k8s
kubectl apply -f ./postgres-operator-manifests/nodeport.yaml
service/acid-minimal-cluster-0-np created
kubectl get svc acid-minimal-cluster-0-np -owide         
NAME                        TYPE       CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE   SELECTOR
acid-minimal-cluster-0-np   NodePort   10.152.183.21   <none>        5432:30451/TCP   4s    application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master

export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)

# access from dbeaver
```java
"jdbc:postgresql://reports51/zalando?user=postgres&password=2mcnagDpaJkj3sIsl1wASZPvni8ndzqogofdLzkolNZNM3ibS0u0mZUFNH60a8aT&port=30451&sslmode=require";
- or dbeaver will prompt you for the password.
"jdbc:postgresql://reports51/zalando?user=postgres&port=30451&sslmode=require";

```

## access from psql

```bash
# get name of master pod of acid-minimal-cluster
export PGMASTER=$(kubectl get pods -o jsonpath={.items..metadata.name} -l application=spilo,cluster-name=acid-minimal-cluster,spilo-role=master -n default)

#  hba rules require ssl for connections from non-local sources
select * from pg_hba_file_rules();
export PGSSLMODE=require # for nodeport

export PGPASSWORD=$(kubectl get secret postgres.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)
export PGPASSWORD=$(kubectl get secret zalando.acid-minimal-cluster.credentials.postgresql.acid.zalan.do -o 'jsonpath={.data.password}' | base64 -d)


```

## create schema

<https://www.postgresqltutorial.com/postgresql-administration/postgresql-create-schema/>

```sql
CREATE SCHEMA [IF NOT EXISTS] Plex;
SELECT * 
FROM pg_catalog.pg_namespace
ORDER BY nspname;

```

## create a sample database

<https://www.postgresqltutorial.com/postgresql-getting-started/postgresql-sample-database/>
