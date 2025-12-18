# **[JWT](https://smallstep.com/docs/step-cli/reference/crypto/jwt/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

step crypto jwt -- sign and verify data using JSON Web Tokens (JWT)

## Usage

```bash
step crypto jwt <subcommand> [arguments] [global-flags] [subcommand-flags]
```

## Description

A JSON Web Token or JWT (pronounced "jot") is a compact data structure used to represent some JSON encoded "claims" that are passed as the payload of a JWS or JWE structure, enabling the claims to be digitally signed and/or encrypted. The "claims" (or "claim set") are represented as an ordinary JSON object. JWTs are represented using a compact format that's URL safe and can be used in space-constrained environments. JWTs can be passed in HTTP Authorization headers and as URI query parameters.

A **JWS structure** is a simpler format, containing only a header and a signed payload, while a **JWE structure** is more complex, including an encrypted payload, requiring additional components like an encrypted key and initialization vector, making it suitable for situations where confidentiality is needed, unlike JWS which only provides integrity and authenticity checks.

A "claim" is a piece of information asserted about a subject, represented as a key/value pair. Logically a verified JWT can be interpreted as "issuer says to audience that subject's claim-name is claim-value" for each claim.

A JWT signed using JWS has three parts:

- A base64 encoded JSON object representing the JOSE (JSON Object Signing and Encryption) header that describes the cryptographic operations applied to the JWT Claims Set
- A base64 encoded JSON object representing the JWT Claims Set
- A base64 encoded digital signature of message authentication code

## Examples

Create a signed JWT using a JWK (with line breaks for display purposes only):

A JWK is a JSON object that represents a cryptographic key, with the object's members representing the key's properties, including its value.

```bash
$ step crypto jwt sign --key p256.priv.json --iss "joe@example.com" \
      --aud "https://example.com" --sub auth --exp $(date -v+1M +"%s")
eyJhbGciOiJFUzI1NiIsImtpZCI6IlpqR1g5N0xtY2ZsUG9sV3Zzb0FXekM1V1BXa05GRkgzUWRLTFVXOTc4aGsiLCJ0eXAiOiJKV1QifQ
.
eyJhdWQiOiJodHRwczovL2V4YW1wbGUuY29tIiwiZXhwIjoxNTM1MjM2MTUyLCJpYXQiOjE1MzI1NTc3NTQsImlzcyI6ImpvZUBleGFtcGxlLmNvbSIsIm5iZiI6MTUzMjU1Nzc1NCwic3ViIjoiYXV0aCJ9
.
Z4veKtRmZLoqHNlTrcYo2W1ikLkDcSNfrT52zAGS9cF90Zi3aTXt_75pkikREvMrkC4mhGDdqxCf9ZHq4VnSvg
```

## **Create a signed JWT using a JWK and a custom payload:**

```bash
$ echo '{"srv":"https://srv.example.com"}' | step crypto jwt sign \
      --key p256.priv.json --iss "joe@example.com" \
      --aud "https://example.com" --sub auth --exp $(date -v+1M +"%s")
eyJhbGciOiJFUzI1NiIsImtpZCI6IlpqR1g5N0xtY2ZsUG9sV3Zzb0FXekM1V1BXa05GRkgzUWRLTFVXOTc4aGsiLCJ0eXAiOiJKV1QifQ
.
eyJhdWQiOiJodHRwczovL2V4YW1wbGUuY29tIiwiZXhwIjoxNTM1MjQyNDcyLCJpYXQiOjE1MzI1NjQwNzMsImlzcyI6ImpvZUBleGFtcGxlLmNvbSIsIm5iZiI6MTUzMjU2NDA3Mywic3J2IjoiaHR0cHM6Ly9zcnYuZXhhbXBsZS5jb20iLCJzdWIiOiJhdXRoIn0
.
DlSkxICjk2h1LarwJgXPbXQe7DwpLMOCvWp3I4GMcBP_5_QYPhVNBPQEeTKAUuQjYwlxZ5zVQnyp8ujvyf1Lqw
```

Verify the previous token:

```bash
$ echo $TOKEN | step crypto jwt verify --key p256.pub.json --iss "joe@example.com" --aud "https://example.com"
{
  "header": {
    "alg": "ES256",
    "kid": "ZjGX97LmcflPolWvsoAWzC5WPWkNFFH3QdKLUW978hk",
    "typ": "JWT"
  },
  "payload": {
    "aud": "https://example.com",
    "exp": 1535242472,
    "iat": 1532564073,
    "iss": "joe@example.com",
    "nbf": 1532564073,
    "srv": "https://srv.example.com",
    "sub": "auth"
  },
  "signature": "DlSkxICjk2h1LarwJgXPbXQe7DwpLMOCvWp3I4GMcBP_5_QYPhVNBPQEeTKAUuQjYwlxZ5zVQnyp8ujvyf1Lqw"
}

```

## **Read the information in the previous token without verifying it:**

```bash
echo $TOKEN | step crypto jwt inspect --insecure
{
  "header": {
    "alg": "ES256",
    "kid": "ZjGX97LmcflPolWvsoAWzC5WPWkNFFH3QdKLUW978hk",
    "typ": "JWT"
  },
  "payload": {
    "aud": "https://example.com",
    "exp": 1535242472,
    "iat": 1532564073,
    "iss": "joe@example.com",
    "nbf": 1532564073,
    "srv": "https://srv.example.com",
    "sub": "auth"
  },
  "signature": "DlSkxICjk2h1LarwJgXPbXQe7DwpLMOCvWp3I4GMcBP_5_QYPhVNBPQEeTKAUuQjYwlxZ5zVQnyp8ujvyf1Lqw"
}
```

## Istio demo jwt

```bash
TOKEN=eyJhbGciOiJSUzI1NiIsImtpZCI6IkRIRmJwb0lVcXJZOHQyenBBMnFYZkNtcjVWTzVaRXI0UnpIVV8tZW52dlEiLCJ0eXAiOiJKV1QifQ.eyJleHAiOjQ2ODU5ODk3MDAsImZvbyI6ImJhciIsImlhdCI6MTUzMjM4OTcwMCwiaXNzIjoidGVzdGluZ0BzZWN1cmUuaXN0aW8uaW8iLCJzdWIiOiJ0ZXN0aW5nQHNlY3VyZS5pc3Rpby5pbyJ9.CfNnxWP2tcnR9q0vxyxweaF3ovQYHYZl82hAUsn21bwQd9zP7c-LS9qd_vpdLG4Tn1A15NxfCjp5f7QNBUo-KC9PJqYpgGbaXhaGx7bEdFWjcwv3nZzvc7M__ZpaCERdwU7igUmJqYGBYQ51vr2njU9ZimyKkfDe3axcyiBZde7G6dabliUosJvvKOPcKIWPccCgefSj_GNfwIip3-SsFdlR7BtbVUcqR-yv-XOxJ3Uc1MI0tz3uMiiZcyPV7sNCU4KRnemRIMHVOfuvHsU60_GhGbiSFzgPTAa9WTltbnarTbxudb_YEOx12JiwYToeX0DCPb43W1tzIBxgm8NxUg

echo $TOKEN | step crypto jwt inspect --insecure

{
  "header": {
    "alg": "RS256",
    "kid": "DHFbpoIUqrY8t2zpA2qXfCmr5VO5ZEr4RzHU_-envvQ",
    "typ": "JWT"
  },
  "payload": {
    "exp": 4685989700,
    "foo": "bar",
    "iat": 1532389700,
    "iss": "testing@secure.istio.io",
    "sub": "testing@secure.istio.io"
  },
  "signature": "CfNnxWP2tcnR9q0vxyxweaF3ovQYHYZl82hAUsn21bwQd9zP7c-LS9qd_vpdLG4Tn1A15NxfCjp5f7QNBUo-KC9PJqYpgGbaXhaGx7bEdFWjcwv3nZzvc7M__ZpaCERdwU7igUmJqYGBYQ51vr2njU9ZimyKkfDe3axcyiBZde7G6dabliUosJvvKOPcKIWPccCgefSj_GNfwIip3-SsFdlR7BtbVUcqR-yv-XOxJ3Uc1MI0tz3uMiiZcyPV7sNCU4KRnemRIMHVOfuvHsU60_GhGbiSFzgPTAa9WTltbnarTbxudb_YEOx12JiwYToeX0DCPb43W1tzIBxgm8NxUg"
}
```
