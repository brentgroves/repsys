# **[Virtual Service](https://istio.io/latest/docs/reference/config/networking/virtual-service/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Configuration affecting traffic routing. Here are a few terms useful to define in the context of traffic routing.

**Service** a unit of application behavior bound to a unique name in a service registry. Services consist of multiple **network endpoints** implemented by workload instances **running on pods, containers, VMs** etc.

**Service versions** (a.k.a. subsets) - In a continuous deployment scenario, for a given service, there can be distinct subsets of instances running different variants of the application binary. These variants are not necessarily different API versions. They could be iterative changes to the same service, deployed in different environments (prod, staging, dev, etc.). Common scenarios where this occurs include A/B testing, canary rollouts, etc. The choice of a particular version can be decided based on various criterion (headers, url, etc.) and/or by weights assigned to each version. Each service has a default version consisting of all its instances.

**Source** - A downstream client calling a service.

**Host** - The address used by a client when attempting to connect to a service.

**Access model** - Applications address only the destination service (Host) without knowledge of individual **service versions (subsets)**. The actual **choice of the version is determined by the proxy/sidecar**, enabling the application code to decouple itself from the evolution of dependent services.

A **VirtualService** defines a **set of traffic routing rules** to apply when a host is addressed. Each routing rule defines matching criteria for traffic of a **specific protocol**. If the traffic is matched, then it is **sent to a named destination service (or subset/version of it)** defined in the registry.

The **source of traffic can also be matched** in a routing rule. This allows routing to be customized for specific client contexts.

The following example on Kubernetes, **routes all HTTP traffic by default to pods of the reviews service with label “version: v1”**. In addition, HTTP requests with **path starting with /wpcatalog/ or /consumercatalog/ will be rewritten to /newcatalog** and sent to pods with label “version: v2”.

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: reviews-route
spec:
  hosts:
  - reviews.prod.svc.cluster.local
  http:
  - name: "reviews-v2-routes"
    match:
    - uri:
        prefix: "/wpcatalog"
    - uri:
        prefix: "/consumercatalog"
    rewrite:
      uri: "/newcatalog"
    route:
    - destination:
        host: reviews.prod.svc.cluster.local
        subset: v2
  - name: "reviews-v1-route"
    route:
    - destination:
        host: reviews.prod.svc.cluster.local
        subset: v1
```

A subset/version of a route destination is identified with a reference to a named service subset which must be declared in a corresponding DestinationRule.

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: reviews-destination
spec:
  host: reviews.prod.svc.cluster.local
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

## VirtualService

Configuration affecting traffic routing

| Field    | Type        | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                | Required |
|----------|-------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| hosts    | string[]    | The destination hosts to which traffic is being sent. Could be a DNS name with wildcard prefix or an IP address. Depending on the platform, short-names can also be used instead of a FQDN (i.e. has no dots in the name). In such a scenario, the FQDN of the host would be derived based on the underlying platform. A single VirtualService can be used to describe all the traffic properties of the corresponding hosts, including those for multiple HTTP and TCP ports. Alternatively, the traffic properties of a host can be defined using more than one VirtualService, with certain caveats. Refer to the Operations Guide for details. Note for Kubernetes users: When short names are used (e.g. “reviews” instead of “reviews.default.svc.cluster.local”), Istio will interpret the short name based on the namespace of the rule, not the service. A rule in the “default” namespace containing a host “reviews” will be interpreted as “reviews.default.svc.cluster.local”, irrespective of the actual namespace associated with the reviews service. To avoid potential misconfigurations, it is recommended to always use fully qualified domain names over short names. The hosts field applies to both HTTP and TCP services. Service inside the mesh, i.e., those found in the service registry, must always be referred to using their alphanumeric names. IP addresses are allowed only for services defined via the Gateway. Note: It must be empty for a delegate VirtualService. | No       |
| gateways | string[]    | The names of gateways and sidecars that should apply these routes. Gateways in other namespaces may be referred to by <gateway namespace>/<gateway name>; specifying a gateway with no namespace qualifier is the same as specifying the VirtualService’s namespace. A single **VirtualService is used for sidecars inside the mesh as well as for one or more gateways.** The selection condition imposed by this field can be overridden using the source field in the match conditions of protocol-specific routes. The reserved word mesh is used to imply all the sidecars in the mesh. When this field is omitted, the default gateway (mesh) will be used, which would apply the rule to all sidecars in the mesh. If a list of gateway names is provided, the rules will apply only to the gateways. To apply the rules to both gateways and sidecars, specify mesh as one of the gateway names.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       | No       |
| http     | HTTPRoute[] | An ordered list of route rules for HTTP traffic. HTTP routes will be applied to platform service ports using HTTP/HTTP2/GRPC protocols, gateway ports with protocol HTTP/HTTP2/GRPC/TLS-terminated-HTTPS and service entry ports using HTTP/HTTP2/GRPC protocols. The first rule matching an incoming request is used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     | No       |
| tls      | TLSRoute[]  | An ordered list of route rule for non-terminated TLS & HTTPS traffic. Routing is typically performed using the SNI value presented by the ClientHello message. TLS routes will be applied to platform service ports named ‘https-’, ’tls-’, unterminated gateway ports using HTTPS/TLS protocols (i.e. with “passthrough” TLS mode) and service entry ports using HTTPS/TLS protocols. The first rule matching an incoming request is used. NOTE: Traffic ‘https-’ or ’tls-’ ports without associated virtual service will be treated as opaque TCP traffic.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | No       |
| tcp      | TCPRoute[]  | An ordered list of route rules for opaque TCP traffic. TCP routes will be applied to any port that is not a HTTP or TLS port. The first rule matching an incoming request is used.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         | No       |
| exportTo | string[]    | A list of namespaces to which this virtual service is exported. Exporting a virtual service allows it to be used by sidecars and gateways defined in other namespaces. This feature provides a mechanism for service owners and mesh administrators to control the visibility of virtual services across namespace boundaries. If no namespaces are specified then the virtual service is exported to all namespaces by default. The value “.” is reserved and defines an export to the same namespace that the virtual service is declared in. Similarly the value “*” is reserved and defines an export to all namespaces.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               | No       |

## Destination

Destination indicates the network addressable service to which the request/connection will be sent after processing a routing rule. The destination.host should unambiguously refer to a service in the service registry. Istio’s service registry is composed of all the services found in the platform’s service registry (e.g., Kubernetes services, Consul services), as well as services declared through the ServiceEntry resource.

Note for Kubernetes users: When short names are used (e.g. “reviews” instead of “reviews.default.svc.cluster.local”), Istio will interpret the short name based on the namespace of the rule, not the service. A rule in the “default” namespace containing a host “reviews” will be interpreted as “reviews.default.svc.cluster.local”, irrespective of the actual namespace associated with the reviews service. To avoid potential misconfigurations, it is recommended to always use fully qualified domain names over short names.

The following Kubernetes example routes all traffic by default to pods of the reviews service with label “version: v1” (i.e., subset v1), and some to subset v2, in a Kubernetes environment.

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: reviews-route
  namespace: foo
spec:
  hosts:
  - reviews # interpreted as reviews.foo.svc.cluster.local
  http:
  - match:
    - uri:
        prefix: "/wpcatalog"
    - uri:
        prefix: "/consumercatalog"
    rewrite:
      uri: "/newcatalog"
    route:
    - destination:
        host: reviews # interpreted as reviews.foo.svc.cluster.local
        subset: v2
  - route:
    - destination:
        host: reviews # interpreted as reviews.foo.svc.cluster.local
        subset: v1
```

And the associated DestinationRule

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: reviews-destination
  namespace: foo
spec:
  host: reviews # interpreted as reviews.foo.svc.cluster.local
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
```

The following VirtualService sets a timeout of 5s for all calls to productpage.prod.svc.cluster.local service in Kubernetes. Notice that there are no subsets defined in this rule. Istio will fetch all instances of productpage.prod.svc.cluster.local service from the service registry and populate the sidecar’s load balancing pool. Also, notice that this rule is set in the istio-system namespace but uses the fully qualified domain name of the productpage service, productpage.prod.svc.cluster.local. Therefore the rule’s namespace does not have an impact in resolving the name of the productpage service.

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: my-productpage-rule
  namespace: istio-system
spec:
  hosts:
  - productpage.prod.svc.cluster.local # ignores rule namespace
  http:
  - timeout: 5s
    route:
    - destination:
        host: productpage.prod.svc.cluster.local
```

To control routing for traffic bound to services outside the mesh, external services must first be added to Istio’s internal service registry using the ServiceEntry resource. VirtualServices can then be defined to control traffic bound to these external services. For example, the following rules define a Service for wikipedia.org and set a timeout of 5s for HTTP requests.

```yaml
apiVersion: networking.istio.io/v1
kind: ServiceEntry
metadata:
  name: external-svc-wikipedia
spec:
  hosts:
  - wikipedia.org
  location: MESH_EXTERNAL
  ports:
  - number: 80
    name: example-http
    protocol: HTTP
  resolution: DNS
---
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: my-wiki-rule
spec:
  hosts:
  - wikipedia.org
  http:
  - timeout: 5s
    route:
    - destination:
        host: wikipedia.org
```

| Field  | Type         | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | Required |
|--------|--------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| host   | string       | The name of a service from the service registry. Service names are looked up from the platform’s service registry (e.g., Kubernetes services, Consul services, etc.) and from the hosts declared by ServiceEntry. Traffic forwarded to destinations that are not found in either of the two, will be dropped. Note for Kubernetes users: When short names are used (e.g. “reviews” instead of “reviews.default.svc.cluster.local”), Istio will interpret the short name based on the namespace of the rule, not the service. A rule in the “default” namespace containing a host “reviews” will be interpreted as “reviews.default.svc.cluster.local”, irrespective of the actual namespace associated with the reviews service. To avoid potential misconfiguration, it is recommended to always use fully qualified domain names over short names. | Yes      |
| subset | string       | The name of a subset within the service. Applicable only to services within the mesh. The subset must be defined in a corresponding DestinationRule.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 | No       |
| port   | PortSelector | Specifies the port on the host that is being addressed. If a service exposes only a single port it is not required to explicitly select the port.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    | No       |

## HTTPRoute

Describes match conditions and actions for routing HTTP/1.1, HTTP2, and gRPC traffic. See VirtualService for usage examples.

## Field Type Description

| Field            | Type                   | Description                                                                                                                                                                                                                                                                                                                                                                                                                                                | Required |
|------------------|------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| name             | string                 | The name assigned to the route for debugging purposes. The route’s name will be concatenated with the match’s name and will be logged in the access logs for requests matching this route/match.                                                                                                                                                                                                                                                           | No       |
| match            | HTTPMatchRequest[]     | Match conditions to be satisfied for the rule to be activated. All conditions inside a single match block have AND semantics, while the list of match blocks have OR semantics. The rule is matched if any one of the match blocks succeed.                                                                                                                                                                                                                | No       |
| route            | HTTPRouteDestination[] | A HTTP rule can either return a direct_response, redirect or forward (default) traffic. The forwarding target can be one of several versions of a service (see glossary in beginning of document). Weights associated with the service version determine the proportion of traffic it receives.                                                                                                                                                            | No       |
| redirect         | HTTPRedirect           | A HTTP rule can either return a direct_response, redirect or forward (default) traffic. If traffic passthrough option is specified in the rule, route/redirect will be ignored. The redirect primitive can be used to send a HTTP 301 redirect to a different URI or Authority.                                                                                                                                                                            | No       |
| directResponse   | HTTPDirectResponse     | A HTTP rule can either return a direct_response, redirect or forward (default) traffic. Direct Response is used to specify a fixed response that should be sent to clients. It can be set only when Route and Redirect are empty.                                                                                                                                                                                                                          | No       |
| delegate         | Delegate               | Delegate is used to specify the particular VirtualService which can be used to define delegate HTTPRoute. It can be set only when Route and Redirect are empty, and the route rules of the delegate VirtualService will be merged with that in the current one. NOTE: Only one level delegation is supported. The delegate’s HTTPMatchRequest must be a strict subset of the root’s, otherwise there is a conflict and the HTTPRoute will not take effect. | No       |
| rewrite          | HTTPRewrite            | Rewrite HTTP URIs and Authority headers. Rewrite cannot be used with Redirect primitive. Rewrite will be performed before forwarding.                                                                                                                                                                                                                                                                                                                      | No       |
| timeout          | Duration               | Timeout for HTTP requests, default is disabled.                                                                                                                                                                                                                                                                                                                                                                                                            | No       |
| retries          | HTTPRetry              | Retry policy for HTTP requests. Note: the default cluster-wide retry policy, if not specified, is: attempts: 2 retryOn: "connect-failure,refused-stream,unavailable,cancelled,503"   This can be customized in Mesh Config defaultHttpRetryPolicy.                                                                                                                                                                                                         | No       |
| fault            | HTTPFaultInjection     | Fault injection policy to apply on HTTP traffic at the client side. Note that timeouts or retries will not be enabled when faults are enabled on the client side.                                                                                                                                                                                                                                                                                          | No       |
| mirror           | Destination            | Mirror HTTP traffic to a another destination in addition to forwarding the requests to the intended destination. Mirrored traffic is on a best effort basis where the sidecar/gateway will not wait for the mirrored cluster to respond before returning the response from the original destination. Statistics will be generated for the mirrored destination.                                                                                            | No       |
| mirrors          | HTTPMirrorPolicy[]     | Specifies the destinations to mirror HTTP traffic in addition to the original destination. Mirrored traffic is on a best effort basis where the sidecar/gateway will not wait for the mirrored destinations to respond before returning the response from the original destination. Statistics will be generated for the mirrored destination.                                                                                                             | No       |
| mirrorPercentage | Percent                | Percentage of the traffic to be mirrored by the mirror field. If this field is absent, all the traffic (100%) will be mirrored. Max value is 100.                                                                                                                                                                                                                                                                                                          | No       |
| corsPolicy       | CorsPolicy             | Cross-Origin Resource Sharing policy (CORS). Refer to CORS for further details about cross origin resource sharing.                                                                                                                                                                                                                                                                                                                                        | No       |
| headers          | Headers                | Header manipulation rules                                                                                                                                                                                                                                                                                                                                                                                                                                  | No       |

## Delegate

Describes the delegate VirtualService. The following routing rules forward the traffic to /productpage by a delegate VirtualService named productpage, forward the traffic to /reviews by a delegate VirtualService named reviews.

```yaml
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: bookinfo
spec:
  hosts:
  - "bookinfo.com"
  gateways:
  - mygateway
  http:
  - match:
    - uri:
        prefix: "/productpage"
    delegate:
       name: productpage
       namespace: nsA
  - match:
    - uri:
        prefix: "/reviews"
    delegate:
        name: reviews
        namespace: nsB
```
