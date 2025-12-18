# **[mTLS everywhere!](https://blog.frankel.ch/mtls-everywhere/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[Securing Istio Service Mesh](https://cert-manager.io/docs/usage/istio-csr/)**
- **[Enable mTLS on Pods with CSI: Using the cert-manager CSI driver to provide unique keys and certificates that share the lifecycle of pods.](https://cert-manager.io/docs/usage/csi/)**
- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

Security in one’s information system has always been among the most critical Non-Functional Requirements. Transport Secure Layer, aka TLS, formerly SSL, is among its many pillars. In this post, I’ll show how to configure TLS for the Apache APISIX API Gateway.

TLS in a few words
TLS offers several capabilities:

- Server authentication: the client is confident that the server it exchanges data with is the right one. It avoids sending data, which might be confidential, to the wrong actor
- Optional client authentication: the other way around, the server only allows clients whose identity can be verified
- Confidentiality: no third party can read the data exchanged between the client and the server
- Integrity: no third party can tamper with the data

TLS works through certificates. A certificate is similar to an ID, proving the certificate’s holder identity. Just like an ID, you need to trust who delivered it. Trust is established through a chain: if I trust Alice, who trusts Bob, who in turn trusts Charlie, who delivered the certificate, then I trust the latter. In this scenario, Alice is known as the root certificate authority.

TLS authentication is based on public key cryptography. Alice generates a public key/private key pair and publishes the public key. If one encrypts data with the public key, only the private key that generated the public key can decrypt them. The other usage is for one to encrypt data with the private key and everybody with the public key to decrypt it, thus proving their identity.

Finally, mutual TLS, aka mTLS, is the configuration of two-way TLS: server authentication to the client, as usual, but also the other way around, client authentication to the server.

We now have enough understanding of the concepts to get our hands dirty.

## Generating certificates with cert-manager

A couple of root CA are installed in browsers by default. That’s how we can browse HTTPS websites safely, trusting that https://apache.org is the site they pretend to be. The infrastructure has no pre-installed certificates, so we must start from scratch.

We need at least one root certificate. In turn, it will generate all other certificates. While it’s possible to do every manually, I’ll rely on cert-manager in Kubernetes. As its name implies, cert-manager is a solution to manage certificates.

Installing it with Helm is straightforward:

```bash
helm repo add jetstack https://charts.jetstack.io  

helm install \
  cert-manager jetstack/cert-manager \
  --namespace cert-manager \                       
  --create-namespace \                             
  --version v1.11.0 \
  --set installCRDs=true \
  --set prometheus.enabled=false  
```

1. Add the charts' repository
2. Install the objects in a dedicated namespace
3. Don’t monitor, in the scope of this post

We can make sure that everything works as expected by looking at the pods:

```bash
kubectl get pods -n cert-manager
```