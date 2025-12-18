# **[Leveraging Redis Sentinel with Bitnami Redis Helm Chart for High Availability in Kubernetes](https://medium.com/@khadkakripu4/leveraging-redis-sentinel-with-bitnami-redis-helm-chart-for-high-availability-in-kubernetes-a25d79e20e69)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

<https://github.com/bitnami/containers/tree/main/bitnami/redis#configuration>
<https://github.com/bitnami/containers/tree/main/bitnami/redis#bitnami-package-for-redis>
<https://github.com/bitnami/charts/blob/main/bitnami/redis/README.md>
<https://medium.com/@khadkakripu4/leveraging-redis-sentinel-with-bitnami-redis-helm-chart-for-high-availability-in-kubernetes-a25d79e20e69>
<https://www.dragonflydb.io/guides/redis-kubernetes>

## Installation of Redis Bitnami Helm Chart

To add the Bitnami Helm chart repository to your local helm configuration, follow these steps:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo ls
```

## To pull the Chart from the remote Chart repository to your local machine, follow these steps

```bash
Navigate to your desired folder using the CLI where you would want the chart to be pulled.
To pull the chart run:
pushd .
cd ~/src/repsys/k8s/redis_sentinel
helm fetch bitnami/redis --untar
```

The command provided will fetch a copy of the Redis Helm chart from the Bitnami repository and untar/extract the chart archive on your local machine. This enables you to make modifications to the Values.yaml file before executing the installation command. By doing this, you can upload the Helm chart to a version control system like GitHub for better management of your charts.

The default configuration in the Redis Helm Chart spins up a 3 Node Master Replica. To ensure a 3 Node or N-node Redis Sentinel Cluster is created in which one node is configured as master and others as real-time replica with Sentinel processes, Update the following configuration in the Values.yaml file available in the local copy of the Helm Chart.

```yaml
replica.replicaCount: N example: 3

sentinel.enabled: true
```

## Create a Namespace or use the default Namespace

```bash
kubectl create namespace redis-sentinel
```

Stay in the root of the Redis Helm chart and Install the Updated Chart in the newly created or existing namespace within the K8s cluster.

```bash
cd ~/src/repsys/k8s/redis_sentinel/redis
# helm install <release-name> ./ -n <namespace>
helm install redis-sentinel ./ -n redis-sentinel
NAME: redis-sentinel
LAST DEPLOYED: Mon Apr 22 15:55:37 2024
NAMESPACE: redis-sentinel
STATUS: deployed
REVISION: 1
TEST SUITE: None
NOTES:
CHART NAME: redis
CHART VERSION: 19.1.2
APP VERSION: 7.2.4

** Please be patient while the chart is being deployed **

Redis&reg; can be accessed on the following DNS names from within your cluster:

    redis-sentinel-master.redis-sentinel.svc.cluster.local for read/write operations (port 6379)
    redis-sentinel-replicas.redis-sentinel.svc.cluster.local for read-only operations (port 6379)



To get your password run:

export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)

To connect to your Redis&reg; server:

1. Run a Redis&reg; pod that you can use as a client:

kubectl run --namespace redis-sentinel redis-client --restart='Never'  --env REDIS_PASSWORD=$REDIS_PASSWORD  --image docker.io/bitnami/redis:7.2.4-debian-12-r12 --command -- sleep infinity
pod/redis-client created

Use the following command to attach to the pod:

kubectl exec --tty -i redis-client \
   --namespace redis-sentinel -- bash

2. Connect using the Redis&reg; CLI:
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-master
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h redis-sentinel-replicas

To connect to your database from outside the cluster execute the following commands:

# https://kubernetes.io/docs/tasks/access-application-cluster/port-forward-access-application-cluster/
kubectl port-forward --namespace redis-sentinel svc/redis-sentinel-master 6379:6379 
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h 127.0.0.1 -p 6379

WARNING: There are "resources" sections in the chart not set. Using "resourcesPreset" is not recommended for production. For production installations, please set the following values according to your workload needs:
  - master.resources
  - replica.resources
+info https://kubernetes.io/docs/concepts/configuration/manage-resources-containers/


```

Now you should have a 3 Node Redis Sentinel Cluster up and running in your k8s cluster. To Verify run:

```bash
kubectl get pods -n redis-sentinel
```

## expose service

```bash
cd ~/src/repsys/k8s/redis_sentinel/
kubectl apply -f redis_sentinel_np.yaml 
export REDIS_PASSWORD=$(kubectl get secret --namespace redis-sentinel redis-sentinel -o jsonpath="{.data.redis-password}" | base64 -d)
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h reports31 -p 30379
```

## connect externally

```bash
REDISCLI_AUTH="$REDIS_PASSWORD" redis-cli -h reports31 -p 30379

```
