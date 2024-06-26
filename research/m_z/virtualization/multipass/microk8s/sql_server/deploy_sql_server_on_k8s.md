# **[Deploy SQL Server Linux containers on Kubernetes with StatefulSets](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-kubernetes-best-practices-statefulsets?view=sql-server-ver16)**

## references

- **[best practices](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-kubernetes-best-practices-statefulsets?view=sql-server-ver16)**

- **[considerations](https://www.mssqltips.com/sqlservertip/6775/run-sql-server-on-kubernetes/)**

- **[workshop](https://github.com/microsoft/sqlworkshops-sql2019workshop/blob/master/sql2019workshop/07_SQLOnKubernetes.md)**

## **[check mcr for database images](https://mcr.microsoft.com/)**

**[sql server ubuntu images](https://mcr.microsoft.com/en-us/product/mssql/server/tags)**

## **[NEXT - create a debug pod](https://medium.com/@shambhand2020/create-the-various-debug-or-test-pod-inside-kubernetes-cluster-e4862c767b96)**

```bash
kubectl run -it --tty --rm debug --image=alpine --restart=Never -- sh
If you don't see a command prompt, try pressing enter.
/ # exit
pod "debug" deleted
```
