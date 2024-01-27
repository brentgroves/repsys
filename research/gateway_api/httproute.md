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
