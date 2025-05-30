# **[ubuntu](https://documentation.ubuntu.com/server/explanation/crypto/openssl/#:~:text=To%20adjust%20the%20algorithms%20and,output%20truncated%20for%20brevity):)**

OpenSSL
OpenSSL is probably the most well known cryptographic library, used by thousands of projects and applications.

The OpenSSL configuration file is located at /etc/ssl/openssl.cnf and is used both by the library itself and the command-line tools included in the package. It is simple in structure, but quite complex in the details, and it won’t be fully covered here. In particular, we will only cover the settings that control which cryptographic algorithms will be allowed by default.

## Structure of the config file

The OpenSSL configuration file is very similar to a standard INI file. It starts with a nameless default section, not inside any [section] block, and after that we have the traditional [section-name] followed by the key = value lines. The SSL config manpage has all the details.

This is what it looks like:

```ini
openssl_conf = <name-of-conf-section>

[name-of-conf-section]
ssl_conf = <name-of-ssl-section>

[name-of-ssl-section]
server = <name of section>
client = <name of section>
system_default = <name of section>
```

See how it’s like a chain, where a key (openssl_conf) points at the name of a section, and that section has a key that points to another section, and so on.

To adjust the algorithms and ciphers used in a SSL/TLS connection, we are interested in the “SSL Configuration” section of the library, where we can define the behavior of server, client, and the library defaults.

For example, in an Ubuntu Jammy installation, we have (omitting unrelated entries for brevity):

```ini
openssl_conf = openssl_init

[openssl_init]
ssl_conf = ssl_sect

[ssl_sect]
system_default = system_default_sect

[system_default_sect]
CipherString = DEFAULT:@SECLEVEL=2
```

This gives us our first information about the default set of ciphers and algorithms used by OpenSSL in an Ubuntu installation: `DEFAULT:@SECLEVEL=2`. What that means is detailed inside the **[SSL_CTX_set_security_level(3) manpage](https://manpages.ubuntu.com/manpages/jammy/en/man3/SSL_CTX_set_security_level.3ssl.html)**.

In Ubuntu Jammy, TLS versions below 1.2 are disabled in OpenSSL’s SECLEVEL=2 due to this **[patch](https://git.launchpad.net/ubuntu/+source/openssl/tree/debian/patches/tls1.2-min-seclevel2.patch?h=ubuntu/jammy-devel)**.

That default is also set at package building time, and in the case of Ubuntu, it’s set to SECLEVEL=2.

The list of allowed ciphers in a security level can be obtained with the openssl ciphers command (output truncated for brevity):

```bash
openssl ciphers -s -v DEFAULT:@SECLEVEL=2
TLS_AES_256_GCM_SHA384         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(256)            Mac=AEAD
TLS_CHACHA20_POLY1305_SHA256   TLSv1.3 Kx=any      Au=any   Enc=CHACHA20/POLY1305(256) Mac=AEAD
TLS_AES_128_GCM_SHA256         TLSv1.3 Kx=any      Au=any   Enc=AESGCM(128)            Mac=AEAD
ECDHE-ECDSA-AES256-GCM-SHA384  TLSv1.2 Kx=ECDH     Au=ECDSA Enc=AESGCM(256)            Mac=AEAD
(...)
```

Note

The openssl ciphers command will output even ciphers that are not allowed, unless the -s switch is given. That option tells the command to list only supported ciphers.

All the options that can be set in the system_default_sect section are detailed in the **[SSL_CONF_cmd manpage](https://manpages.ubuntu.com/manpages/jammy/en/man3/SSL_CONF_cmd.3ssl.html#supported%20configuration%20file%20commands)**.

       CipherString
           Sets the ciphersuite list for TLSv1.2 and below to value. This list will be combined with any
           configured TLSv1.3 ciphersuites. Note: syntax checking of value is currently not performed unless an
           SSL or SSL_CTX structure is associated with ctx.

Cipher strings, cipher suites, cipher lists
Encrypting data (or signing it) is not a one step process. The whole transformation applied to the source data (until it is in its encrypted form) has several stages, and each stage typically uses a different cryptographic algorithm. The combination of these algorithms is called a cipher suite.

Similar to GnuTLS, OpenSSL also uses the concept of cipher strings to group several algorithms and cipher suites together. The full list of cipher strings is shown in the openssl ciphers manpage.

OpenSSL distinguishes the ciphers used with TLSv1.3, and those used with TLSv1.2 and older. Specifically for the openssl ciphers command, we have:

-ciphersuites: used for the TLSv1.3 ciphersuites. So far, there are only five listed in the upstream documentation, and the defaults are:

TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256

cipherlist: this is a plain argument in the command line of the openssl ciphers command, without a specific parameter, and is expected to be a list of cipher strings used in TLSv1.2 and lower. The default in Ubuntu Jammy 22.04 LTS is DEFAULT:@SECLEVEL=2.

These defaults are built-in in the library, and can be set in /etc/ssl/openssl.cnf via the corresponding configuration keys CipherString for TLSv1.2 and older, and CipherSuites for TLSv1.3. For example:

[system_default_sect]
CipherString = DEFAULT:@SECLEVEL=2
CipherSuites = TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256
