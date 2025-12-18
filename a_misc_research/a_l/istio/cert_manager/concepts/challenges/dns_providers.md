# **[DNS providers who easily integrate with Let’s Encrypt DNS validation](https://community.letsencrypt.org/t/dns-providers-who-easily-integrate-with-lets-encrypt-dns-validation/86438)**

**[Current Status](../../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research_list.md)**\
**[Back Main](../../../../../../README.md)**

## references

- **[Certbot](https://eff-certbot.readthedocs.io/en/stable/using.html#dns-plugins)**

- **[PKI secrets engine](https://developer.hashicorp.com/vault/docs/secrets/pki)**

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

In the spirit of **[Web Hosting who support Let's Encrypt](https://community.letsencrypt.org/t/web-hosting-who-support-lets-encrypt/6920)** and **[CDN Providers who support Let's Encrypt](https://community.letsencrypt.org/t/cdn-providers-who-support-lets-encrypt/7107)**, I wanted to compile a list of DNS providers that feature a workflow (e.g. an API and existing ACME client integrations) that is a good fit for Let's Encrypt's DNS validation.

It should serve as a signpost for those who want to use DNS validation (wildcards, firewall problems) and are looking for an automatic solution.

FYI: The DNS hosts listed here are ones that are confirmed to support automated certificate issuance and renewal with existing ACME clients. Although it is technically possible to issue and renew certificates by manually updating TXT records every 60-90 days, it is not a recommended way to use Let's Encrypt DNS validation.

FYI: Your DNS host is not the same place where you register your domain (but it can be). Your DNS host is where you manage your DNS records and where your domain's nameservers point. You can change DNS hosting at any time, for free.

Criteria for inclusion:

- It must support automation for all users (i.e. it has an API and the API is not restricted to certain users)
- At least one ACME client must support it (indirect support like Lexicon is OK) or a published hook for an ACME client must exist for it
- DNS updates must apply reasonably quickly: within 30 minutes

Domain Registrar: **[GoDaddy](https://community.letsencrypt.org/t/godaddy-no-longer-allows-api-access-to-clients-e-g-for-dns-based-cert-renewal-if-you-have-less-than-50-domains/219377/2)**
