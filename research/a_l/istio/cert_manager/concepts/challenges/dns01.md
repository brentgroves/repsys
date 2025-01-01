# **[dns01](https://cert-manager.io/docs/configuration/acme/dns01/)**

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

## Configuring DNS01 Challenge Provider

This page contains details on the different options available on the Issuer resource's DNS01 challenge solver configuration.

For more information on configuring ACME Issuers and their API format, read the **[ACME Issuers](https://cert-manager.io/docs/configuration/acme/)** documentation.

DNS01 provider configuration must be specified on the Issuer resource, similar to the examples in the setting up documentation.

You can read about how the DNS01 challenge type works on the **[Let's Encrypt challenge types page](https://letsencrypt.org/docs/challenge-types/#dns-01-challenge)**.

```yaml
apiVersion: cert-manager.io/v1
kind: Issuer
metadata:
  name: example-issuer
spec:
  acme:
    email: user@example.com
    server: https://acme-staging-v02.api.letsencrypt.org/directory
    privateKeySecretRef:
      name: example-issuer-account-key
    solvers:
    - dns01:
        cloudDNS:
          project: my-project
          serviceAccountSecretRef:
            name: prod-clouddns-svc-acct-secret
            key: service-account.json
```

Each issuer can specify multiple different DNS01 challenge providers, and it is also possible to have multiple instances of the same DNS provider on a single Issuer (e.g. two CloudDNS accounts could be set, each with their own name).

For more information on utilizing multiple solver types on a single Issuer, read the multiple-solver-types section.

## Setting Nameservers for DNS01 Self Check

cert-manager will check the correct DNS records exist before attempting a DNS01 challenge. By default cert-manager will use the recursive nameservers taken from /etc/resolv.conf to query for the authoritative nameservers, which it will then query directly to verify the DNS records exist.

If this is not desired (for example with multiple authoritative nameservers or split-horizon DNS), the cert-manager controller exposes two flags that allows you alter this behavior:

`--dns01-recursive-nameservers` Comma separated string with host and port of the recursive nameservers cert-manager should query.

`--dns01-recursive-nameservers-only` Forces cert-manager to only use the recursive nameservers for verification. Enabling this option could cause the DNS01 self check to take longer due to caching performed by the recursive nameservers.

Example usage:

`--dns01-recursive-nameservers-only --dns01-recursive-nameservers=8.8.8.8:53,1.1.1.1:53`

If you're using the cert-manager helm chart, you can set recursive nameservers through .Values.extraArgs or at the command at helm install/upgrade time with --set:

`--set 'extraArgs={--dns01-recursive-nameservers-only,--dns01-recursive-nameservers=8.8.8.8:53\,1.1.1.1:53}'`

## Delegated Domains for DNS01

By default, cert-manager will not follow CNAME records pointing to subdomains.

If granting cert-manager access to the root DNS zone is not desired, then the _acme-challenge.example.com subdomain can instead be delegated to some other, less privileged domain (less-privileged.example.org). This could be achieved in the following way. Say, one has two zones:

example.com
less-privileged.example.org
Create a CNAME record pointing to this less privileged domain:

_acme-challenge.example.com IN CNAME_acme-challenge.less-privileged.example.org.
Grant cert-manager rights to update less privileged less-privileged.example.org zone

Provide configuration/credentials for updating this less privileged zone and add an additional field into the relevant dns01 solver. Note that selector field is still working for the original example.com, while credentials are provided for less-privileged.example.org

## Supported DNS01 providers

A number of different DNS providers are supported for the ACME Issuer. Below is a listing of available providers, their .yaml configurations, along with additional Kubernetes and provider specific notes regarding their usage.

ACMEDNS
Akamai
AzureDNS
CloudFlare
Google
Route53
DigitalOcean
RFC2136
