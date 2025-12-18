# **[JSON_Web_Signature](https://en.wikipedia.org/wiki/JSON_Web_Signature)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

A JSON Web Signature (abbreviated JWS) is an IETF-proposed standard (RFC 7515) for signing arbitrary data.[1] This is used as the basis for a variety of web-based technologies including JSON Web Token.

JWS is a way to ensure integrity of information in a highly serializable, machine-readable format. That means that it is information, along with proof that the information hasn't changed since being signed. It can be used for sending information from one web site to another, and is especially aimed at communications on the web. It even contains a compact form optimized for applications like URI query parameters.[2]

## Web commerce

JWS can be used for applications in which digitally signed information must be sent in a machine-readable format, such as e-commerce. For example, say a user named Bob is browsing widget prices on a web site (widgets.com), and wishes to get a quote on one of them. Then widgets.com could provide Bob with a JWS object containing all relevant information about the widget, including the price, then sign it using their private key. Then Bob would have a non-repudiable price quote for the product.

## Access to third-party resources

Maybe Widgets.com and WidgetStorage.com have a deal in which WidgetStorage.com will accept coupons from Widgets.com in exchange for traffic. Widgets.com could issue JWS giving Bob a 10% discount on the WidgetStorage.com site. Again, because the data is signed, WidgetStorage can know that Widgets.com emitted this. If the data was not signed, then Bob could change his discount to 50% and no one would know just from looking at the data.

## **[JSON Web Signature (JWS) Overview](https://openid.net/specs/draft-jones-json-web-signature-04.html)**

JWS represents signed content using JSON data structures and base64url encoding. The representation consists of three parts: the **JWS Header, the JWS Payload, and the JWS Signature**. The three parts are base64url-encoded for transmission, and typically represented as the concatenation of the encoded strings in that order, with the three strings being separated by period ('.') characters.

The JWS Header describes the signature method and parameters employed. The JWS Payload is the message content to be secured. The JWS Signature ensures the integrity of both the JWS Header and the JWS Payload.

## 3.1.  Example JWS

The following example JWS Header declares that the encoded object is a JSON Web Token (JWT) [JWT] and the JWS Header and the JWS Payload are signed using the HMAC SHA-256 algorithm:

```json
{ 
 "typ":"JWT",
 "alg":"HS256"
}
```

Base64url encoding the bytes of the UTF-8 representation of the JWS Header yields this Encoded JWS Header value:

eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9
The following is an example of a JSON object that can be used as a JWS Payload. (Note that the payload can be any content, and need not be a representation of a JSON object.)

{"iss":"joe",
 "exp":1300819380,
 "<http://example.com/is_root":true}>
Base64url encoding the bytes of the UTF-8 representation of the JSON object yields the following Encoded JWS Payload (with line breaks for display purposes only):

eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFt
cGxlLmNvbS9pc19yb290Ijp0cnVlfQ
Signing the UTF-8 representation of the JWS Signing Input (the concatenation of the Encoded JWS Header, a period ('.') character, and the Encoded JWS Payload) with the HMAC SHA-256 algorithm and base64url encoding the result, as per Section 6.1, yields this Encoded JWS Signature value:

dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk
Concatenating these parts in the order Header.Payload.Signature with period characters between the parts yields this complete JWS representation (with line breaks for display purposes only):

eyJ0eXAiOiJKV1QiLA0KICJhbGciOiJIUzI1NiJ9
.
eyJpc3MiOiJqb2UiLA0KICJleHAiOjEzMDA4MTkzODAsDQogImh0dHA6Ly9leGFt
cGxlLmNvbS9pc19yb290Ijp0cnVlfQ
.
dBjftJeZ4CVP-mB92K27uhbUJU1p1r_wW1gFWFOEjXk

## **[What is the difference between JSON Web Signature (JWS) and JSON Web Token (JWT)?](https://stackoverflow.com/questions/27640930/what-is-the-difference-between-json-web-signature-jws-and-json-web-token-jwt)**

JWT actually uses JWS for its signature. From the specification's abstract:

JSON Web Token (JWT) is a compact, URL-safe means of representing claims to be transferred between two parties. The claims in a JWT are encoded as a JavaScript Object Notation (JSON) object that is used as the payload of a JSON Web Signature (JWS) structure or as the plaintext of a JSON Web Encryption (JWE) structure, enabling the claims to be digitally signed or MACed and/or encrypted.

So a JWT is a JWS structure with a JSON object as the payload. Some optional keys (or claims) have been defined such as iss, aud, exp, etc.

This also means that its integrity protection is not just limited to shared secrets, but public/private key cryptography can also be used.

## **[](https://www.rfc-editor.org/rfc/rfc7519)**

JSON Web Token (JWT) is a compact, URL-safe means of representing claims to be transferred between two parties.  The claims in a JWT are encoded as a JSON object that is used as the payload of a JSON Web Signature (JWS) structure or as the plaintext of a JSON Web Encryption (JWE) structure, enabling the claims to be digitally  signed or integrity protected with a Message Authentication Code (MAC) and/or encrypted.
