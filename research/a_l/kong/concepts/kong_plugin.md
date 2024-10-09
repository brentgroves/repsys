# Kong Plugin

## references

<https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/custom-resources/#kongplugin>

## KongPlugin

Kong is designed around an extensible plugin architecture and comes with a wide variety of plugins already bundled inside it. These plugins can be used to modify the request or impose restrictions on the traffic.

Once this resource is created, the resource needs to be associated with an Ingress, Service, or KongConsumer resource in Kubernetes.

This diagram shows how you can link a KongPlugin resource to an Ingress, Service, or KongConsumer.

![](https://docs.konghq.com/assets/images/products/kubernetes-ingress-controller/kong-plugin-association1.png)

## KongClusterPlugin

This resource requires the kubernetes.io/ingress.class annotation.

KongClusterPlugin resource is exactly same as KongPlugin, except that it is a Kubernetes cluster-level resources rather than a namespaced resource. This can help when the configuration of the plugin needs to be centralized and the permissions to add or update plugin configuration rests with a different persona other than the application owners.

This resource can be associated with an Ingress, Service, or KongConsumer, and can be used in the exact same way as KongPlugin.

A namespaced KongPlugin resource takes priority over a KongClusterPlugin with the same name.
