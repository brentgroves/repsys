# **[Cert Manager Install](https://cert-manager.io/docs/installation/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

## Installation

Learn about the various ways you can install cert-manager and how to choose between them.

### Default static install

You don't require any tweaking of the cert-manager install parameters.

The default static configuration can be installed as follows:

```bash
kubectl apply -f https://github.com/cert-manager/cert-manager/releases/download/v1.16.2/cert-manager.yaml
```

 Read more about **[installing cert-manager using kubectl apply and static manifests](https://cert-manager.io/docs/installation/kubectl/)**.

## Getting started

You quickly want to learn how to use cert-manager and what it can be used for.

📖 kubectl apply: For new users we recommend installing cert-manager using kubectl apply and static manifests.

📖 helm: You can **[use helm to install cert-manager](https://cert-manager.io/docs/installation/helm/)** and this also allows you to customize the installation if necessary.

📖 OperatorHub: If you have an OpenShift cluster, consider installing cert-manager via OperatorHub, which you can do from the OpenShift web console.

🚧 cmctl: Try the experimental cmctl x install command to quickly install cert-manager.
