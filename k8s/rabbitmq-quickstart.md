# **[RabbitMQ Cluster Kubernetes Operator Quickstart](https://www.rabbitmq.com/kubernetes/operator/quickstart-operator)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[github](https://github.com/rabbitmq/cluster-operator)**
- **[Install](https://www.rabbitmq.com/kubernetes/operator/install-operator)**
- **[Using Kubernetes RabbitMQ Cluster Kubernetes Operator](https://www.rabbitmq.com/kubernetes/operator/using-operator)**
- **[examples](https://github.com/rabbitmq/cluster-operator/blob/main/docs/examples)**

## NEXT - **[Azure AKS Client Secret expired - How to change?](https://stackoverflow.com/questions/53748832/azure-aks-client-secret-expired-how-to-change)**

Right now AKS is not able to update Loadbalancer values or mount persistant storage.

```bash
 Original Error: adal: Refresh request failed. Status Code = '401'. Response body: {"error":"invalid_client","error_description":"AADSTS7000222: The provided client secret keys for app '15cdd566-98bb-4130-8ec5-5c58cffb34bf' are expired. Visit the Azure portal to create new keys for your app: https://aka.ms/NewClientSecret, or consider using certificate credentials for added security: https://aka.ms/certCreds. Trace ID
 ```

AKS client credentials can be updated via command:

```bash
az aks update-credentials \
    --resource-group myResourceGroup \
    --name myAKSCluster \
    --reset-service-principal \
    --service-principal $SP_ID \
    --client-secret $SP_SECRET
```

Official documentation: <https://learn.microsoft.com/en-us/azure/aks/update-credentials#update-aks-cluster-with-new-credentials>

## Delete a RabbitMQ Instance

To delete a RabbitMQ service instance, run
kubectl delete rabbitmqcluster INSTANCE

where INSTANCE is the name of your RabbitmqCluster, or use

```bash
kubectl get rabbitmqclusters.rabbitmq.com
NAME                     ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster-sample   True               True               7d22h

kubectl delete rabbitmqcluster rabbitmqcluster-sample
kubectl delete rabbitmqcluster INSTANCE

# or
kubectl delete -f INSTANCE.yaml
# ie
kubectl delete -f cluster-operator.yml

```

This is the fastest way to get up and running with a RabbitMQ cluster deployed by the Cluster Operator. More detailed resources are available for installation, usage and API reference.

## Note

CPU limits need to be set before I could get this to work. But I only had a 1 node, 2 cpu cluster, with outer pods running so I will try again.

## Prerequisites

Access to a Kubernetes cluster version 1.19 or above
kubectl configured to access the cluster

## **[Resource Limit Note](https://stackoverflow.com/questions/38869673/pod-in-pending-state-due-to-insufficient-cpu)**

Some reading material:

<https://kubernetes.io/docs/tasks/configure-pod-container/assign-cpu-resource/#specify-a-cpu-request-and-a-cpu-limit>

<https://kubernetes.io/docs/tasks/administer-cluster/manage-resources/cpu-default-namespace/#create-a-limitrange-and-a-pod>

<https://kubernetes.io/docs/concepts/configuration/manage-compute-resources-container/#how-pods-with-resource-limits-are-run>

<https://cloud.google.com/blog/products/gcp/kubernetes-best-practices-resource-requests-and-limits>

I recently had this same issue. After some research, I found that GKE has a default LimitRange with CPU requests limit set to 100m.

You can validate this by running ```kubectl get limitrange -o=yaml```. It's going to display something like this:

```yaml
apiVersion: v1
items:
- apiVersion: v1
  kind: LimitRange
  metadata:
    annotations:
      kubectl.kubernetes.io/last-applied-configuration: |
        {"apiVersion":"v1","kind":"LimitRange","metadata":{"annotations":{},"name":"limits","namespace":"default"},"spec":{"limits":[{"defaultRequest":{"cpu":"100m"},"type":"Container"}]}}
    creationTimestamp: 2017-11-16T12:15:40Z
    name: limits
    namespace: default
    resourceVersion: "18741722"
    selfLink: /api/v1/namespaces/default/limitranges/limits
    uid: dcb25a24-cac7-11e7-a3d5-42010a8001b6
  spec:
    limits:
    - defaultRequest:
        cpu: 100m
      type: Container
kind: List
metadata:
  resourceVersion: ""
  selfLink: ""
```

**[Yes](https://www.reddit.com/r/kubernetes/comments/191n7ci/cpu_use_higher_than_requests/)**, when you say request, you're defining what is the minimum CPU that the app will need in order to function, so you're requesting a minimum allocation that cannot be violated (your app is guaranteed requests CPU); not setting a hard limit. If your app makes use of more than that, and there is spare CPU left over after all pods are calculated, then your app is allowed to use that but if another app spins up and takes some away then your app will lose access to the excess capacity.

This is a bit of an over simplification, I admit. But should help you to understand better. I highly recommend the robusta.dev article entitled "For the Love of God, Stop Using CPU Limits on Kubernetes (Updated)", which was

```bash
kubectl describe node
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests      Limits
  --------           --------      ------
  cpu                650m (65%)    300m (30%)
  memory             2618Mi (16%)  2718Mi (17%)
  ephemeral-storage  0 (0%)        0 (0%)
  hugepages-1Gi      0 (0%)        0 (0%)
  hugepages-2Mi      0 (0%)        0 (0%)
Non-terminated Pods:          (8 in total)
  Namespace                   Name                                          CPU Requests  CPU Limits  Memory Requests  Memory Limits  Age
  ---------                   ----                                          ------------  ----------  ---------------  -------------  ---
  default                     mysql-0                                       0 (0%)        0 (0%)      0 (0%)           0 (0%)         42d
  default                     rabbitmqcluster-sample-server-0               100m (10%)    100m (10%)  2Gi (12%)        2Gi (12%)      7d
  default                     test-nginx                                    0 (0%)        0 (0%)      0 (0%)           0 (0%)         7d23h
  kube-system                 calico-kube-controllers-796fb75cc-5pzgd       0 (0%)        0 (0%)      0 (0%)           0 (0%)         48d
  kube-system                 calico-node-s8bsn                             250m (25%)    0 (0%)      0 (0%)           0 (0%)         23h
  kube-system                 coredns-5986966c54-whdsr                      100m (10%)    0 (0%)      70Mi (0%)        170Mi (1%)     48d
  kube-system                 hostpath-provisioner-7c8bdf94b8-nhqc5         0 (0%)        0 (0%)      0 (0%)           0 (0%)         8d
  rabbitmq-system             rabbitmq-cluster-operator-6dcf5746f4-gzl94    200m (20%)    200m (20%)  500Mi (3%)       500Mi (3%)     7d3h


```

## Quickstart Steps

This guide goes through the following steps:

- Install the RabbitMQ Cluster Operator
- Deploy a RabbitMQ Cluster using the Operator
- View RabbitMQ Logs
- Access the RabbitMQ Management UI
- Attach a Workload to the Cluster
- Next Steps

## The kubectl rabbitmq Plugin

Many steps in the quickstart - installing the operator, accessing the Management UI, fetching credentials for the RabbitMQ Cluster, are made easier by the kubectl rabbitmq plugin. While there are instructions to follow along without using the plugin, getting the plugin will make these commands simpler. To install the plugin, look at its **[installation instructions](https://www.rabbitmq.com/kubernetes/operator/install-operator)**.

For extensive documentation on the plugin see the **[kubectl Plugin guide](https://www.rabbitmq.com/kubernetes/operator/kubectl-plugin)**.

## Install the RabbitMQ Cluster Operator

Let's start by installing the latest version of the Cluster Operator. This can be done directly using kubectl apply:

```bash
pushd
cd ~/src/repsys/k8s/rabbitmq
scc.sh reports-aks-user.yaml reports-aks
set-cluster-context cluster: reports-aks-user.yaml
set-cluster-context context: reports-aks
Switched to context "reports-aks".

kubectl apply -f "https://github.com/rabbitmq/cluster-operator/releases/latest/download/cluster-operator.yml"
namespace/rabbitmq-system created
customresourcedefinition.apiextensions.k8s.io/rabbitmqclusters.rabbitmq.com created
serviceaccount/rabbitmq-cluster-operator created
role.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-role created
clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-operator-role created
clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-service-binding-role created
rolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-rolebinding created
clusterrolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-operator-rolebinding created
deployment.apps/rabbitmq-cluster-operator created

# or you can download it first
curl -L -O https://github.com/rabbitmq/cluster-operator/releases/download/v2.9.0/cluster-operator.yml
kubectl apply -f cluster-operator.yml
# namespace/rabbitmq-system created
# customresourcedefinition.apiextensions.k8s.io/rabbitmqclusters.rabbitmq.com created
# serviceaccount/rabbitmq-cluster-operator created
# role.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-role created
# clusterrole.rbac.authorization.k8s.io/rabbitmq-cluster-operator-role created
# rolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-leader-election-rolebinding created
# clusterrolebinding.rbac.authorization.k8s.io/rabbitmq-cluster-operator-rolebinding created
# deployment.apps/rabbitmq-cluster-operator created
```

The Cluster Operator can also be installed using the kubectl rabbitmq plugin:
Note: Have not used this plugin yet.

```bash
kubectl rabbitmq install-cluster-operator
```

Installing the Cluster Operator creates a bunch of Kubernetes resources. Breaking these down, we have:

a new namespace rabbitmq-system. The Cluster Operator deployment is created in this namespace.

```bash
kubectl get all -n rabbitmq-system
NAME                                             READY   STATUS    RESTARTS   AGE
pod/rabbitmq-cluster-operator-6dcf5746f4-gzl94   1/1     Running   0          71m

NAME                                        READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/rabbitmq-cluster-operator   1/1     1            1           71m

NAME                                                   DESIRED   CURRENT   READY   AGE
replicaset.apps/rabbitmq-cluster-operator-6dcf5746f4   1         1         1       71m
```

- a new custom resource rabbitmqclusters.rabbitmq.com. The custom resource allows us to define an API for the creation of RabbitMQ Clusters.

```bash
kubectl get customresourcedefinitions.apiextensions.k8s.io

NAME                                             CREATED AT
...
rabbitmqclusters.rabbitmq.com                    2021-01-14T11:12:26Z
...
```

and some rbac roles. These are required by the Operator to create, update and delete RabbitMQ Clusters.

```bash
kubectl get roles -n rabbitmq-system
NAME                                    CREATED AT
rabbitmq-cluster-leader-election-role   2024-09-05T21:54:01Z
```

## Check resources limits in nodes

```bash
scc.sh reports-aks-user.yaml reports-aks
kubectl describe node
...
Allocatable:
  cpu:                3860m
  ephemeral-storage:  233966001789
  hugepages-1Gi:      0
  hugepages-2Mi:      0
  memory:             28376888Ki
  pods:               110

...
Allocated resources:
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests     Limits
  --------           --------     ------
  cpu                970m (25%)   9190m (238%)
  memory             1170Mi (4%)  6920Mi (24%)
  ephemeral-storage  0 (0%)       0 (0%)
  hugepages-1Gi      0 (0%)       0 (0%)
  hugepages-2Mi      0 (0%)       0 (0%)
Events:              <none>
```

## review **[examples](https://github.com/rabbitmq/cluster-operator/tree/main/docs/examples)** to determine how you want your cluster configured

```yaml
apiVersion: rabbitmq.com/v1beta1
kind: RabbitmqCluster
metadata:
  name: resource-limits
spec:
  replicas: 1
  resources:
    requests:
      cpu: 500m
      memory: 1Gi
    limits:
      cpu: 800m
      memory: 1Gi
```

## deploy rabbitmq instance

Submit this using the following command:

```bash
pushd .
cd ~/src/repsys/k8s/rabbitmq
kubectl apply -f helloworld-x.yaml
rabbitmqcluster.rabbitmq.com/resource-limits created
kubectl get pvc                          
NAME                                   STATUS    VOLUME   CAPACITY   ACCESS MODES   STORAGECLASS   AGE
persistence-resource-limits-server-0   Pending                                      default        2m50s
NAME                           READY   STATUS    RESTARTS   AGE
pod/resource-limits-server-0   0/1     Pending   0          3m40s

NAME                            TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                        AGE
service/kubernetes              ClusterIP   10.0.0.1     <none>        443/TCP                        542d
service/resource-limits         ClusterIP   10.0.5.235   <none>        5672/TCP,15672/TCP,15692/TCP   3m40s
service/resource-limits-nodes   ClusterIP   None         <none>        4369/TCP,25672/TCP             3m40s

NAME                                      READY   AGE
statefulset.apps/resource-limits-server   0/1     3m40s

NAME                                           ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster.rabbitmq.com/resource-limits   False              Unknown            3m40s
# or
# kubectl apply -f https://raw.githubusercontent.com/rabbitmq/cluster-operator/main/docs/examples/hello-world/rabbitmq.yaml

```

## AKS provisioning failed secret keys for app are expired

```bash
kubectl describe pvc persistence-resource-limits-server-0
  Warning  ProvisioningFailed    8m17s                   disk.csi.azure.com_csi-azuredisk-controller-78fd6d8dc4-zjsh2_113b5463-5433-4f4c-849d-b82e107b03b6  failed to provision volume with StorageClass "default": rpc error: code = Internal desc = Retriable: false, RetryAfter: 0s, HTTPStatusCode: 401, RawError: azure.BearerAuthorizer#WithAuthorization: Failed to refresh the Token for request to http://localhost:7788/subscriptions/f7d0cfcb-65b9-4f1c-8c9d-f8f993e4722a/resourceGroups/mc_reports-aks_reports-aks_centralus/providers/Microsoft.Compute/disks/pvc-176f38ad-ea61-4d1b-9708-b5225ec5b80d?api-version=2022-03-02: StatusCode=401 -- Original Error: adal: Refresh request failed. Status Code = '401'. Response body: {"error":"invalid_client","error_description":"AADSTS7000222: The provided client secret keys for app '15cdd566-98bb-4130-8ec5-5c58cffb34bf' are expired. Visit the Azure portal to create new keys for your app: https://aka.ms/NewClientSecret, or consider using certificate credentials for added security: https://aka.ms/certCreds. Trace ID: e780dfdd-08b2-49e9-a982-efd37fa30501 Correlation ID: 6ef388dd-4ac2-4bf4-8a14-55908a8ab492 Timestamp: 2024-09-05 22:43:44Z","error_codes":[7000222],"timestamp":"2024-09-05 22:43:44Z","trace_id":"e780dfdd-08b2-49e9-a982-efd37fa30501","correlation_id":"6ef388dd-4ac2-4bf4-8a14-55908a8ab492","error_uri":"https://login.microsoftonline.com/error?code=7000222"} Endpoint https://login.microsoftonline.com/b4b87e8f-df64-41ff-9ba4-a4930ebc804b/oauth2/token
```

## resource limit issue

Note: DID NOT HAVE THIS ISSUE ONCE I ADDED 2 MORE NODES TO THE CLUSTER

if you don't specify resource limits you might get an error if you don't have enough resources on your node.

In this case, and if this is not a production environment, you might want to install the Local Path Provisioner

Note: On microk8s we don't normally use this local path provisioner but enable hostpath-storage which I believe can do dynamic provisioning. My guess is that the rabbitmq operator does not try but it does create the pvc with the hostpath-storage as a name.

```bash
kubectl logs rabbitmqcluster-sample-server-0
# or insufficient cpu
kubectl edit pvc persistence-rabbitmqcluster-sample-server-0
status:
  conditions:

- lastProbeTime: null
    lastTransitionTime: "2024-08-21T21:45:46Z"
    message: '0/1 nodes are available: 1 Insufficient cpu. preemption: 0/1 nodes are
      available: 1 No preemption victims found for incoming pod.'
    reason: Unschedulable
    status: "False"
    type: PodScheduled
  phase: Pending
  qosClass: Burstable

## 
kubectl edit pvc persistence-resource-limits-server-0
kubectl edit pvc persistence-resource-limits-server-0

E0905 18:59:42.778307 4005976 memcache.go:265] couldn't get current server API group list: Get "https://172.20.88.61:16443/api?timeout=32s": tls: failed to verify certificate: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "10.152.183.1")
E0905 18:59:42.790231 4005976 memcache.go:265] couldn't get current server API group list: Get "https://172.20.88.61:16443/api?timeout=32s": tls: failed to verify certificate: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "10.152.183.1")
E0905 18:59:42.801023 4005976 memcache.go:265] couldn't get current server API group list: Get "https://172.20.88.61:16443/api?timeout=32s": tls: failed to verify certificate: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "10.152.183.1")
E0905 18:59:42.811875 4005976 memcache.go:265] couldn't get current server API group list: Get "https://172.20.88.61:16443/api?timeout=32s": tls: failed to verify certificate: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "10.152.183.1")
E0905 18:59:42.823036 4005976 memcache.go:265] couldn't get current server API group list: Get "https://172.20.88.61:16443/api?timeout=32s": tls: failed to verify certificate: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "10.152.183.1")
Unable to connect to the server: tls: failed to verify certificate: x509: certificate signed by unknown authority (possibly because of "crypto/rsa: verification error" while trying to verify candidate authority certificate "10.152.183.1")


```

## check cluster

```bash
# aks cluster
kubectl get rabbitmqclusters.rabbitmq.com
NAME              ALLREPLICASREADY   RECONCILESUCCESS   AGE
resource-limits   True               True               2m6s

# microk8s cluster
kubectl get rabbitmqclusters.rabbitmq.com
NAME                     ALLREPLICASREADY   RECONCILESUCCESS   AGE
rabbitmqcluster-sample   True               True               12m
kubectl logs rabbitmqcluster-sample-server-0
024-08-21 22:05:01.193675+00:00 [info] <0.675.0> Server startup complete; 8 plugins started.
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_prometheus
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_federation
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_peer_discovery_k8s
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_peer_discovery_common
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_management
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_management_agent
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * rabbitmq_web_dispatch
2024-08-21 22:05:01.193675+00:00 [info] <0.675.0>  * oauth2_client
2024-08-21 22:05:01.285804+00:00 [info] <0.9.0> Time to start RabbitMQ: 190694 ms

kubectl rabbitmq tail rabbitmqcluster-sample
```

## Delete the RabbitMQ Cluster object

```bash
kubectl get rabbitmqclusters.rabbitmq.com
kubectl delete rabbitmqclusters.rabbitmq.com resource-limits
kubectl delete rabbitmqclusters.rabbitmq.com hello-world
kubectl delete rabbitmqclusters.rabbitmq.com rabbitmqcluster-sample
```

## Issues

If your K8s nodes have insufficient resources the rabbitmq pod won't be deployed.

```bash
https://stackoverflow.com/questions/38869673/pod-in-pending-state-due-to-insufficient-cpu
kubectl describe node
  (Total limits may be over 100 percent, i.e., overcommitted.)
  Resource           Requests    Limits
  --------           --------    ------
  cpu                550m (55%)  200m (20%)
  memory             570Mi (3%)  670Mi (4%)
  ephemeral-storage  0 (0%)      0 (0%)
  hugepages-1Gi      0 (0%)      0 (0%)
  hugepages-2Mi      0 (0%)      0 (0%)
```

## Access The Management UI

Next, let's access the Management UI.

```bash
# aks
username="$(kubectl get secret resource-limits-default-user -o jsonpath='{.data.username}' | base64 --decode)"
echo "username: $username"
password="$(kubectl get secret resource-limits-default-user -o jsonpath='{.data.password}' | base64 --decode)"
echo "password: $password"

kubectl port-forward "service/resource-limits" 15672

# microk8s
username="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.username}' | base64 --decode)"
echo "username: $username"
password="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.password}' | base64 --decode)"
echo "password: $password"

kubectl port-forward "service/rabbitmqcluster-sample" 15672
```

Now we can open localhost:15672 in the browser and see the Management UI. The credentials are as printed in the commands above. Alternatively, you can run a curl command to verify access:

```bash
curl -u$username:$password localhost:15672/api/overview
{"management_version":"3.8.9","rates_mode":"basic", ...}

# Using the kubectl rabbitmq plugin, the Management UI can be accessed using:

kubectl rabbitmq manage rabbitmqcluster-sample
```

## Connect An Application To The Cluster

The next step would be to connect an application to the RabbitMQ Cluster in order to use its messaging capabilities. The perf-test application is frequently used within the RabbitMQ community for load testing RabbitMQ Clusters.

Here, we will be using the hello-world service to find the connection address, and the hello-world-default-user to find connection credentials.

```bash
# aks
username="$(kubectl get secret resource-limits-default-user -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret resource-limits-default-user -o jsonpath='{.data.password}' | base64 --decode)"
service="$(kubectl get service resource-limits -o jsonpath='{.spec.clusterIP}')"
echo "service = $service"
kubectl run perf-test --image=pivotalrabbitmq/perf-test -- --uri amqp://$username:$password@$service
# pod/perf-test created

# microk8s
username="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.username}' | base64 --decode)"
password="$(kubectl get secret rabbitmqcluster-sample-default-user -o jsonpath='{.data.password}' | base64 --decode)"
service="$(kubectl get service rabbitmqcluster-sample -o jsonpath='{.spec.clusterIP}')"
echo "service = $service"
kubectl run perf-test --image=pivotalrabbitmq/perf-test -- --uri amqp://$username:$password@$service
# pod/perf-test created
```

The Advanced Message Queuing Protocol is an open standard application layer protocol for message-oriented middleware. The defining features of AMQP are message orientation, queuing, routing, reliability and security.

These steps are automated in the kubectl rabbitmq plugin which may simply be run as:

```bash
kubectl rabbitmq perf-test hello-world

# We can now view the perf-test logs by running:

kubectl logs --follow perf-test
...
id: test-141948-895, time: 16.001s, sent: 25651 msg/s, received: 25733 msg/s, min/median/75th/95th/99th consumer latency: 1346110/1457130/1495463/1529703/1542172 µs
id: test-141948-895, time: 17.001s, sent: 26933 msg/s, received: 26310 msg/s, min/median/75th/95th/99th consumer latency: 1333807/1411182/1442417/1467869/1483273 µs
id: test-141948-895, time: 18.001s, sent: 26292 msg/s, received: 25505 msg/s, min/median/75th/95th/99th consumer latency: 1329488/1428657/1455482/1502191/1518218 µs
id: test-141948-895, time: 19.001s, sent: 23727 msg/s, received: 26055 msg/s, min/median/75th/95th/99th consumer latency: 1355788/1450757/1480030/1514469/1531624 µs
id: test-141948-895, time: 20.001s, sent: 25009 msg/s, received: 25202 msg/s, min/median/75th/95th/99th consumer latency: 1327462/1447157/1474394/1509857/1521303 µs
id: test-141948-895, time: 21.001s, sent: 28487 msg/s, received: 25942 msg/s, min/median/75th/95th/99th consumer latency: 1350527/1454599/1490094/1519461/1531042 µs
...
```

As can be seen, perf-test is able to produce and consume about 25,000 messages per second.

## delete perf-test

```bash
kubectl delete pod perf-test
```

## create nodeport like ClusterIP port

look at the ClusterIP port specs:

```bash
kubectl describe svc rabbitmqcluster-sample         
Name:              rabbitmqcluster-sample
Namespace:         default
Labels:            app.kubernetes.io/component=rabbitmq
                   app.kubernetes.io/name=rabbitmqcluster-sample
                   app.kubernetes.io/part-of=rabbitmq
Annotations:       <none>
Selector:          app.kubernetes.io/name=rabbitmqcluster-sample
Type:              ClusterIP
IP Family Policy:  SingleStack
IP Families:       IPv4
IP:                10.152.183.176
IPs:               10.152.183.176
Port:              amqp  5672/TCP
TargetPort:        5672/TCP
Endpoints:         10.1.187.130:5672
Port:              management  15672/TCP
TargetPort:        15672/TCP
Endpoints:         10.1.187.130:15672
Port:              prometheus  15692/TCP
TargetPort:        15692/TCP
Endpoints:         10.1.187.130:15692
Session Affinity:  None
Events:            <none>
```

create a nodeport like the ClusterIP port:
Nodeport range: 30000 and 32767

```yaml
apiVersion: v1
kind: Service
metadata:
  labels:
    app.kubernetes.io/component=rabbitmq
    app.kubernetes.io/name=rabbitmqcluster-sample
    app.kubernetes.io/part-of=rabbitmq
  name: rabbitmqcluster-sample-np
spec:
  ports:
  - name: rabbitmqcluster-sample-np
    nodePort: 32672
    port: 5672
    protocol: TCP
    targetPort: 5672
  selector:
    app.kubernetes.io/name=rabbitmqcluster-sample
  type: NodePort
```

```bash
pushd .
cd ~/src/repsys/k8s/rabbitmq
kubectl apply -f nodeport.yaml
kubectl describe svc rabbitmqcluster-sample-np   
Name:                     rabbitmqcluster-sample-np
Namespace:                default
Labels:                   app.kubernetes.io/component=rabbitmq
                          app.kubernetes.io/name=rabbitmqcluster-sample
                          app.kubernetes.io/part-of=rabbitmq
Annotations:              <none>
Selector:                 app.kubernetes.io/name=rabbitmqcluster-sample
Type:                     NodePort
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.152.183.45
IPs:                      10.152.183.45
Port:                     rabbitmqcluster-sample-np  5672/TCP
TargetPort:               5672/TCP
NodePort:                 rabbitmqcluster-sample-np  32672/TCP
Endpoints:                10.1.187.130:5672
Session Affinity:         None
External Traffic Policy:  Cluster
Events:                   <none>      


```

## Next Steps

Now that you are up and running with the basics, you can explore what the Cluster Operator can do for you!

You can do so by:

Looking at more examples such as monitoring the deployed RabbitMQ Cluster using Prometheus, enabling TLS, etc.
Looking at the API reference documentation.
Checking out our GitHub repository and contributing to this guide, other docs, and the codebase!
