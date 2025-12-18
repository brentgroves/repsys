# **[JSON Web Key Set](https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-key-sets)** (JWK Set)

## references

<https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-key-sets>
<https://github.com/MicahParks/keyfunc>

## JSON Web Key Sets

The JSON Web Key Set (JWKS) is a set of keys containing the public keys used to verify any JSON Web Token (JWT) issued by the Authorization Server and signed using the RS256 **[signing algorithm.](https://auth0.com/docs/get-started/applications/signing-algorithms)**

When creating applications and APIs in Auth0, two algorithms are supported for signing JWTs: RS256 and HS256. RS256 generates an asymmetric signature, which means a private key must be used to sign the JWT and a different public key must be used to verify the signature.

Auth0 uses the **[JSON Web Key (JWK) specification](https://tools.ietf.org/html/rfc7517)** to represent the cryptographic keys used for signing RS256 tokens. This specification defines two high-level data structures: JSON Web Key (JWK) and JSON Web Key Set (JWKS). Here are the definitions from the specification:

| Item                    | Description                                                                                                                        |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------|
| JSON Web Key (JWK)      | A JSON object that represents a cryptographic key. The members of the object represent properties of the key, including its value. |
| JSON Web Key Set (JWKS) | A JSON object that represents a set of JWKs. The JSON object MUST have a keys member, which is an array of JWKs.                   |

Auth0 exposes a JWKS endpoint for each tenant, which is found at https://{yourDomain}/.well-known/jwks.json. This endpoint will contain the JWK used to verify all Auth0-issued JWTs for this tenant.

Currently, Auth0 signs with only one JWK at a time; however, it is important to assume this endpoint could contain multiple JWKs. As an example, multiple keys can be found in the JWKS when rotating application signing keys.

## **[JSON Web Key set properties](https://auth0.com/docs/secure/tokens/json-web-tokens/json-web-key-set-properties)**

```json
{
"keys": [
  {
    "alg": "RS256",
    "kty": "RSA",
    "use": "sig",
    "x5c": [
      "MIIC+DCCAeCgAwIBAgIJBIGjYW6hFpn2MA0GCSqGSIb3DQEBBQUAMCMxITAfBgNVBAMTGGN1c3RvbWVyLWRlbW9zLmF1dGgwLmNvbTAeFw0xNjExMjIyMjIyMDVaFw0zMDA4MDEyMjIyMDVaMCMxITAfBgNVBAMTGGN1c3RvbWVyLWRlbW9zLmF1dGgwLmNvbTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMnjZc5bm/eGIHq09N9HKHahM7Y31P0ul+A2wwP4lSpIwFrWHzxw88/7Dwk9QMc+orGXX95R6av4GF+Es/nG3uK45ooMVMa/hYCh0Mtx3gnSuoTavQEkLzCvSwTqVwzZ+5noukWVqJuMKNwjL77GNcPLY7Xy2/skMCT5bR8UoWaufooQvYq6SyPcRAU4BtdquZRiBT4U5f+4pwNTxSvey7ki50yc1tG49Per/0zA4O6Tlpv8x7Red6m1bCNHt7+Z5nSl3RX/QYyAEUX1a28VcYmR41Osy+o2OUCXYdUAphDaHo4/8rbKTJhlu8jEcc1KoMXAKjgaVZtG/v5ltx6AXY0CAwEAAaMvMC0wDAYDVR0TBAUwAwEB/zAdBgNVHQ4EFgQUQxFG602h1cG+pnyvJoy9pGJJoCswDQYJKoZIhvcNAQEFBQADggEBAGvtCbzGNBUJPLICth3mLsX0Z4z8T8iu4tyoiuAshP/Ry/ZBnFnXmhD8vwgMZ2lTgUWwlrvlgN+fAtYKnwFO2G3BOCFw96Nm8So9sjTda9CCZ3dhoH57F/hVMBB0K6xhklAc0b5ZxUpCIN92v/w+xZoz1XQBHe8ZbRHaP1HpRM4M7DJk2G5cgUCyu3UBvYS41sHvzrxQ3z7vIePRA4WF4bEkfX12gvny0RsPkrbVMXX1Rj9t6V7QXrbPYBAO+43JvDGYawxYVvLhz+BJ45x50GFQmHszfY3BR9TPK8xmMmQwtIvLu1PMttNCs7niCYkSiUv2sc2mlq1i3IashGkkgmo="
    ],
    "n": "yeNlzlub94YgerT030codqEztjfU_S6X4DbDA_iVKkjAWtYfPHDzz_sPCT1Axz6isZdf3lHpq_gYX4Sz-cbe4rjmigxUxr-FgKHQy3HeCdK6hNq9ASQvMK9LBOpXDNn7mei6RZWom4wo3CMvvsY1w8tjtfLb-yQwJPltHxShZq5-ihC9irpLI9xEBTgG12q5lGIFPhTl_7inA1PFK97LuSLnTJzW0bj096v_TMDg7pOWm_zHtF53qbVsI0e3v5nmdKXdFf9BjIARRfVrbxVxiZHjU6zL6jY5QJdh1QCmENoejj_ytspMmGW7yMRxzUqgxcAqOBpVm0b-_mW3HoBdjQ",
    "e": "AQAB",
    "kid": "NjVBRjY5MDlCMUIwNzU4RTA2QzZFMDQ4QzQ2MDAyQjVDNjk1RTM2Qg",
    "x5t": "NjVBRjY5MDlCMUIwNzU4RTA2QzZFMDQ4QzQ2MDAyQjVDNjk1RTM2Qg"
  }
]}
```

Each property in the key is defined by the JWK specification RFC 7517 Section 4 or, for algorithm-specific properties, in RFC 7518].

| Property name | Description                                                                                                                                                                      |
|---------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| alg           | The specific cryptographic algorithm used with the key.                                                                                                                          |
| kty           | The family of cryptographic algorithms used with the key.                                                                                                                        |
| use           | How the key was meant to be used; sig represents the signature.                                                                                                                  |
| x5c           | The x.509 certificate chain. The first entry in the array is the certificate to use for token verification; the other certificates can be used to verify this first certificate. |
| n             | The modulus for the RSA public key.                                                                                                                                              |
| e             | The exponent for the RSA public key.                                                                                                                                             |
| kid           | The unique identifier for the key.                                                                                                                                               |
| x5t           | The thumbprint of the x.509 cert (SHA-1 thumbprint).                                                                                                                             |

For an example that uses JWKS to verify a JWT's signature, see **[Navigating RS256 and JWKS (uses Node.js)](https://auth0.com/blog/navigating-rs256-and-jwks/)**, or check out our **[Backend/API Quickstarts.](https://auth0.com/docs/quickstart/backend)**
