# **[debug and test pods](https://medium.com/@shambhand2020/create-the-various-debug-or-test-pod-inside-kubernetes-cluster-e4862c767b96)**

## Alpine

```bash
kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
/ # exit
pod "debug" deleted
```

## create a pod with running mssql client

Apply following gist by clicking on view raw and run kubectl apply -f <gist raw file link> -n <namespace> Once deployment created you can exec into pod and run sqlcmd -S <db-host>,1433 -U <username> -P <password> -d <db-name> -Q "SELECT * FROM <table_name>" After your testing or debugging it can be deleted by kubectl delete -f <gist raw file link> -n <namespace>

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

If the above gist did not work — creating pod and exec in did not work then we can follow the instructions for microsoft documentation to install mssql-command line tools:
