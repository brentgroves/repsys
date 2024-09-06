# **[Learn Microservices using Kubernetes and Istio](https://istio.io/latest/docs/examples/microservices-istio/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## setup k8s cluster

Ensure you have access to a Kubernetes cluster. You can use the Google Kubernetes Engine or the IBM Cloud Kubernetes Service.

Create an environment variable to store the name of a namespace that you will use when you run the tutorial commands. You can use any name, for example tutorial.

```bash
scc.sh repsys11c2n1.yaml microk8s
export NAMESPACE=tutorial
# Create the namespace:
kubectl create namespace $NAMESPACE
```

**[Install Istio](https://istio.io/latest/docs/setup/getting-started/)** using the demo profile.
