# **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager](https://istio.io/latest/docs/ops/integrations/certmanager/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

Let’s say you have a Microservice that you would like to expose to the Internet. One of the key requirements before you expose the service is to make it available at a secure endpoint (such as <https://checkout.example.com>).

Even though this is a simple requirement, this is often thought out towards the end of the deployment steps (typically when you are about to make DNS changes). This is primarily because the steps involved in procuring certificates and configuring them have been hard. And then once the certificates are deployed, someone got to make sure they are renewed on time. These challenges are amplified when you operate a number of Microservices and there are many disparate teams managing them.

What if there is a simple and automated way to take care of this?

In this article, we will look at how to automate this entire process so that whenever you deploy a Microservice, a TLS certificate is automatically provisioned and the Microservice is mapped to a DNS entry.

## Overview

We will be using the following components to automatically provision a TLS certificate for our Microservice and map the ingress to a DNS endpoint.
