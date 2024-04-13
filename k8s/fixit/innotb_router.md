# MySQL InnoDB router

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