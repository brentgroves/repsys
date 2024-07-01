# **[Kubernetes API](https://kubernetes.io/docs/concepts/overview/kubernetes-api/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## The Kubernetes API

The core of Kubernetes' control plane is the API server. The API server exposes an HTTP API that lets end users, different parts of your cluster, and external components communicate with one another.

The Kubernetes API lets you query and manipulate the state of API objects in Kubernetes (for example: Pods, Namespaces, ConfigMaps, and Events).

Most operations can be performed through the kubectl command-line interface or other command-line tools, such as kubeadm, which in turn use the API. However, you can also access the API directly using REST calls. Kubernetes provides a set of client libraries for those looking to write applications using the Kubernetes API.

Each Kubernetes cluster publishes the specification of the APIs that the cluster serves. There are two mechanisms that Kubernetes uses to publish these API specifications; both are useful to enable automatic interoperability. For example, the kubectl tool fetches and caches the API specification for enabling command-line completion and other features. The two supported mechanisms are as follows:

- **[The Discovery API](https://kubernetes.io/docs/concepts/overview/kubernetes-api/#discovery-api)** provides information about the Kubernetes APIs: API names, resources, versions, and supported operations. This is a Kubernetes specific term as it is a separate API from the Kubernetes OpenAPI. It is intended to be a brief summary of the available resources and it does not detail specific schema for the resources. For reference about resource schemas, please refer to the OpenAPI document.

- **[The Kubernetes OpenAPI Document](https://kubernetes.io/docs/concepts/overview/kubernetes-api/#openapi-interface-definition)** provides (full) **[OpenAPI v2.0 and 3.0 schemas](https://www.openapis.org/)** for all Kubernetes API endpoints. The OpenAPI v3 is the preferred method for accessing OpenAPI as it provides a more comprehensive and accurate view of the API. It includes all the available API paths, as well as all resources consumed and produced for every operations on every endpoints. It also includes any extensibility components that a cluster supports. The data is a complete specification and is significantly larger than that from the Discovery API.

## Discovery API

Kubernetes publishes a list of all group versions and resources supported via the Discovery API. This includes the following for each resource:

- Name
- Cluster or namespaced scope
- Endpoint URL and supported verbs
- Alternative names
- Group, version, kind

The API is available both aggregated and unaggregated form. The aggregated discovery serves two endpoints while the unaggregated discovery serves a separate endpoint for each group version.

## Aggregated discovery

FEATURE STATE: Kubernetes v1.30 [stable]
Kubernetes offers stable support for aggregated discovery, publishing all resources supported by a cluster through two endpoints (/api and /apis). Requesting this endpoint drastically reduces the number of requests sent to fetch the discovery data from the cluster. You can access the data by requesting the respective endpoints with an Accept header indicating the aggregated discovery resource: Accept:

application/json;v=v2;g=apidiscovery.k8s.io;as=APIGroupDiscoveryList.

Without indicating the resource type using the Accept header, the default response for the /api and /apis endpoint is an unaggregated discovery document.

The **[discovery document](https://github.com/kubernetes/kubernetes/blob/release-1.30/api/discovery/aggregated_v2.json)** for the built-in resources can be found in the Kubernetes GitHub repository. This Github document can be used as a reference of the base set of the available resources if a Kubernetes cluster is not available to query.

The endpoint also supports ETag and protobuf encoding.
