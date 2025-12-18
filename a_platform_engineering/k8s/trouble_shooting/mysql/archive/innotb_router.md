# MySQL InnoDB router

You must have at least one running mysql-router to access the MySQL InnoDB Cluster. Scaling the number of mysql-router instances to zero may result in the MySQL Operator permanently losing communication with the cluster and Keycloak being unable to communicate with MySQL.

```bash
# change the number router instances to 0
kubectl edit innodbcluster mycluster
```

```yaml
apiVersion: mysql.oracle.com/v2
kind: InnoDBCluster
metadata:
  name: mycluster
spec:
  secretName: db-credentials
  tlsUseSelfSigned: true
  instances: 3
  router:
    instances: 1
```