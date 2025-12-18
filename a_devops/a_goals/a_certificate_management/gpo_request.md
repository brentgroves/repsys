# Certificate Management Support Team

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

Good evening, team.

We would like approval and help from  Technical Systems & Support concerning deploying a certificate chain to employees computers accessing Structures Kubernetes Cluster.

- Thank you

## Goal

- Creating, validating, deploying, and updating certificates for non-internet software services in the Structures Kubernetes Cluster as well our Plex Mach2 MES system.

## Request

- Create a GPO to deploy the Structures PKI intermediate and root CA certificates to Linamar employees accessing the Structures Avilla Kubernetes Cluster services. Here is the process. **[Not quite what we want but close](https://support.securly.com/hc/en-us/articles/206688537-How-to-push-the-Securly-SSL-certificate-with-Active-Directory-GPO
)**.
- Create a GPO to deploy the Structures PKI client certificate for **[zero-trust-mTLS security](https://www.ejbca.org/resources/understanding-mtls-and-its-role-in-zero-trust-security/#:~:text=This%20mutual%20authentication%20ensures%20that,need%20to%20prove%20their%20identities.)** to our Kubernetes Cluster.
- To deploy Structures PKI intermediate and root CA certificates to the Plex Mach2 MES system clients which are not part of the Linamar domain. To do this we can create a Wyse thin-client image with the certificates in the Windows trust-store.

## Current Solution

- Kubernetes Cluster is in development.  Initially there will be around 10 employees from Indiana and Michigan locations accessing its services.  Had a meeting on Friday which indicates other locations in Alabama and more in Michigan will be accessing our K8s Cluster so this number will grow.
- Our Mach2 MES Plex systems are deployed to locations in Indiana, Michigan, and Alabama. There are approximately 70 clients in one Michigan location alone. Currenly, each locations Mach2 clients are connecting to there server without using encryption.

## Structures PKI system

- Once the intermediate and root CA certificates are deployed to the clients' trust-store any server certificate signed by it will be accepted by browsers as secure.
- Has passed certificate validation at **[Sectigo Certificate Linter](https://crt.sh/lintcert)** by including **[extensions beyond the current x509 standard](https://knowledge.digicert.com/general-information/certificate-extensions-explained)**.
- In use at Mobex prior to Linamar acquisition for around two years.
- Has both an **[intermediate and root CA certificate](https://venafi.com/blog/what-difference-between-root-certificates-and-intermediate-certificates/#:~:text=An%20Intermediate%20Certificate%20serves%20as,to%20the%20end%2Dentity%20certificate.)**.
- Generates **[mTLS client and server certificates](https://www.ejbca.org/resources/understanding-mtls-and-its-role-in-zero-trust-security/#:~:text=This%20mutual%20authentication%20ensures%20that,need%20to%20prove%20their%20identities.)** to better secure our Kubernetes Cluster.
- Has a database schema for managing certificates.

## team

Kristian Smith: Global Directory IT
Adrian Wise: System Admin, Technical Services Manager.
Christian. Trujillo, IT Structures Manager
Jonathan Lapsley: System Administrator, IT - Technical Systems & Support
Aamir Ghaffar: IT Systems Architect
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor
Sam Jackson, Information System Developer
Justin Langille, Network Technician
Matt Irey, Desktop and System Support Technician
David Maitner,  Desktop and System Support Technician
Carl Stanglang, Desktop and System Support Technician

## Background

The Structures Information System department has developed a **[PKI](https://cpl.thalesgroup.com/faq/public-key-infrastructure-pki/what-public-key-infrastructure-pki)**, and we use it to create certificates for non-internet software services. It produces **[server and client certificates](https://www.digicert.com/faq/public-trust-and-certificates/whats-the-difference-between-client-certificates-vs-server-certificates)** that are validated with the **[Sectigo Certificate Linter](https://crt.sh/lintcert)**. It was used to manage certificates for Structures Kubernetes gateway as well as the **[Plex Mach2 MES system](https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwiF7ZqNyY6MAxV4SH8AHWw3JTEYABAEGgJvYQ&co=1&ase=2&gclid=Cj0KCQjw7dm-BhCoARIsALFk4v-dutdN-7g1SRjPBhuveGaV-3VXAZFAL8RHlucNKm1Yx1_EiIM4Y5oaAh7FEALw_wcB&ohost=www.google.com&cid=CAESV-D2WnmAe32FcPmaqCNPXo6fHvlNK7AWnQBIohrU_YRSs-MhpkxEEUgNek2gJj6KIT5TJh9mW01StqHeFIeIMCdsDEfmg8tOkFn3YvQ4M0odgQOLXdHR2g&sig=AOD64_1TTrMAdnGEJwQp2jCupfdt9xN2ow&q&nis=4&adurl&ved=2ahUKEwiwsZaNyY6MAxVE4ckDHaxMET8Q0Qx6BAgOEAE)**.

## AI Overview: Why should an organization have a PKI

An organization should implement a Public Key Infrastructure (PKI) to establish trust and secure digital communications by verifying identities, enabling encryption, and ensuring data integrity, ultimately enhancing security and compliance.

## Tasks

- We researched the Fortigate Proxy and certificates with Justin Langille.
- Discussed Mach2 user computer trust-store updates with Fruitport DST, Matt Irey, and David Maitner.
- Creating Network config request to temporarily allow my laptop to access Fruitport's OT network for certificate testing.

## team

Kristian Smith: Global Directory IT
Adrian Wise: System Admin, Technical Services Manager.
Christian. Trujillo, IT Structures Manager
Jonathan Lapsley: System Administrator, IT - Technical Systems & Support
Aamir Ghaffar: IT Systems Architect
Brent Hall, System Administrator Senior
Kevin Young, Information Systems Manager
Jared Davis, IT Manager
Hayley Rymer, IT Supervisor
Sam Jackson, Information System Developer
Justin Langille, Network Technician
Matt Irey, Desktop and System Support Technician
David Maitner,  Desktop and System Support Technician
Carl Stanglang, Desktop and System Support Technician

## References

- **[Step CLI](https://smallstep.com/docs/step-cli/basic-crypto-operations/#create-and-work-with-x509-certificates)**
- **[CSR Decoder And Certificate Decoder](https://certlogik.com/decoder/)**
- **[v3_ca extensions](https://www.ibm.com/docs/en/informix-servers/14.10?topic=openssl-x509v3-certificate-extension-basic-constraints)**
- **[Sectigo Certificate Linter](https://crt.sh/lintcert)**
- **[Certificate decoder](https://www.sslshopper.com/certificate-decoder.html)**
- **[CSR decoder](https://www.sslshopper.com/csr-decoder.html)**
- **[ca command](https://www.openssl.org/docs/man1.1.1/man1/ca.html)**
- **[X509 V3 certificate extension configuration format](https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html)**
- **[subject alternative name, SAN, Server Certificate using openssl](https://www.golinuxcloud.com/openssl-generate-csr-create-san-certificate)**
- **[online certificate key matcher](https://www.sslshopper.com/certificate-key-matcher.html)**
