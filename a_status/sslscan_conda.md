# does conda openssl support the following plex cipher?

## refer

## **[issue](https://github.com/openssl/openssl/issues/8408)**

Change your s_client line as follows:

```bash
openssl s_client -cipher 'ADH:@SECLEVEL=0' -tls1 -connect 10.xxx.xxx.xxx:8729
# OpenSSL 1.1.0 implements "security levels". The default security level is 1. ADH ciphersuites are in security level 0 and so are blocked by default.
openssl s_client -cipher 'ADH:@SECLEVEL=0' -tls1 -connect odbc.plex.com:19995
CONNECTED(00000003)
800BB86FAA770000:error:0A00042E:SSL routines:ssl3_read_bytes:tlsv1 alert protocol version:../ssl/record/rec_layer_s3.c:1599:SSL alert number 70
---
no peer certificate available
---
No client certificate CA names sent
---
SSL handshake has read 7 bytes and written 94 bytes
Verification: OK
---
New, (NONE), Cipher is (NONE)
Secure Renegotiation IS NOT supported
Compression: NONE
Expansion: NONE
No ALPN negotiated
SSL-Session:
    Protocol  : TLSv1
    Cipher    : 0000
    Session-ID: 
    Session-ID-ctx: 
    Master-Key: 
    PSK identity: None
    PSK identity hint: None
    SRP username: None
    Start Time: 1748558367
    Timeout   : 7200 (sec)
    Verify return code: 0 (ok)
    Extended master secret: no
---

```

## conda ssl

```bash
openssl version -a
openssl ciphers -s -v

sslscan 172.24.188.84:4433

```

## Plex

```bash

  Supported Server Cipher(s):
Preferred TLSv1.2  128 bits  ADH-AES128-SHA                DHE 1024 bits
    Unable to parse certificate
    Unable to parse certificate
    Unable to parse certificate
    Unable to parse certificate
```
