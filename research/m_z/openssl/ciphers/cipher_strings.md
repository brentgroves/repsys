# # **[CIPHER STRINGS](https://docs.openssl.org/3.3/man1/openssl-ciphers/#cipher-strings)**

**[Back to Research List](../../../research_list.md)**\
**[Back to Current Tasks](../../../../a_status/current_tasks.md)**\
**[Back to Main](../../../../README.md)**

The following is a list of all permitted cipher strings and their meanings.

## COMPLEMENTOFDEFAULT

The ciphers included in ALL, but not enabled by default. Currently this includes all RC4 and anonymous ciphers. Note that this rule does not cover eNULL, which is not included by ALL (use COMPLEMENTOFALL if necessary). Note that RC4 based cipher suites are not built into OpenSSL by default (see the enable-weak-ssl-ciphers option to Configure).

## ALL

All cipher suites except the eNULL ciphers (which must be explicitly enabled if needed). As of OpenSSL 1.0.0, the ALL cipher suites are sensibly ordered by default.

## COMPLEMENTOFALL

The cipher suites not enabled by ALL, currently eNULL.

## HIGH

"High" encryption cipher suites. This currently means those with key lengths larger than 128 bits, and some cipher suites with 128-bit keys.

## MEDIUM

"Medium" encryption cipher suites, currently some of those using 128 bit encryption.

## LOW

"Low" encryption cipher suites, currently those using 64 or 56 bit encryption algorithms but excluding export cipher suites. All these cipher suites have been removed as of OpenSSL 1.1.0.

## eNULL, NULL

The "NULL" ciphers that is those offering no encryption. Because these offer no encryption at all and are a security risk they are not enabled via either the DEFAULT or ALL cipher strings. Be careful when building cipherlists out of lower-level primitives such as kRSA or aECDSA as these do overlap with the eNULL ciphers. When in doubt, include !eNULL in your cipherlist.

## aNULL

The cipher suites offering no authentication. This is currently the anonymous DH algorithms and anonymous ECDH algorithms. These cipher suites are vulnerable to "man in the middle" attacks and so their use is discouraged. These are excluded from the DEFAULT ciphers, but included in the ALL ciphers. Be careful when building cipherlists out of lower-level primitives such as kDHE or AES as these do overlap with the aNULL ciphers. When in doubt, include !aNULL in your cipherlist.

## kRSA, aRSA, RSA

Cipher suites using RSA key exchange or authentication. RSA is an alias for kRSA.

## kDHr, kDHd, kDH

Cipher suites using static DH key agreement and DH certificates signed by CAs with RSA and DSS keys or either respectively. All these cipher suites have been removed in OpenSSL 1.1.0.

## kDHE, kEDH, DH

Cipher suites using ephemeral DH key agreement, including anonymous cipher suites.

## DHE, EDH

Cipher suites using authenticated ephemeral DH key agreement.

## ADH

Anonymous DH cipher suites, note that this does not include anonymous Elliptic Curve DH (ECDH) cipher suites.

## kEECDH, kECDHE, ECDH

Cipher suites using ephemeral ECDH key agreement, including anonymous cipher suites.

## ECDHE, EECDH

Cipher suites using authenticated ephemeral ECDH key agreement.

## AECDH

Anonymous Elliptic Curve Diffie-Hellman cipher suites.

## aDSS, DSS

Cipher suites using DSS authentication, i.e. the certificates carry DSS keys.

## aDH

Cipher suites effectively using DH authentication, i.e. the certificates carry DH keys. All these cipher suites have been removed in OpenSSL 1.1.0.

## aECDSA, ECDSA

Cipher suites using ECDSA authentication, i.e. the certificates carry ECDSA keys.

## TLSv1.2, TLSv1.0, SSLv3

Lists cipher suites which are only supported in at least TLS v1.2, TLS v1.0 or SSL v3.0 respectively. Note: there are no cipher suites specific to TLS v1.1. Since this is only the minimum version, if, for example, TLSv1.0 is negotiated then both TLSv1.0 and SSLv3.0 cipher suites are available.

Note: these cipher strings do not change the negotiated version of SSL or TLS, they only affect the list of available cipher suites.
