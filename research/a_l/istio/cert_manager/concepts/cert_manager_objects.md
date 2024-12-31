# **[cert-manager](https://istio.io/latest/docs/ops/integrations/certmanager/)**

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

## Configuration

Consult the **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)** to get started. No special changes are needed to work with Istio.

## Usage

### Istio Gateway

cert-manager can be used to write a secret to Kubernetes, which can then be referenced by a Gateway.

1. To get started, configure an Issuer resource, following the **[cert-manager issuer documentation](https://cert-manager.io/docs/configuration/)**. Issuers are Kubernetes resources that represent certificate authorities (CAs) that are able to generate signed certificates by honoring certificate signing requests. For example: an Issuer may look like:

```yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: ca-issuer
  namespace: istio-system
spec:
  ca:
    secretName: ca-key-pair
```

For a common Issuer type, ACME, a pod and service are created to respond to challenge requests in order to verify the client owns the domain. To respond to those challenges, an endpoint at http://<YOUR_DOMAIN>/.well-known/acme-challenge/<TOKEN> will need to be reachable. That configuration may be implementation specific.

2. Next, configure a Certificate resource, following the **[cert-manager documentation](https://cert-manager.io/docs/usage/certificate/)**. The Certificate should be created in the same namespace as the istio-ingressgateway deployment. For example, a Certificate may look like:

```yaml
apiVersion: cert-manager.io/v1
kind: Certificate
metadata:
  name: ingress-cert
  namespace: istio-system
spec:
  secretName: ingress-cert
  commonName: my.example.com
  dnsNames:
  - my.example.com
  ...

3. Once we have the certificate created, we should see the secret created in the istio-system namespace. This can then be referenced in the tls config for a Gateway under credentialName:

```yaml
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: gateway
spec:
  selector:
    istio: ingressgateway
  servers:
  - port:
      number: 443
      name: https
      protocol: HTTPS
    tls:
      mode: SIMPLE
      credentialName: ingress-cert # This should match the Certificate secretName
    hosts:
    - my.example.com # This should match a DNS name in the Certificate
```
