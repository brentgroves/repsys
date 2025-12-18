# **[ExternalDNS](https://github.com/kubernetes-sigs/external-dns)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

This README is a part of the complete documentation, available **[here](https://kubernetes-sigs.github.io/external-dns/)**.

What It Does
Inspired by Kubernetes DNS, Kubernetes' cluster-internal DNS server, ExternalDNS makes Kubernetes resources discoverable via public DNS servers. Like KubeDNS, it retrieves a list of resources (Services, Ingresses, etc.) from the Kubernetes API to determine a desired list of DNS records. Unlike KubeDNS, however, it's not a DNS server itself, but merely configures other DNS providers accordingly—e.g. AWS Route 53 or Google Cloud DNS.

In a broader sense, ExternalDNS allows you to control DNS records dynamically via Kubernetes resources in a DNS provider-agnostic way.

The FAQ contains additional information and addresses several questions about key concepts of ExternalDNS.

To see ExternalDNS in action, have a look at this video or read this blogpost.

The Latest Release
ExternalDNS allows you to keep selected zones (via --domain-filter) synchronized with Ingresses and Services of type=LoadBalancer and nodes in various DNS providers:

Google Cloud DNS
AWS Route 53
AWS Cloud Map
AzureDNS
Civo
CloudFlare
DigitalOcean
DNSimple
OpenStack Designate
PowerDNS
CoreDNS
Exoscale
Oracle Cloud Infrastructure DNS
Linode DNS
RFC2136
NS1
TransIP
OVH
Scaleway
Akamai Edge DNS
GoDaddy
Gandi
IBM Cloud DNS
TencentCloud PrivateDNS
TencentCloud DNSPod
Plural
Pi-hole
ExternalDNS is, by default, aware of the records it is managing, therefore it can safely manage non-empty hosted zones. We strongly encourage you to set --txt-owner-id to a unique value that doesn't change for the lifetime of your cluster. You might also want to run ExternalDNS in a dry run mode (--dry-run flag) to see the changes to be submitted to your DNS Provider API.

Note that all flags can be replaced with environment variables; for instance, --dry-run could be replaced with EXTERNAL_DNS_DRY_RUN=1.

