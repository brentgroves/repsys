# **[Custom Resources](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/using-kongplugin-resource/)**

**[Custom Resources](https://kubernetes.io/docs/tasks/access-kubernetes-api/extend-api-custom-resource-definitions/)** in Kubernetes allow controllers to extend Kubernetes-style declarative APIs that are specific to certain applications.

A few custom resources are bundled with the Kong Ingress Controller to configure settings that are specific to Kong and provide fine-grained control over the proxying behavior.

The Kong Ingress Controller uses the configuration.konghq.com API group for storing configuration specific to Kong.

These CRDs allow users to declaratively configure all aspects of Kong:

- KongIngress
- KongPlugin
- KongClusterPlugin
- KongConsumer
- KongConsumerGroup
- TCPIngress
- UDPIngress

## KongIngress

Note: Many fields available on KongIngress are also available as **[annotations](https://docs.konghq.com/kubernetes-ingress-controller/3.3.x/reference/annotations/)**. You can add these annotations directly to Service and Ingress resources without creating a separate KongIngress resource. When an annotation is available, it is the preferred means of configuring that setting, and the annotation value takes precedence over a KongIngress value if both set the same value.

The standard Ingress and Service Kubernetes resources can’t express the full range of Kong’s routing capabilities. You can use KongIngress to extend these resources.

KongIngress is a custom resource that attaches to Ingresses and Services and allows them to control all settings on the Kong routes, services, and upstreams generated for them. KongIngress is not an alternative to Ingress. It can’t be used independently and only functions when attached to another resource.

Once a KongIngress resource is created, you can use the konghq.com/override annotation to associate the KongIngress resource with an Ingress or a Service resource.

Annotated Ingress resource: All routes associated with the annotated Ingress are updated to use the values defined in the KongIngress’s route section.
Annotated Service resource: The corresponding service and upstream in Kong are updated to use the proxy and upstream blocks as defined in the associated KongIngress resource.
Don’t attach a KongIngress that sets values in the proxy and upstream sections to an Ingress, as it won’t have any effect. These sections are only honored when a KongIngress is attached to a Service. Similarly, the route section has no effect when attached to a Service, only when attached to an Ingress.

This diagram shows how the resources are linked with one another.
