# **[Redis Cluster setup](https://ot-container-kit.github.io/redis-operator/guide/setup.html#redis-cluster)**

![](https://ot-container-kit.github.io/redis-operator/assets/img/redis-cluster-setup.c1d7206d.png)

A Redis cluster is simply a data sharding strategy (opens new window). It automatically partitions data across multiple Redis nodes. It is an advanced feature of Redis which achieves distributed storage and prevents a single point of failure.

For redis cluster setup we can use same helm command but with different parameters.

## references

<https://www.baeldung.com/ops/kubernetes-update-helm-values>
<https://www.baeldung.com/ops/kubernetes-helm#3-helm-install>
<https://github.com/OT-CONTAINER-KIT/helm-charts/blob/main/charts/redis-cluster/values.yaml>

## Uninstall

```bash
kubectl get all -n ot-operators
kubectl delete svc redis-cluster-np -n ot-operators
helm uninstall redis -n ot-operators
kubectl delete secret redis-secret
kubectl get all -n ot-operators

```

## password

If we want to use password based authentication inside Redis, we need to create a secret for it. By default the name of the secret is redis-secret and key name is password, but it can be overidden in helm charts.

```bash
# kubectl create secret generic credentials --from-literal=password=password -n ot-operators
kubectl apply -f ~/src/k8s/repsys/namespaces/ot-operators/credentials.yaml
kubectl get secret credentials -n ot-operators -o jsonpath='{.data.redisPassword}' | base64 --decode
kubectl get secret redis-secret -n ot-operators -o jsonpath='{.data.password}' | base64 --decode

```

In redis standalone mode, we deploy redis as a single Stateful pod which means ease of setup, no complexity, no high availability, and no resilience.

## helm install

```bash
pushd .
cd ~/src/repsys/k8s/
helm upgrade redis-cluster ot-helm/redis-cluster \
  --set redisCluster.clusterSize=3 --install --namespace ot-operators

# Verify the cluster by checking the pod status of leader and follower pods.
kubectl get pods -n ot-operators
# If all the pods are in the running state of leader and follower Statefulsets, then we can check the health of the redis cluster by using redis-cli
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli cluster nodes
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -a Opstree@1234 cluster nodes

# install and set values from file.
helm upgrade redis ot-helm/redis --install --namespace ot-operators --values ./redis_standalone/values.yaml
# check values 
helm get values -a redis --namespace ot-operators
# set values by --set param
# helm upgrade redis ot-helm/redis --set redisStandalone.redisSecret.secretName=redis-secret,redisStandalone.redisSecret.secretKey=password --install --namespace ot-operators
# helm get values -a redis --namespace ot-operators
popd
```

Verify the standalone redis setup by kubectl command line.

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

NAME                                        TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/webhook-service                     ClusterIP   10.152.183.98    <none>        443/TCP          3d
service/redis-cluster-leader-headless       ClusterIP   None             <none>        6379/TCP         20m
service/redis-cluster-leader                ClusterIP   10.152.183.120   <none>        6379/TCP         20m
service/redis-cluster-leader-additional     ClusterIP   10.152.183.99    <none>        6379/TCP         20m
service/redis-cluster-follower-headless     ClusterIP   None             <none>        6379/TCP         19m
service/redis-cluster-follower              ClusterIP   10.152.183.185   <none>        6379/TCP         19m
service/redis-cluster-follower-additional   ClusterIP   10.152.183.220   <none>        6379/TCP         19m

NAME                             READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-operator   1/1     1            1           3d

NAME                                       DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-operator-c7d844dd4   1         1         1       3d

NAME                                      READY   AGE
statefulset.apps/redis-cluster-follower   3/3     19m
statefulset.apps/redis-cluster-leader     3/3     20m```

## Failover Testing

Before failover testing, we have to write some dummy data inside the Redis cluster, we can write the dummy data using the redis-cli.

## Issue

Ran the following after install and it worked fine, but ran it the next day and the first couple of set command returned nil. I could not see any errors with kubectl get all -n ot-opererators command then the 3rd or 4th time I ran kubectl exec the sets started working again.

```bash
# https://redis.io/docs/latest/operate/oss_and_stack/management/scaling/#interact-with-the-cluster
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -c
# always get an error when running interactively
127.0.0.1:6379> set tony stark
(error) MOVED 14405 10.1.137.224:6379
# get/set works when using the -c parameter
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -c set tony stark
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli -c get tony
# Let’s restart the pod name redis-leader-0 and see the redis node behavior.
kubectl delete pod redis-cluster-leader-0 -n ot-operators
# Now we can again try to list redis cluster nodes from redis-leader-0 pod and from some other pod as well like:- redis-follower-2
kubectl exec -it redis-cluster-leader-0 -n ot-operators -- redis-cli cluster nodes
# So if you notice the output of cluster nodes command, the node IP is updated and it’s connected as a leader.
kubectl exec -it redis-follower-1 -n ot-operators \
    -- redis-cli -a Opstree@1234 -c get tony
kubectl exec -it redis-cluster-follower-1 -n ot-operators \
    -- redis-cli -c get tony

# get command prompt if password set use -a
kubectl exec -it redis-0 -n ot-operators -- redis-cli -a password
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
redis-cli -h reports31 -p 30380 PING

# connect with password
redis-cli -a password -h reports31 -p 30380 PING
# connect no password then auth
redis-cli -h reports31 -p 30380 
# https://redis.io/docs/latest/commands/auth/
auth password
set tony stark
get tony
set t2 t2
get t2

# connect and get command prompt
redis-cli -a password -h reports31 -p 30379 

```
