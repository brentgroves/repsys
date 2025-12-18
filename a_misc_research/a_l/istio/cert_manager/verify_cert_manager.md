# **[Verifying the Installation](https://cert-manager.io/v1.6-docs/installation/verify/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

## Check cert-manager API

First, make sure that **[cmctl is installed](https://cert-manager.io/v1.6-docs/usage/cmctl/#installation)**.

cmctl performs a dry-run certificate creation check against the Kubernetes cluster. If successful, the message The cert-manager API is ready is displayed.

```bash
$ cmctl check api
The cert-manager API is ready
```

The command can also be used to wait for the check to be successful. Here is an output example of running the command at the same time that cert-manager is being installed:

```bash
$ cmctl check api --wait=2m
Not ready: the cert-manager CRDs are not yet installed on the Kubernetes API server
Not ready: the cert-manager CRDs are not yet installed on the Kubernetes API server
Not ready: the cert-manager webhook deployment is not ready yet
Not ready: the cert-manager webhook deployment is not ready yet
Not ready: the cert-manager webhook deployment is not ready yet
Not ready: the cert-manager webhook deployment is not ready yet
The cert-manager API is ready
```
