# **[Redis Enterprise Install](https://github.com/RedisLabs/redis-enterprise-k8s-docs)**

## references

<https://github.com/RedisLabs/redis-enterprise-k8s-docs>
<https://github.com/RedisLabs/redis-enterprise-k8s-docs#quickstart-guide>
<https://redis.io/docs/latest/operate/kubernetes/>
<https://redis.io/docs/latest/operate/kubernetes/architecture/>

<https://redis.io/docs/latest/operate/kubernetes/deployment/quick-start/>
<https://redis.io/docs/latest/operate/rs/installing-upgrading/>
<https://redis.io/docs/latest/operate/kubernetes/re-clusters/connect-to-admin-console/>

## uninstal redis enterprise operator

```bash
# set namespace
kubectl config set-context --current --namespace=redis-enterprise

# what is created when you deploy the operator bundle
role.rbac.authorization.k8s.io/redis-enterprise-operator created
serviceaccount/redis-enterprise-operator created
rolebinding.rbac.authorization.k8s.io/redis-enterprise-operator created
customresourcedefinition.apiextensions.k8s.io/redisenterpriseclusters.app.redislabs.com configured
customresourcedefinition.apiextensions.k8s.io/redisenterprisedatabases.app.redislabs.com configured
deployment.apps/redis-enterprise-operator created

# does not include everything deployed by the operator bundle
kubectl get all -n redis-enterprise
NAME                                             READY   STATUS    RESTARTS      AGE
pod/my-rec-0                                     2/2     Running   0             18h
pod/my-rec-1                                     2/2     Running   0             18h
pod/redis-enterprise-operator-864cd776d8-wwhft   2/2     Running   1 (16h ago)   18h
pod/my-rec-services-rigger-cd7bdb8b6-fxk7k       1/1     Running   0             10h
pod/my-rec-2                                     2/2     Running   0             10h

NAME                  TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)             AGE
service/admission     ClusterIP   10.152.183.20    <none>        443/TCP             18h
service/my-rec-ui     ClusterIP   10.152.183.148   <none>        8443/TCP            18h
service/my-rec        ClusterIP   10.152.183.254   <none>        9443/TCP,8001/TCP   18h
service/my-rec-prom   ClusterIP   None             <none>        8070/TCP            18h

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/redis-enterprise-operator   1/1     1            1           18h
deployment.apps/my-rec-services-rigger      1/1     1            1           18h

NAME                                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/redis-enterprise-operator-864cd776d8   1         1         1       18h
replicaset.apps/my-rec-services-rigger-cd7bdb8b6       1         1         1       18h

NAME                      READY   AGE
statefulset.apps/my-rec   3/3     18h
(base)  brent@reports-alb  ~/src/repsys/k8s   main ± 

kubectl get deployment redis-enterprise-operator
kubectl get pvc,pv
```

## **[Deploy Redis Enterprise Software for Kubernetes](https://redis.io/docs/latest/operate/kubernetes/deployment/quick-start/)**

How to install Redis Enterprise Software for Kubernetes.

To deploy Redis Enterprise Software for Kubernetes and start your Redis Enterprise cluster (REC), you need to do the following:

- Create a new namespace in your Kubernetes cluster.
- Download the operator bundle.
- Apply the operator bundle and verify it's running.
- Create a Redis Enterprise cluster (REC).

This guide works with most supported Kubernetes distributions. If you're using OpenShift, see Redis Enterprise on OpenShift. For details on what is currently supported, see supported distributions.

## To deploy Redis Enterprise for Kubernetes, you'll need

- a Kubernetes cluster in a supported distribution
- a minimum of three worker nodes
- a Kubernetes client (kubectl)
- access to DockerHub, RedHat Container Catalog, or a private repository that can hold the required images.

## Create a new namespace

Important: Each namespace can only contain one Redis Enterprise cluster. Multiple RECs with different operator versions can coexist on the same Kubernetes cluster, as long as they are in separate namespaces.

Throughout this guide, each command is applied to the namespace in which the Redis Enterprise cluster operates.

```bash
# You can use an existing namespace as long as it does not contain any existing Redis Enterprise cluster resources. It's best practice to create a new namespace to make sure there are no Redis Enterprise resources that could interfere with the deployment.
kubectl create namespace redis-enterprise
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise
```

## Install the operator

Redis Enterprise for Kubernetes bundle is published as a container image. A list of required images is available in the release notes for each version.

The operator **[definition and reference materials](https://github.com/RedisLabs/redis-enterprise-k8s-docs)** are available on GitHub. The operator definitions are packaged as a single generic YAML file.

### Download the operator bundle

```bash
pushd .
cd ~/src/repsys/k8s/redis_enterprise
VERSION=`curl --silent https://api.github.com/repos/RedisLabs/redis-enterprise-k8s-docs/releases/latest | grep tag_name | awk -F'"' '{print $4}'`
echo $VERSION   
v7.4.2-2
```

### Deploy the operator bundle

Apply the operator bundle in your REC namespace:

```bash
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise

kubectl apply -f https://raw.githubusercontent.com/RedisLabs/redis-enterprise-k8s-docs/$VERSION/bundle.yaml
# You should see a result similar to this:

role.rbac.authorization.k8s.io/redis-enterprise-operator created
serviceaccount/redis-enterprise-operator created
rolebinding.rbac.authorization.k8s.io/redis-enterprise-operator created
customresourcedefinition.apiextensions.k8s.io/redisenterpriseclusters.app.redislabs.com configured
customresourcedefinition.apiextensions.k8s.io/redisenterprisedatabases.app.redislabs.com configured
deployment.apps/redis-enterprise-operator created
```

Warning:
DO NOT modify or delete the StatefulSet created during the deployment process. Doing so could destroy your Redis Enterprise cluster (REC).

### Verify the operator is running

Check the operator deployment to verify it's running in your namespace:

```bash
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise
# check rollout of deployment
kubectl rollout status deployment/redis-enterprise-operator
kubectl get deployment redis-enterprise-operator
kubectl get all
```

### Create a Redis Enterprise cluster (REC)

A Redis Enterprise cluster (REC) is created from a RedisEnterpriseCluster custom resource that contains cluster specifications.

This will request a cluster with three Redis Enterprise nodes using the default requests (i.e., 2 CPUs and 4GB of memory per node).

```bash
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise

# This will request a cluster with three Redis Enterprise nodes using the default requests (i.e., 2 CPUs and 4GB of memory per node).
kubectl apply -f ./redis_enterprise/rec.yaml
kubectl get rec
kubectl rollout status sts/my-rec
```

To test with a larger configuration, use the example below to add node resources to the spec section of your test cluster (my-rec.yaml).

```yaml
redisEnterpriseNodeResources:
  limits:
    cpu: 2000m
    memory: 16Gi
  requests:
    cpu: 2000m
    memory: 16Gi
```
