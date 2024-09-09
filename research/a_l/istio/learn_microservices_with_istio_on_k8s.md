# **[Learn Microservices using Kubernetes and Istio](https://istio.io/latest/docs/examples/microservices-istio/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## What are Microservices

In short, the microservice architectural style is an approach to developing a single application as a suite of small services, each running in its own process and communicating with lightweight mechanisms, often an HTTP resource API. These services are built around business capabilities and independently deployable by fully automated deployment machinery. There is a bare minimum of centralized management of these services, which may be written in different programming languages and use different data storage technologies.

## What is Istio?

Istio is an open source service mesh that layers transparently onto existing distributed applications. Istio’s powerful features provide a uniform and more efficient way to secure, connect, and monitor services. Istio is the path to load balancing, service-to-service authentication, and monitoring – with few or no service code changes. It gives you:

Secure service-to-service communication in a cluster with mutual TLS encryption, strong identity-based authentication and authorization
Automatic load balancing for HTTP, gRPC, WebSocket, and TCP traffic
Fine-grained control of traffic behavior with rich routing rules, retries, failovers, and fault injection
A pluggable policy layer and configuration API supporting access controls, rate limits and quotas
Automatic metrics, logs, and traces for all traffic within a cluster, including cluster ingress and egress
Istio is designed for extensibility and can handle a diverse range of deployment needs. Istio’s control plane runs on Kubernetes, and you can add applications deployed in that cluster to your mesh, extend the mesh to other clusters, or even connect VMs or other endpoints running outside of Kubernetes.

A large ecosystem of contributors, partners, integrations, and distributors extend and leverage Istio for a wide variety of scenarios. You can install Istio yourself, or a large number of vendors have products that integrate Istio and manage it for you.

## setup k8s cluster

Ensure you have access to a Kubernetes cluster. You can use the Google Kubernetes Engine or the IBM Cloud Kubernetes Service.

Create an environment variable to store the name of a namespace that you will use when you run the tutorial commands. You can use any name, for example tutorial.

```bash
scc.sh repsys11c2n1.yaml microk8s
export NAMESPACE=tutorial
# Create the namespace:
kubectl create namespace $NAMESPACE
```

**[Install Istio](./install_istio.md)** using the demo profile.
