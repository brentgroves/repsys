# **[Vault](https://www.vaultproject.io/)**

**[Current Status](../../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research_list.md)**\
**[Back Main](../../../../../../README.md)**

## references

- **[PKI secrets engine](https://developer.hashicorp.com/vault/docs/secrets/pki)**

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

The PKI secrets engine generates dynamic X.509 certificates. With this secrets engine, services can get certificates without going through the usual manual process of generating a private key and CSR, submitting to a CA, and waiting for a verification and signing process to complete. Vault's built-in authentication and authorization mechanisms provide the verification functionality.

## Manage secrets and protect sensitive data with Vault

Secure, store, and tightly control access to tokens, passwords, certificates, and encryption keys for protecting secrets and other sensitive data using a UI, CLI, or HTTP API.

## Application and machine identity

Secure applications and systems with machine identity and automate credential issuance, rotation, and more. Enable attestation of application and workload identity, using Vault as the trusted authority.

## User identity with Vault

Leverage trusted identity platforms you use everyday to secure, store, and access credentials and resources.

## How Vault works

Vault tightly controls access to secrets and encryption keys by authenticating against trusted sources of identity such as Active Directory, LDAP, Kubernetes, CloudFoundry, and cloud platforms.

## **[Automated PKI infrastructure](https://www.vaultproject.io/use-cases/automated-pki-infrastructure)**

## Challenge

Creating, rotating, and managing certificates is cumbersome and time consuming
Organizations should protect their infrastructure. However, traditional PKI process workflow takes a long time, which motivates organizations to create certificates which do not expire for a year or more.

## Solution

Generate and rotate certificates on demand with Vault

Vault's PKI secrets engine can dynamically generate X.509 certificates on demand. This allows services to acquire certificates without going through the usual manual process of generating a private key and Certificate Signing Request (CSR), submitting to a Certificate Authority (CA), and then waiting for the verification and signing process to complete.
