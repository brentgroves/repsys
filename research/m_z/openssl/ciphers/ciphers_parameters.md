# # **[OPTIONS](https://docs.openssl.org/3.3/man1/openssl-ciphers/#options)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

-help

Print a usage message.

-provider name

-provider-path path
-propquery propq

See "Provider Options" in openssl(1), provider(7), and property(7).

## -s

Only list supported ciphers: those consistent with the security level, and minimum and maximum protocol version. This is closer to the actual cipher list an application will support.

PSK and SRP ciphers are not enabled by default: they require -psk or -srp to enable them.

It also does not change the default list of supported signature algorithms.

On a server the list of supported ciphers might also exclude other ciphers depending on the configured certificates and presence of DH parameters.

If this option is not used then all ciphers that match the cipherlist will be listed.

## -psk

When combined with -s includes cipher suites which require PSK.

## -srp

When combined with -s includes cipher suites which require SRP. This option is deprecated.

## -v

Verbose output: For each cipher suite, list details as provided by SSL_CIPHER_description(3).

## -V

Like -v, but include the official cipher suite values in hex.

-tls1_3, -tls1_2, -tls1_1, -tls1, -ssl3

In combination with the -s option, list the ciphers which could be used if the specified protocol were negotiated. Note that not all protocols and flags may be available, depending on how OpenSSL was built.

## -stdname

Precede each cipher suite by its standard name.

-convert name

Convert a standard cipher name to its OpenSSL name.

-ciphersuites val
-ciphersuites TLSv1.2

Sets the list of TLSv1.3 ciphersuites. This list will be combined with any TLSv1.2 and below ciphersuites that have been configured. The format for this list is a simple colon (":") separated list of TLSv1.3 ciphersuite names. By default this value is:

TLS_AES_256_GCM_SHA384:TLS_CHACHA20_POLY1305_SHA256:TLS_AES_128_GCM_SHA256
cipherlist

A cipher list of TLSv1.2 and below ciphersuites to convert to a cipher preference list. This list will be combined with any TLSv1.3 ciphersuites that have been configured. If it is not included then the default cipher list will be used. The format is described below.
