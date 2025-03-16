# Certificate Management Support Team

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

Good morning, team.

The Structures Information System department has developed a **[PKI](https://cpl.thalesgroup.com/faq/public-key-infrastructure-pki/what-public-key-infrastructure-pki)**, and we use it to create certificates for non-internet software services. It produces **[server and client certificates](https://www.digicert.com/faq/public-trust-and-certificates/whats-the-difference-between-client-certificates-vs-server-certificates)** that are validated with the **[Sectigo Certificate Linter](https://crt.sh/lintcert)**. It was used to manage certificates for Structures Kubernetes gateway as well as the **[Plex Mach2 MES system](https://www.googleadservices.com/pagead/aclk?sa=L&ai=DChcSEwiF7ZqNyY6MAxV4SH8AHWw3JTEYABAEGgJvYQ&co=1&ase=2&gclid=Cj0KCQjw7dm-BhCoARIsALFk4v-dutdN-7g1SRjPBhuveGaV-3VXAZFAL8RHlucNKm1Yx1_EiIM4Y5oaAh7FEALw_wcB&ohost=www.google.com&cid=CAESV-D2WnmAe32FcPmaqCNPXo6fHvlNK7AWnQBIohrU_YRSs-MhpkxEEUgNek2gJj6KIT5TJh9mW01StqHeFIeIMCdsDEfmg8tOkFn3YvQ4M0odgQOLXdHR2g&sig=AOD64_1TTrMAdnGEJwQp2jCupfdt9xN2ow&q&nis=4&adurl&ved=2ahUKEwiwsZaNyY6MAxVE4ckDHaxMET8Q0Qx6BAgOEAE)**.

## Goal

- Creating, validating, deploying, and updating certificates for non-internet software services.

## AI Overview: Why should an organization have a PKI

An organization should implement a Public Key Infrastructure (PKI) to establish trust and secure digital communications by verifying identities, enabling encryption, and ensuring data integrity, ultimately enhancing security and compliance.

## Tasks

- We researched the Fortigate Proxy and certificates with Justin Langille.
- Discussed Mach2 user computer trust-store updates with Fruitport DST, Matt Irey, and David Maitner.
- Creating Network config request to temporarily allow my laptop to access Fruitport's OT network for certificate testing.

## players

Kristian Smith: Global Directory IT
Adrian Wise: System Admin, Technical Services Manager.
Christian. Trujillo, IT Structures Manager
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
