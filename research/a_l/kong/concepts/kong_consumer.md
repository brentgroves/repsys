# Kong Consumer

## references

<https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/custom-resources/#kongconsumer>

## KongConsumer

This resource requires the kubernetes.io/ingress.class annotation. Its value must match the value of the controller’s --ingress-class argument, which is kong by default.

This custom resource configures consumers in Kong. Every KongConsumer resource in Kubernetes directly translates to a Consumer object in Kong.
