# **[NGINX Gateway Fabric](https://docs.nginx.com/nginx-gateway-fabric/installation/)**

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## references

- **[AKS Loadbalancer and TLS termination](https://stackoverflow.com/questions/53383614/configuring-an-aks-load-balancer-for-https-access)**

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

To install the Gateway API resources, run the following:

Note: These are standard k8s crds not nginx.

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

Note: These resources are made by NGINX.

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

Note: I made a mistake here and thought I was deploying experimental_deploy_azure.yaml but actually ran the following command: ```kubectl apply -f https://raw.githubusercontent.com/nginxinc/nginx-gateway-fabric/v1.4.0/deploy/experimental/deploy.yaml``` which is the unmodified experimental deployment yaml. If this works for Azure that means we don't have to modify the experimental deployment to include a nodeSelector=linux statement.

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

**[4. Verify the Deployment](https://docs.nginx.com/nginx-gateway-fabric/installation/installing-ngf/manifests/)**

To confirm that NGINX Gateway Fabric is running, check the pods in the nginx-gateway namespace:

```bash
kubectl get pods -n nginx-gateway
```

The output should look similar to this (note that the pod name will include a unique string):

```bash
NAME                             READY   STATUS    RESTARTS   AGE
nginx-gateway-7f89b76fd4-lp47m   2/2     Running   0          16h
```

## 5. Access NGINX Gateway Fabric

There are two options for accessing NGINX Gateway Fabric depending on the type of LoadBalancer service you chose during installation:

- If the LoadBalancer type is NodePort, Kubernetes will randomly allocate two ports on every node of the cluster. To access the NGINX Gateway Fabric, use an IP address of any node of the cluster along with the two allocated ports.

    **Tip:**\
    Read more about the type NodePort in the **[Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-nodeport)**.
- If the LoadBalancer type is LoadBalancer:

  - For GCP or Azure, Kubernetes will allocate a cloud load balancer for load balancing the NGINX Gateway Fabric pods. Use the public IP of the load balancer to access NGINX Gateway Fabric.
  - For AWS, Kubernetes will allocate a Network Load Balancer (NLB) in TCP mode with the PROXY protocol enabled to pass the client’s information (the IP address and the port).

    Use the public IP of the load balancer to access NGINX Gateway Fabric. To get the public IP which is reported in the EXTERNAL-IP column:

    For GCP or Azure, run:

    ```bash
    # azure
    kubectl get svc nginx-gateway -n nginx-gateway
    NAME            TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE

    nginx-gateway   LoadBalancer   10.0.160.21   52.228.166.50   80:30244/TCP,443:31999/TCP   17h
    # repsys11-c2-n1
    kubectl get svc nginx-gateway -n nginx-gateway
    NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
    nginx-gateway   LoadBalancer   10.152.183.50   10.1.0.143    80:30833/TCP,443:31343/TCP   82s
    ```

    In AWS, the NLB (Network Load Balancer) DNS (directory name system) name will be reported by Kubernetes instead of a public IP. To get the DNS name, run:

    ```bash
    kubectl get svc nginx-gateway -n nginx-gateway
    ```

    **Note:**\
    We recommend using the NLB DNS whenever possible, but for testing purposes, you can resolve the DNS name to get the IP address of the load balancer:

    ```nslookup <dns-name>```

**Tip:**\
Learn more about type LoadBalancer in the **[Kubernetes documentation](https://kubernetes.io/docs/concepts/services-networking/service/#type-loadbalancer)**.

For AWS, additional options regarding an allocated load balancer are available, such as its type and SSL termination. Read the Kubernetes documentation to learn more.

## Note

Tlsroute may not be supported on **[Azure Loadbalancers](https://stackoverflow.com/questions/53383614/configuring-an-aks-load-balancer-for-https-access)**.

You are right, the default Load Balancer created by AKS is a Layer 4 LB and doesn't support SSL offloading. The equivalent of the AWS Application Load Balancer in Azure is the Application Gateway. As of now there is no option in AKS which allows to choose the Application Gateway instead of a classic load balancer, but like alev said, there is an **[ongoing project](https://github.com/Azure/application-gateway-kubernetes-ingress/)** that still in preview which will allow to deploy a special ingress controller that will drive the routing rules on an external Application Gateway based on your ingress rules. If you really need something that is production ready, here are your options :

- Deploy an Ingress controller like NGINX, Traefik, etc. and use cert-manager to generate your certificate.
- Create an Application Gateway and manage your own routing rule that will point to the default layer 4 LB (k8s LoadBalancer service or via the ingress controller)

In the **[Comparing AKS Ingress options](../research/a_l/azure/aks/ingress_controllers.md#compare-ingress-options)** table it is shown that the only option to provide TLS termination externally is the **[Azure Application Gateway for Containers](https://gateway-api.sigs.k8s.io/api-types/gateway/#gateway)**

## Important:**\

By default Helm and manifests configure NGINX Gateway Fabric on ports 80 and 443, affecting any gateway **[listeners](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.Listener)** on these ports. To use different ports, update the configuration. NGINX Gateway Fabric requires a configured **[gateway resource](https://gateway-api.sigs.k8s.io/api-types/gateway/#gateway)** with a valid listener to listen on any ports.

NGINX Gateway Fabric uses the created service to update the Addresses field in the Gateway Status resource. Using a LoadBalancer service sets this field to the IP address and/or hostname of that service. Without a service, the pod IP address is used.

This gateway is associated with the NGINX Gateway Fabric through the gatewayClassName field. The default installation of NGINX Gateway Fabric creates a GatewayClass with the name nginx. NGINX Gateway Fabric will only configure gateways with a gatewayClassName of nginx unless you change the name via the --gatewayclass command-line flag.

## THIS may work

**[ingress with tls termination example](https://github.com/MicrosoftDocs/azure-docs/blob/90f41730b9836e89d3e53b44707109c32b5e52d0/articles/aks/ingress-own-tls.md)**
