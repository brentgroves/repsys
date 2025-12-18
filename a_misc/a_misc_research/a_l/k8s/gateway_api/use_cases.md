# Gateway API use cases

Gateway API covers a very wide range of use cases (which is both a strength and a weakness!). This page is emphatically not meant to be an exhaustive list of these use cases: rather, it is meant to provide some examples that can be helpful to demonstrate how the API can be used.

In all cases, it's very important to bear in mind the **[roles and personas](https://gateway-api.sigs.k8s.io/concepts/roles-and-personas)** used in Gateway API. The use cases presented here are deliberately described in terms of Ana, Chihiro, and Ian: they are the ones for whom the API must be usable. (It's also important to remember that even though these roles might be filled by the same person, especially in smaller organizations, they all have distinct concerns that we need to consider separately.)

## refererences

<https://gateway-api.sigs.k8s.io/concepts/use-cases/>

## Personas

- Ian (he/him) is an **infrastructure provider**. His role is the care and feeding of a set of infrastructure that permits multiple isolated clusters to serve multiple tenants. He is not beholden to any single tenant; rather, he worries about all of them collectively.
- Chihiro (they/them) is a **cluster operator**. Their role is to manage a single cluster, ensuring that it meets the needs of its several users. Again, Chihiro is beholden to no single user of their cluster; they need to make sure that the cluster serves all of them as needed.
- Ana (she/her) is an **application developer**. Ana is in a unique position among the Gateway API roles: her focus is on the business needs her application is meant to serve, not Kubernetes or Gateway API. In fact, Ana is likely to view Gateway API and Kubernetes as pure friction getting in her way to get things done.

## Use Cases

The example **[use cases](https://gateway-api.sigs.k8s.io/concepts/use-cases)** show this role-oriented model at work. Its flexibility allows the API to adapt to vastly different organizational models and implementations while remaining a portable and standard API.

The use cases presented are deliberately cast in terms of the roles presented above. Ultimately Gateway API is meant for use by humans, which means that it must fit the uses to which each of Ana, Chihiro, and Ian will put it.

## The Use Cases

Basic north/south use case
Multiple applications behind a single Gateway
Basic east/west use case -- experimental
Gateway and mesh use case -- experimental

## Basic north/south use case

Standard Channel in v0.8.0+
Ana has created a microservice application which she wants to run in Kubernetes. Her application will be used by clients outside the cluster, and while Ana has created the application, setting up the cluster is not in her wheelhouse.

1. Ana goes to Chihiro to ask them to set up a cluster. Ana tells Chihiro that her clients will expect her APIs to be available using URLs rooted at <https://ana.application.com/>.
2. Chihiro goes to Ian and requests a cluster.
3. Ian provisions a cluster running a gateway controller with a GatewayClass resource named basic-gateway-class. The gateway controller manages the infrastructure associated with routing traffic from outside the cluster to inside the cluster.
4. Ian gives Chihiro credentials to the new cluster, and tells Chihiro that they can use GatewayClass basic-gateway-class to set things up.
5. Chihiro applies a Gateway named ana-gateway to the cluster, telling it to listen on port 443 for TLS traffic, and providing it a TLS certificate with a Subject CN of ana.application.com. They associate this Gateway with the basic-gateway-class GatewayClass.
6. The gateway controller that Ian provisioned in step 3 allocates a load balancer and an IP address for ana-gateway, provisions data-plane components that can route requests arriving at the load balancer on port 443, and starts watching for routing resources associated with ana-gateway.
7. Chihiro gets the IP address of ana-gateway and creates a DNS record outside the cluster for ana.application.com to match.
8. Chihiro tells Ana that she's good to go, using the Gateway named ana-gateway.
9. Ana writes and applies HTTPRoute resources to configure which URL paths are allowed and which microservices should handle them. She associates these HTTPRoutes with Gateway ana-gateway using the Gateway API Route Attachment Process.
10. At this point, when requests arrive at the load balancer, they are routed to Ana's application according to her routing specification.

This allows Chihiro to enforce centralized policies such as **[TLS at the Gateway](https://gateway-api.sigs.k8s.io/guides/tls#downstream-tls)**, while simultaneously allowing Ana and her colleagues control over the application's routing logic and rollout plans (e.g. traffic splitting rollouts).
