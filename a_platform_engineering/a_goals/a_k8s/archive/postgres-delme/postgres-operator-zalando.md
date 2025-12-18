# Zalando Postgres Operator Helm deployment

## Delete Postgres Cluster and Operator

```bash
# wait until kubectl get postgresql // shows failed
kubectl delete postgresql acid-minimal-cluster

kubectl get deployments
NAME                READY   UP-TO-DATE   AVAILABLE   AGE
postgres-operator   1/1     1            1           28m
kubectl delete deployment postgres-operator 

kubectl delete serviceaccount postgres-operator 
kubectl delete serviceaccount postgres-pod 

kubectl get clusterrole

kubectl delete clusterrole postgres-operator 
kubectl delete clusterrole postgres-pod 

kubectl get clusterrolebinding
kubectl delete clusterrolebinding postgres-operator 

kubectl get svc
kubectl delete svc postgres-operator 

```

## Helm chart

Alternatively, the operator can be installed by using the provided Helm chart which saves you the manual steps. The charts for both the Postgres Operator and its UI are hosted via the gh-pages branch. They only work only with Helm v3. Helm v2 support was dropped with v1.8.0.

```bash
# add repo for postgres-operator
ssh brent@reports51
microk8s helm repo add postgres-operator-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator
"postgres-operator-charts" has been added to your repositories

# install the postgres-operator
microk8s helm install postgres-operator postgres-operator-charts/postgres-operator

NAME: postgres-operator
LAST DEPLOYED: Sat Oct 21 22:49:15 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
To verify that postgres-operator has started, run:

kubectl --namespace=default get pods -l "app.kubernetes.io/name=postgres-operator"
NAME                                 READY   STATUS    RESTARTS   AGE
postgres-operator-74f8877999-4bth4   1/1     Running   0          2m11s

# add repo for postgres-operator-ui
microk8s helm repo add postgres-operator-ui-charts https://opensource.zalando.com/postgres-operator/charts/postgres-operator-ui

"postgres-operator-ui-charts" has been added to your repositories

# install the postgres-operator-ui
microk8s helm install postgres-operator-ui postgres-operator-ui-charts/postgres-operator-ui

NAME: postgres-operator-ui
LAST DEPLOYED: Sat Oct 21 22:52:59 2023
NAMESPACE: default
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
To verify that postgres-operator has started, run:

kubectl --namespace=default get pods -l "app.kubernetes.io/name=postgres-operator-ui"

NAME                                    READY   STATUS    RESTARTS   AGE
postgres-operator-ui-788847ff96-6q6kd   1/1     Running   0          15m

# if you've created the operator using helm chart
kubectl get pod -l app.kubernetes.io/name=postgres-operator
NAME                                 READY   STATUS    RESTARTS   AGE
postgres-operator-74f8877999-4bth4   1/1     Running   0          20m

# create a Postgres cluster
kubectl create -f manifests/minimal-postgres-manifest.yaml
postgresql.acid.zalan.do/acid-minimal-cluster created

# check created database pods
kubectl get pods -l application=spilo -L spilo-role
NAME                     READY   STATUS    RESTARTS   AGE    SPILO-ROLE
acid-minimal-cluster-0   1/1     Running   0          115s   
acid-minimal-cluster-1   1/1     Running   0          106s

kubectl logs acid-minimal-cluster-0 
initdb: removing data directory "/home/postgres/pgdata/pgroot/data"
pg_ctl: database system initialization failed
2023-10-21 23:14:28,658 INFO: removing initialize key after failed attempt to bootstrap the cluster

# check created service resources

```

<https://postgres-operator.readthedocs.io/en/latest/quickstart/>

## Deployment options

The Postgres Operator can be deployed in the following ways:

Manual deployment
Kustomization
Helm chart
Manual deployment setup on Kubernetes
The Postgres Operator can be installed simply by applying yaml manifests. Note, we provide the /manifests directory as an example only; you should consider adjusting the manifests to your K8s environment (e.g. namespaces).

## First, clone the repository and change to the directory

```bash
pushd ~/src/reports/k8s/manifests
git clone https://github.com/zalando/postgres-operator.git
cd postgres-operator

# apply the manifests in the following order

kubectl create -f manifests/configmap.yaml  # configuration
kubectl create -f manifests/operator-service-account-rbac.yaml  # identity and permissions
kubectl create -f manifests/postgres-operator.yaml  # deployment
kubectl create -f manifests/api-service.yaml  # operator API to be used by UI

```
