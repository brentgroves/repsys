# **[cert-manager](https://cert-manager.io/docs/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

cert-manager creates TLS certificates for workloads in your Kubernetes or OpenShift cluster and renews the certificates before they expire.

cert-manager can obtain certificates from a **[variety of certificate authorities](https://cert-manager.io/docs/configuration/issuers/)**, including: Let's Encrypt, HashiCorp Vault, Venafi and private PKI.

With cert-manager's **[Certificate resource](https://cert-manager.io/docs/usage/certificate/)**, the private key and certificate are stored in a Kubernetes Secret which is mounted by an application Pod or used by an Ingress controller. With csi-driver, **[csi-driver-spiffe](https://cert-manager.io/docs/usage/csi-driver-spiffe/)**, or **[istio-csr](https://cert-manager.io/docs/usage/istio-csr/)** , the private key is generated on-demand, before the application starts up; the private key never leaves the node and it is not stored in a Kubernetes Secret.
