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
Istio has been successfully downloaded into the istio-1.24.1 folder on your system.

Next Steps:
See https://istio.io/latest/docs/setup/install/ to add Istio to your Kubernetes cluster.

To configure the istioctl client tool for your workstation,
add the /home/brent/Downloads/istio-1.24.1/bin directory to your environment path variable with:
         export PATH="$PATH:/home/brent/Downloads/istio-1.24.1/bin"

Begin the Istio pre-installation check by running:
istioctl x precheck 

Need more information? Visit https://istio.io/latest/docs/setup/install/ 
```

## Step 2

Move to the Istio package directory. For example, if the package is istio-1.23.0:

```bash
# remove old version
sudo rm /usr/local/bin/istioctl
sudo cp istio-1.24.1/bin/istioctl /usr/local/bin/

istioctl x precheck 
✔ No issues found when checking the cluster. Istio is safe to install or upgrade!
  To get started, check out https://istio.io/latest/docs/setup/getting-started/.
```

The installation directory contains:

- Sample applications in samples/
- The istioctl client binary in the bin/ directory.

```bash
ls ~/Downloads/istio-1.24.1                   
bin  LICENSE  manifests  manifest.yaml  README.md  samples  tools
```

## Install Istio on K8s

For this guide, we use the demo **[configuration profile](https://istio.io/latest/docs/setup/additional-setup/config-profiles/)**. It is selected to have a good set of defaults for testing, but there are other profiles for production, performance testing or OpenShift.

Unlike **[Istio Gateways](https://istio.io/latest/docs/concepts/traffic-management/#gateways)**, creating **[Kubernetes Gateways](https://gateway-api.sigs.k8s.io/api-types/gateway/)** will, by default, also deploy **[gateway proxy servers](https://istio.io/latest/docs/tasks/traffic-management/ingress/gateway-api/#automated-deployment)**. Because they won’t be used, we disable the deployment of the default Istio gateway services that are normally installed as part of the demo profile.

Install Istio using the demo profile, without any gateways:

```bash
scc.sh kind.yaml microk8s 
pushd .

cd ~/Downloads/istio-1.24.1

# If you are going to use the Gateway API instructions, you can install Istio using the minimal profile because you will not need the istio-ingressgateway which is otherwise installed by default:

istioctl install --set profile=minimal
This will install the Istio 1.23.2 "minimal" profile (with components: Istio core and Istiod) into the cluster. Proceed? (y/N) y
✔ Istio core installed 
✔ Istiod installed 🧠                         
✔ Installation complete                                                                Made this installation the default for cluster-wide operations.

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
