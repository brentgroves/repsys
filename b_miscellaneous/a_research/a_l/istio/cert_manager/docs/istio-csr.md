# **[Securing Istio Service Mesh](https://cert-manager.io/docs/usage/istio-csr/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[mtls everywhere](https://blog.frankel.ch/mtls-everywhere/)**
- **[Enable mTLS on Pods with CSI: Using the cert-manager CSI driver to provide unique keys and certificates that share the lifecycle of pods.](https://cert-manager.io/docs/usage/csi/)**
- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

![istio](https://cert-manager.io/images/request-certificate-overview/request-certificate-mesh.svg)

cert-manager can be integrated with Istio using the project istio-csr. istio-csr will deploy an agent that is responsible for receiving certificate signing requests for all members of the Istio mesh, and signing them through cert-manager.

istio-csr is an agent that allows for Istio workload and control plane components to be secured using cert-manager.

Certificates facilitating mTLS — both inter and intra-cluster — will be signed, delivered and renewed using **[cert-manager issuers](https://cert-manager.io/docs/concepts/issuer)**.
