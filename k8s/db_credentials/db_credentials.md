# **[Deploy K8s db_credentials secret](../../../k8s/repsys/db_credentials.yaml)**

This k8s secret contains all encoded passwords that is needed for repsys. Use ~/cp_from_kingston.sh if necessary to refresh contents of ~/src/k8s/ before deploying the db_credentials.yaml.

```bash
pushd .
cd ~/src/k8s/repsys/
kubectl apply -f db_credentials.yaml
kubectl get secret db-credentials -o jsonpath='{.data.password3}' | base64 --decode
kubectl get secret db-credentials -o jsonpath='{.data.mysql-root-password}' | base64 --decode

popd
```
