# **[JSON Web Token](https://wikipedia.org/wiki/JSON_Web_Token)**

JSON Web Token (JWT, suggested pronunciation /dʒɒt/, same as the word "jot"[1]) is a proposed Internet standard for creating data with optional signature and/or optional encryption whose payload holds JSON that asserts some number of claims. The tokens are signed either using a private secret or a public/private key.

For example, a server could generate a token that has the claim "logged in as administrator" and provide that to a client. The client could then use that token to prove that it is logged in as admin. The tokens can be signed by one party's private key (usually the server's) so that any party can subsequently verify whether the token is legitimate. If the other party, by some suitable and trustworthy means, is in possession of the corresponding public key, they too are able to verify the token's legitimacy. The tokens are designed to be compact,[2] URL-safe,[3] and usable, especially in a web-browser single-sign-on (SSO) context. JWT claims can typically be used to pass identity of authenticated users between an identity provider and a service provider, or any other type of claims as required by business processes.[4][5]

JWT relies on other JSON-based standards: JSON Web Signature and JSON Web Encryption.

## Structure

### Header

Identifies which algorithm is used to generate the signature. In the below example, HS256 indicates that this token is signed using HMAC-SHA256.
Typical cryptographic algorithms used are HMAC with SHA-256 (HS256) and RSA signature with SHA-256 (RS256). JWA (JSON Web Algorithms) RFC 7518 introduces many more for both authentication and encryption.[8]

```json
{
  "alg": "HS256",
  "typ": "JWT"
}
```

### Payload

Contains a set of claims. The JWT specification defines seven Registered **[Claim Names](https://en.wikipedia.org/wiki/JSON_Web_Token#Standard_fields)**, which are the standard fields commonly included in tokens.[1] Custom claims are usually also included, depending on the purpose of the token.
This example has the standard Issued At Time claim (iat) and a custom claim (loggedInAs).

```json
{
  "loggedInAs": "admin",
  "iat": 1422779638
}
```

### Signature

Securely validates the token. The signature is calculated by encoding the header and payload using Base64url Encoding RFC 4648 and concatenating the two together with a period separator. That string is then run through the cryptographic algorithm specified in the header. This example uses HMAC-SHA256 with a shared secret (public key algorithms are also defined). The Base64url Encoding is similar to base64, but uses different non-alphanumeric characters and omits padding.

```json
HMAC_SHA256(
  secret,
  base64urlEncoding(header) + '.' +
  base64urlEncoding(payload)
)
```

The three parts are encoded separately using Base64url Encoding RFC 4648, and concatenated using periods to produce the JWT:

const token = base64urlEncoding(header) + '.' + base64urlEncoding(payload) + '.' + base64urlEncoding(signature)

The above data and the secret of "secretkey" creates the token:

```token
eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJsb2dnZWRJbkFzIjoiYWRtaW4iLCJpYXQiOjE0MjI3Nzk2Mzh9.gzSraSYS8EXBxLN_oWnFSRgCzcmJmMjLiuyu5CSpyHI
```

This resulting token can be easily passed into HTML and HTTP.[3]

## Use

In authentication, when the user successfully logs in using their credentials, a JSON Web Token will be returned and must be saved locally (typically in local or session storage, but cookies can also be used), instead of the traditional approach of creating a session in the server and returning a cookie. For unattended processes, the client may also authenticate directly by generating and signing its own JWT with a pre-shared secret and pass it to a OAuth compliant service like so:

```http
POST /oauth2/token
Content-type: application/x-www-form-urlencoded

grant_type=urn:ietf:params:oauth:grant-type:jwt-bearer&assertion=eyJhb...
```

If the client passes a valid JWT assertion the server will generate an access_token valid for making calls to the application and pass it back to the client:

```json
{
  "access_token": "eyJhb...",
  "token_type": "Bearer",
  "expires_in": 3600
}
```

When the client wants to access a protected route or resource, the user agent should send the JWT, typically in the Authorization HTTP header using the Bearer schema. The content of the header might look like the following:

```http
Authorization: Bearer eyJhbGci...<snip>...yu5CSpyHI
```

This is a stateless authentication mechanism as the user state is never saved in server memory. The server's protected routes will check for a valid JWT in the Authorization header, and if it is present, the user will be allowed to access protected resources. As JWTs are self-contained, all the necessary information is there, reducing the need to query the database multiple times.

## Standard fields

|             Code            |                  Name                 |                                                                                                                                                     Description                                                                                                                                                     |
|:---------------------------:|:-------------------------------------:|:-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| Standard claim fields       |                                       | The internet drafts define the following standard fields ("claims") that can be used inside a JWT claim set.                                                                                                                                                                                                        |
| iss                         | Issuer                                | Identifies principal that issued the JWT.                                                                                                                                                                                                                                                                           |
| sub                         | Subject                               | Identifies the subject of the JWT.                                                                                                                                                                                                                                                                                  |
| aud                         | Audience                              | Identifies the recipients that the JWT is intended for. Each principal intended to process the JWT must identify itself with a value in the audience claim. If the principal processing the claim does not identify itself with a value in the aud claim when this claim is present, then the JWT must be rejected. |
| exp                         | Expiration Time                       | Identifies the expiration time on and after which the JWT must not be accepted for processing. The value must be a NumericDate:[9] either an integer or decimal, representing seconds past 1970-01-01 00:00:00Z.                                                                                                    |
| nbf                         | Not Before                            | Identifies the time on which the JWT will start to be accepted for processing. The value must be a NumericDate.                                                                                                                                                                                                     |
| iat                         | Issued at                             | Identifies the time at which the JWT was issued. The value must be a NumericDate.                                                                                                                                                                                                                                   |
| jti                         | JWT ID                                | Case-sensitive unique identifier of the token even among different issuers.                                                                                                                                                                                                                                         |
| Commonly-used header fields |                                       | The following fields are commonly used in the header of a JWT                                                                                                                                                                                                                                                       |
| typ                         | Token type                            | If present, it must be set to a registered IANA Media Type.                                                                                                                                                                                                                                                         |
| cty                         | Content type                          | If nested signing or encryption is employed, it is recommended to set this to JWT; otherwise, omit this field.[1]                                                                                                                                                                                                   |
| alg                         | Message authentication code algorithm | The issuer can freely set an algorithm to verify the signature on the token. However, some supported algorithms are insecure.[10]                                                                                                                                                                                   |
| kid                         | Key ID                                | A hint indicating which key the client used to generate the token signature. The server will match this value to a key on file in order to verify that the signature is valid and the token is authentic.                                                                                                           |
| x5c                         | x.509 Certificate Chain               | A certificate chain in RFC4945 format corresponding to the private key used to generate the token signature. The server will use this information to verify that the signature is valid and the token is authentic.                                                                                                 |
| x5u                         | x.509 Certificate Chain URL           | A URL where the server can retrieve a certificate chain corresponding to the private key used to generate the token signature. The server will retrieve and use this information to verify that the signature is authentic.                                                                                         |
| crit                        | Critical                              | A list of headers that must be understood by the server in order to accept the token as valid                                                                                                                                                                                                                       |
|             Code            |                  Name                 |                                                                                                                                                     Description                                                                                                                                                     |
