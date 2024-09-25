# **[Getting Started Istio](https://istio.io/latest/docs/setup/getting-started/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

This guide lets you quickly evaluate Istio. If you are already familiar with Istio or interested in installing other configuration profiles or advanced deployment models, refer to our which Istio installation method should I use? FAQ page.

## references

- **[microk8s istio](https://gist.github.com/Realiserad/391855c4a0fb0072994e5ad2a53d65c0)**

## Uninstall

To delete the Bookinfo sample application and its configuration, see **[Bookinfo cleanup](https://istio.io/latest/docs/examples/bookinfo/#cleanup)**.

The Istio uninstall deletes the RBAC permissions and all resources hierarchically under the istio-system namespace. It is safe to ignore errors for non-existent resources because they may have been deleted hierarchically.

```bash
kubectl delete -f samples/addons
istioctl uninstall -y --purge
```

The istio-system namespace is not removed by default. If no longer needed, use the following command to remove it:

```bash
kubectl delete namespace istio-system
```

The label to instruct Istio to automatically inject Envoy sidecar proxies is not removed by default. If no longer needed, use the following command to remove it:

```bash
kubectl label namespace default istio-injection-
```

If you installed the Kubernetes Gateway API CRDs and would now like to remove them, run one of the following commands:

If you ran any tasks that required the experimental version of the CRDs:

```bash
kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd/experimental?ref=v1.1.0" | kubectl delete -f -
```

Otherwise:

```bash
kubectl kustomize "github.com/kubernetes-sigs/gateway-api/config/crd?ref=v1.1.0" | kubectl delete -f -
```

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
sudo cp istio-1.23.0/bin/istioctl /usr/local/bin/

```

The installation directory contains:

- Sample applications in samples/
- The istioctl client binary in the bin/ directory.

```bash
ls ~/Downloads/istio-1.23.0                   
bin  LICENSE  manifests  manifest.yaml  README.md  samples  tools
```

## Install Istio on K8s

For this guide, we use the demo **[configuration profile](https://istio.io/latest/docs/setup/additional-setup/config-profiles/)**. It is selected to have a good set of defaults for testing, but there are other profiles for production, performance testing or OpenShift.

Unlike **[Istio Gateways](https://istio.io/latest/docs/concepts/traffic-management/#gateways)**, creating **[Kubernetes Gateways](https://gateway-api.sigs.k8s.io/api-types/gateway/)** will, by default, also deploy **[gateway proxy servers](https://istio.io/latest/docs/tasks/traffic-management/ingress/gateway-api/#automated-deployment)**. Because they won’t be used, we disable the deployment of the default Istio gateway services that are normally installed as part of the demo profile.

Install Istio using the demo profile, without any gateways:

```bash
scc.sh repsys11c2n1.yaml microk8s 
pushd .
# Make a backup
cp ~/Downloads/istio-1.23.0/samples/bookinfo/demo-profile-no-gateways.yaml ~/src/repsys/research/a_l/istio 

cd ~/Downloads/istio-1.23.0
istioctl install -f samples/bookinfo/demo-profile-no-gateways.yaml -y
✔ Istio core installed
✔ Istiod installed
✔ Installation complete
Made this installation the default for injection and validation.
```

Add a namespace label to instruct Istio to automatically inject Envoy sidecar proxies when you deploy your application later:

```bash
$ kubectl label namespace default istio-injection=enabled
namespace/default labeled
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

1. Deploy the **[Bookinfo sample application](https://istio.io/latest/docs/examples/bookinfo/)**:

```bash
kubectl apply -f https://raw.githubusercontent.com/istio/istio/release-1.23/samples/bookinfo/platform/kube/bookinfo.yaml
```
