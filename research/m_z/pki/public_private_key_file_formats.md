# **[Key File Formats: DER, PEM and PKCS #12 Explained](https://myarch.com/public-private-key-file-formats)**

**[Back to Research List](../../../research/research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

Public key cryptography (asymmetric cryptography) is the foundation of the Internet and it is used for a variety of purposes.

Public and private keys can be stored in several different types of files. Each of these types can have its own encoding. The overall format of a file can be quite complex. It is important, however, to understand the purpose of these formats, and how they’re used.

This document can be used as a primer for understanding these file/encoding formats.

The actual structure (objects and fields) of public/private keys, including X.509 certificates, is specified in various RFCs using the ASN.1 notation.

For example, an RSA private key contains the following fields:

```bash
RSAPrivateKey ::= SEQUENCE {
  version           Version,
  modulus           INTEGER,  -- n
  publicExponent    INTEGER,  -- e
  privateExponent   INTEGER,  -- d
  prime1            INTEGER,  -- p
  prime2            INTEGER,  -- q
  exponent1         INTEGER,  -- d mod (p-1)
  exponent2         INTEGER,  -- d mod (q-1)
  coefficient       INTEGER,  -- (inverse of q) mod p
  otherPrimeInfos   OtherPrimeInfos OPTIONAL
}
```

The most widely used format is X.509 and it’s full syntax is defined by the RFC5280. X.509 provides the support for the “chain of trust” to verify a public key, as well as various extensions, primarily concerning the key’s usage. RFC5280 also documents formats for CSR, CLR, etc.

PKCS #8 specification defines the structure of private keys (PKCS stands for Public-Key Cryptography Standards).

These specifications only stipulate the structure (fields and objects), we still need to decide how to “encode” these fields when we want to save them on disk.

Security considerations aside, it would be nice if everything was stored in some sort of a structured format that we’re all used to, such as JSON or YAML, but this not the case for the majority of crypto formats, with the exception of JWK as explained later.

“DER” encoding, which is a variation of a more general X.690 encoding, is the de-facto standard for encoding ASN.1 structures. DER is a purely binary format, DER-encoded content can’t be inspected with a text editor. The basic idea of DER is to represent each field as a type+length+value triplet.

DER format is the one used for sending certificates over the wire — e.g., when a server presents its certificate to the client as part of the TLS handshake, the certificate bits are serialized using DER (theoretically, a certificate can be stored in a completely different format on disk).

DER can be further encoded using Base64, which creates an ASCII text that could be copied-pasted, sent over email and so forth. Base64-encoded DER files are usually saved with the “pem” or “crt” extension. PEM files also contain a header and footer to give an idea of the content of the file (sort of poor man metadata). X.509 files use “—–BEGIN CERTIFICATE—–“/”—–END CERTIFICATE—–“, but various other headers/footers can be used as well, such as “—–BEGIN PUBLIC KEY—–“/”—–END PUBLIC KEY—–“. In this last case, the file contains only the public key information and none of the additional X.509 fields.

Private keys can be saved in the PEM format as well, “—–BEGIN PRIVATE KEY—–“/”—–END PRIVATE KEY—–” is used to denote such files. All these headers as well the detailed PEM-encoding rules are documented in this specification.

ASN.1/DER/PEM is mostly used for TLS implementation and whenever X.509 certificates are involved.

Other public-key cryptography implementations can use different formats. Irrespective of the format, the underlying implementation and algorithms remain the same. E.g., an RSA public key must contain modulus and exponent fields, the only question is how to pass these fields around or how to store them in a file.

OAuth2 and JWT use JSON to exchange public/private keys.
Here is an example of a public key in the JWK format used by OAuth2 authorization servers:

{
    "kty": "RSA",
    "alg": "RS256",
    "kid": "oViynWdKmd9m43BihjrQH9bHlp22fto0Nu-zwaBzUAs",
    "use": "sig",
    "e": "AQAB",
    "n": "q8BD_0q9JQRnpZ5vLnBMEA03nUWmxE56nGvKFY8K0fOAHojFPExI0Il67NEv6TCPZaXiifT5p9N9DIQl-JaWNaQmDCvd5Hbeugqn05QGJ14E_ghTXA6iXsONnavri5qlgc5rPmAS9zkm755ID7mHnuskEMXJy929LlxFKHzDRTkN8Lf1hSVXG8Mdy0f1QW-01VNRE8ZW0Ar5vLLuGrDb8bg9fCZXA6CK7oVJHXzo6ajIgzpa86kpdvWOhhtYPCL9P9wNjt4kfX3LBb6_sl9s8lI0C0OWtoMyNtAbE4wFc08o0ZsW1UGQin5eFFBuH_zbaPwc7wvYw40bBw35U_V9Sw"
}

PEM and PKCS12 are both file formats used to store and exchange cryptographic keys and certificates, but they have some key differences:

## Purpose

PEM was originally designed to secure email, but is now an internet security standard. PKCS12 is a binary format that's commonly used to import and export certificates and private keys on Windows and macOS.

## Format

PEM files are Base64-encoded ASCII files that often have extensions like .pem, .crt, .cer, and .key. PKCS12 files are binary files that often have extensions like .p12 or .pfx.

## Content

PEM files can contain multiple certificates and private keys in a single file. PKCS12 files can contain server certificates, intermediate certificates, and private keys in a single file.

## Use cases

- PEM is the most common format for certificates issued by Certificate Authorities.
- PKCS12 is commonly used to bundle a private key with its X.509 certificate.

## Conversion

You can use a third-party tool like OpenSSL to convert a PEM certificate to a PKCS12 certificate.
