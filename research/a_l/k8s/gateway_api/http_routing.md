# HTTP Routing

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

The HTTPRoute resource allows you to match on HTTP traffic and direct it to Kubernetes backends. This guide shows how the HTTPRoute matches traffic on host, header, and path fields and forwards it to different Kubernetes Services.

## references

<https://gateway-api.sigs.k8s.io/guides/http-routing/>

## HTTP routing

The following diagram describes a required traffic flow across three different Services:

- Traffic to foo.example.com/login is forwarded to foo-svc
- Traffic to bar.example.com/*with a env: canary header is forwarded to bar-svc-canary
- Traffic to bar.example.com/* without the header is forwarded to bar-svc

![](https://gateway-api.sigs.k8s.io/images/http-routing.png)

The dotted lines show the Gateway resources deployed to configure this routing behavior. There are two HTTPRoute resources that create routing rules on the same prod-web Gateway. This illustrates how more than one Route can bind to a Gateway which allows Routes to merge on a Gateway as long as they don't conflict. For more information on Route merging, refer to the HTTPRoute documentation.

In order to receive traffic from a Gateway an HTTPRoute resource must be configured with ParentRefs which reference the parent gateway(s) that it should be attached to. The following example shows how the combination of Gateway and HTTPRoute would be configured to serve HTTP traffic:
