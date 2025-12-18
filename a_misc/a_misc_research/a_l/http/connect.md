# **[connect](https://http.dev/connect)**

The HTTP CONNECT method is a type of HTTP request that is used to establish a tunnel to the origin server, as specified by the target of the HTTP request. Once the HTTP Connection is made, it is intended to be used for the forwarding of data packets in both directions. This can be used to create an end-to-end virtual HTTP connection through one or more proxies.

In this example, the client is requesting a HTTP Connection to the origin server on port 80. The Proxy-Authorization request HTTP header includes a username:password pair using the basic Authentication protocol.

## Request

```http
CONNECT www.example.re:80 HTTP/1.1
Host: www.example.re:80
Proxy-Authorization: basic RXhhbXBsZTphaQ==
```
