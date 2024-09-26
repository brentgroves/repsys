# **[Create an ingress controller](https://kubernetes.github.io/ingress-nginx/deploy/#azure)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[AKS Ingress](../research/a_l/azure/aks/ingress_controllers.md)**
- **[Azure AKS unmanaged ingress](https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli#create-an-ingress-controller)**

## Ingress

Microsoft recommends thier application routing addon which works with their DNS Zones and Key vault.  I may use it later but will try to configure the standard **[NGinx Ingress](https://kubernetes.github.io/ingress-nginx/)** first.

**[Install Nginx Ingress](https://kubernetes.github.io/ingress-nginx/deploy/#azure)**
Make separate install document.  Thank you Lord for giving me peace today and everyday that I follow you!

## Installation Guide

There are multiple ways to install the Ingress-Nginx Controller:

- with Helm, using the project repository chart;
- with kubectl apply, using YAML manifests;
- with specific addons (e.g. for minikube or MicroK8s).

On most Kubernetes clusters, the ingress controller will work without requiring any extra configuration. If you want to get started as fast as possible, you can check the quick start instructions. However, in many environments, you can improve the performance or get better logs by enabling extra features. We recommend that you check the environment-specific instructions for details about optimizing the ingress controller for your particular environment or cloud provider.

## Azure

```bash
pushd .
cd ~/src/repsys/k8s/ingress/aks
scc.sh reports-aks-user.yaml reports-aks
# download yaml
curl -O https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/controller-v1.11.2/deploy/static/provider/cloud/deploy.yaml
# or
kubectl apply -f ./deploy.yaml

```

More information with regard to Azure annotations for ingress controller can be found in the official AKS documentation.

## **[More details found in AKS documentation](https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli#create-an-ingress-controller)**

## **[Check the load balancer service](https://learn.microsoft.com/en-us/azure/aks/ingress-basic?tabs=azure-cli#check-the-load-balancer-service)**

Check the load balancer service by using kubectl get services.

When the Kubernetes load balancer service is created for the NGINX ingress controller, an IP address is assigned under EXTERNAL-IP, as shown in the following example output:

```bash
pushd .
cd ~/src/repsys/k8s/ingress/aks
scc.sh reports-aks-user.yaml reports-aks

kubectl get services --namespace ingress-nginx -o wide -w ingress-nginx-controller
NAME                                 TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE    SELECTOR
cert-manager                         ClusterIP      10.0.51.250    <none>           9402/TCP                     533d   app.kubernetes.io/component=controller,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=cert-manager
cert-manager-webhook                 ClusterIP      10.0.194.134   <none>           443/TCP                      533d   app.kubernetes.io/component=webhook,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=webhook
ingress-nginx-controller             LoadBalancer   10.0.135.65    23.101.116.170   80:31260/TCP,443:30197/TCP   548d   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
ingress-nginx-controller-admission   ClusterIP      10.0.55.173    <none>           443/TCP                      548d   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
```

Note: Noticed that the load balancer service is mapped to what looks like a nodeport destination.

If you browse to the external IP address at this stage, you see a 404 page displayed. This is because you still need to set up the connection to the external IP, which is done in the next sections.

Note: I created another Load balancer for rabbitmq and got an entirely different external IP.

## Run demo applications

To see the ingress controller in action, run two demo applications in your AKS cluster. In this example, you use kubectl apply to deploy two instances of a simple Hello world application.

Create an **[aks-helloworld-one.yaml](./ingress/aks/aks-helloworld-one.yaml)** file and copy in the following example YAML:

Create an **[aks-helloworld-two.yaml](./ingress/aks/aks-helloworld-two.yaml)** file and copy in the following example YAML:

Run the two demo applications using kubectl apply:

```bash
pushd .
cd ~/src/repsys/k8s/ingress/aks
kubectl create namespace ingress-test
kubectl apply -f aks-helloworld-one.yaml --namespace ingress-test
kubectl apply -f aks-helloworld-two.yaml --namespace ingress-test

kubectl get all -n ingress-test 
NAME                                      READY   STATUS    RESTARTS   AGE
pod/aks-helloworld-one-749789b6c5-r7k8m   1/1     Running   0          60s
pod/aks-helloworld-two-5b8d45b8bf-bphw7   1/1     Running   0          51s

NAME                         TYPE        CLUSTER-IP     EXTERNAL-IP   PORT(S)   AGE
service/aks-helloworld-one   ClusterIP   10.0.25.114    <none>        80/TCP    61s
service/aks-helloworld-two   ClusterIP   10.0.147.227   <none>        80/TCP    52s

NAME                                 READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/aks-helloworld-one   1/1     1            1           61s
deployment.apps/aks-helloworld-two   1/1     1            1           52s

NAME                                            DESIRED   CURRENT   READY   AGE
replicaset.apps/aks-helloworld-one-749789b6c5   1         1         1       61s
replicaset.apps/aks-helloworld-two-5b8d45b8bf   1         1         1       52s
```

## Create an ingress route

Both applications are now running on your Kubernetes cluster. To route traffic to each application, create a Kubernetes ingress resource. The ingress resource configures the rules that route traffic to one of the two applications.

In the following example, traffic to EXTERNAL_IP/hello-world-one is routed to the service named aks-helloworld-one. Traffic to EXTERNAL_IP/hello-world-two is routed to the aks-helloworld-two service. Traffic to EXTERNAL_IP/static is routed to the service named aks-helloworld-one for static assets.

Create a file named **[hello-world-ingress.yaml](./ingress/aks/hello-world-ingress.yaml)** and copy in the following example YAML:

Create the ingress resource using the kubectl apply command.

```bash
pushd .
cd ~/src/repsys/k8s/ingress/aks
scc.sh reports-aks-user.yaml reports-aks
kubectl apply -f hello-world-ingress.yaml --namespace ingress-test
```

## Test the ingress controller

To test the routes for the ingress controller, browse to the two applications. Open a web browser to the IP address of your NGINX ingress controller, such as EXTERNAL_IP. The first demo application is displayed in the web browser, as shown in the following example:

```bash
kubectl get services --namespace ingress-nginx -o wide            
NAME                                 TYPE           CLUSTER-IP     EXTERNAL-IP      PORT(S)                      AGE    SELECTOR
cert-manager                         ClusterIP      10.0.51.250    <none>           9402/TCP                     533d   app.kubernetes.io/component=controller,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=cert-manager
cert-manager-webhook                 ClusterIP      10.0.194.134   <none>           443/TCP                      533d   app.kubernetes.io/component=webhook,app.kubernetes.io/instance=cert-manager,app.kubernetes.io/name=webhook
ingress-nginx-controller             LoadBalancer   10.0.135.65    23.101.116.170   80:31260/TCP,443:30197/TCP   548d   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx
ingress-nginx-controller-admission   ClusterIP      10.0.55.173    <none>           443/TCP                      548d   app.kubernetes.io/component=controller,app.kubernetes.io/instance=ingress-nginx,app.kubernetes.io/name=ingress-nginx

curl repsys.linamar.com
curl 23.101.116.170 

```

To test the routes for the ingress controller, browse to the two applications. Open a web browser to the IP address of your NGINX ingress controller, such as EXTERNAL_IP. The first demo application is displayed in the web browser, as shown in the following example:

![home](https://learn.microsoft.com/en-us/previous-versions/azure/aks/media/ingress-basic/app-one.png)

Now add the /hello-world-two path to the IP address, such as EXTERNAL_IP/hello-world-two. The second demo application with the custom title is displayed:

![2nd app](https://learn.microsoft.com/en-us/previous-versions/azure/aks/media/ingress-basic/app-two.png)

## **[go to magic section](https://www.enabler.no/en/blog/mosquitto-mqtt-broker-in-kubernetes)**

This will show you how to allow the ingress to route tcp traffic!
