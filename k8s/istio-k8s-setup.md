# **[Set up a Kubernetes Cluster for Istio](https://istio.io/latest/docs/examples/microservices-istio/setup-kubernetes-cluster/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

This guide lets you quickly evaluate Istio. If you are already familiar with Istio or interested in installing other configuration profiles or advanced deployment models, refer to our which Istio installation method should I use? FAQ page.

## references

- **[microk8s istio](https://gist.github.com/Realiserad/391855c4a0fb0072994e5ad2a53d65c0)**

## 1

```bash
pushd .
cd ~/src/repsys/k8s
# Create an environment variable to store the name of a namespace that you will use when you run the tutorial commands. You can use any name, for example tutorial.

export NAMESPACE=tutorial

# Create the namespace:
kubectl create namespace $NAMESPACE
namespace/tutorial created
```
