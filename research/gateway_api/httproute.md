# HTTPRoute

## references

<https://gateway-api.sigs.k8s.io/api-types/httproute/>

## HTTPRoute Standard Channel in v0.5.0+

HTTPRoute is a Gateway API type for specifying routing behavior of HTTP requests from a Gateway listener to an API object, i.e. Service.

Spec
The specification of an HTTPRoute consists of:

- ParentRefs- Define which Gateways this Route wants to be attached to.
- Hostnames (optional)- Define a list of hostnames to use for matching the Host header of HTTP requests.
- Rules- Define a list of rules to perform actions against matching HTTP requests. Each rule consists of matches, filters (optional), backendRefs (optional) and - timeouts (optional) fields.

The following illustrates an HTTPRoute that sends all traffic to one Service:

![](https://gateway-api.sigs.k8s.io/images/httproute-basic-example.svg)

## Attaching to Gateways

Each Route includes a way to reference the parent resources it wants to attach to. In most cases, that's going to be Gateways, but there is some flexibility here for implementations to support other types of parent resources.

The following example shows how a Route would attach to the acme-lb Gateway:

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: httproute-example
spec:
  parentRefs:
  - name: acme-lb

```

Note that the target Gateway needs to allow HTTPRoutes from the route's namespace to be attached for the attachment to be successful.

## Hostnames

Hostnames define a list of hostnames to match against the Host header of the HTTP request. When a match occurs, the HTTPRoute is selected to perform request routing based on rules and filters (optional). A hostname is the fully qualified domain name of a network host, as defined by RFC 3986. Note the following deviations from the “host” part of the URI as defined in the RFC:

- IPs are not allowed.
- The : delimiter is not respected because ports are not allowed.

Incoming requests are matched against hostnames before the HTTPRoute rules are evaluated. If no hostname is specified, traffic is routed based on HTTPRoute rules and filters (optional).

```yaml
# The following example defines hostname "my.example.com":
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
metadata:
  name: httproute-example
spec:
  hostnames:
  - my.example.com
```

## Rules

Rules define semantics for matching an HTTP request based on conditions, optionally executing additional processing steps, and optionally forwarding the request to an API object.

## Matches

Matches define conditions used for matching an HTTP request. Each match is independent, i.e. this rule will be matched if any single match is satisfied.

Take the following matches configuration as an example:

```yaml
apiVersion: gateway.networking.k8s.io/v1beta1
kind: HTTPRoute
...
spec:
  rules:
  - matches:
    - path:
        value: "/foo"
      headers:
      - name: "version"
        value: "2"
    - path:
        value: "/v2/foo"
```

For a request to match against this rule, it must satisfy EITHER of the following conditions:

- A path prefixed with /foo AND contains the header "version: 2"
- A path prefix of /v2/foo

If no matches are specified, the default is a prefix path match on “/”, which has the effect of matching every HTTP request.

## Filters (optional)

Filters define processing steps that must be completed during the request or response lifecycle. Filters act as an extension point to express additional processing that may be performed in Gateway implementations. Some examples include request or response modification, implementing authentication strategies, rate-limiting, and traffic shaping.

The following example adds header "my-header: foo" to HTTP requests with Host header "my.filter.com".

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: http-filter-1
spec:
  hostnames:
    - my.filter.com
  rules:
    - filters:
        - type: RequestHeaderModifier
          requestHeaderModifier:
            add:
              - name: my-header
                value: foo
      backendRefs:
        - name: my-filter-svc1
          weight: 1
          port: 80
```

API conformance is defined based on the filter type. The effects of ordering multiple behaviors is currently unspecified. This may change in the future based on feedback during the alpha stage.

Conformance levels are defined by the filter type:

- All "core" filters MUST be supported by implementations.
- Implementers are encouraged to support "extended" filters.
- "Implementation-specific" filters have no API guarantees across implementations.

Specifying a core filter multiple times has unspecified or implementation-specific conformance.

All filters are expected to be compatible with each other except for the URLRewrite and RequestRedirect filters, which may not be combined. If an implementation can not support other combinations of filters, they must clearly document that limitation. In cases where incompatible or unsupported filters are specified and cause the Accepted condition to be set to status False, implementations may use the IncompatibleFilters reason to specify this configuration error.

## BackendRefs (optional)

BackendRefs defines API objects where matching requests should be sent. If unspecified, the rule performs no forwarding. If unspecified and no filters are specified that would result in a response being sent, a 404 error code is returned.

The following example forwards HTTP requests for prefix /bar to service "my-service1" on port 8080 and HTTP requests for prefix /some/thing with header magic: foo to service "my-service2" on port 8080:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: acme-lb
spec:
  controllerName: acme.io/gateway-controller
  parametersRef:
    name: acme-lb
    group: acme.io
    kind: Parameters
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: my-gateway
spec:
  gatewayClassName: acme-lb
  listeners:  # Use GatewayClass defaults for listener definition.
  - name: http
    protocol: HTTP
    port: 80
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: http-app-1
spec:
  parentRefs:
  - name: my-gateway
  hostnames:
  - "foo.com"
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /bar
    backendRefs:
    - name: my-service1
      port: 8080
  - matches:
    - headers:
      - type: Exact
        name: magic
        value: foo
      queryParams:
      - type: Exact
        name: great
        value: example
      path:
        type: PathPrefix
        value: /some/thing
      method: GET
    backendRefs:
    - name: my-service2
      port: 8080
```

The following example uses the weight field to forward 90% of HTTP requests to foo.example.com to the "foo-v1" Service and the other 10% to the "foo-v2" Service:

```yaml
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: foo-route
  labels:
    gateway: prod-web-gw
spec:
  hostnames:
  - foo.example.com
  rules:
  - backendRefs:
    - name: foo-v1
      port: 8080
      weight: 90
    - name: foo-v2
      port: 8080
      weight: 10
```

Reference the **[backendRef API documentation](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1beta1.HTTPBackendRef)** for additional details on weight and other fields.

## Timeouts (optional)

Experimental Channel in v1.0.0+
HTTPRoute Rules include a Timeouts field. If unspecified, timeout behavior is implementation-specific.

HTTPRoute Rules include a Timeouts field. If unspecified, timeout behavior is implementation-specific.

There are 2 kinds of timeouts that can be configured in an HTTPRoute Rule:

## Next

<https://kubernetes.io/blog/2023/11/28/gateway-api-ga/>
<https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io/v1alpha2.BackendTLSPolicy>
<https://gateway-api.sigs.k8s.io/api-types/httproute/>

## Using Explicit CA Certificates

In this example, the BackendTLSPolicy is configured to use certificates defined in the configuration map auth-cert to connect with a TLS-encrypted upstream connection where Pods backing the auth Service are expected to serve a valid certificate for auth.example.com.

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
