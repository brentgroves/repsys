# **[IETF RFC7517](https://datatracker.ietf.org/doc/html/rfc7517)**

   A JSON Web Key (JWK) is a JavaScript Object Notation (JSON) [RFC7159]
   data structure that represents a cryptographic key.  This
   specification also defines a JWK Set JSON data structure that
   represents a set of JWKs.  Cryptographic algorithms and identifiers
   for use with this specification are described in the separate JSON
   Web Algorithms (JWA) [JWA] specification and IANA registries
   established by that specification.

   Goals for this specification do not include representing new kinds of
   certificate chains, representing new kinds of certified keys, or
   replacing X.509 certificates.

   JWKs and JWK Sets are used in the JSON Web Signature [JWS] and JSON
   Web Encryption [JWE] specifications.

   Names defined by this specification are short because a core goal is
   for the resulting representations to be compact.

## Terminology

   The terms "JSON Web Signature (JWS)", "Base64url Encoding",
   "Collision-Resistant Name", "Header Parameter", and "JOSE Header" are
   defined by the JWS specification **[JWS](https://datatracker.ietf.org/doc/html/rfc7517#ref-JWS)**.

   The terms "JSON Web Encryption (JWE)", "Additional Authenticated Data
   (AAD)", "JWE Authentication Tag", "JWE Ciphertext", "JWE Compact
   Serialization", "JWE Encrypted Key", "JWE Initialization Vector", and
   "JWE Protected Header" are defined by the JWE specification **[JWE](https://datatracker.ietf.org/doc/html/rfc7517#ref-JWE)**.

   The terms "Ciphertext", "Digital Signature", "Message Authentication
   Code (MAC)", and "Plaintext" are defined by the "Internet Security
   Glossary, Version 2" [RFC4949].

   These terms are defined by this specification:

## JSON Web Key (JWK)

      A JSON object that represents a cryptographic key.  The members of
      the object represent properties of the key, including its value.

## JWK Set

      A JSON object that represents a set of JWKs.  The JSON object MUST
      have a "keys" member, which is an array of JWKs.

## Example JWK

   This section provides an example of a JWK.  The following example JWK
   declares that the key is an Elliptic Curve **[DSS](https://datatracker.ietf.org/doc/html/rfc7517#ref-DSS)** key, it is used with
   the P-256 Elliptic Curve, and its x and y coordinates are the
   base64url-encoded values shown.  A key identifier is also provided
   for the key.

    ```json
        {"kty":"EC",
        "crv":"P-256",
        "x":"f83OJ3D2xF1Bg8vub9tLe1gHMzV76e8Tus9uPHvRVEU",
        "y":"x_FEzRu9m36HLN_tue659LNpXW6pCyStikYjKIWI5a0",
        "kid":"Public key used in JWS spec Appendix A.3 example"
        }
    ```

    ```json
    {
    "keys": [
        {
        "e": "AQAB",
        "kid": "DHFbpoIUqrY8t2zpA2qXfCmr5VO5ZEr4RzHU_-envvQ",
        "kty": "RSA",
        "n": "xAE7eB6qugXyCAG3yhh7pkDkT65pHymX-P7KfIupjf59vsdo91bSP9C8H07pSAGQO1MV_xFj9VswgsCg4R6otmg5PV2He95lZdHtOcU5DXIg_pbhLdKXbi66GlVeK6ABZOUW3WYtnNHD-91gVuoeJT_DwtGGcp4ignkgXfkiEm4sw-4sfb4qdt5oLbyVpmW6x9cfa7vs2WTfURiCrBoUqgBo_-4WTiULmmHSGZHOjzwa8WtrtOQGsAFjIbno85jp6MnGGGZPYZbDAa_b3y5u-YpW7ypZrvD8BgtKVjgtQgZhLAGezMt0ua3DRrWnKqTZ0BJ_EyxOGuHJrLsn00fnMQ"
        }
    ]
    }
    ```
   Additional example JWK values can be found in **[Appendix A](https://datatracker.ietf.org/doc/html/rfc7517#appendix-A)**.

## JSON Web Key (JWK) Format

   A JWK is a JSON object that represents a cryptographic key.  The
   members of the object represent properties of the key, including its
   value.  This JSON object MAY contain whitespace and/or line breaks
   before or after any JSON values or structural characters, in
   accordance with Section 2 of RFC 7159 [RFC7159].  This document
   defines the key parameters that are not algorithm specific and, thus,
   common to many keys.

   In addition to the common parameters, each JWK will have members that
   are key type specific.  These members represent the parameters of the
   key.  Section 6 of the JSON Web Algorithms (JWA) **[JWA](https://datatracker.ietf.org/doc/html/rfc7517#ref-JWA)** specification
   defines multiple kinds of cryptographic keys and their associated
   members.

   The member names within a JWK MUST be unique; JWK parsers MUST either
   reject JWKs with duplicate member names or use a JSON parser that
   returns only the lexically last duplicate member name, as specified
   in Section 15.12 (The JSON Object) of ECMAScript 5.1 **[ECMAScript](https://datatracker.ietf.org/doc/html/rfc7517#ref-ECMAScript)**.

   Additional members can be present in the JWK; if not understood by
   implementations encountering them, they MUST be ignored.  Member
   names used for representing key parameters for different keys types
   need not be distinct.  Any new member name should either be
   registered in the IANA "JSON Web Key Parameters" registry established
   by Section 8.1 or be a value that contains a Collision-Resistant
   Name.

## "kty" (Key Type) Parameter

   The "kty" (key type) parameter identifies the cryptographic algorithm
   family used with the key, such as "RSA" or "EC".  "kty" values should
   either be registered in the IANA "JSON Web Key Types" registry
   established by [JWA] or be a value that contains a Collision-
   Resistant Name.  The "kty" value is a case-sensitive string.  This
   member MUST be present in a JWK.

   A list of defined "kty" values can be found in the IANA "JSON Web Key
   Types" registry established by [JWA]; the initial contents of this
   registry are the values defined in Section 6.1 of **[JWA](https://datatracker.ietf.org/doc/html/rfc7517#ref-JWA)**.

   The key type definitions include specification of the members to be
   used for those key types.  Members used with specific "kty" values
   can be found in the IANA "JSON Web Key Parameters" registry
   established by **[Section 8.1](https://datatracker.ietf.org/doc/html/rfc7517#section-8.1)**.
