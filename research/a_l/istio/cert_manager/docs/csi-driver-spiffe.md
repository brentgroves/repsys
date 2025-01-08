# **[csi-driver-spiffe](https://cert-manager.io/docs/usage/csi-driver-spiffe/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

csi-driver-spiffe is a Container Storage Interface (CSI) driver plugin for Kubernetes, designed to work alongside cert-manager.

It transparently delivers **[SPIFFE](https://spiffe.io/)** **[SVIDs](https://spiffe.io/docs/latest/spiffe-about/spiffe-concepts/#spiffe-verifiable-identity-document-svid)** (in the form of X.509 certificate key pairs) to mounting Kubernetes Pods.

The end result is that any and all Pods running in Kubernetes can securely request a SPIFFE identity document from a Trust Domain with minimal configuration.

These documents in turn have the following properties:

automatically renewed ✔️
private key never leaves the node's virtual memory ✔️
each Pod's document is unique ✔️
the document shares the same life cycle as the Pod and is destroyed on Pod termination ✔️
enable mTLS within a trust domain ✔️
