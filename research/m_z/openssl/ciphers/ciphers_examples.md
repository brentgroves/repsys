# # **[EXAMPLES](https://docs.openssl.org/3.3/man1/openssl-ciphers/#examples)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

## options

### -v

Verbose output: For each cipher suite, list details as provided by SSL_CIPHER_description(3).

### -V

Like -v, but include the official cipher suite values in hex.

### -tls1_3, -tls1_2, -tls1_1, -tls1, -ssl3

In combination with the -s option, list the ciphers which could be used if the specified protocol were negotiated. Note that not all protocols and flags may be available, depending on how OpenSSL was built.

### -stdname

Precede each cipher suite by its standard name.

### -convert name

Convert a standard cipher name to its OpenSSL name.

### -ciphersuites val

Sets the list of TLSv1.3 ciphersuites. This list will be combined with any TLSv1.2 and below ciphersuites that have been configured. The format for this list is a simple colon (":") separated list of TLSv1.3 ciphersuite names. By default this value is:

TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256

## -s

Only list supported ciphers: those consistent with the security level, and minimum and maximum protocol version. This is closer to the actual cipher list an application will support.

PSK and SRP ciphers are not enabled by default: they require -psk or -srp to enable them.

It also does not change the default list of supported signature algorithms.

On a server the list of supported ciphers might also exclude other ciphers depending on the configured certificates and presence of DH parameters.

If this option is not used then all ciphers that match the cipherlist will be listed.

NOTES¶
Some compiled versions of OpenSSL may not include all the ciphers listed here because some ciphers were excluded at compile time.

EXAMPLES¶

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
