# [Navigating JWKS](https://auth0.com/blog/navigating-rs256-and-jwks/)

When signing your JWTs it is better to use an asymmetric signing algorithm. Doing so will no longer require sharing a private key across many applications. Using an algorithm like RS256 and the JWKS endpoint allows your applications to trust the JWTs signed by Auth0.

## Verifying RS256

Due to the symmetric nature of HS256, we favor the use of RS256 for signing your JWTs, especially for APIs with 3rd party clients. However, this decision comes with some extra steps for verifying the signature of your JWTs. Auth0 uses the **[JWK specification](https://tools.ietf.org/html/rfc7517)** to represent the cryptographic keys used for signing or verifying tokens. This spec defines two high level data structures: JWKS and JWK. Here are the definitions directly from the specification:

## JSON Web Key (JWK)

A JSON object that represents a cryptographic key. The members of the object represent properties of the key, including its value.

## JWK Set

A JSON object that represents a set of JWKs. The JSON object MUST have a "keys" member, which is an array of JWKs.

At the most basic level, the JWKS is a set of keys containing the public keys that should be used to verify any JWT issued by the authorization server. Auth0 exposes a JWKS endpoint for each tenant, which is found at <https://your-tenant.auth0.com/.well-known/jwks.json>. This endpoint will contain the JWK used to sign all Auth0 issued JWTs for this tenant. Here is an example of the JWKS used by a demo tenant.

## Azure endpoint

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0/.well-known/openid-configuration>

<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/v2.0/keys>

## Here is an example of the JWKS used by a demo Auth0 tenant

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

## Here is an example of the JWKS used by a demo Azure tenant

```json
// 20240304133211
// https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/v2.0/keys

{
  "keys": [
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "kWbkaa6qs8wsTnBwiiNYOhHbnAw",
      "x5t": "kWbkaa6qs8wsTnBwiiNYOhHbnAw",
      "n": "t6Q2XSeWnMA_-crH2UbftfS01QDAqHoPQFqsRtVkxG4eyamnNlTl3Da07QQkjpPEbLoLtgtMI2Pr0plO7xU9f94mhbfK_UJ6Y0KcWxhwKMkCgnzcFOQF4eH_AICHLOKa8vPthtcprNcCmjbksW5TYBZi6uLhFLw_HsjGOxhK0VaDWnWizNVeqvzVB0jt9Vdmfhs6Zohy_1b2Wusdad1NmSKzhC74IDjlIaFoik_ZJJdtLOgoIwOZTLW0M1UKhRrWtj7AjVCnE_zBiloACm1IrIM_PymE10cJJ6WFz29ep4g7X65xCEU6zJ5oIFibvk6cKKcFNB7FFjbehYVpw5BxVQ",
      "e": "AQAB",
      "x5c": [
        "MIIC/TCCAeWgAwIBAgIICHb5qy8hKKgwDQYJKoZIhvcNAQELBQAwLTErMCkGA1UEAxMiYWNjb3VudHMuYWNjZXNzY29udHJvbC53aW5kb3dzLm5ldDAeFw0yNDAxMTUxODA0MTRaFw0yOTAxMTUxODA0MTRaMC0xKzApBgNVBAMTImFjY291bnRzLmFjY2Vzc2NvbnRyb2wud2luZG93cy5uZXQwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQC3pDZdJ5acwD/5ysfZRt+19LTVAMCoeg9AWqxG1WTEbh7Jqac2VOXcNrTtBCSOk8Rsugu2C0wjY+vSmU7vFT1/3iaFt8r9QnpjQpxbGHAoyQKCfNwU5AXh4f8AgIcs4pry8+2G1yms1wKaNuSxblNgFmLq4uEUvD8eyMY7GErRVoNadaLM1V6q/NUHSO31V2Z+GzpmiHL/VvZa6x1p3U2ZIrOELvggOOUhoWiKT9kkl20s6CgjA5lMtbQzVQqFGta2PsCNUKcT/MGKWgAKbUisgz8/KYTXRwknpYXPb16niDtfrnEIRTrMnmggWJu+TpwopwU0HsUWNt6FhWnDkHFVAgMBAAGjITAfMB0GA1UdDgQWBBQLGQYqt7pRrKWQ25XWSi6lGN818DANBgkqhkiG9w0BAQsFAAOCAQEAtky1EYTKZvbTAveLmL3VCi+bJMjY5wyDO4Yulpv0VP1RS3dksmEALOsa1Bfz2BXVpIKPUJLdvFFoFhDqReAqRRqxylhI+oMwTeAsZ1lYCV4hTWDrN/MML9SYyeQ441Xp7xHIzu1ih4rSkNwrsx231GTfzo6dHMsi12oEdyn6mXavWehBDbzVDxbeqR+0ymhCgeYjIfCX6z2SrSMGYiG2hzs/xzypnIPnv6cBMQQDS4sdquoCsvIqJRWmF9ow79oHhzSTwGJj4+jEQi7QMTDR30rYiPTIdE63bnuARdgNF/dqB7n4ZJv566jvbzHpfCTqrJyj7Guvjr9i56NpLmz2DA=="
      ],
      "issuer": "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0"
    },
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "XRvko8P7A3UaWSnU7bM9nT0MjhA",
      "x5t": "XRvko8P7A3UaWSnU7bM9nT0MjhA",
      "n": "vRIL3aZt-xVqOZgMOr71ltWe9YY2Wf_B28C4Jl2nBSTEcFnf_eqOHZ8yzUBbLc4Nti2_ETcCsTUNuzS368BWkSgxc45JBH1wFSoWNFUSXaPt8mRwJYTF0H32iNhw_tBb9mvdQVgVs4Ci0dVJRYiz-ilk3PeO8wzlwRuwWIsaKFYlMyOKG9DVFbg93DmP5Tjq3C3oJlATyhAiJJc1T2trEP8960an33dDEaWwVAHh3c_34meAO4R6kLzIq0JnSsZMYB9O_6bMyIlzxmdZ8F442SynCUHxhnIh3yZew-xDdeHr6Ofl7KeVUcvSiZP9X44CaVJvknXQbBYNl-H7YF5RgQ",
      "e": "AQAB",
      "x5c": [
        "MIIC/jCCAeagAwIBAgIJAKysonliFZLIMA0GCSqGSIb3DQEBCwUAMC0xKzApBgNVBAMTImFjY291bnRzLmFjY2Vzc2NvbnRyb2wud2luZG93cy5uZXQwHhcNMjQwMjA4MTcwMjUzWhcNMjkwMjA4MTcwMjUzWjAtMSswKQYDVQQDEyJhY2NvdW50cy5hY2Nlc3Njb250cm9sLndpbmRvd3MubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvRIL3aZt+xVqOZgMOr71ltWe9YY2Wf/B28C4Jl2nBSTEcFnf/eqOHZ8yzUBbLc4Nti2/ETcCsTUNuzS368BWkSgxc45JBH1wFSoWNFUSXaPt8mRwJYTF0H32iNhw/tBb9mvdQVgVs4Ci0dVJRYiz+ilk3PeO8wzlwRuwWIsaKFYlMyOKG9DVFbg93DmP5Tjq3C3oJlATyhAiJJc1T2trEP8960an33dDEaWwVAHh3c/34meAO4R6kLzIq0JnSsZMYB9O/6bMyIlzxmdZ8F442SynCUHxhnIh3yZew+xDdeHr6Ofl7KeVUcvSiZP9X44CaVJvknXQbBYNl+H7YF5RgQIDAQABoyEwHzAdBgNVHQ4EFgQU8Sqmrf0UFpZbGtl5y1CjUdQq5ycwDQYJKoZIhvcNAQELBQADggEBAA57FiIOUs5yyLD6a6rWCbQ4Z2XJTfQb+TM/tZ6V6QqNhSS+Q98KFOIWe9Sit0iAyDsCCKuA8f08PYnUiHmHq8dG/7YRTShE/3zCZXHYKJgMaBhYfS788zQuq/hXDdVVc5X0pZwM4ibc6+2XpcpeDHxpMOLwo2AwujDdHVLzedAkIaTCzwPIizP4LB6l6IxR+xRXsH/1f034Gk3ReAEGgHW12NkajtXmC3DKl6vGIHvx1PgAMWQbxq3F2OopNx6aZEIIZWcMpQZ6/62f3pxRJHzZiJZN+khV8hpNjJvCNf6/hNbxkLcjLAycjW8AttcCRSTM4F+02S3TyHmoE4pYywA="
      ],
      "issuer": "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0"
    },
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "qor_VePWgmxWy3r1dpfsWsw2-zY",
      "x5t": "qor_VePWgmxWy3r1dpfsWsw2-zY",
      "n": "rV8eXna9NCyzvgVZvbz18NhLIAfo1Qzn-VQQCbQzyGi2KDe3RI2sLeHltv9mVI2sahcRjgvhYNSETyxqHaKw3w8L4jg0kJdfzhD8dvpl32hunOCzuY2WpyJVq6CkxzGN4iikWTEIe_GMGsu9qhdxybaTCBTAya8qyKL1sbEByk8FiY6nsm6BhuRUVCh_rzfAp3HY-U_58ORLF1tmZrmSljHMFwlxvYuOIlKHacXy9gen8HsT7PUSA4n2PdnT1XAmlKJG1mzvdqyG2L3iRQJ45tcmrERKcd1pYwhb7ZtTyKypkeR9lkKbaYiQUt1QhpeO12pH1bRB1_k9MMzOm8Ca1Q",
      "e": "AQAB",
      "x5c": [
        "MIIC6jCCAdKgAwIBAgIJAMqvEglnjttEMA0GCSqGSIb3DQEBCwUAMCMxITAfBgNVBAMTGGxvZ2luLm1pY3Jvc29mdG9ubGluZS51czAeFw0yNDAxMjQyMjE0MjNaFw0yOTAxMjQyMjE0MjNaMCMxITAfBgNVBAMTGGxvZ2luLm1pY3Jvc29mdG9ubGluZS51czCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAK1fHl52vTQss74FWb289fDYSyAH6NUM5/lUEAm0M8hotig3t0SNrC3h5bb/ZlSNrGoXEY4L4WDUhE8sah2isN8PC+I4NJCXX84Q/Hb6Zd9obpzgs7mNlqciVaugpMcxjeIopFkxCHvxjBrLvaoXccm2kwgUwMmvKsii9bGxAcpPBYmOp7JugYbkVFQof683wKdx2PlP+fDkSxdbZma5kpYxzBcJcb2LjiJSh2nF8vYHp/B7E+z1EgOJ9j3Z09VwJpSiRtZs73ashti94kUCeObXJqxESnHdaWMIW+2bU8isqZHkfZZCm2mIkFLdUIaXjtdqR9W0Qdf5PTDMzpvAmtUCAwEAAaMhMB8wHQYDVR0OBBYEFKOxwRo5B0oCCCLMp8I/cHosF4cPMA0GCSqGSIb3DQEBCwUAA4IBAQCifXD9bW3dh6WAwfFHnL2HefUhuDQzisAZBR0o6kPASObicJK91BtfVg6iYW0LUCE70EVnFkyypTy19JIPf3zutQkHFAdXtS2/0NiR0vRJ561gi5Yqjl9BW9Az6Eb/O4UEzqBpe313FNt2co8I0OjRNhbKB1lIPUu6UZs5qBdfTwQFB6fU/XfXHnpZERZgRUZu5mku/n2EHZ1iMe9of1Qv/AtXgB51ZlfpT6YbrqMJBJs1yHxLd+rYqoXCwWLoBlJ3xYm4jEzSHPLjFgqHrUb9Cl2SazRKhV/UBAGqq0xG6qZMoiWvcfv0equddGa/r84lrEU2y1RBGUGw15jiLL/y"
      ],
      "issuer": "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0"
    }
  ]
}
```

Note: At the time of writing, Auth0 only supports a single JWK for token verification, however it is important to assume this endpoint could contain multiple JWKs. As an example, multiple keys can be found in the JWKS when rotating signing certificates.

The JWKS above contains a single key. Each property in the key is defined by the JWK specification RFC 7517 Section 4. We will use these properties to determine which key was used to sign the JWT. Here is a quick breakdown of what each property represents:

- alg: is the algorithm for the key
- kty: is the key type
- use: is how the key was meant to be used. For the example above, sig represents signature verification.
- x5c: The x.509 certificate chain. The first entry in the array is the certificate to use for token verification; the other certificates can be used to verify this first certificate.
e: is the exponent for a standard pem
n: is the moduluos for a standard pem
kid: is the unique identifier for the key
x5t: is the thumbprint of the x.509 cert (SHA-1 thumbprint)

## Here are the steps for validating the JWT

1. Retrieve the JWKS and filter for potential signature verification keys.
2. Extract the JWT from the request's authorization header. In Azure this is in the body.
jwtToken := r.FormValue("id_token")
"eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImtpZCI6IlhSdmtvOFA3QTNVYVdTblU3Yk05blQwTWpoQSJ9.eyJhdWQiOiJkNmI2NjhjNy1lMTgxLTQ0MTUtYjZmZS1mYjdhNzZkNDhkNGEiLCJpc3MiOiJodHRwczovL2xvZ2luLm1pY3Jvc29mdG9ubGluZS5jb20vNTI2OWIwMjEtNTMzZS00NzAyLWI5ZDktNzJhY2JjODUyYzk3L3YyLjAiLCJpYXQiOjE3MDk1Nzk5MDYsIm5iZiI6MTcwOTU3OTkwNiwiZXhwIjoxNzA5NTgzODA2LCJhaW8iOiJBV1FBbS84V0FBQUE0aHRhdzhmaFc5aUptVllvODU1b2ZhZXJGUHowam9RZWM1YzNSRU5mdlRJckxVWEFTVzlkbVlUT1BlMEdDWnRRSlppd0pVaUhRcm5YOWNpT3FWdmZMcWg0SEw4c3BBUW01WnRIdSs3cUZuYXg3cXV1N0dtYUg4dGI1b09DVGMvdiIsImVtYWlsIjoiYnJlbnRncm92ZXNAMWhrdDV0Lm9ubWljcm9zb2Z0LmNvbSIsIm5hbWUiOiJCcmVudCBHcm92ZXMiLCJub25jZSI6IjY3ODkxMCIsIm9pZCI6IjlhY2NmYTg5LTk4NzItNGI2Ni05ZDcwLWI3NWYyMzQyZjNiYSIsInByZWZlcnJlZF91c2VybmFtZSI6ImJyZW50Z3JvdmVzQDFoa3Q1dC5vbm1pY3Jvc29mdC5jb20iLCJyaCI6IjAuQVh3QUliQnBVajVUQWtlNTJYS3N2SVVzbDhkb3R0YUI0UlZFdHY3N2VuYlVqVXJNQUxJLiIsInN1YiI6IndJaGtqazNPbVQ1cVc2WE1ETVktRFMwTGVZUkt3UU56UE5NcjJ2NGtNQUkiLCJ0aWQiOiI1MjY5YjAyMS01MzNlLTQ3MDItYjlkOS03MmFjYmM4NTJjOTciLCJ1dGkiOiJxQ0pJYnpwdXdrZXh2UjhWSDdtRUFRIiwidmVyIjoiMi4wIn0.Lx4qAVioYjE-l9X6f0i_nB4Omt0UyZY6BdpG2akk6QNQyOND4KJzTmqQnfkJib2EOL8u_8NgmLIdkgYu8D2Bmzvt-FOBFPPUBySbkVCbYl66StArAjdxGAwI_9t9xMtNX9z3FDwxV5-ts0fEnvolItss2U5q2cN9HF8qySFFfFJFpp4i4dCwoeq4mQCN79lUrXJz95z8F2HKzGtU7ic0_H0aL-L5_9p71nCUunG1fZaqjYS2IgcWRrEpWfQpgFtYms1Ekz14oyK_7PAJLhZpxP_xVQXP9cH9azyQWo9GkfKP0Q5hOAUwXx2xdqFgtHgohzTRQyYzPVPAA9Q7g4qGYw"

# the id_token from Azure endpoin base64 encoded so it needs decoded to get at the kid property

3. Decode the JWT and grab the kid property from the header.
<https://jwt.io/#libraries-io>
or
<https://jwt.ms/#id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyIsImtpZCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyJ9.eyJhdWQiOiJiMTRhNzUwNS05NmU5LTQ5MjctOTFlOC0wNjAxZDBmYzljYWEiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9mYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkvIiwiaWF0IjoxNTM2Mjc1MTI0LCJuYmYiOjE1MzYyNzUxMjQsImV4cCI6MTUzNjI3OTAyNCwiYWlvIjoiQVhRQWkvOElBQUFBcXhzdUIrUjREMnJGUXFPRVRPNFlkWGJMRDlrWjh4ZlhhZGVBTTBRMk5rTlQ1aXpmZzN1d2JXU1hodVNTajZVVDVoeTJENldxQXBCNWpLQTZaZ1o5ay9TVTI3dVY5Y2V0WGZMT3RwTnR0Z2s1RGNCdGsrTExzdHovSmcrZ1lSbXY5YlVVNFhscGhUYzZDODZKbWoxRkN3PT0iLCJhbXIiOlsicnNhIl0sImVtYWlsIjoiYWJlbGlAbWljcm9zb2Z0LmNvbSIsImZhbWlseV9uYW1lIjoiTGluY29sbiIsImdpdmVuX25hbWUiOiJBYmUiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC83MmY5ODhiZi04NmYxLTQxYWYtOTFhYi0yZDdjZDAxMWRiNDcvIiwiaXBhZGRyIjoiMTMxLjEwNy4yMjIuMjIiLCJuYW1lIjoiYWJlbGkiLCJub25jZSI6IjEyMzUyMyIsIm9pZCI6IjA1ODMzYjZiLWFhMWQtNDJkNC05ZWMwLTFiMmJiOTE5NDQzOCIsInJoIjoiSSIsInN1YiI6IjVfSjlyU3NzOC1qdnRfSWN1NnVlUk5MOHhYYjhMRjRGc2dfS29vQzJSSlEiLCJ0aWQiOiJmYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkiLCJ1bmlxdWVfbmFtZSI6IkFiZUxpQG1pY3Jvc29mdC5jb20iLCJ1dGkiOiJMeGVfNDZHcVRrT3BHU2ZUbG40RUFBIiwidmVyIjoiMS4wIn0=.UJQrCA6qn2bXq57qzGX_-D3HcPHqBMOKDPx4su1yKRLNErVD8xkxJLNLVRdASHqEcpyDctbdHccu6DPpkq5f0ibcaQFhejQNcABidJCTz0Bb2AbdUCTqAzdt9pdgQvMBnVH1xk3SCM6d4BbT4BkLLj10ZLasX7vRknaSjE_C5DI7Fg4WrZPwOhII1dB0HEZ_qpNaYXEiy-o94UJ94zCr07GgrqMsfYQqFR7kn-mn68AjvLcgwSfZvyR_yIK75S_K37vC3QryQ7cNoafDe9upql_6pB2ybMVlgWPs_DmbJ8g0om-sPlwyn74Cc1tW3ze-Xptw_2uVdPgWyqfuWAfq6Q>

{
  "typ": "JWT",
  "alg": "RS256",
  "kid": "XRvko8P7A3UaWSnU7bM9nT0MjhA"
}.{
  "aud": "d6b668c7-e181-4415-b6fe-fb7a76d48d4a",
  "iss": "<https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0>",
  "iat": 1709579906,
  "nbf": 1709579906,
  "exp": 1709583806,
  "aio": "AWQAm/8WAAAA4htaw8fhW9iJmVYo855ofaerFPz0joQec5c3RENfvTIrLUXASW9dmYTOPe0GCZtQJZiwJUiHQrnX9ciOqVvfLqh4HL8spAQm5ZtHu+7qFnax7quu7GmaH8tb5oOCTc/v",
  "email": "<brentgroves@1hkt5t.onmicrosoft.com>",
  "name": "Brent Groves",
  "nonce": "678910",
  "oid": "9accfa89-9872-4b66-9d70-b75f2342f3ba",
  "preferred_username": "<brentgroves@1hkt5t.onmicrosoft.com>",
  "rh": "0.AXwAIbBpUj5TAke52XKsvIUsl8dottaB4RVEtv77enbUjUrMALI.",
  "sub": "wIhkjk3OmT5qW6XMDMY-DS0LeYRKwQNzPNMr2v4kMAI",
  "tid": "5269b021-533e-4702-b9d9-72acbc852c97",
  "uti": "qCJIbzpuwkexvR8VH7mEAQ",
  "ver": "2.0"
}.[Signature]

4. Find the signature verification key in the filtered JWKS with a matching kid property.

```json
// https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/discovery/v2.0/keys
{
  "keys": [
    {
      "kty": "RSA",
      "use": "sig",
      "kid": "XRvko8P7A3UaWSnU7bM9nT0MjhA",
      "x5t": "XRvko8P7A3UaWSnU7bM9nT0MjhA",
      "n": "vRIL3aZt-xVqOZgMOr71ltWe9YY2Wf_B28C4Jl2nBSTEcFnf_eqOHZ8yzUBbLc4Nti2_ETcCsTUNuzS368BWkSgxc45JBH1wFSoWNFUSXaPt8mRwJYTF0H32iNhw_tBb9mvdQVgVs4Ci0dVJRYiz-ilk3PeO8wzlwRuwWIsaKFYlMyOKG9DVFbg93DmP5Tjq3C3oJlATyhAiJJc1T2trEP8960an33dDEaWwVAHh3c_34meAO4R6kLzIq0JnSsZMYB9O_6bMyIlzxmdZ8F442SynCUHxhnIh3yZew-xDdeHr6Ofl7KeVUcvSiZP9X44CaVJvknXQbBYNl-H7YF5RgQ",
      "e": "AQAB",
      "x5c": [
        "MIIC/jCCAeagAwIBAgIJAKysonliFZLIMA0GCSqGSIb3DQEBCwUAMC0xKzApBgNVBAMTImFjY291bnRzLmFjY2Vzc2NvbnRyb2wud2luZG93cy5uZXQwHhcNMjQwMjA4MTcwMjUzWhcNMjkwMjA4MTcwMjUzWjAtMSswKQYDVQQDEyJhY2NvdW50cy5hY2Nlc3Njb250cm9sLndpbmRvd3MubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvRIL3aZt+xVqOZgMOr71ltWe9YY2Wf/B28C4Jl2nBSTEcFnf/eqOHZ8yzUBbLc4Nti2/ETcCsTUNuzS368BWkSgxc45JBH1wFSoWNFUSXaPt8mRwJYTF0H32iNhw/tBb9mvdQVgVs4Ci0dVJRYiz+ilk3PeO8wzlwRuwWIsaKFYlMyOKG9DVFbg93DmP5Tjq3C3oJlATyhAiJJc1T2trEP8960an33dDEaWwVAHh3c/34meAO4R6kLzIq0JnSsZMYB9O/6bMyIlzxmdZ8F442SynCUHxhnIh3yZew+xDdeHr6Ofl7KeVUcvSiZP9X44CaVJvknXQbBYNl+H7YF5RgQIDAQABoyEwHzAdBgNVHQ4EFgQU8Sqmrf0UFpZbGtl5y1CjUdQq5ycwDQYJKoZIhvcNAQELBQADggEBAA57FiIOUs5yyLD6a6rWCbQ4Z2XJTfQb+TM/tZ6V6QqNhSS+Q98KFOIWe9Sit0iAyDsCCKuA8f08PYnUiHmHq8dG/7YRTShE/3zCZXHYKJgMaBhYfS788zQuq/hXDdVVc5X0pZwM4ibc6+2XpcpeDHxpMOLwo2AwujDdHVLzedAkIaTCzwPIizP4LB6l6IxR+xRXsH/1f034Gk3ReAEGgHW12NkajtXmC3DKl6vGIHvx1PgAMWQbxq3F2OopNx6aZEIIZWcMpQZ6/62f3pxRJHzZiJZN+khV8hpNjJvCNf6/hNbxkLcjLAycjW8AttcCRSTM4F+02S3TyHmoE4pYywA="
      ],
      "issuer": "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0"
    },
  ]
}
```

5. Using the x5c property build a certificate which will be used to verify the JWT signature. We just paste the x5c value between -----BEGIN CERTIFICATE----- and
-----END CERTIFICATE-----

```pem
-----BEGIN CERTIFICATE-----
MIIC/jCCAeagAwIBAgIJAKysonliFZLIMA0GCSqGSIb3DQEBCwUAMC0xKzApBgNVBAMTImFjY291bnRzLmFjY2Vzc2NvbnRyb2wud2luZG93cy5uZXQwHhcNMjQwMjA4MTcwMjUzWhcNMjkwMjA4MTcwMjUzWjAtMSswKQYDVQQDEyJhY2NvdW50cy5hY2Nlc3Njb250cm9sLndpbmRvd3MubmV0MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAvRIL3aZt+xVqOZgMOr71ltWe9YY2Wf/B28C4Jl2nBSTEcFnf/eqOHZ8yzUBbLc4Nti2/ETcCsTUNuzS368BWkSgxc45JBH1wFSoWNFUSXaPt8mRwJYTF0H32iNhw/tBb9mvdQVgVs4Ci0dVJRYiz+ilk3PeO8wzlwRuwWIsaKFYlMyOKG9DVFbg93DmP5Tjq3C3oJlATyhAiJJc1T2trEP8960an33dDEaWwVAHh3c/34meAO4R6kLzIq0JnSsZMYB9O/6bMyIlzxmdZ8F442SynCUHxhnIh3yZew+xDdeHr6Ofl7KeVUcvSiZP9X44CaVJvknXQbBYNl+H7YF5RgQIDAQABoyEwHzAdBgNVHQ4EFgQU8Sqmrf0UFpZbGtl5y1CjUdQq5ycwDQYJKoZIhvcNAQELBQADggEBAA57FiIOUs5yyLD6a6rWCbQ4Z2XJTfQb+TM/tZ6V6QqNhSS+Q98KFOIWe9Sit0iAyDsCCKuA8f08PYnUiHmHq8dG/7YRTShE/3zCZXHYKJgMaBhYfS788zQuq/hXDdVVc5X0pZwM4ibc6+2XpcpeDHxpMOLwo2AwujDdHVLzedAkIaTCzwPIizP4LB6l6IxR+xRXsH/1f034Gk3ReAEGgHW12NkajtXmC3DKl6vGIHvx1PgAMWQbxq3F2OopNx6aZEIIZWcMpQZ6/62f3pxRJHzZiJZN+khV8hpNjJvCNf6/hNbxkLcjLAycjW8AttcCRSTM4F+02S3TyHmoE4pYywA=
-----END CERTIFICATE-----
```

6. Extract the public key from the public certificate

referenced <https://stackoverflow.com/questions/68349345/verifying-jwt-rs256-using-openssl>

```bash
cd ~/src/repsys/research/microsoft_identity_platform/oidc/dev_tenant
openssl x509 -pubkey -noout -in dev_account_x509c.pem > dev_account_publickey.pem
```

7. Extract the input payload
copied and pasted from jwt.io to payload.json

8. Decode the signature
