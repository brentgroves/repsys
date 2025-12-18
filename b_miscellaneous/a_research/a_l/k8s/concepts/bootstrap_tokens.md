# **[Bootstrap tokens](https://kubernetes.io/docs/reference/access-authn-authz/bootstrap-tokens/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Authenticating with Bootstrap Tokens

FEATURE STATE: Kubernetes v1.18 [stable]
Bootstrap tokens are a simple bearer token that is meant to be used when creating new clusters or joining new nodes to an existing cluster. It was built to support kubeadm, but can be used in other contexts for users that wish to start clusters without kubeadm. It is also built to work, via RBAC policy, with the kubelet TLS Bootstrapping system.

**[bearer token](https://oauth.net/2/bearer-tokens/)**\
RFC 6750: OAuth 2.0 Bearer Token Usage
tools.ietf.org/html/rfc6750

Bearer Tokens are the predominant type of access token used with OAuth 2.0.

A Bearer Token is an opaque string, not intended to have any meaning to clients using it. Some servers will issue tokens that are a short string of hexadecimal characters, while others may use structured tokens such as JSON Web Tokens.

Related Specs:

Token Introspection (RFC 7662)
Token Revocation (RFC 7009)
JSON Web Token (RFC 7519)
JWT Profile for Access Tokens
More resources

OAuth 2.0 Access Tokens
Access Tokens (oauth.com)

## Bootstrap Tokens Overview

Bootstrap Tokens are defined with a specific type (bootstrap.kubernetes.io/token) of secrets that lives in the kube-system namespace. These Secrets are then read by the Bootstrap Authenticator in the API Server. Expired tokens are removed with the TokenCleaner controller in the Controller Manager. The tokens are also used to create a signature for a specific ConfigMap used in a "discovery" process through a BootstrapSigner controller.

## Token Format

Bootstrap Tokens take the form of abcdef.0123456789abcdef. More formally, they must match the regular expression [a-z0-9]{6}\.[a-z0-9]{16}.

The first part of the token is the "Token ID" and is considered public information. It is used when referring to a token without leaking the secret part used for authentication. The second part is the "Token Secret" and should only be shared with trusted parties.

## Enabling Bootstrap Token Authentication

The Bootstrap Token authenticator can be enabled using the following flag on the API server:

```--enable-bootstrap-token-auth```

When enabled, bootstrapping tokens can be used as bearer token credentials to authenticate requests against the API server.

```Authorization: Bearer 07401b.f395accd246ae52d```

Tokens authenticate as the username system:bootstrap:<token id> and are members of the group system:bootstrappers. Additional groups may be specified in the token's Secret.

Expired tokens can be deleted automatically by enabling the tokencleaner controller on the controller manager.

```--controllers=*,tokencleaner```
