# **[Cloud native certificate management](https://kubernetes.io/docs/tasks/administer-cluster/cpu-management-policies/#cpu-management-policies)**

**[Current Status](../../../../../`development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

cert-manager is a powerful and extensible X.509 certificate controller for Kubernetes and OpenShift workloads. It will obtain certificates from a variety of Issuers, both popular public Issuers as well as private Issuers, and ensure the certificates are valid and up-to-date, and will attempt to renew certificates at a configured time before expiry.

## references

- **[cert-manager](https://cert-manager.io/)**

## cert-manager

cert-manager creates TLS certificates for workloads in your Kubernetes or OpenShift cluster and renews the certificates before they expire.

cert-manager can obtain certificates from a variety of **[certificate authorities](https://cert-manager.io/docs/configuration/issuers/)**, including: **[Let's Encrypt](https://cert-manager.io/docs/configuration/acme/)**, HashiCorp Vault, Venafi and private PKI.

With cert-manager's **[Certificate resource](https://cert-manager.io/docs/usage/certificate/)**, the private key and certificate are stored in a Kubernetes Secret which is mounted by an application Pod or used by an Ingress controller. With csi-driver, csi-driver-spiffe, or istio-csr , the private key is generated on-demand, before the application starts up; the private key never leaves the node and it is not stored in a Kubernetes Secret.

![cert](https://cert-manager.io/images/high-level-overview.svg)

Buy domain name such as repsys.io.

Simply open Terminal and type “whois domain.” Be sure to replace “domain” with the domain you want to check the availability of, as shown below in the Terminal image when checking the availability of alvinbrown.in. Hit the “Enter” key, and the domain's availability will be displayed as shown in the image below.

AKS + LoadBalancer + Let's Encrypt: Learn how to deploy cert-manager on Azure Kubernetes Service (AKS) and how to configure it to get certificates for an HTTPS web server, from Let's Encrypt.
