# **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## NOTE

This is the one I followed first since it describes a Route53 Issuer which I have.

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

## cert-manager

**[cert-manager](https://cert-manager.io/docs/installation/supported-releases/)** is a native Kubernetes certificate management controller. It can help with issuing certificates from a variety of sources, such as Let’s Encrypt, HashiCorp Vault, Venafi, a simple signing key pair, or self-signed.

## external-dns

**[external-dns](https://github.com/kubernetes-sigs/external-dns)** sets up DNS records at DNS providers that are external to Kubernetes such that Kubernetes services are discoverable via the external DNS providers and allows the controlling of DNS records to be done dynamically, in a DNS provider agnostic way.

external-dns will be used to create Amazon Route53 entries for our Microservice.

## Istio Service Mesh

Istio is an open-source service mesh that layers transparently onto existing distributed applications.

## Step By Step Guide

The below setup is performed on an EKS Cluster running Kubernetes version 1.21 with DNS hosted on Route53. IRSA (IAM Roles for Service Accounts) is used for accessing AWS services from EKS.

## Pre-requisites

You need to have the following installed on your laptop:

- eksctl – We will be creating an Amazon EKS Cluster to deploy our Microservice
- Helm – To deploy all required components
- kubectl – To connect to our Kubernetes cluster

## Create an EKS Cluster

Skipped this step since I'm using AKS.

Instead study **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](getting_started_aks_lets_encrypt.md)**
