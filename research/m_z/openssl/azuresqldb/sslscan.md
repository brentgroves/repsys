# sslscan

## scan client machine

```bash

sslscan repsys1.database.windows.net:1433


Version: 2.1.2
OpenSSL 3.0.13 30 Jan 2024

Connected to 20.40.228.131

Testing SSL server repsys1.database.windows.net on port 1433 using SNI name repsys1.database.windows.net

  SSL/TLS Protocols:
SSLv2     disabled
SSLv3     disabled
TLSv1.0   enabled
TLSv1.1   enabled
TLSv1.2   enabled
TLSv1.3   enabled

  TLS Fallback SCSV:
Server does not support TLS Fallback SCSV

  TLS renegotiation:
Secure session renegotiation supported

  TLS Compression:
OpenSSL version does not support compression
Rebuild with zlib1g-dev package for zlib support

  Heartbleed:
TLSv1.3 not vulnerable to heartbleed
TLSv1.2 not vulnerable to heartbleed
TLSv1.1 not vulnerable to heartbleed
TLSv1.0 not vulnerable to heartbleed

  Supported Server Cipher(s):
Preferred TLSv1.3  256 bits  TLS_AES_256_GCM_SHA384        Curve P-384 DHE 384
Accepted  TLSv1.3  128 bits  TLS_AES_128_GCM_SHA256        Curve P-256 DHE 256
Preferred TLSv1.2  256 bits  ECDHE-RSA-AES256-GCM-SHA384   Curve P-384 DHE 384
Accepted  TLSv1.2  128 bits  ECDHE-RSA-AES128-GCM-SHA256   Curve P-256 DHE 256
Accepted  TLSv1.2  256 bits  ECDHE-RSA-AES256-SHA384       Curve P-384 DHE 384
Accepted  TLSv1.2  128 bits  ECDHE-RSA-AES128-SHA256       Curve P-256 DHE 256
Accepted  TLSv1.2  256 bits  ECDHE-RSA-AES256-SHA          Curve P-384 DHE 384
Accepted  TLSv1.2  128 bits  ECDHE-RSA-AES128-SHA          Curve P-256 DHE 256
Accepted  TLSv1.2  256 bits  AES256-GCM-SHA384            
Accepted  TLSv1.2  256 bits  AES256-SHA256                
Accepted  TLSv1.2  128 bits  AES128-SHA256                
Accepted  TLSv1.2  256 bits  AES256-SHA                   
Accepted  TLSv1.2  128 bits  AES128-SHA                   
Accepted  TLSv1.2  112 bits  TLS_RSA_WITH_3DES_EDE_CBC_SHA
Preferred TLSv1.1  256 bits  ECDHE-RSA-AES256-SHA          Curve P-384 DHE 384
Accepted  TLSv1.1  128 bits  ECDHE-RSA-AES128-SHA          Curve P-256 DHE 256
Accepted  TLSv1.1  256 bits  AES256-SHA                   
Accepted  TLSv1.1  128 bits  AES128-SHA                   
Accepted  TLSv1.1  112 bits  TLS_RSA_WITH_3DES_EDE_CBC_SHA
Preferred TLSv1.0  256 bits  ECDHE-RSA-AES256-SHA          Curve P-384 DHE 384
Accepted  TLSv1.0  128 bits  ECDHE-RSA-AES128-SHA          Curve P-256 DHE 256
Accepted  TLSv1.0  256 bits  AES256-SHA                   
Accepted  TLSv1.0  128 bits  AES128-SHA                   
Accepted  TLSv1.0  112 bits  TLS_RSA_WITH_3DES_EDE_CBC_SHA

  Server Key Exchange Group(s):
TLSv1.3  128 bits  secp256r1 (NIST P-256)
TLSv1.3  192 bits  secp384r1 (NIST P-384)
TLSv1.2  128 bits  secp256r1 (NIST P-256)
TLSv1.2  192 bits  secp384r1 (NIST P-384)

  SSL Certificate:
Signature Algorithm: sha384WithRSAEncryption
RSA Key Strength:    2048

Subject:  cr15.centralus1-a.control.database.windows.net
Altnames: DNS:*.cr15.centralus1-a.control.database.windows.net, DNS:centralus1-a.control.database.windows.net, DNS:*.centralus1-a.control.database.windows.net, DNS:*.database.windows.net, DNS:*.database.secure.windows.net, DNS:*.secondary.database.windows.net, DNS:*.mariadb.database.azure.com, DNS:*.mysql.database.azure.com, DNS:*.postgres.database.azure.com, DNS:*.sql.projectarcadia.net, DNS:*.sql.azuresynapse.net, DNS:*.sql.azuresynapse-dogfood.net, DNS:*.database-fleet.windows.net, DNS:*.secondary.database-fleet.windows.net, DNS:*.daily-database.fabric.microsoft.com, DNS:*.dxt-database.fabric.microsoft.com, DNS:*.msit-database.fabric.microsoft.com, DNS:*.database.fabric.microsoft.com, DNS:cr15.centralus1-a.control.database.windows.net
Issuer:   Microsoft Azure RSA TLS Issuing CA 07

Not valid before: Mar  1 19:36:42 2025 GMT
Not valid after:  Aug 28 19:36:42 2025 GMT
```
