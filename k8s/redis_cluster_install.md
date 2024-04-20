# **[Redis Cluster setup](https://ot-container-kit.github.io/redis-operator/guide/setup.html#redis-cluster)**

![](https://ot-container-kit.github.io/redis-operator/assets/img/redis-cluster-setup.c1d7206d.png)

A Redis cluster is simply a data sharding strategy (opens new window). It automatically partitions data across multiple Redis nodes. It is an advanced feature of Redis which achieves distributed storage and prevents a single point of failure.

For redis cluster setup we can use same helm command but with different parameters.

## references

<https://github.com/OT-CONTAINER-KIT/helm-charts/blob/main/charts/redis-cluster/README.md>
<https://www.baeldung.com/ops/kubernetes-update-helm-values>
<https://www.baeldung.com/ops/kubernetes-helm#3-helm-install>
<https://github.com/OT-CONTAINER-KIT/helm-charts/blob/main/charts/redis-cluster/values.yaml>
<https://redis.io/learn/operate/redis-at-scale/scalability/redis-cli-with-redis-cluster>

## Uninstall

```bash
kubectl get all -n ot-operators
kubectl delete svc redis-cluster-leader-np -n ot-operators
kubectl delete svc redis-cluster-follower-np -n ot-operators
helm uninstall redis-cluster -n ot-operators
kubectl delete secret credentials -n ot-operators
kubectl get all -n ot-operators

```

## password

If we want to use password based authentication inside Redis, we need to create a secret for it. By default the name of the secret is redis-secret and key name is password, but it can be overidden in helm charts.

```bash
kubectl apply -f ~/src/k8s/repsys/namespaces/ot-operators/credentials.yaml
kubectl get secret credentials -n ot-operators -o jsonpath='{.data.redisPassword}' | base64 --decode
```

## note

When interacting with a redis cluster using redis_cli from outside of the cluster you must be ssh'd into one of the nodes of the k8s cluter. This is because of the redirecting to other nodes that happens because of sharding and hashing that takes place to store keys.

## helm install

```bash
pushd .
cd ~/src/repsys/k8s/
# install and set values from file.
helm upgrade redis-cluster ot-helm/redis-cluster --install --namespace ot-operators --values ./redis_cluster/values.yaml
# helm upgrade redis-cluster ot-helm/redis-cluster --set redisCluster.clusterSize=0, redisCluster.leader.replicas=0,redisCluster.follower.replicas=0 --install --namespace ot-operators

# Verify the cluster by checking the pod status of leader and follower pods.
kubectl get pods -n ot-operators
# If all the pods are in the running state of leader and follower Statefulsets, then we can check the health of the redis cluster by using redis-cli
# Note -c needs to be given for a cluster
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -c -a password cluster nodes

# check values 
helm get values -a redis-cluster --namespace ot-operators
# you can update these values at any time by using the with either the --values or --set param
# helm upgrade redis-cluster ot-helm/redis-cluster --set redisStandalone.redisSecret.secretName=redis-secret,redisStandalone.redisSecret.secretKey=password --install --namespace ot-operators
# helm get values -a redis --namespace ot-operators
popd
```

Verify the redis cluster setup by kubectl command line.

```bash
kubectl get all -n ot-operators
NAME                                 READY   STATUS    RESTARTS   AGE
pod/redis-operator-c7d844dd4-9rq4v   1/1     Running   0          3d
pod/redis-cluster-leader-1           1/1     Running   0          20m
pod/redis-cluster-leader-2           1/1     Running   0          20m
pod/redis-cluster-follower-0         1/1     Running   0          19m
pod/redis-cluster-follower-1         1/1     Running   0          19m
pod/redis-cluster-follower-2         1/1     Running   0          19m
pod/redis-cluster-leader-0           1/1     Running   0          3m11s

```

## Failover Testing

Before failover testing, we have to write some dummy data inside the Redis cluster, we can write the dummy data using the redis-cli.

```bash
# When interacting with a redis cluster using redis_cli from outside of the cluster you must be ssh'd into one of the nodes of the k8s cluter. This is because of the redirecting to other nodes that happens because of sharding and hashing that takes place to store keys.

# Must use the -c parameter when interacting with a redis cluster
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -c -a password
# get/set works when using the -c parameter
127.0.0.1:6379> set tony stark
-> Redirected to slot [14405] located at 10.1.137.228:6379
OK
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -a password -c set tony stark
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -a password -c get tony
# Let’s restart the pod name redis-leader-0 and see the redis node behavior.
kubectl delete pod redis-cluster-leader-0 -n ot-operators
# ISSUE: this took at least a 1/2 to work again.

# Now we can again try to list redis cluster nodes from redis-leader-0 pod and from some other pod as well like:- redis-follower-2
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -a password -c cluster nodes
# So if you notice the output of cluster nodes command, the node IP is updated and it’s connected as a leader.
kubectl exec -it redis-cluster-follower-1 -n ot-operators -- redis-cli -a password -c get tony
(error) CLUSTERDOWN The cluster is down

kubectl exec -it redis-cluster-follower-1 -n ot-operators -- redis-cli -a password -c get tony

# get command prompt if password set use -a
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -c -a password
set tony stark
get tony
set t2 t2
get t2
# get command prompt and authenticate with auth command 
kubectl exec -it redis-0 -n ot-operators -- redis-cli -a password
auth password
set tony stark
get tony
set t2 t2
get t2

kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password -c set t2 t2
kubectl exec -it redis-0 -n ot-operators \
    -- redis-cli -a password PING


```

## **[Exposing Redis](https://ot-container-kit.github.io/redis-operator/guide/exposing-redis.html#exposing-service)**

This article does not say much about nodeport access but if you reference the **[client library docs](https://redis.io/docs/latest/develop/connect/clients/go/)** you can see all the ports that are shown in the connection string to connect to a redis cluster.

```go
// 30000-32767
client := redis.NewClusterClient(&redis.ClusterOptions{
    Addrs: []string{":16379", ":16380", ":16381", ":16382", ":16383", ":16384"},

    // To route commands by latency or randomly, enable one of the following.
    //RouteByLatency: true,
    //RouteRandomly: true,
})

```

Notice also that all the services show the same port 6379

```bash
kubectl get svc -n ot-operators
service/redis-cluster-leader-headless       ClusterIP   None             <none>        6379/TCP         22h
service/redis-cluster-leader                ClusterIP   10.152.183.120   <none>        6379/TCP         22h
service/redis-cluster-leader-additional     ClusterIP   10.152.183.99    <none>        6379/TCP         22h
service/redis-cluster-follower-headless     ClusterIP   None             <none>        6379/TCP         22h
service/redis-cluster-follower              ClusterIP   10.152.183.185   <none>        6379/TCP         22h
service/redis-cluster-follower-additional   ClusterIP   10.152.183.220   <none>        6379/TCP         22h
```

Notice the selector for the redis-cluster-leader

```bash
kubectl describe service/redis-cluster-leader -n ot-operators
Selector:          app.kubernetes.io/component=middleware,app.kubernetes.io/instance=redis-cluster,app.kubernetes.io/managed-by=Helm,app.kubernetes.io/name=redis-cluster,app.kubernetes.io/version=0.15.1,app=redis-cluster-leader,helm.sh/chart=redis-cluster-0.15.11,redis_setup_type=cluster,role=leader
```

Notice which pod the service is setup to select.

```bash
kubectl describe pod redis-cluster-leader-0 -n ot-operators
Labels:           app=redis-cluster-leader
                  app.kubernetes.io/component=middleware
                  app.kubernetes.io/instance=redis-cluster
                  app.kubernetes.io/managed-by=Helm
                  app.kubernetes.io/name=redis-cluster
                  app.kubernetes.io/version=0.15.1
                  apps.kubernetes.io/pod-index=0
                  controller-revision-hash=redis-cluster-leader-b9bcf45f7
                  helm.sh/chart=redis-cluster-0.15.11
                  redis_setup_type=cluster
                  role=leader
```

By default, the nature of Redis standalone/cluster setup is private and limited to the Kubernetes cluster only. But we do have a provision to expose it using the Kubernetes "Service" object. If we can expose the service by doing some configuration inside the helm values for redis standalone and cluster setup. This will create another service in parallel to the internal redis service to expose redis.

The service can be exposed with these service types:-

NodePort: Exposes the Service on each Node's IP at a static port (the NodePort). A ClusterIP Service, to which the NodePort Service routes, is automatically created. You'll be able to contact the NodePort Service, from outside the cluster, by requesting <NodeIP>:<NodePort>.
LoadBalancer: Exposes the Service externally using a cloud provider's load balancer. NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.

```bash
kubectl apply -f ./redis_cluster/nodeport.yaml
```

## **[Connect to Redis](https://redis.io/docs/latest/develop/connect/cli/#host-port-password-and-database)**

```bash
kubectl apply -f ./redis_cluster/nodeport.yaml


redis-cli -c -a password -h reports31 -p 30498 PING
redis-cli -c -a password -h reports31 -p 30498 get tony

redis-cli -c -h reports31 -p 30380 set t2 t2

redis-cli -c set t2 t2
# connect with password
redis-cli -a password -h reports31 -p 30380 PING
# connect no password then auth
redis-cli -h reports31 -p 30380 
redis-cli -c -h reports31 -p 30380 

# https://redis.io/docs/latest/commands/auth/
auth password
set tony stark
get tony
set t2 t2
get t2

# connect and get command prompt
redis-cli -a password -h reports31 -p 30379 

```
