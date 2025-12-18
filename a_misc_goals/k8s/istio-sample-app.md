# **[Getting Started Istio](https://istio.io/latest/docs/setup/getting-started/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

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
