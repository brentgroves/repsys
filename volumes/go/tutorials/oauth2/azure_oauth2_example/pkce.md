# Generate Code Verifier and Code Challenge

<https://gist.github.com/ogazitt/f749dad9cca8d0ac6607f93a42adf322>

<https://example-app.com/pkce>

Code_verifier(random_string)=5b7c647392f1f049e1319918a220c4a0ee39bb453aa58f3b87f7ff73
URL-Safe SHA256 (Code Challenge)=iyIT0W4qFHxvxpgNOg9C2cs84WSeAHCliJYX0DaMEKI

1bb2ec44ba38581bb41ebd9c6459bbcb6809a82d477f7870ddabb9df9cd55524

## **[Proof Key for Code Exchange Overview](https://curity.io/resources/learn/oauth-pkce/#:~:text=The%20Proof%20Key%20for%20Code,same%20one%20that%20finishes%20it.)**

## OAuth 2.0 Proof Key for Code Exchange

The Proof Key for Code Exchange (PKCE) is an extension used in OAuth 2.0, to improve security for public clients. It ensures that the application that starts the authentication flow is the same one that finishes it.

In the
Code Flow overview
 we explained:

- How this popular message exchange pattern works;
- The kinds of client applications that use it;
- Variations that can be used to get different types of tokens (e.g., ID Tokens and Refresh Tokens); and
- How the user is redirected back to the client application once authentication and delegation are complete.

This last point about OAuth URL redirection is an important one. As mentioned many times in the OAuth 2.0 Threat Model (RFC 6819), the use of redirects is one of the primary attack vectors of OAuth. There are many ways that an attacker may try to take advantage of the code flow's redirection back to the client. These dangers are largely mitigated by:

- Requiring the client to authenticate itself at the token endpoint (when redeeming the authorization code);
- Using TLS on the client's redirect URI;
- Having a unique redirect URI for each client which it has total control over.

For Web applications, these safeguards are usually in place. They may not be, however, for mobile applications. In such environments, an attacker may be able to obtain the client ID and secret used by the app when it authenticates itself to the OAuth server's token endpoint. Also, the redirection may use a custom scheme that is not confidential and may be possible for an attacker to also register to handle. This situation is shown in the following figure:

![](https://curity.io/images/resources/architect/oauth/pkce/Vulnerability-Necessitating-PKCE.svg)

This danger can be mitigated though using Proof Key for Code Exchange (PKCE), or "pixie" as it is commonly referred to, which is defined in RFC 7636.

## Explanation of PKCE

The reason that such a vulnerability exists is because the OAuth server (i.e., the Curity Identity Server) doesn't know the difference between the legitimate app that starts the flow in step one and the malicious app that redeems the authorization code in step five. To close this hole, the OAuth server needs a way of determining that the app that starts the flow is the same one that finishes it. This is what PKCE does. The way it accomplishes this is by specifying that:

1. The legitimate client app creates a secret key that only it knows.
2. The request in step one above includes a hash of this secret key and info about which hashing algorithm was used.
3. Step five in the previous figure includes the actual key.
4. Before the OAuth server returns the tokens in step six, it uses the secret key to determine if it can arrive at the same hash that was previously given (using the early-provided hashing algorithm).

These additional steps are shown in the following figure:

![](https://curity.io/images/resources/architect/oauth/pkce/No-Vulnerability-Using-PKCE.svg)

This is the code flow using a proof key for the code exchange (hence the name). The key proves that the one who requested the code is the same entity that redeems it. This makes the authorization code a "proof of possession" token because the client must prove that it posses the secret key used when the authorization flow is initiated. Because the malicious app does not have access to the secret key, it will not be able to redeem the code. Conversely, the legitimate one does, so only it will receive tokens when redeeming the authorization code:

![](https://curity.io/images/resources/architect/oauth/pkce/Legit-Use-with-PKCE.svg)

## Pseudo Example Code

```python
code_verifier = generate_random_string(length = 100) # (1)
session["code_verifier"] = code_verifier             # (2)
hash = sha256_hash(code_verifier)                    # (3)
code_challenge = base64_url_encode(hash)             # (4)

redirect_to_authorization_endpoint_using_pkce(       # (5)
 code_challenge = code_challenge, code_challenge_method = "S256")
```

In (1), the client generates a random key or string of bytes that only it knows. It saves this in some persistent session store (2). It then hashes these bytes (3) and encodes them for use in a URL (4). When redirecting to the OAuth server, it includes the hash of the key and the algorithm used to compute that hash (5).

Later, when the client receives the call back from the OAuth server, it would redeem the authorization code using pseudocode like this:

```python
post_code_to_token_endpoint_using_pkce(             # (6)
 code = request["code"], code_verifier = session["code_verifier"])

```

In this sample code, the client would include the key generated when it started the authorization request (as shown in step one in the figures above). Then, the Curity Identity Server would be able to verify that the client exchanging the code (step five in the previous diagram) is the original one. It would do this by using the signing algorithm included in (5) and the code verifier in (6). If the result was the same as the hash in (3), then the request initiator and the code exchanger are the same entity, and tokens are issued; otherwise, an error results.

To implement this, the client would use pseudocode such as the following when it starts the authorization request:

## **[PKCE flow](https://stackoverflow.com/questions/72599321/unable-to-generate-authorization-code-via-pkce-flow-for-spa)** for SPA

## generate code challenge

To generate code_challenge, you can make use of this **[tool](https://tonyxu-io.github.io/pkce-generator/)** like below:

![alt](https://i.stack.imgur.com/mqBVY.png)
