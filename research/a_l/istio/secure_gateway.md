# **[Secure Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The **[Control Ingress Traffic task](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)** describes how to configure an ingress gateway to expose an HTTP service to external traffic. This task shows how to expose a secure HTTPS service using either simple or mutual TLS.

## **[self-signed root certificate](https://istio.io/latest/docs/tasks/security/cert-management/plugin-ca-cert/)**

By default the Istio CA generates a self-signed root certificate and key and uses them to sign the workload certificates. To protect the root CA key, you should use a root CA which runs on a secure machine offline, and use the root CA to issue intermediate certificates to the Istio CAs that run in each cluster. An Istio CA can sign workload certificates using the administrator-specified certificate and key, and distribute an administrator-specified root certificate to the workloads as the root of trust.
