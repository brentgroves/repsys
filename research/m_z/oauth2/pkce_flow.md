# **[PKCE]<https://blog.postman.com/what-is-pkce/>)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../research_list.md)**\
**[Back Main](../../../README.md)**

PKCE, which stands for “Proof of Key Code Exchange” and is pronounced “pixy,” is an extension of the OAuth 2.0 protocol that helps prevent code interception attacks. OAuth 2.0 allows users to share their data securely between different applications, and PKCE provides an additional security layer on top of it.

Here, we will discuss how PKCE enhances the security of authorization code grant flows, explore some of the benefits, best practices, and challenges of working with PKCE, and highlight how the Postman API Platform can help simplify PKCE and OAuth workflows.

If you’re not already familiar with OAuth 2.0, we recommend that you review our “What is OAuth 2.0?” article before proceeding.

## How does PKCE work?

Before we discuss how PKCE works, you must first understand the authorization code grant flow—as well as its security vulnerabilities.

When an authorization request is made, the authorization code grant type requires the authorization server to generate an authorization code, which is returned to the client application via a redirect URL. This code can then be exchanged for an access token, which can be used to access the user’s data.

An attacker can intercept the authorization code that is sent back to the client and exchange it for an access token, which can cause serious data leaks or breaches. One popular method malicious actors use to intercept authorization codes is by registering a malicious application on the user’s device. This malicious application will register and use the same custom URL scheme as the client application, allowing it to intercept redirect URLs on that URL scheme and extract the authorization code:

![ACG](https://s47089.pcdn.co/wp-content/uploads/2023/10/Authorization-code-grant-flow.png)

PKCE addresses this vulnerability by introducing a new flow and three new parameters: Code Verifier, Code Challenge, and the Code Challenge Method. Below is a breakdown of a PKCE authentication flow.

Before an authorization request is made, the client creates and stores a secret called the “code verifier.” The code verifier is a cryptographically random string that the client uses to identify itself when exchanging an authorization code for an access token. It has a minimum length of 43 characters and a maximum length of 128 characters.

- Plain: In the plain mode, the code challenge is equal to the code verifier; nothing changes.
- S256: In S256 mode, the SHA-256 hash of the code verifier is encoded using the BASE64URL encoding. The S256 method is recommended by the specification and should be considered before the plain method.

Next, the code challenge is securely stored by the authorization server, and an authorization code is returned with the redirect URL as usual. When the client wants to exchange this authorization code for the access token, it sends a request that includes the initial code verifier. The server then hashes the code verifier using SHA-256 (if it has a code challenge method of S256) and encodes the hashed value as a BASE64URL. The corresponding value is then compared to the code challenge. If they match, an access token is issued. Otherwise, an error message is returned.

This flow ensures that a malicious third-party application cannot exchange an authorization code for an access token, since the malicious application does not have the code verifier. Intercepting the code challenge is also useless because SHA256 is a one-way hashing algorithm and cannot be decrypted.

This diagram represents the PKCE protocol flow:

![pkce](https://s47089.pcdn.co/wp-content/uploads/2023/09/PKCE-protocol-flow-768x441.png)

The following step-by-step example illustrates using the authorization code flow with PKCE.

## Step-by-step

The high level overview is this:
