# **[Deploy Istio Egress Gateway After Installation](https://istio.io/latest/docs/tasks/traffic-management/egress/egress-gateway/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

When working with Istio, it’s common to kick off a new installation with the default profile:

```bash
$ istioctl install -y
✔ Istio core installed                                                                         ✔ Istiod installed                                                                         ✔ Ingress gateways installed                                                                         ✔ Installation complete                                                                          Making this installation the default for injection and validation.
```

As you can see, Istio installed an ingress gateway:

```bash
$ kubectl get po -A -l istio=ingressgateway
NAMESPACE      NAME                                    READY   STATUS    RESTARTS   AGE
istio-system   istio-ingressgateway-677f4f9cc4-xks8k   1/1     Running   0          59s
```

But there is no egress gateway from this profile:

```bash
$ kubectl get po -A -l istio=egressgateway
No resources found
```

This is because the default profile doesn’t have it enabled.

The Accessing External Services task shows how to configure Istio to allow access to external HTTP and HTTPS services from applications inside the mesh. There, the external services are called directly from the client sidecar. This example also shows how to configure Istio to call external services, although this time indirectly via a dedicated egress gateway service.

Istio uses ingress and egress gateways to configure load balancers executing at the edge of a service mesh. An ingress gateway allows you to define entry points into the mesh that all incoming traffic flows through. Egress gateway is a symmetrical concept; it defines exit points from the mesh. Egress gateways allow you to apply Istio features, for example, monitoring and route rules, to traffic exiting the mesh.

Note: At the time of writing, the latest Istio version to reach General Availability is 1.14.0 and that is the version used when the article was written. You can try newer versions if you like, but these are not guaranteed to work equally.
