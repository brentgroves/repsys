# **[ACME](https://cert-manager.io/docs/configuration/acme/)**

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

The ACME Issuer type represents a single account registered with the Automated Certificate Management Environment (ACME) Certificate Authority server. When you create a new ACME Issuer, cert-manager will generate a private key which is used to identify you with the ACME server.

Certificates issued by public ACME servers are typically trusted by client's computers by default. This means that, for example, visiting a website that is backed by an ACME certificate issued for that URL, will be trusted by default by most client's web browsers. ACME certificates are typically free.

## Solving Challenges

In order for the ACME CA server to verify that a client owns the domain, or domains, a certificate is being requested for, the client must complete "challenges". This is to ensure clients are unable to request certificates for domains they do not own and as a result, fraudulently impersonate another's site. As detailed in the **[RFC8555](https://tools.ietf.org/html/rfc8555)**, cert-manager offers two challenge validations - HTTP01 and DNS01 challenges.

**[HTTP01](https://cert-manager.io/docs/configuration/acme/http01/)** challenges are completed by presenting a computed key, that should be present at a HTTP URL endpoint and is routable over the internet. This URL will use the domain name requested for the certificate. Once the ACME server is able to get this key from this URL over the internet, the ACME server can validate you are the owner of this domain. When a HTTP01 challenge is created, cert-manager will automatically configure your cluster ingress to route traffic for this URL to a small web server that presents this key.

**[DNS01](https://cert-manager.io/docs/configuration/acme/dns01/)** challenges are completed by providing a computed key that is present at a DNS TXT record. Once this TXT record has been propagated across the internet, the ACME server can successfully retrieve this key via a DNS lookup and can validate that the client owns the domain for the requested certificate. With the correct permissions, cert-manager will automatically present this TXT record for your given DNS provider.

## Configuration

## Creating a Basic ACME Issuer

All ACME Issuers follow a similar configuration structure - a clients email, a server URL, a privateKeySecretRef, and one or more solvers. Below is an example of a simple ACME issuer:

```yaml
apiVersion: cert-manager.io/v1
kind: ClusterIssuer
metadata:
  name: letsencrypt-staging
spec:
  acme:
    # You must replace this email address with your own.
    # Let's Encrypt will use this to contact you about expiring
    # certificates, and issues related to your account.
    email: user@example.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      # Secret resource that will be used to store the account's private key.
      name: example-issuer-account-key
    # Add a single challenge solver, HTTP01 using nginx
    solvers:
    - http01:
        ingress:
          ingressClassName: nginx
```

Solvers come in the form of dns01 and http01 stanzas. For more information on how to configure these solver types, visit their respective documentation - **[DNS01](https://cert-manager.io/docs/configuration/acme/dns01/)**, **[HTTP01](https://cert-manager.io/docs/configuration/acme/http01/)**.
