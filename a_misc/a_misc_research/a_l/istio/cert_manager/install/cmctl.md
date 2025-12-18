# **[cmctl](https://cert-manager.io/v1.6-docs/usage/cmctl/#installation)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

cmctl is a CLI tool that can help you to manage cert-manager resources inside your cluster.

While also available as a **[kubectl plugin](https://cert-manager.io/v1.6-docs/usage/kubectl-plugin/)**, it is recommended to use as a stand alone binary as this allows the use of command **[auto-completion](https://cert-manager.io/v1.6-docs/usage/cmctl/#completion)**.

## Installation

You need the cmctl.tar.gz file for the platform you're using, these can be found on our **[GitHub releases page](https://github.com/cert-manager/cert-manager/releases)**. In order to use cmctl you need its binary to be accessible under the name cmctl in your $PATH. Run the following commands to set up the CLI. Replace OS and ARCH with your systems equivalents:
