# Kong Ingress

## references

<https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/custom-resources/>

The standard Ingress and Service Kubernetes resources can’t express the full range of Kong’s routing capabilities. You can use KongIngress to extend these resources.

KongIngress is a custom resource that attaches to Ingresses and Services and allows them to control all settings on the Kong routes, services, and upstreams generated for them. KongIngress is not an alternative to Ingress. It can’t be used independently and only functions when attached to another resource.

Once a KongIngress resource is created, you can use the konghq.com/override annotation to associate the KongIngress resource with an Ingress or a Service resource.

- Annotated Ingress resource: All routes associated with the annotated Ingress are updated to use the values defined in the KongIngress’s route section.
- Annotated Service resource: The corresponding service and upstream in Kong are updated to use the proxy and upstream blocks as defined in the associated KongIngress resource.

Don’t attach a KongIngress that sets values in the proxy and upstream sections to an Ingress, as it won’t have any effect. These sections are only honored when a KongIngress is attached to a Service. Similarly, the route section has no effect when attached to a Service, only when attached to an Ingress.

This diagram shows how the resources are linked with one another.

![](https://docs.konghq.com/assets/images/products/kubernetes-ingress-controller/kong-ingress-association.png)
