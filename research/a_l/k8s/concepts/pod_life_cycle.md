# **[pod life cycle](https://kubernetes.io/docs/concepts/workloads/pods/pod-lifecycle/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Pod Lifecycle

This page describes the lifecycle of a Pod. Pods follow a defined lifecycle, starting in the Pending phase, moving through Running if at least one of its primary containers starts OK, and then through either the Succeeded or Failed phases depending on whether any container in the Pod terminated in failure.

Whilst a Pod is running, the kubelet is able to restart containers to handle some kind of faults. Within a Pod, Kubernetes tracks different container states and determines what action to take to make the Pod healthy again.

In the Kubernetes API, Pods have both a specification and an actual status. The status for a Pod object consists of a set of Pod conditions. You can also inject custom readiness information into the condition data for a Pod, if that is useful to your application.

The **[ETag](https://en.wikipedia.org/wiki/HTTP_ETag)** or entity tag is part of HTTP, the protocol for the World Wide Web. It is one of several mechanisms that HTTP provides for **Web cache validation**, which allows a client to make conditional requests. This mechanism allows caches to be more efficient and saves bandwidth, as a Web server does not need to send a full response if the content has not changed. ETags can also be used for optimistic concurrency control[1] to help prevent simultaneous updates of a resource from overwriting each other.

An ETag is an opaque identifier assigned by a Web server to a specific version of a resource found at a URL.[2] If the resource representation at that URL ever changes, a new and different ETag is assigned. Used in this manner, ETags are similar to fingerprints and can quickly be compared to determine whether two representations of a resource are the same.

The use of ETags in the HTTP header is optional (not mandatory as with some other fields of the HTTP 1.1 header). The method by which ETags are generated has never been specified in the HTTP specification.

Common methods of ETag generation include using a collision-resistant hash function of the resource's content, a hash of the last modification timestamp, or even just a revision number.

In order to avoid the use of stale cache data, methods used to generate ETags should guarantee (as much as is practical) that each ETag is unique. However, an ETag-generation function could be judged to be "usable", if it can be proven (mathematically) that duplication of ETags would be "acceptably rare", even if it could or would occur.

## **[protobuf encoding](https://medium.com/@yashschandra/an-inner-view-to-protobuf-encoding-e668f37847d5)**

In this article we will see how protocol buffers encodes data to make it more compact (hence smaller) to transmit. This article does not focus on how to use protocol buffers but instead explores what it does under the hood. Code pieces demonstrated here are in python v3 but similar things will be happening in other languages also.

Here we explore encoding of 6 types -int, string, float, double, dict, array. Having understanding of these 6 types should be sufficient to get a fair idea of working protobuf.

### **[Protocol Buffers](./protocol_buffers.md)**

**[Protocol buffers](https://en.wikipedia.org/wiki/Protocol_Buffers)** are Google’s language-neutral, platform-neutral, extensible mechanism for serializing structured data. Just like xml but smaller in size. It is useful in developing programs to communicate with each other over a wire or for storing data.

## Unaggregated discovery

Without discovery aggregation, discovery is published in levels, with the root endpoints publishing discovery information for downstream documents.

A list of all group versions supported by a cluster is published at the /api and /apis endpoints. Example:

```yaml
{
  "kind": "APIGroupList",
  "apiVersion": "v1",
  "groups": [
    {
      "name": "apiregistration.k8s.io",
      "versions": [
        {
          "groupVersion": "apiregistration.k8s.io/v1",
          "version": "v1"
        }
      ],
      "preferredVersion": {
        "groupVersion": "apiregistration.k8s.io/v1",
        "version": "v1"
      }
    },
    {
      "name": "apps",
      "versions": [
        {
          "groupVersion": "apps/v1",
          "version": "v1"
        }
      ],
      "preferredVersion": {
        "groupVersion": "apps/v1",
        "version": "v1"
      }
    },
    ...
}
```

Additional requests are needed to obtain the discovery document for each group version at /apis/<group>/<version> (for example: /apis/rbac.authorization.k8s.io/v1alpha1), which advertises the list of resources served under a particular group version. These endpoints are used by kubectl to fetch the list of resources supported by a cluster.

## OpenAPI interface definition

For details about the OpenAPI specifications, see the OpenAPI documentation.

Kubernetes serves both OpenAPI v2.0 and OpenAPI v3.0. OpenAPI v3 is the preferred method of accessing the OpenAPI because it offers a more comprehensive (lossless) representation of Kubernetes resources. Due to limitations of OpenAPI version 2, certain fields are dropped from the published OpenAPI including but not limited to default, nullable, oneOf.
