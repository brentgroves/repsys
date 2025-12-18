# Postgres Operator

```bash
# do not delete the operator until the cluster has been deleted
# wait until kubectl get postgresql // shows failed
# try changing the number of instances to 0
kubectl edit postgresql acid-minimal-cluster

kubectl delete deployment postgres-operator 
kubectl describe deployment.apps/postgres-operator
```

```yaml
apiVersion: "acid.zalan.do/v1"
kind: postgresql
metadata:
  name: acid-minimal-cluster
spec:
  teamId: "acid"
  volume:
    size: 20Gi
  numberOfInstances: 2
```