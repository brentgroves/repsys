# OpenID Connect Authorization Code Flow

## references

<https://curity.io/resources/learn/openid-code-flow/>
https://learn.microsoft.com/en-us/entra/identity-platform/v2-oauth2-auth-code-flow

## What is the OpenID Connect Authorization Code Flow?

The Authorization Code Flow is the most advanced flow in OpenID Connect. It is also the most flexible, that allows both mobile and web clients to obtain tokens securely.

It is split into two parts, the authorization flow that runs in the browser where the client redirects to the OpenID Provider (OP) and the OP redirects back when done, and the token flow which is a back-channel call from the client to the token endpoint of the OP.

## Authorization Endpoint

![](https://curity.io/images/resources/standards/oauth/flows/code-flow-01.svg)

1. Browser redirects to the authorization endpoint at the Token Service of the Authorization Server.
2. If the user is not yet authenticated, the Token Service redirects to the Authentication Service. Note that these two entities, while running in the same product, are separate conceptually.
3. The User authenticates, and is redirected back to the Token Service.
4. The Authorization Server issues a one time token called the authorization code.

## Token Endpoint

![](https://curity.io/images/resources/standards/oauth/flows/code-flow-02.svg)

1. The client backend makes a POST request to the token endpoint with the authorization code and client credentials.
2. The Authorization Server validates the code and the credentials. It returns an access token and optionally a refresh token if configured.

## User Authentication

The user is authenticated during this part of the flow. This may involve multiple factors and is not defined by the specification. In the Curity Identity Server all user authentication is configured in the Authentication Service and is configured per client.

## Client Authentication

The client authenticates in the Token part of the flow. Client authentication can be done in many ways, the most common being client secret. The following authentication mechanisms are supported in Curity:

No authentication (public client)
Secret in post body
Secret using basic Authentication
Client Assertion JWT
Mutual TLS (mTLS) client certificate
Asymmetric Key
Symmetric Key
Credential Manager
JWKS URI

## The Authorization Code

Once the authorization flow is done, the redirect back to the client contains an authorization code. This is a nonce, not-more-than-once token, that is to be used a single time. It has a short lifespan (usually less than 30 seconds) and must be presented in the token part of the flow.

## The Access Token

The Access Token is returned by the token endpoint. It is the token that later can be used to call the API and gain access. It is a Bearer token, and must not be sent to untrusted parties. The access token usually have a lifetime of 5-30 minutes.

## The Refresh Token

The Refresh Token is issued if the client is configured to have refresh tokens. This token can be used to obtain more access tokens once the first one expires. The refresh token may have a very long lifetime, ranging from hours to years.

## The Authorization Endpoint Request

```bash
Method: GET
Agent: Browser
Response Type: Redirect to pre-registered callback at client with query parameters
```

<https://curity.io/resources/learn/openid-code-flow/>

## Response

A redirect back to the “redirect_uri”. Response parameters are provided on the query string by default or as defined by the response_mode in the request.

| Parameter |                  Value                 | Mandatory |                                                                                                    Description                                                                                                    |
|:---------:|:--------------------------------------:|:---------:|:-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------:|
| state     | The same value as given in the request | yes*      | The same value as the client sent in the request. Use to match request to the redirect response. *Mandatory if the state was sent in the request                                                                  |
| iss       | Issuer Identifier                      | yes*      | The issuer identifier of the authorization server where the authorization request was sent to. *Mandatory if the authorization server supports the OAuth 2.0 Authorization Server Issuer Identifier specification |
| code      | An Authorization Code                  | yes       | An authorization code nonce, to be used in the token request.                                                                                                                                                     |

## The Token Endpoint Request

```bash
Request Parameters
Method: POST
Content-Type: application/x-www-form-urlencoded
Agent: HTTP client
Response Type: json
```

|   Parameter   |                     Value                    | Mandatory |                                                                   Description                                                                  |
|:-------------:|:--------------------------------------------:|:---------:|:----------------------------------------------------------------------------------------------------------------------------------------------:|
| client_id     | The Client ID                                | yes       | The ID of the requesting client                                                                                                                |
| client_secret | The client secret                            | yes*      | The secret of the client. *Mandatory if client authentication is of type secret, and the authentication is not done using basic authentication |
| grant_type    | authorization_code                           | yes       | Tells the token endpoint to do the second part of the code flow.                                                                               |
| code          | The authorization code                       | yes       | The code given in the response of the Authorization request                                                                                    |
| redirect_uri  | The callback URL of the Client               | no*       | The same redirect URI as was sent in the authorize request. *Required if redirect_uri was sent in the authorize request.                       |
| code_verifier | The verifier that matches the code_challenge | no*       | *Mandatory if code_challenge was used in the authorize request.                                                                                |

## Response Type

Response Type: application/json

|   Parameter   |             Value            | Mandatory |                                                      Description                                                     |
|:-------------:|:----------------------------:|:---------:|:--------------------------------------------------------------------------------------------------------------------:|
| access_token  | A newly issued access token  | yes       | The resulting access token for the code flow                                                                         |
| refresh_token | A newly issued refresh token | no        | Only issued if the client is configured to receive refresh tokens                                                    |
| expires_in    | Expiration in seconds        | yes       | The time to live of the access token in seconds                                                                      |
| scope         | Space separated string       | no        | If not present the requested scopes where issued. If present the issued scopes may differ from the requested scopes. |
| token_type    | Bearer or other token type   | yes       | Describes how the token can be used. Most commonly Bearer token usage.                                               |
| id_token      | A newly issued ID token      | yes       | The resulting ID token for the code flow.                                                                            |
