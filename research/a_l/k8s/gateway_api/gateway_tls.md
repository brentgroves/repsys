# **[Gateway TLS](https://gateway-api.sigs.k8s.io/guides/tls/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Experimental Channel

The TLSRoute and BackendTLSPolicy resources described below are currently only included in the "Experimental" channel of Gateway API. For more information on release channels, refer to our versioning guide.

## TLS Configuration

Gateway API allows for a variety of ways to configure TLS. This document lays out various TLS settings and gives general guidelines on how to use them effectively.

Although this doc covers the most common forms of TLS configuration with Gateway API, some implementations may also offer implementation-specific extensions that allow for different or more advanced forms of TLS configuration. In addition to this documentation, it's worth reading the TLS documentation for whichever implementation(s) you're using with Gateway API.

## Client/Server and TLS

![client](https://gateway-api.sigs.k8s.io/images/tls-overview.svg)

For Gateways, there are two connections involved:

- **downstream:** This is the connection between the client and the Gateway.
- **upstream:** This is the connection between the Gateway and backend resources specified by routes. These backend resources will usually be Services.

With Gateway API, TLS configuration of downstream and upstream connections is managed independently.

For downstream connections, depending on the Listener Protocol, different TLS modes and Route types are supported.

| Listener Protocol | TLS Mode    | Route Type Supported |
|-------------------|-------------|----------------------|
| TLS               | Passthrough | TLSRoute             |
| TLS               | Terminate   | TCPRoute             |
| HTTPS             | Terminate   | HTTPRoute            |
| GRPC              | Terminate   | GRPCRoute            |

Please note that in case of Passthrough TLS mode, no TLS settings take effect as the TLS session from the client is NOT terminated at the Gateway, but rather passes through the Gateway, encrypted.

For upstream connections, BackendTLSPolicy is used, and neither listener protocol nor TLS mode apply to the upstream TLS configuration. For HTTPRoute, the use of both Terminate TLS mode and BackendTLSPolicy is supported. Using these together provides what is commonly known as a connection that is terminated and then re-encrypted at the Gateway.

## Downstream TLS

Downstream TLS settings are configured using listeners at the Gateway level.

## Listeners and TLS

Listeners expose the TLS setting on a per domain or subdomain basis. TLS settings of a listener are applied to all domains that satisfy the hostname criteria.

In the following example, the Gateway serves the TLS certificate defined in the default-cert Secret resource for all requests. Although the example refers to HTTPS protocol, one can also use the same feature for TLS-only protocol along with TLSRoutes.

```yaml
listeners:
- protocol: HTTPS # Other possible value is `TLS`
  port: 443
  tls:
    mode: Terminate # If protocol is `TLS`, `Passthrough` is a possible mode
    certificateRefs:
    - kind: Secret
      group: ""
      name: default-cert
```

## Examples

## Listeners with different certificates

In this example, the Gateway is configured to serve the foo.example.com and bar.example.com domains. The certificate for these domains is specified in the Gateway.

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: tls-basic
spec:
  gatewayClassName: example
  listeners:
  - name: foo-https
    protocol: HTTPS
    port: 443
    hostname: foo.example.com
    tls:
      certificateRefs:
      - kind: Secret
        group: ""
        name: foo-example-com-cert
  - name: bar-https
    protocol: HTTPS
    port: 443
    hostname: bar.example.com
    tls:
      certificateRefs:
      - kind: Secret
        group: ""
        name: bar-example-com-cert
```
