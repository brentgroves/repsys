# **[Redis standalone setup](https://ot-container-kit.github.io/redis-operator/guide/setup.html#redis-standalone)**

![](https://ot-container-kit.github.io/redis-operator/assets/img/redis-standalone.a6152d9b.png)

## references

<https://www.baeldung.com/ops/kubernetes-update-helm-values>
<https://www.baeldung.com/ops/kubernetes-helm#3-helm-install>
<https://ot-container-kit.github.io/redis-operator/guide/setup.html#redis-standalone>

## Uninstall

```bash
kubectl delete redis redis-standalone
helm uninstall redis -n ot-operators
kubectl delete secret redis-secret
```

## password

If we want to use password based authentication inside Redis, we need to create a secret for it. By default the name of the secret is redis-secret and key name is password, but it can be overidden in helm charts.

```bash
kubectl create secret generic redis-secret --from-literal=password=password -n ot-operators

```

In redis standalone mode, we deploy redis as a single Stateful pod which means ease of setup, no complexity, no high availability, and no resilience.

## helm install

```bash
# install and set values from file.
helm upgrade redis ot-helm/redis --install --namespace ot-operators --values values.yaml
# check values 
helm get values -a redis --namespace ot-operators
# set values by --set param
helm upgrade redis ot-helm/redis --set redisStandalone.redisSecret.secretName=redis-secret,redisStandalone.redisSecret.secretKey=password --install --namespace ot-operators
helm get values -a redis --namespace ot-operators

kubectl get secret redis-secret -n ot-operators -o jsonpath='{.data.password}' | base64 --decode
```

Verify the standalone redis setup by kubectl command line.

```bash
kubectl get pods -n ot-operators
NAME                             READY   STATUS    RESTARTS   AGE
redis-operator-c7d844dd4-9rq4v   1/1     Running   0          63m
redis-0                          1/1     Running   0          45s
```

## Failover Testing

Before failover testing, we have to write some dummy data inside the Redis cluster, we can write the dummy data using the redis-cli.

```bash
# get command prompt if password set use -a
kubectl exec -it redis-0 -n ot-operators -- redis-cli -a password
set t2 stark

kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password -c set t2 t2
kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password PING


```
