# [Client credential flow](https://pkg.go.dev/golang.org/x/oauth2/clientcredentials)**

## references

<https://cs.opensource.google/go/x/oauth2/+/refs/tags/v0.18.0:clientcredentials/clientcredentials.go>

## Overview

Package clientcredentials implements the OAuth2.0 "client credentials" token flow, also known as the "two-legged OAuth 2.0".

This should be used when the client is acting on its own behalf or when the client is the resource owner. It may also be used when requesting access to protected resources based on an authorization previously arranged with the authorization server.

See <https://tools.ietf.org/html/rfc6749#section-4.4>
