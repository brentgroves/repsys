# **[Deploy SQL Server Linux containers on Kubernetes with StatefulSets](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-kubernetes-best-practices-statefulsets?view=sql-server-ver16)**

**[Current Status](../../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research_list.md)**\
**[Back Main](../../../../../../README.md)**

## references

- **[best practices](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-kubernetes-best-practices-statefulsets?view=sql-server-ver16)**

- **[considerations](https://www.mssqltips.com/sqlservertip/6775/run-sql-server-on-kubernetes/)**

- **[workshop](https://github.com/microsoft/sqlworkshops-sql2019workshop/blob/master/sql2019workshop/07_SQLOnKubernetes.md)**

## **[check mcr for database images](https://mcr.microsoft.com/)**

**[sql server ubuntu images](https://mcr.microsoft.com/en-us/product/mssql/server/tags)**

## **[create a debug pod](https://medium.com/@shambhand2020/create-the-various-debug-or-test-pod-inside-kubernetes-cluster-e4862c767b96)**

```bash
kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
/ # exit
pod "debug" deleted
```

## Kubernetes with StatefulSets

This article contains best practices and guidance for running SQL Server containers on Kubernetes with StatefulSets. We recommend deploying one SQL Server container (instance) per pod in Kubernetes. Thus, you have one SQL Server instance deployed per pod in the Kubernetes cluster.

Similarly, the deployment script recommendation is to deploy one SQL Server instance by setting the replicas value to 1. If you enter a number greater than 1 as the replicas value, you get that many SQL Server instances with corelated names. For example, in the below script, if you assigned the number 2 as the value for replicas, you would deploy two SQL Server pods, with the names mssql-0 and mssql-1 respectively.

Another reason we recommend one SQL Server per deployment script is to allow changes to configuration values, edition, trace flags, and other settings to be made independently for each SQL Server instance deployed.

In the following example, the StatefulSet workload name should match the .spec.template.metadata.labels value, which in this case is mssql. For more information, see StatefulSets.

## Important

The SA_PASSWORD environment variable is deprecated. Use MSSQL_SA_PASSWORD instead.

```yaml
apiVersion: apps/v1
kind: StatefulSet
metadata:
 name: mssql # name of the StatefulSet workload, the SQL Server instance name is derived from this. We suggest to keep this name same as the .spec.template.metadata.labels, .spec.selector.matchLabels and .spec.serviceName to avoid confusion.
spec:
 serviceName: "mssql" # serviceName is the name of the service that governs this StatefulSet. This service must exist before the StatefulSet, and is responsible for the network identity of the set.
 replicas: 1 # only one pod, with one SQL Server instance deployed.
 selector:
  matchLabels:
   app: mssql  # this has to be the same as .spec.template.metadata.labels
 template:
  metadata:
   labels:
    app: mssql # this has to be the same as .spec.selector.matchLabels, as documented [here](https://kubernetes.io/docs/concepts/workloads/controllers/statefulset/):
  spec:
   securityContext:
     fsGroup: 10001
   containers:
   - name: mssql # container name within the pod.
     image: mcr.microsoft.com/mssql/server:2019-latest
     ports:
     - containerPort: 1433
       name: tcpsql
     env:
     - name: ACCEPT_EULA
       value: "Y"
     - name: MSSQL_ENABLE_HADR
       value: "1"
     - name: MSSQL_AGENT_ENABLED
       value: "1"
     - name: MSSQL_SA_PASSWORD
       valueFrom:
         secretKeyRef:
          name: mssql
          key: MSSQL_SA_PASSWORD
     volumeMounts:
     - name: mssql
       mountPath: "/var/opt/mssql"
 volumeClaimTemplates:
   - metadata:
      name: mssql
     spec:
      accessModes:
      - ReadWriteOnce
      resources:
       requests:
        storage: 8Gi
```
