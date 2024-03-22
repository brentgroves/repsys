# **[JSON Web Signature](https://openid.net/specs/draft-jones-json-web-signature-04.html)** (JWS)

JSON Web Signature (JWS) is a means of representing signed content using JSON data structures. Related encryption capabilities are described in the separate JSON Web Encryption (JWE) specification.

## Introduction

JSON Web Signature (JWS) is a compact signature format intended for space constrained environments such as HTTP Authorization headers and URI query parameters. It represents signed content using JSON [RFC4627] data structures. The JWS signature mechanisms are independent of the type of content being signed, allowing arbitrary content to be signed. A related encryption capability is described in a separate JSON Web Encryption (JWE) [JWE] specification.

## Terminology

- **JSON Web Signature (JWS)** A data structure cryptographically securing a JWS Header and a JWS Payload with a JWS Signature.
- **JWS Header** A string representing a JSON object that describes the signature applied to the JWS Header and the JWS Payload to create the JWS Signature.
- **JWS Payload** The bytes to be signed - a.k.a., the message.
- **JWS Signature** A byte array containing the cryptographic material that secures the contents of the JWS Header and the JWS Payload.
- **Encoded JWS Header** Base64url encoding of the bytes of the UTF-8 RFC 3629 [RFC3629] representation of the JWS Header.

## JSON Web Signature (JWS) Overview

JWS represents signed content using JSON data structures and base64url encoding. The representation consists of three parts: the JWS Header, the JWS Payload, and the JWS Signature. The three parts are base64url-encoded for transmission, and typically represented as the concatenation of the encoded strings in that order, with the three strings being separated by period ('.') characters.

The JWS Header describes the signature method and parameters employed. The JWS Payload is the message content to be secured. The JWS Signature ensures the integrity of both the JWS Header and the JWS Payload.

## Example JWS

The following example JWS Header declares that the encoded object is a JSON Web Token (JWT) [JWT] and the JWS Header and the JWS Payload are signed using the HMAC SHA-256 algorithm:

{"typ":"JWT",
 "alg":"HS256"}

Base64url encoding the bytes of the UTF-8 representation of the JWS Header yields this Encoded JWS Header value:

eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9
