# **[BackendTLSPolicyy](https://gateway-api.sigs.k8s.io/api-types/backendtlspolicy/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

BackendTLSPolicy is a Gateway API type for specifying the TLS configuration of the connection from the Gateway to a backend pod/s via the Service API object.

## Background

BackendTLSPolicy specifically addresses the configuration of TLS in order to convey HTTPS from the Gateway dataplane to the backend. This is referred to as "backend TLS termination" and enables the Gateway to know how to connect to a backend pod that has its own certificate.

While there are other API objects provided for TLS to be configured for passthrough and edge termination, this API object allows users to specifically configure backend TLS termination. For more information on TLS configuration in Gateway API, see **[TLS Configuration](https://gateway-api.sigs.k8s.io/guides/tls/)**.

**[types](https://gateway-api.sigs.k8s.io/images/tls-termination-types.png)**

BackendTLSPolicy is a Direct PolicyAttachment without defaults or overrides, applied to a Service that accesses a backend, where the BackendTLSPolicy resides in the same namespace as the Service to which it is applied. The BackendTLSPolicy and the Service must reside in the same namespace in order to prevent the complications involved with sharing trust across namespace boundaries.

All Gateway API Routes that point to a referenced Service should respect a configured BackendTLSPolicy.

## Spec

The specification of a BackendTLSPolicy consists of:

- **TargetRefs** - Defines the targeted API object of the policy. Only Service is allowed.
- **Validation** - Defines the configuration for TLS, including hostname, CACertificateRefs, and WellKnownCACertificates.
- **Hostname** - Defines the Server Name Indication (SNI) that the Gateway uses to connect to the backend.
- **CACertificateRefs** - Defines one or more references to objects that contain PEM-encoded TLS certificates, which are used to establish a TLS handshake between the Gateway and backend Pod. Either CACertficateRefs or WellKnownCACertificates may be specified, but not both.
- **WellKnownCACertificates** - Specifies whether system CA certificates may be used in the TLS handshake between the Gateway and backend Pod. Either CACertficateRefs or WellKnownCACertificates may be specified, but not both.
The following chart outlines the object definitions and relationship:

## Targeting backends

A BackendTLSPolicy targets a backend Pod (or set of Pods) via one or more TargetRefs to a Service. This TargetRef is a required object reference that specifies a Service by its Name, Kind (Service), and optionally its Namespace and Group. TargetRefs identify the Service/s for which your HTTPRoute requires TLS.

Server Name Indication, often abbreviated SNI, is an extension to TLS that allows multiple hostnames to be served over HTTPS from the same IP address.

## BackendTLSPolicyValidation

A BackendTLSPolicyValidation is the specification for the BackendTLSPolicy and defines the configuration for TLS, including hostname (for server name indication) and certificates.

## Hostname

Hostname defines the server name indication (SNI) the Gateway should use in order to connect to the backend, and must match the certificate served by the backend pod. A hostname is the fully qualified domain name of a network host, as defined by RFC 3986. Note the following deviations from the “host” part of the URI as defined in the RFC:

IP addresses are not allowed.

Restrictions

Wildcard hostnames are not allowed.
Certificates¶
The BackendTLSPolicyValidation must contain a certificate reference of some kind, and contains two ways to configure the certificate to use for backend TLS, CACertificateRefs and WellKnownCACertificates. Only one of these may be used per BackendTLSPolicyValidation.

## CACertficateRefs

CACertificateRefs refer to one or more PEM-encoded TLS certificates.

## Restrictions

Cross-namespace certificate references are not allowed.

## WellKnownCACertificates

If you are working in an environment where specific TLS certificates are not required, and your Gateway API implementation allows system or default certificates to be used, e.g. in a development environment, you may set WellKnownCACertificates to "System" to tell the Gateway to use a set of trusted CA Certificates. There may be some variation in which system certificates are used by each implementation. Refer to documentation from your implementation of choice for more information.

## PolicyStatus

Status defines the observed state of the BackendTLSPolicy and is not user-configurable. Check status in the same way you do for other Gateway API objects to verify correct operation. Note that the status in BackendTLSPolicy uses PolicyAncestorStatus to allow you to know which parentReference set that particular status.
