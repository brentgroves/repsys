# **[Cloud native certificate management](https://cert-manager.io/docs/)**

**[Current Status](../../../../../`development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

cert-manager is a powerful and extensible X.509 certificate controller for Kubernetes and OpenShift workloads. It will obtain certificates from a variety of Issuers, both popular public Issuers as well as private Issuers, and ensure the certificates are valid and up-to-date, and will attempt to renew certificates at a configured time before expiry.

## references

- **[cert-manager](https://cert-manager.io/)**
- **[what is cert-manager](https://venafi.com/open-source/cert-manager/#item-4)**

## cert-manager

cert-manager creates TLS certificates for workloads in your Kubernetes or OpenShift cluster and renews the certificates before they expire.

cert-manager can obtain certificates from a variety of **[certificate authorities](https://cert-manager.io/docs/configuration/issuers/)**, including: **[Let's Encrypt](https://cert-manager.io/docs/configuration/acme/)**, HashiCorp Vault, Venafi and private PKI.

With cert-manager's **[Certificate resource](https://cert-manager.io/docs/usage/certificate/)**, the private key and certificate are stored in a Kubernetes Secret which is mounted by an application Pod or used by an Ingress controller. With csi-driver, csi-driver-spiffe, or istio-csr , the private key is generated on-demand, before the application starts up; the private key never leaves the node and it is not stored in a Kubernetes Secret.

![cert](https://cert-manager.io/images/high-level-overview.svg)

Buy domain name such as repsys.io.

Simply open Terminal and type “whois domain.” Be sure to replace “domain” with the domain you want to check the availability of, as shown below in the Terminal image when checking the availability of alvinbrown.in. Hit the “Enter” key, and the domain's availability will be displayed as shown in the image below.

AKS + LoadBalancer + Let's Encrypt: Learn how to deploy cert-manager on Azure Kubernetes Service (AKS) and how to configure it to get certificates for an HTTPS web server, from Let's Encrypt.

## **[what is cert-manager](https://venafi.com/open-source/cert-manager/#item-4)**

At its core, cert-manager is a cloud native certificate management tool that automatically issues and renews X.509 machine identities as first-class resource types within Kubernetes. To do this, cert-manager needs to be deployed inside a Kubernetes cluster. Once installed, cert-manager can issue and renew certificates for all the machine identities contained within a cluster, no matter how short their lifespans become.

It's easy to see the role cert-manager can play for your organization. With the use of cloud native technologies and Kubernetes only heading in one direction, the management and protection of cloud native machine identities is increasingly complex. But it doesn’t have to be!

Organizations that use cert-manager reduce the likelihood of certificate-based outages and secure their workloads by verifying all the machine identities that are contained within a Kubernetes cluster. Without cert-manager, manually finding and configuring TLS certificates will become ridiculously burdensome, and time-consuming. Thankfully, cert-manager removes this burden for developers, which is why they love using cert-manager.  

## How does cert-manager work?

To quote cert-manager directly, “cert-manager adds certificates and certificate issuers as resource types in Kubernetes clusters, and simplifies the process of obtaining, renewing and using those certificates.” In other words, cert-manager encrypts cloud native workloads by issuing and renewing certificates that have been obtained as part of a PKI.

![issuers](https://cdn.venafi.com/994513b8-133f-0003-9fb3-9cbe4b61ffeb/5453a975-7ef2-4714-9789-604a304ab20b/how-cert-manager-works.png?fm=webp&q=85)

In terms of flow, Issuers are a Kubernetes resource that represents a Certificate Authority, which generates signed certificates as requested. But cert-manager will specify the type of certificate that is needed, how long it should be valid for, renewal terms, and the required issuer. Once it’s been issued, the certificate will be stored as a Kubernetes Secret.

## What cloud service providers (CSPs) are compatible with cert-manager?

cert-manager is an open source project that builds on top of Kubernetes to provide X.509 certificates and issuers as first class resource types. Fast-forward a few years and enterprise DevOps teams are deploying cert-manager to production clusters with all the major cloud service providers (CSPs)

- Red Hat OpenShift
- Google Kubernetes Engine (GKE)
- Azure Kubernetes Service (AKS)
- Amazon Elastic Kubernetes Service (EKS)
- VMware Tanzu

## What are some uses cases of cert-manager?

cert-manager has received some accolades in recent years. At the start of 2021, cert-manager was being considered an essential general solution for secrets management within the CNCF End User Technology Report. By the end of the year, it was included in the ThoughtWorks Technology Radar for the first time! But what are some of the more practical applications of cert-manager? Why is it being downloaded over a million times each day?

Let's take a closer look at the different ways cert-manager is being deployed to secure cloud native machine identities.

## Securing ingress traffic  

One of the most widespread uses of cert-manager is to secure incoming traffic to your Kubernetes clusters with TLS encryption. It just makes sense. You wouldn’t give a stranger the keys to your house - so why would organizations running highly distributed infrastructure give unfiltered access to public-facing workloads? They shouldn’t.

By verifying the machine identities of incoming traffic and adopting one of the core principles of Zero Trust (never trust, always verify), organizations will ensure that their public-facing web applications are locked down and tamper-resistant.

## mTLS protection

Developers often build internal workloads that aren't necessarily exposed to ingress traffic but could still be susceptible to an attack if a nefarious actor found their way into a related Kubernetes cluster. It’s no longer enough to assume your network perimeter is perfectly secure. We need to secure east-to-west traffic as well as north-to-south traffic within clusters.

An mTLS type deployment for mutually authenticated communication would typically use cert-manager as the conduit to issue and renew private certificates. Whether through HashiCorp Vault, ACME, or Venafi Firefly, there are several ways organizations can utilize cert-manager to extend the underlying principles of Zero Trust to include internal workloads.

## Managing workloads in a service mesh

A service mesh is a networking technology that allows secure connections between the increasingly expanding number of end points within a cloud native architecture. Often seen as an extension of mTLS, cert-manager can be used to issue and renew certificates within service mesh zones.

A service mesh will only allow access to services within a microservice architecture that has explicit authorization to do so. This service-based identity allows an application to seamlessly scale resources to keep in line with demand. And how might a resource identify itself to a service?

 You guessed it. TLS certificates.

In short, cert-manager acts as a control plane that can be used within service mesh environments to enforce security policies for mesh workload encryption and automated protection.
