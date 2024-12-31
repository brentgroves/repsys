# **[cert-manager concepts](https://cert-manager.io/docs/concepts/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

**[cert-manager](https://cert-manager.io/)** is a tool that automates certificate management. This can be integrated with Istio gateways to manage TLS certificates.

There are several components and ideas that make up cert-manager. This section describes them on a conceptual level, to aid with understanding how cert-manager does its job.

You probably don't want this section if you're just getting started; check out a **[tutorial instead](https://cert-manager.io/docs/tutorials/)**.

## Issuer

Issuers, and ClusterIssuers, are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests. All cert-manager certificates require a referenced issuer that is in a ready condition to attempt to honor the request.

An example of an Issuer type is CA. A simple CA Issuer is as follows:

```yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ca-issuer
  namespace: mesh-system
spec:
  ca:
    secretName: ca-key-pair
```

This is a simple Issuer that will sign certificates based on a private key. The certificate stored in the secret ca-key-pair can then be used to trust newly signed certificates by this Issuer in a Public Key Infrastructure (PKI) system.

## Namespaces

An Issuer is a namespaced resource, and it is not possible to issue certificates from an Issuer in a different namespace. This means you will need to create an Issuer in each namespace you wish to obtain Certificates in.

If you want to create a single Issuer that can be consumed in multiple namespaces, you should consider creating a ClusterIssuer resource. This is almost identical to the Issuer resource, however is non-namespaced so it can be used to issue Certificates across all namespaces.

## Supported Issuers

cert-manager supports a number of 'in-tree', as well as 'out-of-tree' Issuer types. An exhaustive list of these Issuer types can be found in the cert-manager **[configuration documentation](https://cert-manager.io/docs/configuration/)**.

## ACME Orders and Challenges

cert-manager supports requesting certificates from ACME servers, including from **[Let's Encrypt](https://letsencrypt.org/)**, with use of the **[ACME Issuer](https://cert-manager.io/docs/configuration/acme/)**. These certificates are typically trusted on the public Internet by most computers. To successfully request a certificate, cert-manager must solve ACME Challenges which are completed in order to prove that the client owns the DNS addresses that are being requested.

In order to complete these challenges, cert-manager introduces two CustomResource types; Orders and Challenges.

## Orders

Order resources are used by the ACME issuer to manage the lifecycle of an ACME 'order' for a signed TLS certificate. More details on ACME orders and domain validation can be found on the Let's Encrypt website **[here](https://letsencrypt.org/how-it-works/)**. An order represents a single **[certificate request](https://cert-manager.io/docs/usage/certificaterequest/)** which will be created automatically once a new CertificateRequest resource referencing an ACME issuer has been created. CertificateRequest resources are created automatically by cert-manager once a **[Certificate](https://cert-manager.io/docs/usage/certificate/)** resource is created, has its specification changed, or needs renewal.

As an end-user, you will never need to manually create an Order resource. Once created, an Order cannot be changed. Instead, a new Order resource must be created.

The Order resource encapsulates multiple ACME 'challenges' for that 'order', and as such, will manage one or more Challenge resources.
