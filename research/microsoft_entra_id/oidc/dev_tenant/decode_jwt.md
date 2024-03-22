# **[jwt decoder](https://jwt.ms/#id_token=eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsIng1dCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyIsImtpZCI6IjdfWnVmMXR2a3dMeFlhSFMzcTZsVWpVWUlHdyJ9.eyJhdWQiOiJiMTRhNzUwNS05NmU5LTQ5MjctOTFlOC0wNjAxZDBmYzljYWEiLCJpc3MiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC9mYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkvIiwiaWF0IjoxNTM2Mjc1MTI0LCJuYmYiOjE1MzYyNzUxMjQsImV4cCI6MTUzNjI3OTAyNCwiYWlvIjoiQVhRQWkvOElBQUFBcXhzdUIrUjREMnJGUXFPRVRPNFlkWGJMRDlrWjh4ZlhhZGVBTTBRMk5rTlQ1aXpmZzN1d2JXU1hodVNTajZVVDVoeTJENldxQXBCNWpLQTZaZ1o5ay9TVTI3dVY5Y2V0WGZMT3RwTnR0Z2s1RGNCdGsrTExzdHovSmcrZ1lSbXY5YlVVNFhscGhUYzZDODZKbWoxRkN3PT0iLCJhbXIiOlsicnNhIl0sImVtYWlsIjoiYWJlbGlAbWljcm9zb2Z0LmNvbSIsImZhbWlseV9uYW1lIjoiTGluY29sbiIsImdpdmVuX25hbWUiOiJBYmUiLCJpZHAiOiJodHRwczovL3N0cy53aW5kb3dzLm5ldC83MmY5ODhiZi04NmYxLTQxYWYtOTFhYi0yZDdjZDAxMWRiNDcvIiwiaXBhZGRyIjoiMTMxLjEwNy4yMjIuMjIiLCJuYW1lIjoiYWJlbGkiLCJub25jZSI6IjEyMzUyMyIsIm9pZCI6IjA1ODMzYjZiLWFhMWQtNDJkNC05ZWMwLTFiMmJiOTE5NDQzOCIsInJoIjoiSSIsInN1YiI6IjVfSjlyU3NzOC1qdnRfSWN1NnVlUk5MOHhYYjhMRjRGc2dfS29vQzJSSlEiLCJ0aWQiOiJmYTE1ZDY5Mi1lOWM3LTQ0NjAtYTc0My0yOWYyOTU2ZmQ0MjkiLCJ1bmlxdWVfbmFtZSI6IkFiZUxpQG1pY3Jvc29mdC5jb20iLCJ1dGkiOiJMeGVfNDZHcVRrT3BHU2ZUbG40RUFBIiwidmVyIjoiMS4wIn0=.UJQrCA6qn2bXq57qzGX_-D3HcPHqBMOKDPx4su1yKRLNErVD8xkxJLNLVRdASHqEcpyDctbdHccu6DPpkq5f0ibcaQFhejQNcABidJCTz0Bb2AbdUCTqAzdt9pdgQvMBnVH1xk3SCM6d4BbT4BkLLj10ZLasX7vRknaSjE_C5DI7Fg4WrZPwOhII1dB0HEZ_qpNaYXEiy-o94UJ94zCr07GgrqMsfYQqFR7kn-mn68AjvLcgwSfZvyR_yIK75S_K37vC3QryQ7cNoafDe9upql_6pB2ybMVlgWPs_DmbJ8g0om-sPlwyn74Cc1tW3ze-Xptw_2uVdPgWyqfuWAfq6Q)

## references

<https://www.sslshopper.com/certificate-decoder.html>

```json
{
  "typ": "JWT",
  "alg": "RS256",
  "kid": "XRvko8P7A3UaWSnU7bM9nT0MjhA"
}.{
  "aud": "d6b668c7-e181-4415-b6fe-fb7a76d48d4a",
  "iss": "https://login.microsoftonline.com/5269b021-533e-4702-b9d9-72acbc852c97/v2.0",
  "iat": 1709579906,
  "nbf": 1709579906,
  "exp": 1709583806,
  "aio": "AWQAm/8WAAAA4htaw8fhW9iJmVYo855ofaerFPz0joQec5c3RENfvTIrLUXASW9dmYTOPe0GCZtQJZiwJUiHQrnX9ciOqVvfLqh4HL8spAQm5ZtHu+7qFnax7quu7GmaH8tb5oOCTc/v",
  "email": "brentgroves@1hkt5t.onmicrosoft.com",
  "name": "Brent Groves",
  "nonce": "678910",
  "oid": "9accfa89-9872-4b66-9d70-b75f2342f3ba",
  "preferred_username": "brentgroves@1hkt5t.onmicrosoft.com",
  "rh": "0.AXwAIbBpUj5TAke52XKsvIUsl8dottaB4RVEtv77enbUjUrMALI.",
  "sub": "wIhkjk3OmT5qW6XMDMY-DS0LeYRKwQNzPNMr2v4kMAI",
  "tid": "5269b021-533e-4702-b9d9-72acbc852c97",
  "uti": "qCJIbzpuwkexvR8VH7mEAQ",
  "ver": "2.0"
}.[Signature]
```
