# **[A Technical Deep Dive: Securing the Automation of ACME DNS Challenge Validation](https://www.eff.org/deeplinks/2018/02/technical-deep-dive-securing-automation-acme-dns-challenge-validation)**

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

Earlier this month, Let's Encrypt (the free, automated, open Certificate Authority EFF helped launch two years ago) passed a huge milestone: issuing over 50 million active certificates. And that number is just going to keep growing, because in a few weeks Let's Encrypt will also start issuing “wildcard” certificates—a feature many system administrators have been asking for.

## What's A Wildcard Certificate?

In order to validate an HTTPS certificate, a user’s browser checks to make sure that the domain name of the website is actually listed in the certificate. For example, a certificate from `www.eff.org` has to actually list `www.eff.org` as a valid domain for that certificate. Certificates can also list multiple domains (e.g., `www.eff.org`, `ssd.eff.org`, `sec.eff.org`, etc.) if the owner just wants to use one certificate for all of her domains. A wildcard certificate is just a certificate that says “I'm valid for all of the subdomains in this domain” instead of explicitly listing them all off. (In the certificate, this is indicated by using a wildcard character, indicated by an asterisk. So if you examine the certificate for eff.org today, it will say it's valid for *.eff.org.) That way, a system administrator can get a certificate for their entire domain, and use it on new subdomains they hadn't even thought of when they got the certificate.

In order to issue wildcard certificates, Let's Encrypt is going to require users to prove their control over a domain by using a challenge based on DNS, the domain name system that translates domain names like `www.eff.org` into IP addresses like 69.50.232.54. From the perspective of a Certificate Authority (CA) like Let's Encrypt, there's no better way to prove that you control a domain than by modifying its DNS records, as controlling the domain is the very essence of DNS.

But one of the key ideas behind Let's Encrypt is that getting a certificate should be an automatic process. In order to be automatic, though, the software that requests the certificate will also need to be able to modify the DNS records for that domain. In order to modify the DNS records, that software will also need to have access to the credentials for the DNS service (e.g. the login and password, or a cryptographic token), and those credentials will have to be stored wherever the automation takes place. In many cases, this means that if the machine handling the process gets compromised, so will the DNS credentials, and this is where the real danger lies. In the rest of this post, we'll take a deep dive into the components involved in that process, and what the options are for making it more secure.

## How Does the DNS Challenge Work?

At a high level, the DNS challenge works like all the other automatic challenges that are part of the ACME protocol—the protocol that a Certificate Authority (CA) like Let's Encrypt and client software like Certbot use to communicate about what certificate a server is requesting, and how the server should prove ownership of the corresponding domain name. In the DNS challenge, the user requests a certificate from a CA by using ACME client software like Certbot that supports the DNS challenge type. When the client requests a certificate, the CA asks the client to prove ownership over the domain by adding a specific TXT record to its DNS zone. More specifically, the CA sends a unique random token to the ACME client, and whoever has control over the domain is expected to put this TXT record into its DNS zone, in the predefined record named "_acme-challenge" under the actual domain the user is trying to prove ownership of. As an example, if you were trying to validate the domain for *.eff.org, the validation subdomain would be "_acme-challenge.eff.org." When the token value is added to the DNS zone, the client tells the CA to proceed with validating the challenge, after which the CA will do a DNS query towards the authoritative servers for the domain. If the authoritative DNS servers reply with a DNS record that contains the correct challenge token, ownership over the domain is proven and the certificate issuance process can continue.

## DNS Controls Digital Identity

What makes a DNS zone compromise so dangerous is that DNS is what users’ browsers rely on to know what IP address they should contact when trying to reach your domain. This applies to every service that uses a resolvable name under your domain, from email to web services. When DNS is compromised, a malicious attacker can easily intercept all the connections directed toward your email or other protected service, terminate the TLS encryption (since they can now prove ownership over the domain and get their own valid certificates for it), read the plaintext data, and then re-encrypt the data and pass the connection along to your server. For most people, this would be very hard to detect.

## Separate and Limited Privileges

Strictly speaking, in order for the ACME client to handle updates in an automated fashion, the client only needs to have access to credentials that can update the TXT records for "_acme-challenge" subdomains. Unfortunately, most DNS software and DNS service providers do not offer granular access controls that allow for limiting these privileges, or simply do not provide an API to handle automating this outside of the basic DNS zone updates or transfers. This leaves the possible automation methods either unusable or insecure.

A simple trick can help maneuver past these kinds of limitations: using the **[CNAME record](https://en.wikipedia.org/wiki/CNAME_record)**. CNAME records essentially act as links to another DNS record. Let's Encrypt follows the chain of CNAME records and will resolve the challenge validation token from the last record in the chain.

## Ways to Mitigate the Issue

Even using CNAME records, the underlying issue exists that the ACME client will still need access to credentials that allow it to modify some DNS record. There are different ways to mitigate this underlying issue, with varying levels of complexity and security implications in case of a compromise. In the following sections, this post will introduce some of these methods while trying to explain the possible impact if the credentials get compromised. With one exception, all of them make use of CNAME records.

## Only Allow Updates to TXT Records

The first method is to create a set of credentials with privileges that only allow updating of TXT records. In the case of a compromise, this method limits the fallout to the attacker being able to issue certificates for all domains within the DNS zone (since they could use the DNS credentials to get their own certificates), as well as interrupting mail delivery. The impact to mail delivery stems from mail-specific TXT records, namely **[SPF](https://en.wikipedia.org/wiki/Sender_Policy_Framework)**, **[DKIM](https://en.wikipedia.org/wiki/DomainKeys_Identified_Mail)**, its extension **[ADSP](https://en.wikipedia.org/wiki/Author_Domain_Signing_Practices)** and **[DMARC](https://en.wikipedia.org/wiki/DMARC)**. A compromise of these would also make it easy to deliver phishing emails impersonating a sender from the compromised domain in question.

## Use a "Throwaway" Validation Domain

The second method is to manually create CNAME records for the "_acme-challenge" subdomain and point them towards a validation domain that would reside in a zone controlled by a different set of credentials. For example, if you want to get a certificate to cover yourdomain.tld and `www.yourdomain.tld`, you'd have to create two CNAME records—"_acme-challenge.yourdomain.tld" and "_acme-challenge.www.yourdomain.tld"—and point both of them to an external domain for the validation.

The domain used for the challenge validation should be in an external DNS zone or in a subdelegate DNS zone that has its own set of management credentials. (A subdelegate DNS zone is defined using NS records and it effectively delegates the complete control over a part of the zone to an external authority.)

The impact of compromise for this method is rather limited. Since the actual stored credentials are for an external DNS zone, an attacker who gets the credentials would only gain the ability to issue certificates for all the domains pointing to records in that zone.

However, figuring out which domains actually do point there is trivial: the attacker would just have to read **[Certificate Transparency](https://www.certificate-transparency.org/)** logs and check if domains in those certificates have a magic subdomain pointing to the compromised DNS zone.

## Limited DNS Zone Access

If your DNS software or provider allows for creating permissions tied to a subdomain, this could help you to mitigate the whole issue. Unfortunately, at the time of publication the only provider we have found that allows this is **[Microsoft Azure DNS](https://docs.microsoft.com/en-us/azure/dns/dns-protect-zones-recordsets)**. Dyn supposedly also has granular privileges, but we were not able to find a lower level of privileges in their service besides “Update records,” which still leaves the zone completely vulnerable.

Route53 and possibly others allow their users to create a subdelegate zone, new user credentials, point NS records towards the new zone, and point the "_acme-challenge" validation subdomains to them using the CNAME records. It’s a lot of work to do the privilege separation correctly using this method, as one would need to go through all of these steps for each domain they would like to use DNS challenges for.

## Use ACME-DNS

As a disclaimer, the software discussed below is written by the author, and it’s used as an example of the functionality required to handle credentials required for DNS challenge automation in a secure fashion. The final method is a piece of software called ACME-DNS, written to combat this exact issue, and it's able to mitigate the issue completely. One downside is that it adds one more thing to your infrastructure to maintain as well as the requirement to have DNS port (53) open to the public internet. ACME-DNS acts as a simple DNS server with a limited HTTP API. The API itself only allows updating of TXT records of automatically generated random subdomains. There are no methods to request lost credentials, update or add other records. It provides two endpoints:

/register – This endpoint generates a new subdomain for you to use, accompanied by a username and password. As an optional parameter, the register endpoint takes a list of CIDR ranges to whitelist updates from.
/update – This endpoint is used to update the actual challenge token to the server.
In order to use ACME-DNS, you first have to create A/AAAA records for it, and then point NS records towards it to create a delegation node. After that, you simply create a new set of credentials via the /register endpoint, and point the CNAME record from the "_acme-challenge" validation subdomain of the originating zone towards the newly generated subdomain.

The only credentials saved locally would be the ones for ACME-DNS, and they are only good for updating the exact TXT records for the validation subdomains for the domains on the box. This effectively limits the impact of a possible compromise to the attacker being able to issue certificates for these domains. For more information about ACME-DNS, visit <https://github.com/joohoi/acme-dns/>.

## Conclusion

To alleviate the issues with ACME DNS challenge validation, proposals like assisted-DNS to IETF’s ACME working group have been discussed, but are currently still left without a resolution. Since the only way to limit exposure from a compromise is to limit the DNS zone credential privileges to only changing specific TXT records, the current possibilities for securely implementing automation for DNS validation are slim. The only sustainable option would be to get DNS software and service providers to either implement methods to create more fine-grained zone credentials or provide a completely new type of credentials for this exact use case.
