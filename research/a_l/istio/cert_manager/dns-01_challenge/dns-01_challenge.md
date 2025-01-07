# **[DNS-01 challenge protocol](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../esearch_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

This challenge asks you to prove that you control the DNS for your domain name by putting a specific value in a TXT record under that domain name. It is harder to configure than HTTP-01, but can work in scenarios that HTTP-01 can’t. It also allows you to issue wildcard certificates. After Let’s Encrypt gives your ACME client a token, your client will create a TXT record derived from that token and your account key, and put that record at `_acme-challenge.<YOUR_DOMAIN>`. Then Let’s Encrypt will query the DNS system for that record. If it finds a match, you can proceed to issue a certificate!

Since automation of issuance and renewals is really important, it only makes sense to use DNS-01 challenges if your DNS provider has an API you can use to automate updates. Our community has started a list of such DNS providers **[here](https://community.letsencrypt.org/t/dns-providers-who-easily-integrate-with-lets-encrypt-dns-validation/86438)**. Your DNS provider may be the same as your registrar (the company you bought your domain name from), or it might be different. If you want to change your DNS provider, you just need to make some small changes at your registrar. You don’t need to wait for your domain to be close to expiration to do so.

Note that putting your full DNS API credentials on your web server significantly increases the impact if that web server is hacked. Best practice is to use more narrowly scoped **[API credentials](https://www.eff.org/deeplinks/2018/02/technical-deep-dive-securing-automation-acme-dns-challenge-validation)**, or perform DNS validation from a separate server and automatically copy certificates to your web server.

Since Let’s Encrypt follows the DNS standards when looking up TXT records for DNS-01 validation, you can use CNAME records or NS records to delegate answering the challenge to other DNS zones. This can be used to delegate the _acme-challenge subdomain to a validation-specific server or zone. It can also be used if your DNS provider is slow to update, and you want to delegate to a quicker-updating server.
