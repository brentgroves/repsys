# **[Kind LoadBalancer github](https://github.com/kubernetes-sigs/cloud-provider-kind)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

## reference

- **[Kind LoadBalancer github](https://github.com/kubernetes-sigs/cloud-provider-kind)**
- **[Kind LoadBalancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/)**

## Alternative port-forward

There is a gateway or loadbalancer plugin but I have not tested it.

```bash
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
kubectl delete -f  usage.yaml  
pod "foo-app" deleted
pod "bar-app" deleted
service "foo-service" deleted
```

## Install

You can install cloud-provider-kind using go install:

```bash
go install sigs.k8s.io/cloud-provider-kind@latest
```

This will install the binary in $GOBIN (typically ~/go/bin); you can make it available elsewhere if appropriate:

```bash
sudo install ~/go/bin/cloud-provider-kind /usr/local/bin
```

## How to use it

Run a KIND cluster:

```bash
$ kind create cluster
Creating cluster "kind" ...
 ✓ Ensuring node image (kindest/node:v1.26.0) 🖼
 ✓ Preparing nodes 📦
 ✓ Writing configuration 📜
 ✓ Starting control-plane 🕹️
 ✓ Installing CNI 🔌
 ✓ Installing StorageClass 💾
Set kubectl context to "kind-kind"
You can now use your cluster with:

kubectl cluster-info --context kind-kind

Have a question, bug, or feature request? Let us know! https://kind.sigs.k8s.io/#community 🙂
```

Note

Control-plane nodes need to remove the special label node.kubernetes.io/exclude-from-external-load-balancers to be able to access the workloads running on those nodes using a LoadBalancer Service.

```bash
$ kubectl label node kind-control-plane node.kubernetes.io/exclude-from-external-load-balancers-
node/kind-control-plane unlabeled
# or if node isn't control plane?
label "node.kubernetes.io/exclude-from-external-load-balancers" not found.
node/kind-control-plane not labeled
```

Once the cluster is running, we need to run the cloud-provider-kind in a terminal and keep it running. The cloud-provider-kind will monitor all your KIND clusters and Services with Type LoadBalancer and create the corresponding LoadBalancer containers that will expose those Services.

```bash
# from a separate terminal
cloud-provider-kind
I0416 19:58:18.391222 2526219 controller.go:98] Creating new cloud provider for cluster kind
I0416 19:58:18.398569 2526219 controller.go:105] Starting service controller for cluster kind
I0416 19:58:18.399421 2526219 controller.go:227] Starting service controller
I0416 19:58:18.399582 2526219 shared_informer.go:273] Waiting for caches to sync for service
I0416 19:58:18.500460 2526219 shared_informer.go:280] Caches are synced for service
...

kubectl get all -n istio-system
...
NAME                           TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                                                                      AGE
service/istio-egressgateway    ClusterIP      10.96.65.154    <none>        80/TCP,443/TCP                                                               11d
service/istio-ingressgateway   LoadBalancer   10.96.20.134    172.21.0.3    15021:32564/TCP,80:31067/TCP,443:32190/TCP,31400:32692/TCP,15443:30233/TCP   11d
service/istiod                 ClusterIP      10.96.145.115   <none>        15010/TCP,15012/TCP,443/TCP,15014/TCP  
...
```

## Terminate Cloud Provider Kind

```bash
^c
^CI1206 19:20:02.905075  146066 app.go:69] Exiting: received signal
I1206 19:20:02.905201  146066 controller.go:253] Shutting down service controller
I1206 19:20:02.905346  146066 controller.go:304] Cleaning resources for cluster kind
I1206 19:20:02.968697  146066 loadbalancer.go:42] Ensure LoadBalancer deleted cluster: kind service: istio-ingressgateway
````

## Using LoadBalancer

The following example creates a loadbalancer service that routes to two http-echo pods, one that outputs foo and the other outputs bar.

```bash
cd ~/src/repsys/k8s/kind/loadbalancer
scc.sh kind.yaml kind-kind
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
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
# or
kubectl apply -f https://kind.sigs.k8s.io/examples/loadbalancer/usage.yaml
```

## Creating a Service and exposing it via a LoadBalancer

Let's create an application that listens on port 8080 and expose it in the port 80 using a LoadBalancer.

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: policy-local
  labels:
    app: MyLocalApp
spec:
  replicas: 1
  selector:
    matchLabels:
      app: MyLocalApp
  template:
    metadata:
      labels:
        app: MyLocalApp
    spec:
      containers:
      - name: agnhost
        image: registry.k8s.io/e2e-test-images/agnhost:2.40
        args:
          - netexec
          - --http-port=8080
          - --udp-port=8080
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: lb-service-local
spec:
  type: LoadBalancer
  externalTrafficPolicy: Local
  selector:
    app: MyLocalApp
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8080
```

```bash
$ kubectl apply -f examples/loadbalancer_etp_local.yaml
deployment.apps/policy-local created
service/lb-service-local created
$ kubectl get service/lb-service-local
NAME               TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)        AGE
lb-service-local   LoadBalancer   10.96.207.137   192.168.8.7   80:31215/TCP   57s
```

We can see how the EXTERNAL-IP field contains an IP, and we can use it to connect to our application.

```bash
$ curl  192.168.8.7:80/hostname
policy-local-59854877c9-xwtfk

$  kubectl get pods
NAME                            READY   STATUS    RESTARTS   AGE
policy-local-59854877c9-xwtfk   1/1     Running   0          2m38s

```

## Limitations

Mutation of Services, adding or removing ports to an existing Services, is not supported.
cloud-provider-kind binary needs permissions to add IP address to interfaces and to listen on privileged ports.
Overlapping IP between the containers and the host can break connectivity.
Mainly tested with docker and Linux, though Windows and Mac are also basically supported:

On macOS you must run cloud-provider-kind using sudo
On Windows you must run cloud-provider-kind from a shell that uses Run as administrator
Further feedback from users will be helpful to support other related platforms.
Note

The project is still in very alpha state, bugs are expected, please report them back opening a Github issue.

## Code of conduct

Participation in the Kubernetes community is governed by the Kubernetes Code of Conduct.
