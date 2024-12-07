# **[Kind LoadBalancer github](https://github.com/kubernetes-sigs/cloud-provider-kind)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

## Note

This document is a combination of parts of articles from both references below.

## reference

- **[Kind LoadBalancer github](https://github.com/kubernetes-sigs/cloud-provider-kind)**
- **[Kind LoadBalancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/)**

## Alternative port-forward

There is a gateway or loadbalancer plugin but I have not tested it.

```bash
cd ~/src/repsys/k8s/kind/loadbalancer
scc.sh kind.yaml kind-kind
kubectl port-forward -n istio-system svc/istio-ingressgateway 8000:80 
```

## **[Cloud Provider Kind](https://github.com/kubernetes-sigs/cloud-provider-kind)**

## Kubernetes Cloud Provider for KIND

KIND has demonstrated to be a very versatile, efficient, cheap and very useful tool for Kubernetes testing. However, KIND doesn't offer capabilities for testing all the features that depend on cloud-providers, specifically the Load Balancers, causing a gap on testing and a bad user experience, since is not easy to connect to the applications running on the cluster.

cloud-provider-kind aims to fill this gap and provide an agnostic and cheap solution for all the Kubernetes features that depend on a cloud-provider using KIND.

Cloud Provider KIND runs as a standalone binary in your host and connects to your KIND cluster and provisions new Load Balancer containers for your Services. It requires privileges to open ports on the system and to connect to the container runtime.

## Cleanup

```bash
cd ~/src/repsys/k8s/kind/loadbalancer
scc.sh kind.yaml kind-kind
kubectl delete -f  usage.yaml  
pod "foo-app" deleted
pod "bar-app" deleted
service "foo-service" deleted

# Check cloud-provider-kind terminal for load balancer deletion.
I1207 18:24:17.089055   87012 loadbalancer.go:16] Get LoadBalancer cluster: kind service: foo-service
I1207 18:24:17.120005   87012 controller.go:383] Deleting existing load balancer for service default/foo-service
I1207 18:24:17.120066   87012 loadbalancer.go:42] Ensure LoadBalancer deleted cluster: kind service: foo-service
I1207 18:24:17.120245   87012 event.go:389] "Event occurred" object="default/foo-service" fieldPath="" kind="Service" apiVersion="v1" type="Normal" reason="DeletingLoadBalancer" message="Deleting load balancer"
I1207 18:24:18.744597   87012 controller.go:973] Removing finalizer from service default/foo-service
I1207 18:24:18.949533   87012 controller.go:999] Patching status for service default/foo-service
I1207 18:24:18.949672   87012 event.go:389] "Event occurred" object="default/foo-service" fieldPath="" kind="Service" apiVersion="v1" type="Normal" reason="DeletedLoadBalancer" message="Deleted load balancer"
I
```

## Install

You can install cloud-provider-kind using go install:

```bash
cd ~/src/repsys/k8s/kind/loadbalancer
scc.sh kind.yaml kind-kind
go install sigs.k8s.io/cloud-provider-kind@latest
```

This will install the binary in $GOBIN (typically ~/go/bin); you can make it available elsewhere if appropriate:

```bash
sudo install ~/go/bin/cloud-provider-kind /usr/local/bin
```

## How to use it

- **[Install Kind and Create cluster](../kind-install.md)**
-

Note

Control-plane nodes need to remove the special label node.kubernetes.io/exclude-from-external-load-balancers to be able to access the workloads running on those nodes using a LoadBalancer Service.
I don't know what this means exactly but I got a not found message when I tried it.

```bash
kubectl label node kind-control-plane node.kubernetes.io/exclude-from-external-load-balancers-
node/kind-control-plane unlabeled
# or if node isn't control plane?
label "node.kubernetes.io/exclude-from-external-load-balancers" not found.
node/kind-control-plane not labeled

# verify that label
kubectl describe node/kind-control-plane 
```

Once the cluster is running, we need to run the cloud-provider-kind in a terminal and keep it running. The cloud-provider-kind will monitor all your KIND clusters and Services with Type LoadBalancer and create the corresponding LoadBalancer containers that will expose those Services.

```bash
# from a separate terminal
# Note: better to start this before any loadbalancer services have been created.
cloud-provider-kind
I0416 19:58:18.391222 2526219 controller.go:98] Creating new cloud provider for cluster kind
I0416 19:58:18.398569 2526219 controller.go:105] Starting service controller for cluster kind
I0416 19:58:18.399421 2526219 controller.go:227] Starting service controller
I0416 19:58:18.399582 2526219 shared_informer.go:273] Waiting for caches to sync for service
I0416 19:58:18.500460 2526219 shared_informer.go:280] Caches are synced for service
...

cd ~/src/repsys/k8s/kind/loadbalancer
scc.sh kind.yaml kind-kind
kubectl get svc --all-namespaces
...
NAMESPACE     NAME         TYPE        CLUSTER-IP   EXTERNAL-IP   PORT(S)                  AGE
default       kubernetes   ClusterIP   10.96.0.1    <none>        443/TCP                  12d
kube-system   kube-dns     ClusterIP   10.96.0.10   <none>        53/UDP,53/TCP,9153/TCP   12d
...

```

## Using LoadBalancer

The following example creates a loadbalancer service that routes to two http-echo pods, one that outputs foo and the other outputs bar.

```bash
cd ~/src/repsys/k8s/kind/loadbalancer
scc.sh kind.yaml kind-kind
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
# or
kubectl apply -f usage.yaml
# or
kubectl apply -f - <<EOF 
kind: Pod
apiVersion: v1
metadata:
  name: foo-app
  labels:
    app: http-echo
spec:
  containers:
  - command:
    - /agnhost
    - serve-hostname
    - --http=true
    - --port=8080
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
    name: foo-app
---
kind: Pod
apiVersion: v1
metadata:
  name: bar-app
  labels:
    app: http-echo
spec:
  containers:
  - command:
    - /agnhost
    - serve-hostname
    - --http=true
    - --port=8080
    image: registry.k8s.io/e2e-test-images/agnhost:2.39
    name: bar-app
---
kind: Service
apiVersion: v1
metadata:
  name: foo-service
spec:
  type: LoadBalancer
  selector:
    app: http-echo
  ports:
  - port: 5678
    targetPort: 8080
EOF
pod/foo-app created
pod/bar-app created
service/foo-service created

kubectl get all          
NAME          READY   STATUS    RESTARTS   AGE
pod/bar-app   1/1     Running   0          37s
pod/foo-app   1/1     Running   0          37s

NAME                  TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)          AGE
service/foo-service   LoadBalancer   10.96.189.107   172.21.0.3    5678:30380/TCP   37s
service/kubernetes    ClusterIP      10.96.0.1       <none>        443/TCP          12d
```

Now verify that the loadbalancer works by sending traffic to it’s external IP and port.

```bash
LB_IP=$(kubectl get svc/foo-service -o=jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $LB_IP                                     
172.21.0.3

# should output foo and bar on separate lines 
for _ in {1..10}; do
  curl ${LB_IP}:5678
done
foo-appfoo-appfoo-appfoo-appbar-appfoo-appfoo-appfoo-appbar-appfoo-app% 
# Issue: Did not load balance the first time but did the second time
# should output foo and bar on separate lines 
for _ in {1..10}; do
  curl ${LB_IP}:5678
done
bar-appbar-appfoo-appbar-appfoo-appbar-appbar-appfoo-appbar-appbar-app%    
```
