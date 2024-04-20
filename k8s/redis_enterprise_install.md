# **[Redis Enterprise Install](https://github.com/RedisLabs/redis-enterprise-k8s-docs)**

## summary

Everything worked ok until I tried to create a database. The database never became active. I tried to delete the rec with kubectl delete rec my-rec -n redis-enterprise.

<https://redis.io/docs/latest/operate/rs/databases/connect/troubleshooting-guide/>

## **[Licensing](https://redis.io/legal/licenses/)**

## NOTE THE LICENSE EXPIRES IN 1 MONTH

```bash
kubectl get rec
NAME     NODES   VERSION    STATE     SPEC STATUS   LICENSE STATE   SHARDS LIMIT   LICENSE EXPIRATION DATE   AGE
my-rec   3       7.4.2-54   Running   Valid         Valid           4              2024-05-19T23:59:50Z      20h
```

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
kubectl delete rec my-rec
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
# Apply your custom resource file in the same namespace as my-rec.yaml.
kubectl apply -f ./redis_enterprise/rec.yaml
# At this point, the operator will go through the process of creating various services and pod deployments.
kubectl get rec
NAME     NODES   VERSION    STATE     SPEC STATUS   LICENSE STATE   SHARDS LIMIT   LICENSE EXPIRATION DATE   AGE
my-rec   3       7.4.2-54   Running   Valid         Valid           4              2024-05-19T23:59:50Z      20h
# NOTE THE LICENSE EXPIRES IN 1 MONTH
# You can track the progress by examining the StatefulSet associated with the cluster:
kubectl rollout status sts/my-rec
# or by looking at the status of all of the resources in your namespace:
kubectl get all
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

Note:
Each cluster must have at least 3 nodes. Single-node RECs are not supported.
See the **[Redis Enterprise hardware requirements]** for more information on sizing Redis Enterprise node resource requests.

### Enable the admission controller

The admission controller dynamically validates REDB resources configured by the operator. It is strongly recommended that you use the admission controller on your Redis Enterprise Cluster (REC). The admission controller only needs to be configured once per operator deployment.

As part of the REC creation process, the operator stores the admission controller certificate in a Kubernetes secret called admission-tls. You may have to wait a few minutes after creating your REC to see the secret has been created.

1. Verify the admission-tls secret exists.

```bash
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise
kubectl get secret admission-tls
# The output should look similar to
 NAME            TYPE     DATA   AGE
 admission-tls   Opaque   2      2m43s
# Save the certificate to a local environment variable.
CERT=`kubectl get secret admission-tls -o jsonpath='{.data.cert}'`
```

Create a Kubernetes validating webhook, replacing <namespace> with the namespace where the REC was installed.

The webhook.yaml template can be found in **[redis-enterprise-k8s-docs/admission](https://github.com/RedisLabs/redis-enterprise-k8s-docs/tree/master/admission)**

```bash
pushd .
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise

cd ~/src/repsys/k8s/redis_enterprise
sed 's/OPERATOR_NAMESPACE/redis-enterprise/g' webhook.yaml | kubectl create -f -
validatingwebhookconfiguration.admissionregistration.k8s.io/redis-enterprise-admission created
```

Patch the webhook with the certificate.

```bash
pushd .
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise
cd ~/src/repsys/k8s/redis_enterprise
# Replace environment variables in a file with their actual value
eval "echo \"$(cat modified-webhook.yaml)\"" > eval-webhook.yaml
# did this in bash not zsh
kubectl patch ValidatingWebhookConfiguration redis-enterprise-admission --patch "$(cat eval-webhook.yaml)"
validatingwebhookconfiguration.admissionregistration.k8s.io/redis-enterprise-admission patched
```

### Limit the webhook to the relevant namespaces

I did not do this because I'm not sure which namespace.
The operator bundle includes a webhook file. The webhook will intercept requests from all namespaces unless you edit it to target a specific namespace. You can do this by adding the namespaceSelector section to the webhook spec to target a label on the namespace.

Make sure the namespace has a unique namespace-name label.

```bash
Patch the webhook to add the namespaceSelector section.

cat > modified-webhook.yaml <<EOF
webhooks:
- name: redisenterprise.admission.redislabs
  namespaceSelector:
    matchLabels:
      namespace-name: staging
EOF

```

Apply the patch.

```bash

kubectl patch ValidatingWebhookConfiguration \
  redis-enterprise-admission --patch "$(cat modified-webhook.yaml)"
```

## Verify the admission controller is working

Verify the admission controller is installed correctly by applying an invalid resource. This should force the admission controller to correct it.

```bash
kubectl apply -f - << EOF
apiVersion: app.redislabs.com/v1alpha1
kind: RedisEnterpriseDatabase
metadata:
  name: redis-enterprise-database
spec:
  evictionPolicy: illegal
EOF
# You should see your request was denied by the admission webhook "redisenterprise.admission.redislabs".
Error from server: error when creating "STDIN": admission webhook "redisenterprise.admission.redislabs" denied the request: eviction_policy: u'illegal' is not one of [u'volatile-lru', u'volatile-ttl', u'volatile-random', u'allkeys-lru', u'allkeys-random', u'noeviction', u'volatile-lfu', u'allkeys-lfu']
```

## Create a Redis Enterprise Database (REDB)

You can create multiple databases within the same namespace as your REC or in other namespaces.

See **[manage Redis Enterprise databases for Kubernetes](https://redis.io/docs/latest/operate/kubernetes/re-databases/db-controller/)** to create a new REDB.

## Manage Redis Enterprise databases for Kubernetes

This section describes how the database controller provides the ability to create, manage, and use databases via a database custom resource.

## Redis Enterprise database (REDB) lifecycle

A Redis Enterprise database (REDB) is created with a custom resource file. The custom resource defines the size, name, and other specifications for the REDB. The database is created when you apply the custom resource file.

The database controller in Redis Enterprise for Kubernetes:

Discovers the custom resource
Makes sure the REDB is created in the same namespace as the Redis Enterprise cluster (REC)
Maintains consistency between the custom resource and the REDB
The database controller recognizes the new custom resource and validates the specification. If valid, the controller combines the values specified in the custom resource with default values to create a full specification. It then uses this full specification to create the database on the specified Redis Enterprise cluster (REC).

Once the database is created, it is exposed with the same service mechanisms by the service rigger for the Redis Enterprise cluster. If the database custom resource is deleted, the database and its services are deleted from the cluster.

## Create a database

Your Redis Enterprise database custom resource must be of the kind: RedisEnterpriseDatabase and have values for name and memorySize. All other values are optional and will be defaults if not specified.

Create a file (in this example mydb.yaml) that contains your database custom resource.

```yaml
apiVersion: app.redislabs.com/v1alpha1
kind: RedisEnterpriseDatabase
metadata:
  name: mydb
spec:
  memorySize: 1GB
```

To create a REDB in a different namespace from your REC, you need to specify the cluster with redisEnterpriseCluster in the spec section of your RedisEnterpriseDatabase custom resource.

```yaml
redisEnterpriseCluster:
  name: rec
```

Apply the file in the namespace you want your database to be in.

```bash
pushd .
# Change the namespace context to make the newly created namespace default for future commands.
kubectl config set-context --current --namespace=redis-enterprise
cd ~/src/repsys/k8s/redis_enterprise
kubectl apply -f mydb.yaml
redisenterprisedatabase.app.redislabs.com/mydb created
# Check the status of your database.
kubectl get redb mydb -o jsonpath="{.status.status}"
# When the status is active, the database is ready to use.
```

### Modify a database

The custom resource defines the properties of the database. To change the database, you can edit your original specification and apply the change or use kubectl edit.

To modify the database:

Edit the definition:

```bash
kubectl edit redb mydb
Change the specification (only properties in spec section) and save the changes.
For more details, see RedisEnterpriseDatabaseSpec or Options for Redis Enterprise databases.

Monitor the status to see when the changes take effect:

kubectl get redb mydb -o jsonpath="{.status.status}"
When the status is active, the database is ready for use.
```

### Delete a database

The database exists as long as the custom resource exists. If you delete the custom resource, the database controller deletes the database. The database controller removes the database and its services from the cluster.

To delete a database, run:

```bash
kubectl delete redb mydb
```
