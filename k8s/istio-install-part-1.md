# **[Getting Started Istio](https://istio.io/latest/docs/setup/getting-started/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

This guide lets you quickly evaluate Istio. If you are already familiar with Istio or interested in installing other configuration profiles or advanced deployment models, refer to our which Istio installation method should I use? FAQ page.

## references

- **[microk8s istio](https://gist.github.com/Realiserad/391855c4a0fb0072994e5ad2a53d65c0)**

## **[Cleanup](./istio-cleanup.md)**

## Install Istio

1. Go to the Istio release page to download the installation file for your OS, or download and extract the latest release automatically (Linux or macOS):

```bash
pushd .
cd ~/Downloads
curl -L https://istio.io/downloadIstio | sh -
# Downloading istio-1.23.0 from https://github.com/istio/istio/releases/download/1.23.0/istio-1.23.0-linux-amd64.tar.gz ...

# Istio 1.23.0 Download Complete!

# Istio has been successfully downloaded into the istio-1.23.0 folder on your system.
```

## Step 2

Move to the Istio package directory. For example, if the package is istio-1.23.0:

```bash
# remove old version
sudo rm /usr/local/bin/istioctl
sudo cp istio-1.23.2/bin/istioctl /usr/local/bin/

```

The installation directory contains:

- Sample applications in samples/
- The istioctl client binary in the bin/ directory.

```bash
ls ~/Downloads/istio-1.23.2                   
bin  LICENSE  manifests  manifest.yaml  README.md  samples  tools
```

## Install Istio on K8s

For this guide, we use the demo **[configuration profile](https://istio.io/latest/docs/setup/additional-setup/config-profiles/)**. It is selected to have a good set of defaults for testing, but there are other profiles for production, performance testing or OpenShift.

Unlike **[Istio Gateways](https://istio.io/latest/docs/concepts/traffic-management/#gateways)**, creating **[Kubernetes Gateways](https://gateway-api.sigs.k8s.io/api-types/gateway/)** will, by default, also deploy **[gateway proxy servers](https://istio.io/latest/docs/tasks/traffic-management/ingress/gateway-api/#automated-deployment)**. Because they won’t be used, we disable the deployment of the default Istio gateway services that are normally installed as part of the demo profile.

Install Istio using the demo profile, without any gateways:

```bash
scc.sh repsys11c2n1.yaml microk8s 
pushd .

cd ~/Downloads/istio-1.23.0
# I did not install the demo profile since I wanted to run a full stack app 
# tutorial after this one.
# istioctl install -f samples/bookinfo/demo-profile-no-gateways.yaml -y
# ✔ Istio core installed
# ✔ Istiod installed
# ✔ Installation complete
# Made this installation the default for injection and validation.
istioctl install
This will install the Istio 1.23.2 "default" profile (with components: Istio core, Istiod, and Ingress gateways) into the cluster. Proceed? (y/N) y

Istio core installed
Istiod installed
Ingress gateways installed
Installation complete
Made this installation the default for cluster-wide operations. 

```

Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

```bash
kubectl label namespace default istio-injection=enabled
namespace/default labeled
kubectl describe ns default                            
Name:         default
Labels:       istio-injection=enabled
              kubernetes.io/metadata.name=default
Annotations:  <none>
Status:       Active

No resource quota.

No LimitRange resource.
```

## Install the Kubernetes Gateway API CRDs

The Kubernetes Gateway API CRDs do not come installed by default on most Kubernetes clusters, so make sure they are installed before using the Gateway API.

Install the Gateway API CRDs, if they are not already present:

```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
{ kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.1.0" | kubectl apply -f -; }
ustomresourcedefinition.apiextensions.k8s.io/gatewayclasses.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/gateways.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/grpcroutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/referencegrants.gateway.networking.k8s.io created
```

## Deploy the sample application

You have configured Istio to inject sidecar containers into any application you deploy in your default namespace.

### 1. Deploy the **[Bookinfo sample application](https://istio.io/latest/docs/examples/bookinfo/)**

```bash
pushd .
cd ~/Downloads/istio-1.23.0

kubectl apply -f samples/bookinfo/platform/kube/bookinfo.yaml
service/details created
serviceaccount/bookinfo-details created
deployment.apps/details-v1 created
service/ratings created
serviceaccount/bookinfo-ratings created
deployment.apps/ratings-v1 created
service/reviews created
serviceaccount/bookinfo-reviews created
deployment.apps/reviews-v1 created
deployment.apps/reviews-v2 created
deployment.apps/reviews-v3 created
service/productpage created
serviceaccount/bookinfo-productpage created
deployment.apps/productpage-v1 created
# or
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/bookinfo/platform/kube/bookinfo.yaml

service/details created
serviceaccount/bookinfo-details created
deployment.apps/details-v1 created
service/ratings created
serviceaccount/bookinfo-ratings created
deployment.apps/ratings-v1 created
service/reviews created
serviceaccount/bookinfo-reviews created
deployment.apps/reviews-v1 created
deployment.apps/reviews-v2 created
deployment.apps/reviews-v3 created
service/productpage created
serviceaccount/bookinfo-productpage created
deployment.apps/productpage-v1 created
```

The application will start. As each pod becomes ready, the Istio sidecar will be deployed along with it.

```bash
kubectl get services
NAME          TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
details       ClusterIP   10.152.183.102   <none>        9080/TCP         4m54s
kubernetes    ClusterIP   10.152.183.1     <none>        443/TCP          90d
mysql-svc     NodePort    10.152.183.210   <none>        3306:30031/TCP   85d
productpage   ClusterIP   10.152.183.192   <none>        9080/TCP         4m54s
ratings       ClusterIP   10.152.183.115   <none>        9080/TCP         4m54s
reviews       ClusterIP   10.152.183.213   <none>        9080/TCP         4m54s

kubectl get pods
NAME                             READY   STATUS    RESTARTS         AGE
details-v1-65cfcf56f9-bdr7h      2/2     Running   0                6m27s
mysql-0                          1/1     Running   2479 (85m ago)   85d
productpage-v1-d5789fdfb-7fq5k   2/2     Running   0                6m27s
ratings-v1-7c9bd4b87f-hhjsv      2/2     Running   0                6m27s
reviews-v1-6584ddcf65-tf9kv      2/2     Running   0                6m27s
reviews-v2-6f85cb9b7c-689bt      2/2     Running   0                6m27s
reviews-v3-6f5b775685-jzvzc      2/2     Running   0                6m27s
```

Note that the pods show READY 2/2, confirming they have their application container and the Istio sidecar container.

Validate that the app is running inside the cluster by checking for the page title in the response:

```bash
# kubectl exec (POD | TYPE/NAME) [-c CONTAINER] [flags] -- COMMAND [args...]
# When used with -s, --silent, it makes curl show an error message if it fails.

kubectl exec "$(kubectl get pod -l app=ratings -o jsonpath='{.items[0].metadata.name}')" -c ratings -- curl -sS productpage:9080/productpage | grep -o "<title>.*</title>"
<title>Simple Bookstore App</title>
```

## Open the application to outside traffic

The Bookinfo application is deployed, but not accessible from the outside. To make it accessible, you need to create an ingress gateway, which maps a path to a route at the edge of your mesh.

## Create a Kubernetes Gateway for the Bookinfo application

```bash
scc.sh repsys11c2n1.yaml microk8s 
pushd .
cd ~/Downloads/istio-1.23.2
# review the yaml
cp samples/bookinfo/gateway-api/bookinfo-gateway.yaml ~/src/repsys/k8s/istio/
kubectl apply -f samples/bookinfo/gateway-api/bookinfo-gateway.yaml
gateway.gateway.networking.k8s.io/bookinfo-gateway created
httproute.gateway.networking.k8s.io/bookinfo created

# Azure
scc.sh reports-aks-user.yaml reports-aks
kubectl apply -f samples/bookinfo/gateway-api/bookinfo-gateway.yaml

gateway.gateway.networking.k8s.io/bookinfo-gateway unchanged
httproute.gateway.networking.k8s.io/bookinfo configured
```

By default, Istio creates a LoadBalancer service for a gateway. As we will access this gateway by a tunnel, we don’t need a load balancer. If you want to learn about how load balancers are configured for external IP addresses, read the **[ingress gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)** documentation.

## Change the service type to ClusterIP by annotating the gateway

```bash
# Before change the svc is of type loadbalancer
# Microk8s
scc.sh repsys11c2n1.yaml microk8s  
kubectl get svc                                                    
NAME                     TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                        AGE
bookinfo-gateway-istio   LoadBalancer   10.152.183.114   10.1.0.144    15021:30377/TCP,80:30444/TCP   6s
# get gateway
kubectl get gateway
NAME               CLASS   ADDRESS      PROGRAMMED   AGE
bookinfo-gateway   istio   10.1.0.144   True         112s

# Azure AKS
scc.sh reports-aks-user.yaml reports-aks
kubectl get svc 
NAME                     TYPE           CLUSTER-IP     EXTERNAL-IP     PORT(S)                        AGE
bookinfo-gateway-istio   LoadBalancer   10.0.133.32    20.15.156.95   15021:31202/TCP,80:31760/TCP   53m
# get gateway
kubectl get gateway                     
NAME               CLASS   ADDRESS         PROGRAMMED   AGE
bookinfo-gateway   istio   20.15.156.95   True         10m

kubectl annotate gateway bookinfo-gateway networking.istio.io/service-type=ClusterIP --namespace=default
# to change back to loadbalancer
kubectl annotate gateway bookinfo-gateway networking.istio.io/service-type- --namespace=default

```

To check the status of the gateway, run:

```bash
# with loadbalancer
kubectl get gateway
NAME               CLASS   ADDRESS      PROGRAMMED   AGE
bookinfo-gateway   istio   10.1.0.144   True         25m

# Azure
kubectl get gateway
NAME               CLASS   ADDRESS         PROGRAMMED   AGE
bookinfo-gateway   istio   20.15.156.95   True         34m

# with clusterip
kubectl get gateway
NAME               CLASS   ADDRESS                                            PROGRAMMED   AGE
bookinfo-gateway   istio   bookinfo-gateway-istio.default.svc.cluster.local   True         42s
```

## Access the application

You will connect to the Bookinfo productpage service through the gateway you just provisioned. To access the gateway, you need to use the kubectl port-forward command:

```bash
# with loadbalancer
# Microk8s
scc.sh repsys11c2n1.yaml microk8s  
curl http://10.1.0.144/productpage
# Azure AKS
scc.sh reports-aks-user.yaml reports-aks
curl http://20.15.156.95/productpage

# with clusterip
# from a separate terminal
kubectl port-forward svc/bookinfo-gateway-istio 8080:80
# Start a new terminal to test
curl http://localhost:8080/productpage
```

## View the dashboard

Istio integrates with **[several different telemetry applications](https://istio.io/latest/docs/ops/integrations/)**. These can help you gain an understanding of the structure of your service mesh, display the topology of the mesh, and analyze the health of your mesh.

Use the following instructions to deploy the **[Kiali dashboard](https://istio.io/latest/docs/ops/integrations/kiali/)**, along with **[Prometheus](https://istio.io/latest/docs/ops/integrations/prometheus/)**, **[Grafana](https://istio.io/latest/docs/ops/integrations/grafana/)**, and **[Jaeger](https://istio.io/latest/docs/ops/integrations/jaeger/)**.

### 1. Install Kiali and the other addons and wait for them to be deployed

```bash
kubectl apply -f samples/addons
kubectl rollout status deployment/kiali -n istio-system
Waiting for deployment "kiali" rollout to finish: 0 of 1 updated replicas are available...
deployment "kiali" successfully rolled out
```

### 2. Access the Kiali dashboard

```bash
istioctl dashboard kiali
```

### 3. select Graph

In the left navigation menu, select Graph and in the Namespace drop down, select default

To see trace data, you must send requests to your service. The number of requests depends on Istio’s sampling rate and can be configured using the Telemetry API. With the default sampling rate of 1%, you need to send at least 100 requests before the first trace is visible. To send 100 requests to the productpage service, use the following command:

```bash
export GATEWAY_URL=10.1.0.144

# before pressing enter remove \ after productpage";
cat <<EOF > ./test.sh 
#!/bin/bash
for i in {1..100}
do
   curl -s -o /dev/null "http://$GATEWAY_URL/productpage";
done
EOF
chmod 777 test.sh 
./test.sh
```
