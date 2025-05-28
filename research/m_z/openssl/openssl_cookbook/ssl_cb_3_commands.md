# **[1.1.3 Examine Available Commands](https://www.feistyduck.com/library/openssl-cookbook/online/openssl-command-line/examine-available-commands.html)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

OpenSSL is a cryptographic toolkit that consists of many different utilities. I counted 48 in my version. If there was ever an appropriate time to use the phrase Swiss Army knife of cryptography, this is it. Even though you’ll use only a handful of the utilities, you should familiarize yourself with everything that’s available because you never know what you might need in the future.

To get an idea of what is on offer, simply request help:

```bash
openssl help
```

The first part of the help output lists all available utilities. To get more information about a particular utility, use the man command followed by the name of the utility. For example, `man ciphers` will give you detailed information on how cipher suites are configured. However, man openssl-ciphers should also work:

```bash
man openssl-s_client
```

Standard commands
asn1parse         ca                ciphers           cms
crl               crl2pkcs7         dgst              dhparam
dsa               dsaparam          ec                ecparam
enc               engine            errstr            gendsa
genpkey           genrsa            help              list
nseq              ocsp              passwd            pkcs12
pkcs7             pkcs8             pkey              pkeyparam
pkeyutl           prime             rand              rehash
req               rsa               rsautl            s_client
s_server          s_time            sess_id           smime
speed             spkac             srp               storeutl
ts                verify            version           x509
The help output doesn’t actually end there, but the rest is somewhat less interesting. In the second part, you get the list of message digest commands:

Message Digest commands (see the `dgst' command for more details)
blake2b512        blake2s256        gost              md4
md5               rmd160            sha1              sha224
sha256            sha3-224          sha3-256          sha3-384
sha3-512          sha384            sha512            sha512-224
sha512-256        shake128          shake256          sm3
And then in the third part, you’ll see the list of all cipher commands:

Cipher commands (see the `enc' command for more details)
aes-128-cbc       aes-128-ecb       aes-192-cbc       aes-192-ecb
aes-256-cbc       aes-256-ecb       aria-128-cbc      aria-128-cfb
aria-128-cfb1     aria-128-cfb8     aria-128-ctr      aria-128-ecb
aria-128-ofb      aria-192-cbc      aria-192-cfb      aria-192-cfb1
aria-192-cfb8     aria-192-ctr      aria-192-ecb      aria-192-ofb
aria-256-cbc      aria-256-cfb      aria-256-cfb1     aria-256-cfb8
aria-256-ctr      aria-256-ecb      aria-256-ofb      base64
bf                bf-cbc            bf-cfb            bf-ecb
bf-ofb            camellia-128-cbc  camellia-128-ecb  camellia-192-cbc  
camellia-192-ecb  camellia-256-cbc  camellia-256-ecb  cast
cast-cbc          cast5-cbc         cast5-cfb         cast5-ecb
cast5-ofb         des               des-cbc           des-cfb
des-ecb           des-ede           des-ede-cbc       des-ede-cfb
des-ede-ofb       des-ede3          des-ede3-cbc      des-ede3-cfb
des-ede3-ofb      des-ofb           des3              desx
rc2               rc2-40-cbc        rc2-64-cbc        rc2-cbc
rc2-cfb           rc2-ecb           rc2-ofb           rc4
rc4-40            seed              seed-cbc          seed-cfb
seed-ecb          seed-ofb          sm4-cbc           sm4-cfb
sm4-ctr           sm4-ecb           sm4-ofb  
