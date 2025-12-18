# **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

In this tutorial you will learn how to deploy and configure cert-manager on Azure Kubernetes Service (AKS) and how to deploy an HTTPS web server and make it available on the Internet. You will learn how to configure cert-manager to get a signed certificate from Let's Encrypt, which will allow clients to connect to your HTTPS website securely. You will configure cert-manager to use the Let's Encrypt **[DNS-01 challenge protocol](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge)** with Azure DNS, using workload identity federation to authenticate to Azure.

## Part 1

In the first part of this tutorial you will learn the basics required to deploy an HTTPS website on an Azure Kubernetes cluster using cert-manager to create the SSL certificate for the web server. You will create a DNS domain for your website, create an Azure Kubernetes cluster, install cert-manager, create an SSL certificate and then deploy a web server which responds to HTTPS requests from clients on the Internet. But the SSL certificate in part 1 is only for testing purposes.

In part 2 you will learn how to configure cert-manager to use Let's Encrypt and Azure DNS to create a trusted SSL certificate which you can use in production.

## Configure the Azure CLI (az)

Already done.

## Create a public domain name

Note: Use linamar.repsys.dev

In this tutorial you will deploy an HTTPS website with a publicly accessible domain name, so you will need to register a domain unless you already have one. You could use any domain name registrar to register a domain name for your site. Here we will use a registrar called Gandi and register a cheap domain name for the purposes of this tutorial. We will use the domain name: cert-manager-tutorial-22.site but you should choose your own.

Now that you know your domain name, save it in an environment variable:


export DOMAIN_NAME=cert-manager-tutorial-22.site # ❗ Replace this with your own DNS domain name

Note: I don't think we have to do this since I am using AWS Route53 for DNS.

And add it to Azure DNS as a zone:


az network dns zone create --name $DOMAIN_NAME

## Create a Kubernetes cluster

Already done.

## Install cert-manager

Note: This is important because it shows us how to install cert-manager in AKS.

Now you can install and configure cert-manager.

Install cert-manager using helm as follows:

```bash
helm repo add jetstack https://charts.jetstack.io --force-update
helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \
  --create-namespace \
  --version v1.16.2 \
  --set crds.enabled=true
```

This will create three Deployments and some Services and Pods in a new namespace called cert-manager. It also installs various cluster scoped supporting resources such as RBAC roles and Custom Resource Definitions.

