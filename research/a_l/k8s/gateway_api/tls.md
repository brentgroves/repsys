# **[TLS](https://gateway-api.sigs.k8s.io/guides/tls)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## K8s Downstream TLS

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

### Listeners with different certificates

In this example, the Gateway is configured to serve the foo.example.com and bar.example.com domains. The certificate for these domains is specified in the Gateway.

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: tls-basic
spec:
  gatewayClassName: acme-lb
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

## Wildcard TLS listeners

In this example, the Gateway is configured with a wildcard certificate for *.example.com and a different certificate for foo.example.com. Since a specific match takes priority, the Gateway will serve foo-example-com-cert for requests to foo.example.com and wildcard-example-com-cert for all other requests.

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: wildcard-tls-gateway
spec:
  gatewayClassName: acme-lb
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
  - name: wildcard-https
    protocol: HTTPS
    port: 443
    hostname: "*.example.com"
    tls:
      certificateRefs:
      - kind: Secret
        group: ""
        name: wildcard-example-com-cert
```

## Cross namespace certificate references

In this example, the Gateway is configured to reference a certificate in a different namespace. This is allowed by the ReferenceGrant created in the target namespace. Without that ReferenceGrant, the cross-namespace reference would be invalid.

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: Gateway
metadata:
  name: cross-namespace-tls-gateway
  namespace: gateway-api-example-ns1
spec:
  gatewayClassName: acme-lb
  listeners:
  - name: https
    protocol: HTTPS
    port: 443
    hostname: "*.example.com"
    tls:
      certificateRefs:
      - kind: Secret
        group: ""
        name: wildcard-example-com-cert
        namespace: gateway-api-example-ns2
---
apiVersion: gateway.networking.k8s.io/v1beta1
kind: ReferenceGrant
metadata:
  name: allow-ns1-gateways-to-ref-secrets
  namespace: gateway-api-example-ns2
spec:
  from:
  - group: gateway.networking.k8s.io
    kind: Gateway
    namespace: gateway-api-example-ns1
  to:
  - group: ""
    kind: Secret
```

## Upstream TLS

Upstream TLS settings are configured using the experimental BackendTLSPolicy attached to a Service via a target reference.

This resource can be used to describe the SNI the Gateway should use to connect to the backend and how the certificate served by the backend Pod(s) should be verified.

## TargetRefs and TLS

BackendTLSPolicy contains specification for the TargetRef and TLS. TargetRef is required and identifies the Service for which your HTTPRoute requires TLS. The TLS configuration contains a required Hostname, and either CACertRefs or WellKnownCACerts.

Hostname refers to the SNI the Gateway should use to connect to the backend, and must match the certificate served by the backend pod.

CACertRefs refer to one or more PEM-encoded TLS certificates. If there are no specific certificates to use, then you must set WellKnownCACerts to "System" to tell the Gateway to use a set of trusted CA Certificates. There may be some variation in which system certificates are used by each implementation. Refer to documentation from your implementation of choice for more information.

Restrictions

Cross-namespace certificate references are not allowed.
Wildcard hostnames are not allowed.

## Examples BackendTLSPolicy

## Using System Certificates

In this example, the BackendTLSPolicy is configured to use system certificates to connect with a TLS-encrypted upstream connection where Pods backing the dev Service are expected to serve a valid certificate for dev.example.com.

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: BackendTLSPolicy
metadata:
  name: tls-upstream-dev
spec:
  targetRef:
    kind: Service
    name: dev-service
    group: ""
  tls:
    wellKnownCACerts: "System"
    hostname: dev.example.com
```

## Using Explicit CA Certificates

In this example, the BackendTLSPolicy is configured to use certificates defined in the configuration map auth-cert to connect with a TLS-encrypted upstream connection where Pods backing the auth Service are expected to serve a valid certificate for auth.example.com.

```yaml
apiVersion: gateway.networking.k8s.io/v1alpha2
kind: BackendTLSPolicy
metadata:
  name: tls-upstream-auth
spec:
  targetRef:
    kind: Service
    name: auth-service
    group: ""
  tls:
    caCertRefs:
      - kind: ConfigMapReference
        name: auth-cert
        group: ""
    hostname: auth.example.com
```

## Extensions

Gateway TLS configurations provides an options map to add additional TLS settings for implementation-specific features. Some examples of features that could go in here would be TLS version restrictions, or ciphers to use.

 Back to top
