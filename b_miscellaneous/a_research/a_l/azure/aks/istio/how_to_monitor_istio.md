# **[Monitoring Istio on AKS with Prometheus and Grafana](https://hshahin.com/monitoring-istio-on-aks-with-prometheus-and-grafana/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

As more teams deploy Istio on AKS, I want to demonstrate how to leverage the Managed Prometheus and Grafana services in Azure to monitor the service mesh and associated services sitting behind it.

One of the benefits of leveraging Istio in your stack on AKS is that you can get metrics about calls being made to your backend service without needing to manually instrument your application. This comes from the injected envoy sidecars and the ingress gateway Istio deploys. With the Managed Prometheus and Grafana services in Azure, we have an easy path towards a fully managed solution to store and monitor those exposed metrics.

A few pre-requisites that I'm expecting:

- AKS
- Istio on AKS
- Azure Monitor Workspace linked to Grafana - if you need guidance on this one, review my post on **[integrating Prometheus with AKS](https://hshahin.com/prometheus-with-kubernetes-on-azure/)**
