# Generate and Install Certificates

**[Back to Main](../..//README.md)**\
**[Current Status](../../development/status/weekly/current_status.md)**

The directories referenced are not in a public repo.  If you need access to our PKI please ask the MIS manager.

## References

<https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/>

## Requirements

Use OpenSSL version 3 we use the version installed by miniconda here.

```bash
which openssl          
/home/brent/miniconda3/bin/openssl
openssl version                                                 
OpenSSL 3.0.9 30 May 2023 (Library: OpenSSL 3.0.9 30 May 2023)
openssl version -d
OPENSSLDIR: "/home/brent/miniconda3/ssl"
ls /home/brent/miniconda3/ssl                                  
cacert.pem  cert.pem  ct_log_list.cnf  ct_log_list.cnf.dist  misc  openssl.cnf  openssl.cnf.dist

```

## Create the RSA key pair for the root certificate

First generate private key ca.key, we will use this private key to create Certificate Authority certificate. This is done only once please don't overwrite this private key.

```bash
# The genrsa command generates an RSA private key but it contains all the fields for the public key so you could say it generates an RSA key pair.
openssl genrsa -out ~/src/pki/rootCA/private/ca.key.pem 4096
chmod 400 ~/src/pki/rootCA/private/ca.key.pem

# We will use openssl command to view the content of private key:
openssl rsa -noout -text -in ~/src/pki/rootCA/private/ca.key.pem
```

## Create the root CA certificate

- OpenSSL create certificate chain requires Root and Intermediate Certificate. In this step you'll take the place of VeriSign, Thawte, etc.
- Use the Root CA key ca.key.pem to create a Root CA certificate cacert.pem
- Give the root certificate a long expiry date. Once the root certificate expires, all certificates signed by the CA become invalid.
- Whenever you use the openssl req tool, you must specify a configuration file to use with the -config option, otherwise OpenSSL will default to its directory. ```openssl version -d```
- We will use several **[v3_ca extensions](https://www.ibm.com/docs/en/informix-servers/14.10?topic=openssl-x509v3-certificate-extension-basic-constraints)** to create CA certificate

note: The Common Name (CN) of the CA and the Server certificates must NOT match or else a naming collision will occur and you'll get errors later on.

Use below command to create Root Certificate Authority Certificate cacert.pem. I have specified the Subj inline to the same command, you can update the command based on your environment.

- Please don't create this root certificate again since it is good for 20 years.

```bash
pushd .
cd ~/src/pki
# The req command primarily creates and processes certificate requests in PKCS#10 format. It can additionally create self signed certificates for use as root CAs
# This certificate is good for 365*10*2 days = 7300 days = 20 years
openssl req \
-config ~/src/pki/openssl_root.cnf \
-key ~/src/pki/rootCA/private/ca.key.pem \
-new -x509 -days 7300 -sha256 -extensions v3_ca \
-out ~/src/pki/rootCA/certs/ca.cert.pem \
-subj "/C=US/ST=Indiana/L=Albion/O=Mobex Global/CN=Root CA"
```

Notice the req_distinguished_name section of openssl_root.cnf has very few DN when compared to an intermediate or server certificate. The **[Sectigo Certificate Linter](https://crt.sh/lintcert)** warned against the other DN.

```bash
[ req_distinguished_name ]                               # Template for the DN in the CSR
countryName                     = Country Name (2 letter code)
stateOrProvinceName             = State or Province Name (full name)
localityName                    = Locality Name (city)
0.organizationName              = Organization Name (company)
# ERROR OrganizationalUnitName is prohibited if...the certificate was issued on or after September 1, 2022
# organizationalUnitName          = Organizational Unit Name (section)
# INFO Subject has a deprecated CommonName
# dont use this in openssl_intermediate_for_san_certificate.cnf
commonName              = supplied                       # Must provide a common name
# cablint INFO Name has deprecated attribute emailAddress
# emailAddress                    = Email Address

```

Also notice the v3_ca section adds several OpenSSL version 3 DN extensions that the **[Sectigo Certificate Linter](https://crt.sh/lintcert)** asked us to add.

```bash
[ v3_ca ]                                           # Root CA certificate extensions
subjectKeyIdentifier = hash                         # Subject key identifier
authorityKeyIdentifier = keyid:always,issuer        # Authority key identifier
basicConstraints = critical, CA:true                # Basic constraints for a CA
# CA certificates without Digital Signature do not allow direct signing of OCSP responses
# https://www.openssl.org/docs/manmaster/man5/x509v3_config.html
keyUsage = critical, keyCertSign, digitalSignature, cRLSign           # Key usage for a CA

```

The CA certificate can be world readable so that it can be used to sign the cert by anyone.

```bash
chmod 444 ~/src/pki/rootCA/certs/ca.cert.pem
ls -al ~/src/pki/rootCA/certs/ca.cert.pem
```

Execute the below command to verify root CA certificate:

```bash
openssl x509 -noout -text -in ~/src/pki/rootCA/certs/ca.cert.pem
...
    Signature Algorithm: sha256WithRSAEncryption
    Validity
        Not Before: Aug 18 23:42:55 2023 GMT
        Not After : Aug 13 23:42:55 2043 GMT
    Public Key Algorithm: rsaEncryption
        Public-Key: (4096 bit)
    Issuer: C = US, ST = Indiana, L = Albion, O = Mobex Global, CN = Root CA
    Subject: C = US, ST = Indiana, L = Albion, O = Mobex Global, CN = Root CA
    X509v3 extensions:
        X509v3 Subject Key Identifier:
            3E:3F:CA:A6:0F:0C:09:34:D2:C8:F5:F4:8F:00:7E:D6:F8:F4:59:2D
        X509v3 Authority Key Identifier:
            3E:3F:CA:A6:0F:0C:09:34:D2:C8:F5:F4:8F:00:7E:D6:F8:F4:59:2D
        X509v3 Basic Constraints: critical
            CA:TRUE
        X509v3 Key Usage: critical
            Digital Signature, Certificate Sign, CRL Sign
...
```

The output shows

- the Signature Algorithm used
- the dates of certificate Validity
- the Public-Key bit length
- the Issuer, which is the entity that signed the certificate
- the Subject, which refers to the certificate itself

note: The Issuer and Subject are identical as the certificate is self-signed

Output from the **[Sectigo Certificate Linter](https://crt.sh/lintcert)**:

```bash
cablint INFO CA certificate identified
x509lint INFO Checking as root CA certificate
```

**[Use an online certificate decoder to view](https://www.sslshopper.com/certificate-decoder.html)**

```bash
- certificate information
Common Name: Root CA
Subject Alternative Names:
Organization: Mobex Global
Organization Unit:
Locality: Albion
State: Indiana
Country: US
Valid From: August 18, 2023
Valid To: August 13, 2043
Issuer: Root CA, Mobex Global
Key Size: 4096 bit
Serial Number: 3b4b36cbb5fb2435011b3a6eca1546cd4bdcfe5c
```

## Generate the intermediate RSA key pair

```bash
# Create an RSA key pair for the intermediate CA without a password and secure the file by removing permissions to groups and others.
openssl genrsa -out ~/src/pki/intermediateCA/private/intermediate.key.pem 4096
chmod 400 ~/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem
ls -al ~/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem
```

## Verify the intermediate RSA key pair

```bash
openssl rsa -noout -text -in ~/src/pki/intermediateCA/private/intermediate.key.pem
```

## Create the intermediate CA certificate signing request (CSR) in PKCS#10 format

```bash
# The req command primarily creates and processes certificate requests in PKCS#10 format. It can additionally create self signed certificates for use as root CAs

# Note the generation of the cert does not happen until the next step unlike for the root cert.

openssl req \
-config ~/src/pki/openssl_intermediate.cnf \
-key ~/src/pki/intermediateCA/private/intermediate.key.pem \
-new -sha256 -out ~/src/pki/intermediateCA/csr/intermediate.csr.pem -subj "/C=US/ST=Indiana/L=Albion/O=Mobex Global/CN=Intermediate CA"
```

Note differences between the above request and the below ca root request. Don't run the next command just look at the differences. Also note v3 extensions are not added to the CSR but the subject line and RSA key pair info is.

```bash
openssl req \
-config ~/src/pki/openssl_root.cnf \
-key ~/src/pki/rootCA/private/ca.key.pem \
-new -x509 -days 7300 -sha256 -extensions v3_ca \
-out ~/src/pki/rootCA/certs/ca.cert.pem \
-subj "/C=US/ST=Indiana/L=Albion/O=Mobex Global/CN=Root CA"
```

Verify the intermediate CA certificate signing request (CSR) with the OpenSSL req command.

```bash
openssl req -text -noout -verify -in ~/src/pki/intermediateCA/csr/intermediate.csr.pem

Certificate request self-signature verify OK
Certificate Request:
    Data:
        Version: 1 (0x0)
        Subject: C = US, ST = Indiana, L = Albion, O = Mobex Global, CN = Intermediate CA
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (4096 bit)
                Modulus:
                    00:d4:d1:9c:b8:06:a1:c6:df:8b:48:ba:09:82:b5:
...
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        6b:3a:1c:89:ef:6a:c5:b5:05:ef:0f:db:bc:8f:01:07:1e:1c:
...
```

View the intermediate CA certificate signing request (CSR) in PKCS#10 format with an online **[CSR decoder](https://www.sslshopper.com/csr-decoder.html)**.

```bash
CSR Information:
Common Name: Intermediate CA
Organization: Mobex Global
Locality: Albion
State: Indiana
Country: US
Key Size: 4096 bit
```

## Sign the intermediate CSR with the root CA key

The **[ca command](https://www.openssl.org/docs/man1.1.1/man1/ca.html)** is a minimal CA application. It can be used to sign certificate requests in a variety of forms and generate CRLs it also maintains a text database of issued certificates and their status.

```bash
pushd .
cd ~/src/pki
openssl ca \
-rand_serial -config ~/src/pki/openssl_root.cnf \
-extensions v3_intermediate_ca \
-days 3650 -notext -md sha256 \
-in ~/src/pki/intermediateCA/csr/intermediate.csr.pem -out ~/src/pki/intermediateCA/certs/intermediate.cert.pem
popd
```

Note the following in the v3_intermediate_ca compared to the v3_ca section used to generate the root certificate:

- **[pathlen:0](https://www.encryptionconsulting.com/wp-content/uploads/2022/08/path-length-1024x569.jpg.webp)** no CA certificate under this certificate.
- Specifying **[issuer](https://superuser.com/questions/1778937/the-authoritykeyidentifier-does-not-get-accepted)** asks OpenSSL to copy the DN from the issuing certificate... and there is no issuing certificate yet if you're just generating a CSR – it will only become known sometime in the future, when the CSR is given to a CA to sign.
- **[certificatePolicies](https://security.stackexchange.com/questions/264110/how-to-determine-validation-process-of-a-certificate-used-by-a-website-using-htt)**
- **[crlDistributionPoints](http://rcardon.free.fr/websign/download/api-x509-ext/be/cardon/asn1/x509/extensions/CRLDistributionPoints.html)**
- **[extendedKeyUsage](https://stackoverflow.com/questions/63433936/what-is-serverauth-and-clientauth)**
- **[authorityInfoAccess](https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html)**

For the complete **[X509 V3 certificate extension configuration format](https://www.openssl.org/docs/man1.0.2/man5/x509v3_config.html)**

```bash
[ v3_ca ]                                           # Root CA certificate extensions
subjectKeyIdentifier = hash                         # Subject key identifier
authorityKeyIdentifier = keyid:always,issuer        # Authority key identifier
basicConstraints = critical, CA:true                # Basic constraints for a CA
# CA certificates without Digital Signature do not allow direct signing of OCSP responses
# https://www.openssl.org/docs/manmaster/man5/x509v3_config.html
keyUsage = critical, keyCertSign, digitalSignature, cRLSign           # Key usage for a CA

[ v3_intermediate_ca ]                                      # Intermediate CA certificate extensions
subjectKeyIdentifier = hash                                 # Subject key identifier
# https://github.com/OpenVPN/easy-rsa/issues/417
# authorityKeyIdentifier = keyid,issuer                       # Authority key identifier linking the certificate to the issuer's public key.
authorityKeyIdentifier = keyid:always                       # Authority key identifier
basicConstraints = critical, CA:true, pathlen:0             # Basic constraints for a CA
# CA certificates without Digital Signature do not allow direct signing of OCSP responses
# https://www.openssl.org/docs/manmaster/man5/x509v3_config.html
keyUsage = critical, keyCertSign, digitalSignature, cRLSign           # Key usage for a CA
# For general purpose CAs, you can use a universal Object Identifier with the value 2.5.29.32.0. This identifier means “All Issuance Policies” and is a sort of wildcard policy. Any policy will match this identifier during certificate chain validation.
# https://security.stackexchange.com/questions/264110/how-to-determine-validation-process-of-a-certificate-used-by-a-website-using-htt
# For general purpose CAs, you can use a universal Object Identifier with the value 2.5.29.32.0. This identifier means “All Issuance Policies” and is a sort of wildcard policy. Any policy will match this identifier during certificate chain validation.
# certificatePolicies = 2.5.29.32.0 # any policy
# certificatePolicies = 2.23.140.1.2.1 # validation policy

# https://security.stackexchange.com/questions/264110/how-to-determine-validation-process-of-a-certificate-used-by-a-website-using-htt
certificatePolicies = 2.23.140.1.2.1, 2.5.29.32.0
# https://security.stackexchange.com/questions/252622/what-is-the-purpose-of-certificatepolicies-in-a-csr-how-should-an-oid-be-used
# certificatePolicies = 1.2.3.4
# ERROR Subordinate CA Certificate: cRLDistributionPoints MUST be present and MUST NOT be marked critical.
crlDistributionPoints=URI:http://busche-cnc.com/crl.pem
# zlint NOTICE To be considered Technically Constrained, the Subordinate CA certificate MUST have extkeyUsage extension
extendedKeyUsage = serverAuth                               # Extended key usage for server authentication purposes (e.g., TLS/SSL servers).
# authorityInfoAccess = OCSP;URI:http://ocsp.busche-cnc.com/
# authorityInfoAccess = caIssuers;URI:http://busche-cnc.com/ca.html
authorityInfoAccess = OCSP;URI:http://ocsp.busche-cnc.com/,caIssuers;URI:http://busche-cnc.com/ca.html

```

## Assign 444 permission to the CRT to make it readable by everyone

```bash
chmod 444 ~/src/pki/intermediateCA/certs/intermediate.cert.pem
ls -al ~/src/pki/intermediateCA/certs/intermediate.cert.pem
```

### Verify the Intermediate CA Certificate content

```bash
openssl x509 -noout -text -in ~/src/pki/intermediateCA/certs/intermediate.cert.pem
```

## Intermidiate CA certificate

- Was generated using **[openssl ca](https://www.openssl.org/docs/man1.1.1/man1/ca.html)**
- Used an v3_intermediate_ca section of openssl_root.cnf file addressing problems found when checking the certificate at the **[Sectigo Certificate Linter](https://crt.sh/lintcert)**:

**[Certificate Information:](https://www.sslshopper.com/certificate-decoder.html)**

Common Name: Intermediate CA
Subject Alternative Names:
Organization: Mobex Global
Organization Unit:
Locality:
State: Indiana
Country: US
Valid From: August 18, 2023
Valid To: August 15, 2033
Issuer: Root CA, Mobex Global
Key Size: 4096 bit
Serial Number: 57456f1a0956ab0c6301c7ab93fc22918ba3b406

Next verify the intermediate certificate against the root certificate. An OK indicates that the chain of trust is intact.

```bash
pushd .
cd ~/src/pki/intermediateCA
openssl verify -CAfile ~/src/pki/rootCA/certs/ca.cert.pem ~/src/pki/intermediateCA/certs/intermediate.cert.pem
/home/brent/src/pki/intermediateCA/certs/intermediate.cert.pem: OK
```

## Generate the partial Certificate Chain (Certificate Bundle)

To create certificate chain (certificate bundle), concatenate the intermediate and root certificates

In the below example I have combined our Root and Intermediate CA certificates to create our certificate chain. We will use this file later to verify certificates signed by the intermediate CA

```bash
cat ~/src//pki/intermediateCA/certs/intermediate.cert.pem ~/src/pki/rootCA/certs/ca.cert.pem > ~/src/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem
```

## Verify the intermediate CA signature against the partial certificate chain

An OK indicates that the chain of trust is intact.

```bash
pushd .
cd ~/src/pki/intermediateCA
openssl verify -CAfile ~/src/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/pki/intermediateCA/certs/intermediate.cert.pem
/home/brent/src/pki/intermediateCA/certs/intermediate.cert.pem: OK
```

## Create a **[subject alternative name, SAN, Certificate using openssl](https://www.golinuxcloud.com/openssl-generate-csr-create-san-certificate)**

What is SAN Certificate?
A (Subject Alternative Name) SAN certificate can be used on multiple domain names, for example, abc.com or xyz.com, where the domain names are completely different, but they can use the same certificate.
SAN can have multiple common names associated with the certificate.
This is useful when the server runs multiple services and therefore will use multiple names.
For example, I could have a SAN certificate for my Exchange server that holds the names mail.golinuxcloud.com and server.golinuxcloud.com.
Without the use of a SAN certificate, I would need to purchase multiple single common name certificates.
We define a list of IP Address, DNS values which will be used as Common Name for certificate validation when we create CSR using openssl.

## Generate server SAN certificate RSA key pair or use the one generated from Mach2

We generated the following private keys for various report system K8s cluster

## reports1 kong ingress controller

```bash
openssl genpkey -algorithm RSA \
-out ~/src/pki/intermediateCA/private/reports1.busche-cnc.com.san.key.pem
```

## reports51

```bash
openssl genpkey -algorithm RSA \
-out ~/src/pki/intermediateCA/private/reports51.busche-cnc.com.san.key.pem
```

## reports11

```bash
openssl genpkey -algorithm RSA \
-out ~/src/pki/intermediateCA/private/reports11.busche-cnc.com.san.key.pem
```

## reports-alb

```bash
openssl genpkey -algorithm RSA \
-out ~/src/pki/intermediateCA/private/reports-alb.busche-cnc.com.san.key.pem
```

## moto and home

```bash
openssl genpkey -algorithm RSA \
-out ~/src/pki/intermediateCA/private/moto.busche-cnc.com.san.key.pem
```

## devcon2

```bash
openssl genpkey -algorithm RSA \
-out ~/src/pki/intermediateCA/private/devcon2.busche-cnc.com.san.key.pem
```

## frt-kors43.busche-cnc.com from Niagara CSR (Failed Attempt)

This was from the failed Mach2 attempt 1 when Sam generated the CSR and I signed it. I don't remember the reason of the failue but I think the subject line of the CSR contained DN that are no longer accepted by browsers. The method that we got to work is the following:

- Generate a certificate from Niagara and export the a non-encrypted RSA private key
- Generate a SAN certificate from the RSA key pair generated from Niagara

## frt-kors43.busche-cnc.com use Niagara RSA key pair

```bash
# RSA key pair generated by Niagara
code ~/src/pki/intermediateCA/private/frt-kors43.busche-cnc.com.san.key.pem
```

## frt-kors43.linamar.com.san.key.pem

```bash
# RSA key pair generated by Niagara
code ~/src/pki/intermediateCA/private/frt-kors43.linamar.com.san.key.pem
```

## Generate and **[validate CSR](https://www.sslshopper.com/csr-decoder.html)** with online CSR decoder and OpenSSL

Now in order to create a SAN certificate we must generate a new CSR i.e. Certificate Signing Request which we will use in next step with openssl to generate a SAN certificate. Accept the default Country Name when prompted no other subject fields should be added.

The output from the **[CSR decoder](https://www.sslshopper.com/csr-decoder.html)** should look like this.

```yaml
CSR Information:
Country: US
Key Size: 2048 bit
```

The output from OpenSSL should look like this

```bash
openssl req -in ~/src/pki/intermediateCA/csr/frt-kors43.linamar.com.san.csr.pem -noout -text
Certificate Request:
    Data:
        Version: 1 (0x0)
        Subject: C = US
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:8d:01:c2:9a:d4:d5:5e:5e:aa:b3:a6:5e:ad:af:
                    04:7e:50:fb:8b:69:3b:d8:b5:54:e8:5a:e9:86:64:
                    e0:b2:4d:c8:c6:97:1f:37:45:74:fa:af:45:5e:72:
                    f1:98:17:2f:55:85:63:17:59:6d:6b:83:45:3c:3b:
                    a1:ee:9a:f1:a6:21:ed:7d:30:4c:0c:aa:34:67:2b:
                    2f:6f:c5:bf:71:b0:57:e7:13:19:e4:20:43:a7:ed:
                    cb:4e:be:d4:4d:c3:ad:4c:84:94:c9:6a:10:c2:e0:
                    80:49:c6:0c:e6:2a:78:3c:9d:74:87:06:71:51:92:
                    6a:15:32:cd:99:4c:39:d0:29:6e:0a:33:11:da:68:
                    6a:11:30:af:ca:31:80:11:11:92:7c:5c:81:fb:fe:
                    28:4b:72:85:07:f0:d3:f6:71:03:de:62:bc:69:e3:
                    3a:08:99:ca:c8:5c:ef:b7:19:07:c6:a5:a9:28:83:
                    46:65:9c:1f:04:4e:0e:e5:43:a6:eb:95:32:70:23:
                    e8:7b:d0:e0:5d:fb:75:fc:e7:02:c5:03:96:4e:ab:
                    34:3a:99:5a:d3:b7:ad:b1:f1:e6:ff:de:10:82:b4:
                    01:dc:33:27:33:c4:b8:ad:23:ab:f9:20:4b:7c:5c:
                    01:23:c1:90:05:22:7e:77:db:4a:12:8f:2a:76:f9:
                    31:b5
                Exponent: 65537 (0x10001)
        Attributes:
            (none)
            Requested Extensions:
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        52:c5:53:ce:85:b0:76:ef:76:f8:f0:b5:39:1f:d4:dc:90:c2:
        86:cd:de:9b:57:07:c1:15:69:c6:6e:4d:13:5b:ba:15:d5:a7:
        3e:ef:53:af:6e:68:fe:7b:b4:9b:fe:b3:a9:ef:a8:8c:ba:68:
        79:1b:46:7d:f8:62:09:56:bd:a9:ef:9b:23:a3:ed:26:1a:cf:
        30:2c:ae:72:c5:b7:2a:3d:9e:64:f9:6f:5d:3c:65:f7:3d:65:
        70:b7:49:42:9d:c9:df:fa:d4:65:4c:82:38:a5:09:5d:a3:c1:
        75:5e:6d:a8:7e:87:c9:3b:00:14:3e:48:76:d5:28:4a:31:09:
        06:21:83:c9:8a:ae:70:35:fe:17:7d:04:b8:4c:9e:cc:0d:7e:
        d3:35:69:f6:67:4a:cf:e5:c2:f1:f6:d0:fc:d8:41:f6:ad:38:
        88:30:c7:2a:b1:e4:aa:d7:30:c6:ca:85:42:ce:b2:6f:77:a5:
        23:82:45:7d:ce:aa:59:db:f6:be:c5:07:c8:13:d4:1d:37:fd:
        b3:56:96:35:0e:a0:01:37:ca:32:00:6f:dc:01:4d:6f:7f:8e:
        1f:4e:0b:cf:d4:ca:c7:08:9a:00:39:00:4a:5b:5b:a3:39:5a:
        5c:b7:d2:11:60:7a:4a:06:0f:81:1f:c6:84:4c:f2:9d:18:50:
        ac:d0:63:54
```

```bash
pushd .
cd ~/src/pki/intermediateCA
# frt-kors43.linamar.com.san.key.pem
openssl req \
-config ~/src/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/pki/intermediateCA/private/frt-kors43.linamar.com.san.key.pem \
-new -sha256 \
-out ~/src/pki/intermediateCA/csr/frt-kors43.linamar.com.san.csr.pem

# check with openssl
openssl req -in ~/src/pki/intermediateCA/csr/frt-kors43.linamar.com.san.csr.pem -noout -text

# hrt-kors43.busche-cnc.com.key

# I can ping this server. ping hrt-kors43.busche-cnc.com

openssl req \
-config ~/src/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/hrt-kors43.busche-cnc.com.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/hrt-kors43.busche-cnc.com.san.csr.pem

# mgedo-srv-mach2.busche-cnc.com

# note: can not ping this but can access it with chrome

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/mgedo-srv-mach2.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/mgedo-srv-mach2.san.csr.pem

# frt-kors43.busche-cnc.com

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/sams.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/sams.san.csr.pem

# reports-alb

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/reports-alb.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/reports-alb.busche-cnc.com.san.csr.pem

# reports1 for kong ingress control

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/reports1.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/reports1.busche-cnc.com.san.csr.pem

# reports11

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/reports11.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/reports11.busche-cnc.com.san.csr.pem

# reports51

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/reports51.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/reports51.busche-cnc.com.san.csr.pem

# moto and home

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/moto.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/moto.busche-cnc.com.san.csr.pem

# devcon2

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/devcon2.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/devcon2.busche-cnc.com.san.csr.pem

# frt-kors43

openssl req \
-config ~/src/repsys/volumes/pki/openssl_intermediate_for_san_certificate.cnf \
-key ~/src/repsys/volumes/pki/intermediateCA/private/frt-kors43.busche-cnc.com.san.key.pem \
-new -sha256 \
-out ~/src/repsys/volumes/pki/intermediateCA/csr/frt-kors43.busche-cnc.com.san.csr.pem

```

## Sign the CSR with our intermediate CA certificate

Sign the CSR with our intermediate CA certificate chain bundle and intermediate certificates private key to create a Subject Alternative Name, SAN, certificate.  Make sure to create a new configuration file such as, cert_ext_reports11.cnf, for each server. This config file contains the FQDN in which the certificate is valid for.  These certificates are only valid for 1 year which is a minimum now imposed by browsers.

Can we have one SAN certificate for all Mach2 servers?

Only certificates with the private key generated from the Niagara server using it are able to be set, so I don't believe one Niagara server will be able to use another Niagara server's certificate.

```bash
# reports1 for kong ingress controller

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/reports11.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/reports11.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_reports11.cnf

# reports11

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/reports11.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/reports11.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_reports11.cnf

# reports51

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/reports51.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/reports51.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_reports51.cnf

# reports-alb

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/reports-alb.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/reports-alb.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_reports-alb.cnf

# moto and home

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/moto.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/moto.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_moto.cnf

# devcon2

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/devcon2.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/devcon2.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_devcon2.cnf

# frt-kors43.busche-cnc.com

# Mach2 attempt2 in which we generate the certificate and private key with Niagara and we discard the certificate and generate our own using Niagara generated private key

openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/sams.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/sams.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_frt-kors43.cnf

# mgedo-srv-mach2.busche-cnc.com

pushd ~/src/repsys/volumes/pki/intermediateCA
openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/mgedo-srv-mach2.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/mgedo-srv-mach2.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_mgedo-srv-mach2.cnf

# hrt-kors43.busche-cnc.com

pushd ~/src/repsys/volumes/pki/intermediateCA
openssl x509 -req \
-in /home/brent/src/repsys/volumes/pki/intermediateCA/csr/hrt-kors43.busche-cnc.com.san.csr.pem \
-CA /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/repsys/volumes/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/repsys/volumes/pki/intermediateCA/certs/hrt-kors43.busche-cnc.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/repsys/volumes/pki/cert_ext_hrt-kors43.cnf

# frt-kors43.linamar.com

# Sam generated this certificate and private key with Niagara and we discard the certificate and generate our own CSR and certificate using Niagara generated private key

openssl x509 -req \
-in /home/brent/src/pki/intermediateCA/csr/frt-kors43.linamar.com.san.csr.pem \
-CA /home/brent/src/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem \
-CAkey /home/brent/src/pki/intermediateCA/private/intermediate.key.pem \
-out /home/brent/src/pki/intermediateCA/certs/frt-kors43.linamar.com.san.cert.pem \
-CAcreateserial -days 365 -sha256 \
-extfile /home/brent/src/pki/cert_ext_frt-kors43_linamar.cnf

Certificate request self-signature ok
subject=C = US

```

Since we used x509 instead of ca to sign the cert the index.txt and serial database was not updated but the certs/ca-chain/ca-chain-bundle.cert.srl file serial number was updated but we probably should have a list of all of the serial numbers issued not just the latest

Check with online **[certficate decoder](https://www.sslshopper.com/certificate-decoder.html)**

```bash
code ~/src/pki/intermediateCA/certs/frt-kors43.linamar.com.san.cert.pem
```

```yaml
Certificate Information:
Common Name:
Subject Alternative Names: frt-kors43.linamar.com
Organization:
Organization Unit:
Locality:
State:
Country: US
Valid From: May 14, 2024
Valid To: May 14, 2025
Issuer: Intermediate CA, Mobex Global
Key Size: 2048 bit
Serial Number: 50d4396fe4e68bfdff25bb5849da436ba29d4e30
```

Check certificate with OpenSSL

```bash
openssl x509 -noout -text -in ~/src/pki/intermediateCA/certs/frt-kors43.linamar.com.san.cert.pem
Certificate:
    Data:
        Version: 3 (0x2)
        Serial Number:
            50:d4:39:6f:e4:e6:8b:fd:ff:25:bb:58:49:da:43:6b:a2:9d:4e:30
        Signature Algorithm: sha256WithRSAEncryption
        Issuer: C = US, ST = Indiana, O = Mobex Global, CN = Intermediate CA
        Validity
            Not Before: May 14 21:40:26 2024 GMT
            Not After : May 14 21:40:26 2025 GMT
        Subject: C = US
        Subject Public Key Info:
            Public Key Algorithm: rsaEncryption
                Public-Key: (2048 bit)
                Modulus:
                    00:8d:01:c2:9a:d4:d5:5e:5e:aa:b3:a6:5e:ad:af:
                    04:7e:50:fb:8b:69:3b:d8:b5:54:e8:5a:e9:86:64:
                    e0:b2:4d:c8:c6:97:1f:37:45:74:fa:af:45:5e:72:
                    f1:98:17:2f:55:85:63:17:59:6d:6b:83:45:3c:3b:
                    a1:ee:9a:f1:a6:21:ed:7d:30:4c:0c:aa:34:67:2b:
                    2f:6f:c5:bf:71:b0:57:e7:13:19:e4:20:43:a7:ed:
                    cb:4e:be:d4:4d:c3:ad:4c:84:94:c9:6a:10:c2:e0:
                    80:49:c6:0c:e6:2a:78:3c:9d:74:87:06:71:51:92:
                    6a:15:32:cd:99:4c:39:d0:29:6e:0a:33:11:da:68:
                    6a:11:30:af:ca:31:80:11:11:92:7c:5c:81:fb:fe:
                    28:4b:72:85:07:f0:d3:f6:71:03:de:62:bc:69:e3:
                    3a:08:99:ca:c8:5c:ef:b7:19:07:c6:a5:a9:28:83:
                    46:65:9c:1f:04:4e:0e:e5:43:a6:eb:95:32:70:23:
                    e8:7b:d0:e0:5d:fb:75:fc:e7:02:c5:03:96:4e:ab:
                    34:3a:99:5a:d3:b7:ad:b1:f1:e6:ff:de:10:82:b4:
                    01:dc:33:27:33:c4:b8:ad:23:ab:f9:20:4b:7c:5c:
                    01:23:c1:90:05:22:7e:77:db:4a:12:8f:2a:76:f9:
                    31:b5
                Exponent: 65537 (0x10001)
        X509v3 extensions:
            X509v3 Basic Constraints: critical
                CA:FALSE
            X509v3 Subject Key Identifier: 
                48:BE:7B:DA:28:07:69:82:4D:72:99:16:EC:0A:09:D8:42:F0:11:49
            X509v3 Authority Key Identifier: 
                B2:04:7B:21:5A:89:EA:FE:3F:91:F2:97:D2:46:3D:42:AA:AA:60:66
            X509v3 Key Usage: critical
                Digital Signature, Key Encipherment
            X509v3 Extended Key Usage: 
                TLS Web Server Authentication
            X509v3 Subject Alternative Name: 
                DNS:frt-kors43.linamar.com
            Authority Information Access: 
                OCSP - URI:http://ocsp.busche-cnc.com/
                CA Issuers - URI:http://busche-cnc.com/ca.html
            X509v3 Certificate Policies: 
                Policy: 2.23.140.1.2.1
                Policy: X509v3 Any Policy
    Signature Algorithm: sha256WithRSAEncryption
    Signature Value:
        3f:f3:a2:87:38:e8:b7:75:30:66:40:46:59:b3:f6:7d:c8:1c:
        2d:c2:6d:44:08:f1:bc:10:d9:e7:22:ae:eb:ee:ac:0f:ac:2d:
        7e:91:72:21:2e:e3:79:da:d2:99:01:44:00:28:d3:e9:43:e1:
        7d:8f:45:ff:3f:b0:6b:eb:43:42:e7:94:1f:d0:48:9c:db:9b:
        e3:65:7b:5c:b6:e6:61:dc:16:78:6a:b5:64:d1:71:02:f1:1d:
        78:b2:9d:14:bf:03:15:c4:c5:d1:4d:6f:4d:14:71:a4:75:32:
        3a:77:93:72:2c:48:c6:c2:f3:f8:c3:7b:58:05:c5:73:fe:39:
        72:51:21:43:45:6f:59:29:c8:10:8b:71:1e:94:bf:be:e0:73:
        9a:b9:dc:e4:19:2c:db:af:72:1f:23:50:86:5a:52:7d:66:20:
        57:ff:92:58:7d:06:06:fe:e9:6f:b5:6d:58:c4:2f:c7:a0:3f:
        0f:7f:8f:17:f1:f2:d7:05:fe:67:9c:43:2f:dd:ec:94:f9:66:
        cf:1d:c1:a1:dc:91:fc:9a:ae:c7:ae:b4:f2:f3:24:a8:be:f4:
        25:f0:98:11:0d:51:1b:c0:c3:82:19:0b:fc:92:e5:25:ed:82:
        97:e7:c6:26:f2:a2:16:50:be:fb:d8:a5:84:21:fc:b2:33:95:
        7f:46:3f:17:e1:c1:5a:ca:bf:36:c1:7a:dd:b8:74:bc:ee:1c:
        9c:66:ea:a0:83:17:0a:54:77:26:2f:e5:50:40:39:7d:07:eb:
        3b:64:6e:09:c7:b5:6e:91:6d:ad:70:45:92:60:a2:56:c2:15:
        43:d5:3f:66:cc:1b:ba:0b:4a:b5:33:ad:66:62:07:15:6e:46:
        c2:c3:9a:80:bf:5c:d7:b5:2e:0b:21:a3:a2:80:f3:33:93:c5:
        33:83:a4:91:7e:ff:b6:87:c4:19:b7:e3:0d:2c:e3:9d:d7:53:
        a7:bf:11:8d:48:98:ca:75:52:1b:c4:0d:4d:62:82:90:8c:b7:
        f0:f4:1c:7c:e7:72:d9:5a:18:dd:a0:74:4b:1c:e3:40:9d:47:
        20:a7:d0:6d:47:d3:98:9d:e1:9e:ae:31:91:3c:58:a2:d5:4d:
        d3:da:35:e7:c2:ca:f8:6d:72:4b:36:66:e3:72:33:96:6d:c9:
        9b:b2:07:5b:6a:71:fe:76:d7:28:9f:8a:83:92:68:b0:e1:51:
        28:24:29:8a:72:49:9c:db:37:ad:70:c5:86:b4:74:c2:e4:82:
        4a:88:59:12:9c:98:78:c8:85:de:a3:23:5d:1d:ab:b6:6f:12:
        18:3e:b9:39:77:1b:9d:89:6d:dc:57:e8:f2:85:84:01:b3:3a:
        39:09:0e:f5:cb:c3:e5:17
```

Verify private/public key pair match using an **[online certificate key matcher](https://www.sslshopper.com/certificate-key-matcher.html)**.

```bash
code ~/src/pki/intermediateCA/certs/frt-kors43.linamar.com.san.cert.pem
code /home/brent/src/pki/intermediateCA/private/intermediate.key.pem
code ~/src/pki/intermediateCA/private/frt-kors43.linamar.com.san.key.pem
```

Output from **[online key tool](https://www.sslshopper.com/certificate-key-matcher.html)**

```bash
The certificate and private key match!
Certificate Hash:
1c72d815d1aa3b32ff83eb642c216ec0467a250bf52d2247f65d7329b10688c7
Key Hash:
1c72d815d1aa3b32ff83eb642c216ec0467a250bf52d2247f65d7329b10688c7
```

The **[Certificate Key Matcher](https://www.sslshopper.com/certificate-key-matcher.html)** simply compares a hash of the public key from the private key, the certificate, or the CSR and tells you whether they match or not. You can check whether a certificate matches a private key, or a CSR matches a certificate on your own computer by using the OpenSSL commands below:

```bash
openssl pkey -in privateKey.key -pubout -outform pem | sha256sum
openssl x509 -in certificate.crt -pubkey -noout -outform pem | sha256sum
openssl req -in CSR.csr -pubkey -noout -outform pem | sha256sum
```

## Validate server SAN certificate at **[Sectigo Certificate Linter](https://crt.sh/lintcert)**

On May 14, 2024 marked basicConstraints as critical in server config file to rid ourselves of the following linter error:

```bash
zlint ERROR basicConstraints MAY appear in the certificate, and when it is included MUST be marked as critical
```

The Sectigo Linter did not show this error on some of the previously generated server certificates but I don't know why. The CSR config file already had basicConstraints marked as critical. This change has not been tested on Niagara yet.

Added to server config file:
```basicConstraints = critical, CA:FALSE```

```bash
code ~/src/pki/intermediateCA/certs/frt-kors43.linamar.com.san.cert.pem

cablint INFO TLS Server certificate identified
x509lint INFO Checking as leaf certificate
zlint NOTICE Check if certificate has enough embedded SCTs to meet Apple CT Policy

```

# <https://crt.sh/lintcert>

# <https://www.sslshopper.com/certificate-decoder.html>

# cablint INFO TLS Server certificate identified

# x509lint INFO Checking as leaf certificate

# zlint NOTICE Check if certificate has enough embedded SCTs to meet Apple CT Policy

# verify certificate

# Next openssl verify intermediate certificate against the root certificate. An OK indicates that the chain of trust is intact

# verifying with just the intermediate certificate fails as expected

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/intermediate.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/moto.busche-cnc.com.san.cert.pem
error 2 at 1 depth lookup: unable to get issuer certificate

# ok

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/reports51.busche-cnc.com.san.cert.pem

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/reports1.busche-cnc.com.san.cert.pem

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/reports11.busche-cnc.com.san.cert.pem

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/hrt-kors43.busche-cnc.com.san.cert.pem

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/hrt-kors43.busche-cnc.com.san.cert.pem

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/mgedo-srv-mach2.san.cert.pem

openssl verify -CAfile ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/reports-alb.busche-cnc.com.san.cert.pem

# Make the cert chain for nginx. this does not include the SAN certificates private key

cat ~/src/repsys/volumes/pki/intermediateCA/certs/reports1.busche-cnc.com.san.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem  > ~/src/repsys/volumes/pki/intermediateCA/certs/server-chain/reports1.busche-cnc.com-ca-chain-bundle.cert.pem

cat ~/src/repsys/volumes/pki/intermediateCA/certs/reports51.busche-cnc.com.san.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem  > ~/src/repsys/volumes/pki/intermediateCA/certs/server-chain/reports51.busche-cnc.com-ca-chain-bundle.cert.pem

# This is the format needed for the Niagara system

# Make the key server cert chain for Niagara. This needs to include the certificates private key generated from Niagara

cat ~/src/repsys/volumes/pki/intermediateCA/certs/hrt-kors43.busche-cnc.com.san.cert.pem ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem  > ~/src/repsys/volumes/pki/intermediateCA/certs/server-chain/hrt-kors43.busche-cnc.com-ca-chain-bundle.cert.pem

# note: make sure private key has a carriage return at the end before concatenating it with the certificate bundle

cat ~/src/repsys/volumes/pki/intermediateCA/private/hrt-kors43.busche-cnc.com.key.pem ~/src/repsys/volumes/pki/intermediateCA/certs/server-chain/hrt-kors43.busche-cnc.com-ca-chain-bundle.cert.pem  > ~/src/repsys/volumes/pki/intermediateCA/certs/niagara/key-hrt-kors43-ca-chain-bundle.cert.pem

# Apache Certificate installation process

pushd ~/src/repsys/volumes/pki/intermediateCA/certs
sudo mkdir -p /usr/local/apache2/conf/ssl.crt/
sudo mkdir -p /usr/local/apache2/conf/ssl.key/

# moto home and work

sudo cp moto.busche-cnc.com.san.cert.pem /usr/local/apache2/conf/ssl.crt/
ls -al /usr/local/apache2/conf/ssl.crt/

# devcon2

sudo cp devcon2.busche-cnc.com.san.cert.pem /usr/local/apache2/conf/ssl.crt/

# frt-kors43

sudo cp frt-kors43.busche-cnc.com.san.cert.pem /usr/local/apache2/conf/ssl.crt/

ls -al /usr/local/apache2/conf/ssl.crt/

# ca-chain-bundle

pushd ~/src/repsys/volumes/pki/intermediateCA/certs/ca-chain
sudo cp ca-chain-bundle.cert.pem /usr/local/apache2/conf/ssl.crt/
ls -al /usr/local/apache2/conf/ssl.crt/

# copy server key

pushd ~/src/repsys/volumes/pki/intermediateCA/private

# moto home and work

sudo cp moto.busche-cnc.com.san.key.pem /usr/local/apache2/conf/ssl.key/
ls -al /usr/local/apache2/conf/ssl.key/

# devcon2

sudo cp devcon2.busche-cnc.com.san.key.pem /usr/local/apache2/conf/ssl.key/
ls -al /usr/local/apache2/conf/ssl.key/

# Instructions for adding our certificate chain to Windows computers

# Our Mach2 servers use SSL certificates that we have generated from our PKI.  We must add the certificate chain to each computer that access the Mach2 servers so the user does not have to bypass a security warning screen.  There are several ways to do this  

## add to local Windows trust store

certmgr

# add ca.cert.pem to trusted root certificate authorities

# add intermediate.cert.pem to intermediate certificate authorities

## add to Windows trust store using GPO

**[Not quite what we want but close](https://support.securly.com/hc/en-us/articles/206688537-How-to-push-the-Securly-SSL-certificate-with-Active-Directory-GPO
)**

# In our PKI we have an intermediate as well as a root CA so we must add a second step to import our intermediate certificate into the trusted intermediate certificate store like we did using certmgr in the previous section

# add to chrome trust store

```bash
get ca-chain-bundle.cert.pem 
run chrome
type chrome://settings/certificates
go to Authorities tab
import certs
select PEM certificate chain from the dropdown.
select ca-chain-bundle.cert.pem
select trust websites
notice new authority entry and select it
verify both the root and intermediate certificates are installed.

# verify

certutil -d sql:$HOME/.pki/nssdb -L
Certificate Nickname                                         Trust Attributes
SSL,S/MIME,JAR/XPI

Root CA - Mobex Global                                       CT,c,c
Intermediate CA - Mobex Global                               ,,  

# add to Linux openssl trust store

# <https://ubuntu.com/server/docs/security-trust-store>
# <https://manpages.ubuntu.com/manpages/lunar/en/man8/update-ca-certificates.8.html>
# Installing a certificate in PEM form
# Assuming a PEM-formatted root CA certificate is in local-ca.crt, follow the steps below to install it.

# Note: It is important to have the .crt extension on the file, otherwise it will not be processed. Can only import one certificate at a time.

pushd /home/brent/src/repsys/volumes/pki/intermediateCA/certs
mkdir ~/certs
cp intermediate.cert.pem ~/certs
cp ca-chain/ca-chain-bundle.cert.pem ~/certs
pushd /home/brent/src/repsys/volumes/pki/rootCA/certs
cp ca.cert.pem ~/certs
sudo mount -t cifs //alb-utl.busche-cnc.com/Downloads /mnt/winshare -o username=bgroves
sudo cp ~/certs/ /mnt/winshare/

sudo apt-get install -y ca-certificates
sudo cp intermediate.cert.pem /usr/local/share/ca-certificates/intermediate.crt
pushd /home/brent/src/repsys/volumes/pki/rootCA/certs
sudo cp ca.cert.pem /usr/local/share/ca-certificates/ca.cert.crt
ls -al /usr/local/share/ca-certificates/ca.cer*
ls -al /usr/local/share/ca-certificates/int*
sudo update-ca-certificates

Importing into legacy system store:
I already trust 144, your new list has 139
Certificate added: C=US, S=Indiana, L=Albion, O=Mobex Global, CN=Root CA
Certificate added: C=US, S=Indiana, O=Mobex Global, CN=Intermediate CA
2 new root certificates were added to your trust store.
Import process completed.

Importing into BTLS system store:
I already trust 139, your new list has 139
Certificate added: C=ES, CN=Autoridad de Certificacion Firmaprofesional CIF A62634068
Certificate added: C=US, S=Indiana, L=Albion, O=Mobex Global, CN=Root CA
Certificate added: C=US, S=Indiana, O=Mobex Global, CN=Intermediate CA
3 new root certificates were added to your trust store.
Import process completed.
Done
done.

# verify

ls /etc/ssl/certs/ca*
ls /etc/ssl/certs/int*
sudo nvim /etc/ssl/certs/ca-certificates.crt

After this point you can use Ubuntu’s tools like curl and wget to connect to local sites.

# nginx ingress example
- **[K8s Ingress installation](../../k8s/ingress-lb-install.md)**


# Verify certificate is being used
openssl s_client -showcerts -connect reports11:443 -servername reports11 -CApath /etc/ssl/certs -


# Linux
<https://manpages.ubuntu.com/manpages/lunar/en/man8/update-ca-certificates.8.html>
openssl s_client -connect moto.busche-cnc.com:443 -CApath /etc/ssl/certs -
openssl s_client -connect frt-kors43.busche-cnc.com:443 -CApath /etc/ssl/certs


pushd /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain
curl -v --cacert ca-chain-bundle.cert.pem https://frt-kors43.busche-cnc.com
curl -v https://frt-kors43.busche-cnc.com

curl -v --cacert ca-chain-bundle.cert.pem https://moto.busche-cnc.com
or
<https://serverfault.com/questions/485597/default-ca-cert-bundle-location>
Running curl with strace might give you a clue.
strace curl <https://moto.busche-cnc.com> |& grep open
openat(AT_FDCWD, "/home/brent/anaconda3/ssl/cacert.pem", O_RDONLY) = 6
openat(AT_FDCWD, "/etc/localtime", O_RDONLY|O_CLOEXEC) = 6

# deactivate an environment
conda deactivate
Now the openssl that comes with ubuntu is used
curl -L http://moto.busche-cnc.com
https://everything.curl.dev/http/hsts
curl -v --hsts hsts.txt https://frt-kors43.busche-cnc.com
curl -v --hsts hsts.txt http://frt-kors43.busche-cnc.com

# enable environment called "base", the default env from conda
conda activate base

# Windows and Mac
https://linuxize.com/post/how-to-mount-cifs-windows-share-on-linux/
add moto.busche-cnc.com to hosts file.
sudo mount -t cifs -o rw,username=paul //192.168.1.9/Users /mnt/win_share
bluebird12
sudo umount /mnt/win_share
C:\Windows\System32\drivers\etc

<https://docs.vmware.com/en/VMware-Horizon-7/7.13/horizon-scenarios-ssl-certificates/GUID-6E6211BC-3CA2-490F-B731-2B5210FF50E0.html>
You must import the root certificate and any intermediate certificates in the certificate chain into the Windows local computer certificate store.

If the TLS server certificate that you imported from the intermediate server is signed by a root CA that is known and trusted by the Connection Server host, and there are no intermediate certificates in your certificate chains, you can skip this task. Commonly used Certificate Authorities are likely to be trusted by the host.

Procedure
In the MMC console on the Windows Server host, expand the Certificates (Local Computer) node and go to the Trusted Root Certification Authorities > Certificates folder.
If your root certificate is in this folder, and there are no intermediate certificates in your certificate chain, skip to step 7.
If your root certificate is in this folder, and there are intermediate certificates in your certificate chain, skip to step 6.
If your root certificate is not in this folder, proceed to step 2.
Right-click the Trusted Root Certification Authorities > Certificates folder and click All Tasks > Import.
In the Certificate Import wizard, click Next and browse to the location where the root CA certificate is stored.
Select the root CA certificate file and click Open.
Click Next, click Next, and click Finish.
If your server certificate was signed by an intermediate CA, import all intermediate certificates in the certificate chain into the Windows local computer certificate store.
Go to the Certificates (Local Computer) > Intermediate Certification Authorities > Certificates folder.
Repeat steps 3 through 6 for each intermediate certificate that must be imported.
Restart the Connection Server service or Security Server service to make your changes take effect.

<https://www.namecheap.com/support/knowledgebase/article.aspx/9774/2238/incomplete-certificate-chain-on-windows-servers/>
<https://curl.se/docs/sslcerts.html>
Certificate Verification with Schannel and Secure Transport
If libcurl was built with Schannel (Microsoft's native TLS engine) or Secure Transport (Apple's native TLS engine) support, then libcurl will still perform peer certificate verification, but instead of using a CA cert bundle, it will use the certificates that are built into the OS. These are the same certificates that appear in the Internet Options control panel (under Windows) or Keychain Access application (under OS X). Any custom security rules for certificates will be honored.

Schannel will run CRL checks on certificates unless peer verification is disabled. Secure Transport on iOS will run OCSP checks on certificates unless peer verification is disabled. Secure Transport on OS X will run either OCSP or CRL checks on certificates if those features are enabled, and this behavior can be adjusted in the preferences of Keychain Access.


https://www.cloudflare.com/learning/ssl/what-is-sni/
## What is SNI? How TLS server name indication works
SNI, or Server Name Indication, is an addition to the TLS encryption protocol that enables a client device to specify the domain name it is trying to reach in the first step of the TLS handshake, preventing common name mismatch errors.


# Sam used niagara to generate a cert and exported the private key. This cert had a san field of frt-kors43 but no policy field. I did not use Niagara's cert but did use it's private key to generate a CSR and SAN certificate. Using this method niagara successfully imported the key,cert,cert chain pem files generated and that included the private key Sam sent me

# The following private keys are located in the /home/brent/pki/intermediateCA directory

# hrt-kors43.busche-cnc.com.key.pem

# Sam sent this file which included both a certificate and private key. I didn't need the certificate so I removed it from the file

# mgedo-srv-mach2.key.pem

# Sam exported this private key after generating a certificate from Niagara for the Edon Mach2 server

# sams.key.pem

# Sam exported this private key after generating a certificate from Niagara for frt-kors43
