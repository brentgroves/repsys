# **[Set up my SSL certificate with ACME](https://www.godaddy.com/help/set-up-my-ssl-certificate-with-acme-40393)**

**[Current Status](../../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../../research_list.md)**\
**[Back Main](../../../../../../README.md)**

## references

- **[godaddy webhook](https://github.com/snowdrop/godaddy-webhook)**
- **[godaddy lego](https://go-acme.github.io/lego/dns/godaddy/)**
- **[PKI secrets engine](https://developer.hashicorp.com/vault/docs/secrets/pki)**

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Secure your Microservices Ingress in Istio with Let’s Encrypt](https://invisibl.io/blog/secure-your-microservices-ingress-in-istio-with-lets-encrypt/)**
- **[Requesting Certificates](https://cert-manager.io/docs/usage/)**
- **[Deploy cert-manager on Azure Kubernetes Service (AKS) and use Let's Encrypt to sign a certificate for an HTTPS website](https://cert-manager.io/docs/tutorials/getting-started-aks-letsencrypt/)**
- **[Cert-Manager and Istio: Choosing Ingress Options for the Istio-based service mesh add-on for AKS](https://medium.com/microsoftazure/cert-manager-and-istio-choosing-ingress-options-for-the-istio-based-service-mesh-add-on-for-aks-c633c97fa4f2)**
- **[Kubernetes, Istio, Cert Manager, and Let’s Encrypt](https://medium.com/@rd.petrusek/kubernetes-istio-cert-manager-and-lets-encrypt-c3e0822a3aaf)**

Automated Certificate Management Environment (ACME) is a protocol for automating the interactions required between your server and the certificate authority for your SSL certificate. It can automate the request, download and install of your certificate.

 Note: This feature is not supported for API reseller customers at this time.

To use ACME you must install an ACME client on your server and use your server’s command line interface (CLI). If you are not comfortable with installing the client or using a CLI, you can install your SSL certificate manually.

Install an ACME client like Certbot onto your server.
Go to your GoDaddy product page.
For SSL Certificates, select Manage All.
Select Manage All for SSL Certificates.
Select ACME Automation > ACME Setup.
The ACME External Account Binding Key section includes the External Account Binding (EAB) Key ID and External Account Binding (EAB) Key Data that are unique for your certificate. These will be used in the commands to set up your ACME client.
If you are using the Certbot client, look for your server version in the Example Certbot Commands section. We provide instructions for some of the most common servers. If your server version is listed, follow the instructions to configure your ACME client. There are some things to look out for.
The correct Key ID and Key Data will be included in the example commands, but you will need to replace placeholders like my.domain.com with the correct information for your site.
If the final installation of the certificate is not currently supported, see Install my SSL certificate.
If your server version is not listed or you are using an ACME client other than Certbot, refer to the documentation for your ACME client and server OS on how to configure the client and install a certificate.
