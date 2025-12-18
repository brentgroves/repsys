# # **[EXAMPLES](https://docs.openssl.org/3.3/man1/openssl-ciphers/#examples)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

EXAMPLES¶

single cipher-suite include security level 0:

```bash
# -V Like -v, but include the official cipher suite values in hex.
# -stdname. Precede each cipher suite by its standard name.

# -tls1_2 and below

openssl ciphers -s -V -stdname -tls1_2 'ADH-AES128-SHA:@SECLEVEL=0'

0x00,0x34 - TLS_DH_anon_WITH_AES_128_CBC_SHA              - ADH-AES128-SHA                 SSLv3   Kx=DH       Au=None  Enc=AES(128)               Mac=SHA1

openssl ciphers -s -V -stdname 'ADH-AES128-SHA:@SECLEVEL=0'
0x13,0x02 - TLS_AES_256_GCM_SHA384                        - TLS_AES_256_GCM_SHA384         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(256)            Mac=AEAD
0x13,0x03 - TLS_CHACHA20_POLY1305_SHA256                  - TLS_CHACHA20_POLY1305_SHA256   TLSv1.3 Kx=any      Au=any   Enc=CHACHA20/POLY1305(256) Mac=AEAD
0x13,0x01 - TLS_AES_128_GCM_SHA256                        - TLS_AES_128_GCM_SHA256         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(128)            Mac=AEAD
0x00,0x34 - TLS_DH_anon_WITH_AES_128_CBC_SHA              - ADH-AES128-SHA                 SSLv3   Kx=DH       Au=None  Enc=AES(128)               Mac=SHA1
```

listing of single cipher-suite:

```bash
openssl ciphers -s -v 'ADH-AES128-SHA'
TLS_AES_256_GCM_SHA384         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(256)            Mac=AEAD
TLS_CHACHA20_POLY1305_SHA256   TLSv1.3 Kx=any      Au=any   Enc=CHACHA20/POLY1305(256) Mac=AEAD
TLS_AES_128_GCM_SHA256         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(128)            Mac=AEAD
```

```bash
openssl ciphers -s -v 'ADH-AES128-SHA:@SECLEVEL=0'
TLS_AES_256_GCM_SHA384         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(256)            Mac=AEAD
TLS_CHACHA20_POLY1305_SHA256   TLSv1.3 Kx=any      Au=any   Enc=CHACHA20/POLY1305(256) Mac=AEAD
TLS_AES_128_GCM_SHA256         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(128)            Mac=AEAD
ADH-AES128-SHA                 SSLv3   Kx=DH       Au=None  Enc=AES(128)               Mac=SHA1
```

Verbose listing of all OpenSSL ciphers including NULL ciphers:

`openssl ciphers -v 'ALL:eNULL'`

Include all ciphers except NULL and anonymous DH then sort by strength:

`openssl ciphers -v 'ALL:!ADH:@STRENGTH'`

Include all ciphers except ones with no encryption (eNULL) or no authentication (aNULL):

`openssl ciphers -v 'ALL:!aNULL'`

Include only 3DES ciphers and then place RSA ciphers last:

`openssl ciphers -v '3DES:+RSA'`

Include all RC4 ciphers but leave out those without authentication:

`openssl ciphers -v 'RC4:!COMPLEMENTOFDEFAULT'`

Include all ciphers with RSA authentication but leave out ciphers without encryption.

`openssl ciphers -v 'RSA:!COMPLEMENTOFALL'`

Set security level to 2 and display all ciphers consistent with level 2:

`openssl ciphers -s -v 'ALL:@SECLEVEL=2'`
