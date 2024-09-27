# **[NGINX Gateway Fabric](https://docs.nginx.com/nginx-gateway-fabric/installation/)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[Create an ingress controller](https://blog.nashtechglobal.com/hands-on-kubernetes-gateway-api-with-nginx-gateway-fabric/)**
- **[Installation with Kubernetes manifests](https://docs.nginx.com/nginx-gateway-fabric/installation/installing-ngf/manifests/)**

## **[Installation with Kubernetes manifests](https://docs.nginx.com/nginx-gateway-fabric/installation/installing-ngf/manifests/)**

## Choices

- Install fabric with manifests.
- Install from the experimental channel because I wanted to make sure I could use tls objects.

## Uninstall NGINX Gateway Fabric

Follow these steps to uninstall NGINX Gateway Fabric and Gateway API from your Kubernetes cluster:

### 1. Uninstall NGINX Gateway Fabric

- To remove NGINX Gateway Fabric and its custom resource definitions (CRDs), run:

```bash
kubectl delete namespace nginx-gateway
kubectl delete cluterrole nginx-gateway
kubectl delete clusterrolebinding nginx-gateway
kubectl delete -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/crds.yaml
```

### 2. Remove the Gateway API resources

- **Warning:**\
This will remove all corresponding custom resources in your entire cluster, across all namespaces. Double-check to make sure you don’t have any custom resources you need to keep, and confirm that there are **no other Gateway API implementations active** in your cluster.

To uninstall the Gateway API resources, run the following:

```bash
kubectl kustomize "https://github.com/nginxinc/nginx-gateway-fabric/config/crd/gateway-api/experimental?ref=v1.4.0" | kubectl delete -f -
```

## Deploy NGINX Gateway Fabric

Deploying NGINX Gateway Fabric with Kubernetes manifests takes only a few steps. With manifests, you can configure your deployment exactly how you want. Manifests also make it easy to replicate deployments across environments or clusters, ensuring consistency.

## 1. Install the Gateway API resources

**Note:**\
The **[Gateway API](https://github.com/kubernetes-sigs/gateway-api)** resources from the standard channel must be installed before deploying NGINX Gateway Fabric. If they are already installed in your cluster, please ensure they are the correct version as supported by the NGINX Gateway Fabric - see the **[Technical Specifications](https://github.com/nginxinc/nginx-gateway-fabric/blob/v1.4.0/README.md#technical-specifications)**.

```bash
kubectl kustomize "https://github.com/nginxinc/nginx-gateway-fabric/config/crd/gateway-api/experimental?ref=v1.4.0" | kubectl apply -f -
```

To install the Gateway API resources, run the following:

```bash
pushd .
cd ~/src/repsys/k8s/nginx_gateway_fabric
# pick cluster
scc.sh reports-aks-user.yaml reports-aks
# create a resource file for scrutiny. 
kubectl kustomize "https://github.com/nginxinc/nginx-gateway-fabric/config/crd/gateway-api/experimental?ref=v1.4.0" > resources.yaml
# install resources
kubectl kustomize "https://github.com/nginxinc/nginx-gateway-fabric/config/crd/gateway-api/experimental?ref=v1.4.0" | kubectl apply -f -
# or
kubectl apply -f resources.yaml

# standard resource only. no tlsroute
definition.apiextensions.k8s.io/gatewayclasses.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/gateways.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/grpcroutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/referencegrants.gateway.networking.k8s.io created

# experimental resources
customresourcedefinition.apiextensions.k8s.io/backendtlspolicies.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/gatewayclasses.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/gateways.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/grpcroutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/httproutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/referencegrants.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/tcproutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/tlsroutes.gateway.networking.k8s.io created
customresourcedefinition.apiextensions.k8s.io/udproutes.gateway.networking.k8s.io created
```

## 2. Deploy the NGINX Gateway Fabric CRDs

```bash
pushd .
cd ~/src/repsys/k8s/nginx_gateway_fabric
# pick cluster
scc.sh reports-aks-user.yaml reports-aks
# create a crd file for scrutiny. 
curl https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/crds.yaml > crds.yaml
# install crds
kubectl apply -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/crds.yaml
# or
kubectl apply -f crds.yaml

customresourcedefinition.apiextensions.k8s.io/clientsettingspolicies.gateway.nginx.org created
customresourcedefinition.apiextensions.k8s.io/nginxgateways.gateway.nginx.org created
customresourcedefinition.apiextensions.k8s.io/nginxproxies.gateway.nginx.org created
customresourcedefinition.apiextensions.k8s.io/observabilitypolicies.gateway.nginx.org created
```

## 3. Deploy NGINX Gateway Fabric

**Note:**\
By default, NGINX Gateway Fabric is installed in the nginx-gateway namespace. You can deploy in another namespace by modifying the manifest files.

### Azure

Deploys NGINX Gateway Fabric with NGINX OSS and nodeSelector to deploy on Linux nodes.

```bash
curl https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/experimental/deploy.yaml > experimental_deploy.yaml
curl https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/azure/deploy.yaml > azure_deploy
```

**Did a diff** on the experimental deploy and the azure deploy and decided to add the node selector lines to the experimental deploy and call it azure_deploy.yaml. I was thinking these experimental features may not work in azure

```bash
pushd .
cd ~/src/repsys/k8s/nginx_gateway_fabric
# Azure AKS cluster
kubectl apply -f experimental_deploy_azure.yaml
# Microk8s
kubectl apply -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/experimental/deploy.yaml
# or
kubectl apply -f experimental_deploy.yaml

namespace/nginx-gateway created
serviceaccount/nginx-gateway created
clusterrole.rbac.authorization.k8s.io/nginx-gateway created
clusterrolebinding.rbac.authorization.k8s.io/nginx-gateway created
service/nginx-gateway created
deployment.apps/nginx-gateway created
gatewayclass.gateway.networking.k8s.io/nginx created
nginxgateway.gateway.nginx.org/nginx-gateway-config created
```

## NEXT

**[4. Verify the Deployment](https://docs.nginx.com/nginx-gateway-fabric/installation/installing-ngf/manifests/)**

If tlsroute is not supported on Azure. Try another option like NGINX IC.
