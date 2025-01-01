# **[Automated Certificate Management Environment (ACME) Explained](https://www.securew2.com/blog/automated-certificate-management-environment-acme-explained#:~:text=ACME%20automates%20the%20whole%20process,HTTPS%20connection%20using%20JSON%20messages.)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[mTLS Lets Encrypt](https://community.letsencrypt.org/t/generating-mtls-client-certs/218728/3)**
- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Automatic Certificate Management Environment (ACME)](https://datatracker.ietf.org/doc/html/rfc8555)**
- **[Built his own ACME Server](https://blog.daknob.net/workload-mtls-with-acme/)**
- **[ACME flow](https://smallstep.com/blog/acme-managed-device-attestation-explained/)**

Using X.509 digital certificates to authenticate is the most secure option and an excellent way to provide context for identity and role-based access management. Certificates cannot be stolen or replicated, providing significant assurance that you are connected to the correct network and that the user and machine logging in is indeed authorized to access the network. These are just a few reasons the use of certificates for authentication is gaining popularity in network security.

Certificate management, however, can often become a significant challenge without proper infrastructure. The lack of a certificate inventory in a central place, lack of automation for certificate renewal, and lack of overall visibility of the certificate life cycle are some of the major challenges one faces at the time of deploying certificates. This disorganization makes it easy to miss certificate expiration dates. . An expired certificate can have a significant impact on your business, some of the most common ones being:

- Security risks
- Outages leading to loss of productivity
- Potential security breaches
- Negative publicity
- Loss of customer trust
- Fines from regulatory bodies

Renewing client certs is usually not done using ACME. Albeit it is possible (see <https://smallstep.com/blog/acme-managed-device-attestation-explained/> ) Typically REST-API or SCEP is used for this purpose, or proprietary protocols such as Microsoft GPO based)
