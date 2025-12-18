# **[debug and test pods](https://medium.com/@shambhand2020/create-the-various-debug-or-test-pod-inside-kubernetes-cluster-e4862c767b96)**

![](https://miro.medium.com/v2/resize:fit:640/format:webp/1*rWGb5T0OIcWXZ4buwKSHzQ.png)

For example most of the times we need the following:

- create a debug pod and run curl or telnet or dig.
- create a pod with running postgres sql client.
- create a pod with running mssql client
- create a pod with running mongodb client
- create a pod with running redis-cli

## create a debug pod and run curl or telnet or dig

This is a vey common thing for any k8s cluster admin to create a pod with running curl command and to check the db, network connectivity or test the internal endpoint which is accessible within the cluster only.

## pod with alpine image

```bash
kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh -n <namespace>
```

It will exec into the pod with ssh. Next install curl with ```apk add curl``` and we are good to go. Similarly you can install the telnet with apk update && apk add busybox-extras, nslookup and dig with ```apk update && apk add bind-tools```

It will create a ephemeral pod, as soon as you are done with your debug or test pressing control + D will pods "debug" deleted

## pod with ubuntu or debian image

```kubectl run ubuntu --image=ubuntu:latest --command sleep 604800 -n <namespace>```

It will create ubuntu pod into which you can exec with kubectl exec -it pods/ubuntu -n <namespace> -- sh and run apt update && apt install curl dns-utils && telnet to install curl, nslookup or dig and telnet respectively. As soon as you are done with your debug or test you can delete with kubectl delete pods/ubuntu —n <namespace>

```bash
kubectl exec -it pods/ubuntu -n <namespace> -- sh
apt update && apt install curl dns-utils
kubectl delete pods/ubuntu —n <namespace>
```

## create a pod with running postgres sql client

a. create a postgres client pod with kubectl run

```bash
kubectl run pgsql-client --rm --tty -i --restart='Never' --namespace dev --image docker.io/bitnami/postgresql --env="PGPASSWORD=<password>" --command -- psql  --host <db-host> -U <user> -d <db-name> -p 5432
```

It will enter you into pssql-client console where you can execute the query against selected db or run other postgres-sql command

## create a postgres client pod with deployment

Sometime there may be need to create full fledged k8s deployment this can be done through the below gist. You can also specify nodeName where you want to create the deployment and running for for postgres shell or client.

Click on view raw and run kubectl apply -f <gist raw file link> -n <namespace> once deployment created you can exec into pod and run psql -U <username> -h <db-host> -p 5432 <db-name> After your testing or debugging it can be deleted by kubectl delete -f <gist raw file link> -n <namespace>

```bash
kubectl apply -f <postgres-client.yaml>
kubectl exec -it <postgres-client-pod-name>  -n <namespace> -- sh
psql -U username -h db-host -p 5432 db-name
kubectl delete -f <postgres-client.yaml>
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: postgres-client-deployment
  labels:
    app: postgres-client
spec:
  replicas: 1
  selector:
    matchLabels:
      app: postgres-client
  template:
    metadata:
      labels:
        app: postgres-client
    spec:
      containers:
      - name: postgres-client
        image: docker.io/bitnami/postgresql:latest
        ports:
        - containerPort: 5432
        env:
         - name: POSTGRES_PASSWORD
           value: password
      #nodeName: <name of a node>

### kubectl apply -f <postgres-client.yaml>
### kubectl exec -it <postgres-client-pod-name>  -n <namespace> -- sh
### psql -U username -h db-host -p 5432 db-name
### kubectl delete -f <postgres-client.yaml>
```

## create a pod with running mssql client

Apply following gist by clicking on view raw and run kubectl apply -f <gist raw file link> -n <namespace> Once deployment created you can exec into pod and run sqlcmd -S <db-host>,1433 -U <username> -P <password> -d <db-name> -Q "SELECT * FROM <table_name>" After your testing or debugging it can be deleted by kubectl delete -f <gist raw file link> -n <namespace>

```bash
kubectl exec -it <mssql-client-deployment-pod> -n <namespace> bash

sqlcmd -S <db-host>,1433 -U <username> -P <password> -d <db-name> -Q "SELECT * FROM <table_name>"
```

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: mssql-client-deployment
  labels:
    app: mssql-client
spec:
  replicas: 1
  selector:
    matchLabels:
      app: mssql-client
  template:
    metadata:
      labels:
        app: mssql-client
    spec:
      containers:
      - name: mssql-client
        image: liaisonintl/mssql-server-linux
        ports:
        - containerPort: 1433
        
# kubectl exec -it <mssql-client-deployment-pod> -n <namespace> bash

# sqlcmd -S <db-host>,1433 -U <username> -P <password> -d <db-name> -Q "SELECT * FROM <table_name>"

```

If the above gist did not work — creating pod and exec in did not work then we can follow the instructions for **[microsoft documentation to install mssql-command line tools](https://learn.microsoft.com/en-us/sql/linux/quickstart-install-connect-ubuntu?view=sql-server-ver16&tabs=ubuntu2204#tools)**:

**Create a ubuntu pod**\

```bash
kubectl run ubuntu --image=ubuntu:latest --command sleep 604800 -n <namespace>
```

Install the pre requisite tools into ubuntu contains

```bash
kubectl exec -it pods/ubuntu -n <namespace> - sh
apt update -y && apt install curl -y && apt install sudo -y
```

Then run the instructions from the microsoft documentation for ubuntu

Run the sql query on the exec container shell

```bash
sqlcmd -S <DB_HOST>,<DB_PORT e.g. 1433> -U <DB_USER> -P <password> -C -d messaging -Q "<sql query>";
```
