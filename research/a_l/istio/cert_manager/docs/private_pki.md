# **[Private PKI](https://cert-manager.io/docs/configuration/ca/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

⚠️ CA issuers are generally for cert-manager demos or for advanced users with experience and tooling for running a PKI. To be used safely in production, CA issuers introduce complex planning requirements around rotation, trust store distribution and disaster recovery.

If you're not planning to run your own PKI, use a different issuer type.

Otherwise, be sure to read the Important Information below.

The CA issuer represents a Certificate Authority whose certificate and private key are stored inside the cluster as a Kubernetes Secret.

Certificates issued by a CA issuer will not be publicly trusted and so are unlikely to be trusted by your applications without further configuration.

Consider trust-manager for distributing your CA certificate safely across your cluster!
