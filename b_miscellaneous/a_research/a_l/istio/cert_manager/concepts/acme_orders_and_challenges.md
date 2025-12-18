# **[ACME Orders and Challenges](https://cert-manager.io/docs/concepts/acme-orders-challenges/)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[cert-manager installation documentation](https://cert-manager.io/docs/installation/kubernetes/)**
- **[Automatic Certificate Management Environment (ACME)](https://datatracker.ietf.org/doc/html/rfc8555)**

cert-manager supports requesting certificates from Automatic Certificate Management Environment,ACME servers, including from **[Let's Encrypt](https://letsencrypt.org/)**, with use of the ACME Issuer. These certificates are typically trusted on the public Internet by most computers. To successfully request a certificate, cert-manager must solve ACME Challenges which are completed in order to prove that the client owns the DNS addresses that are being requested.

In order to complete these challenges, cert-manager introduces two CustomResource types; Orders and Challenges.

## Orders

Order resources are used by the ACME issuer to manage the lifecycle of an ACME 'order' for a signed TLS certificate. More details on ACME orders and domain validation can be found on the **[Let's Encrypt website here](https://letsencrypt.org/how-it-works/)**. An order represents a single certificate request which will be created automatically once a new CertificateRequest resource referencing an ACME issuer has been created. CertificateRequest resources are created automatically by cert-manager once a Certificate resource is created, has its specification changed, or needs renewal.

As an end-user, you will never need to manually create an Order resource. Once created, an Order cannot be changed. Instead, a new Order resource must be created.

The Order resource encapsulates multiple ACME 'challenges' for that 'order', and as such, will manage one or more Challenge resources.
