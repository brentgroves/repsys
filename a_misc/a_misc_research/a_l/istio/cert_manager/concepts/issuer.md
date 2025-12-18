# **[Issuers, and ClusterIssuers](https://cert-manager.io/docs/concepts/issuer/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[Automatic Certificate Management Environment (ACME)](https://datatracker.ietf.org/doc/html/rfc8555)**
- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

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

## Issuer Configuration

The first thing you'll need to configure after you've installed cert-manager is an Issuer or a ClusterIssuer. These are resources that represent certificate authorities (CAs) able to sign certificates in response to certificate signing requests.

This section documents how the different issuer types can be configured. You might want to read more about Issuer and ClusterIssuer resources.

cert-manager comes with a number of built-in certificate issuers which are denoted by being in the cert-manager.io group. You can also install external issuers in addition to the built-in types. Built-in and external issuers are treated the same and are configured similarly.

## Cluster Resource Namespace

When using ClusterIssuer resource types, ensure you understand the purpose of the Cluster Resource Namespace; this can be a common source of issues for people getting started with cert-manager.

The ClusterIssuer resource is cluster scoped. This means that when referencing a secret via the secretName field, secrets will be looked for in the Cluster Resource Namespace. By default, this namespace is cert-manager however it can be changed via a flag on the cert-manager-controller component:

`--cluster-resource-namespace=my-namespace`

## Issuers

The following list contains all known cert-manager issuer integrations

| Tier | Controller                  | Docs | Issuer                                         | cert-manager version used in tutorial1 | Released within 12 months2 | Is Open Source |
|------|-----------------------------|------|------------------------------------------------|----------------------------------------|----------------------------|----------------|
| 🥇    | acme-issuer (in-tree)       | 📄    | ACME                                           | latest                                 | ✔️                          | ✔️              |
| 🥇    | venafi-enhanced-issuer      | 📄    | Venafi TLS Protect                             | v1.12.1                                | ✔️                          | ❌              |
| 🥇    | origin-ca-issuer            | 📄    | Cloudflare Origin CA                           | supported                              | ✔️                          | ✔️              |
| 🥈    | adcs-issuer                 | 📄    | Microsoft Active Directory Certificate Service | -                                      | ✔️                          | ✔️              |
| 🥈    | aws-privateca-issuer        | 📄    | AWS Private Certificate Authority              | -                                      | ✔️                          | ✔️              |
| 🥈    | ca-issuer (in-tree)         | 📄    | CA issuer                                      | -                                      | ✔️                          | ✔️              |
| 🥈    | czertainly-issuer           | 📄    | CZERTAINLY                                     | supported                              | ✔️                          | ✔️              |
| 🥈    | command-issuer              | 📄    | Keyfactor Command                              | -                                      | ✔️                          | ✔️              |
| 🥈    | cview-issuer                | 📄    | CView-issuer                                   | -                                      | ✔️                          | ❌              |
| 🥈    | ejbca-issuer                | 📄    | EJBCA                                          | -                                      | ✔️                          | ✔️              |
| 🥈    | google-cas-issuer           | 📄    | Google Cloud Certificate Authority Service     | -                                      | ✔️                          | ✔️              |
| 🥈    | gs-atlas-issuer             | 📄    | GlobalSign CA                                  | -                                      | ✔️                          | ✔️              |
| 🥈    | horizon-issuer              | 📄    | EVERTRUST Horizon                              | -                                      | ✔️                          | ✔️              |
| 🥈    | ncm-issuer                  | 📄    | Nokia Netguard Certificate Manager             | -                                      | ✔️                          | ✔️              |
| 🥈    | selfsigned-issuer (in-tree) | 📄    | Self-Signed issuer                             | -                                      | ✔️                          | ✔️              |
| 🥈    | step-issuer                 | 📄    | Certificate Authority server                   | -                                      | ✔️                          | ✔️              |
| 🥈    | vault-issuer (in-tree)      | 📄    | HashiCorp Vault                                | -                                      | ✔️                          | ✔️              |
| 🥈    | venafi-issuer (in-tree)     | 📄    | Venafi TLS Protect                             | -                                      | ✔️                          | ✔️              |
| 🥈    | cfssl-issuer                | 📄    | CFSSL                                          | -                                      | ✔️                          | ✔️              |
| 🥉    | tcs-issuer                  | 📄    | Intel's SGX technology                         | -                                      | ❌                          | ✔️              |
| 🥉    | freeipa-issuer              | 📄    | FreeIPA                                        | -                                      | ❌                          | ✔️              |
| 🥉    | kms-issuer                  | 📄    | AWS KMS                                        | -                                      | ❌                          | ✔️              |

- The issuers are sorted by their tier and then alphabetically.
- "in-tree" issuers are issuers that are shipped with cert-manager itself.
- These issuers are known to support and honor **[approval](https://cert-manager.io/docs/concepts/certificaterequest/#approval)**.
