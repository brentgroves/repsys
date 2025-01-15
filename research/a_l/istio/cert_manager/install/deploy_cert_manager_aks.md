# **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

In this tutorial you will learn how to deploy and configure cert-manager on Azure Kubernetes Service (AKS) and how to deploy an HTTPS web server and make it available on the Internet. You will learn how to configure cert-manager to get a signed certificate from Let's Encrypt, which will allow clients to connect to your HTTPS website securely. You will configure cert-manager to use the **[Let's Encrypt DNS-01 challenge protocol](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge)** with Azure DNS, using workload identity federation to authenticate to Azure.

1. Create a public domain name

    ```bash
    export DOMAIN_NAME=cert-manager-tutorial-22.site # ❗ Replace this with your own DNS domain name
    ```

2. Install cert-manager

    ```bash
    helm repo add jetstack https://charts.jetstack.io --force-update
    helm install \
    cert-manager jetstack/cert-manager \
    --namespace cert-manager \
    --create-namespace \
    --version v1.16.2 \
    --set crds.enabled=true
    ```
