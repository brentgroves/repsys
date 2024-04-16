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
kubectl get all -n ot-operators
NAME                             READY   STATUS    RESTARTS   AGE
pod/redis-operator-c7d844dd4-9rq4v   1/1     Running   0          23h
pod/redis-0                          1/1     Running   0          20h

NAME                       TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
service/webhook-service    ClusterIP   10.152.183.98    <none>        443/TCP    23h
service/redis-headless     ClusterIP   None             <none>        6379/TCP   20h
service/redis              ClusterIP   10.152.183.148   <none>        6379/TCP   20h
service/redis-additional   ClusterIP   10.152.183.221   <none>        6379/TCP   20h

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-operator   1/1     1            1           23h

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-operator-c7d844dd4   1         1         1       23h

NAME                     READY   AGE
statefulset.apps/redis   1/1     20h
```

## Failover Testing

Before failover testing, we have to write some dummy data inside the Redis cluster, we can write the dummy data using the redis-cli.

## Issue

Ran the following after install and it worked fine, but ran it the next day and the first couple of set command returned nil. I could not see any errors with kubectl get all -n ot-opererators command then the 3rd or 4th time I ran kubectl exec the sets started working again.

```bash
# get command prompt if password set use -a
kubectl exec -it redis-0 -n ot-operators -- redis-cli -a password
set tony stark
set t2 t2
kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password -c set t2 t2
kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password PING


```

# **[Exposing Redis](https://ot-container-kit.github.io/redis-operator/guide/exposing-redis.html#exposing-service)**

By default, the nature of Redis standalone/cluster setup is private and limited to the Kubernetes cluster only. But we do have a provision to expose it using the Kubernetes "Service" object. If we can expose the service by doing some configuration inside the helm values for redis standalone and cluster setup. This will create another service in parallel to the internal redis service to expose redis.

The service can be exposed with these service types:-

NodePort: Exposes the Service on each Node's IP at a static port (the NodePort). A ClusterIP Service, to which the NodePort Service routes, is automatically created. You'll be able to contact the NodePort Service, from outside the cluster, by requesting <NodeIP>:<NodePort>.
LoadBalancer: Exposes the Service externally using a cloud provider's load balancer. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.

```bash
kubectl apply -f ./redis_standalone/nodeport.yaml
```

## **[Connect to Redis](https://redis.io/docs/latest/develop/connect/cli/#host-port-password-and-database)**

```bash
kubectl apply -f ./redis_standalone/nodeport.yaml
redis-cli -a password -h reports31 -p 30379 PING
redis-cli -a password -h reports31 -p 30379 

```
