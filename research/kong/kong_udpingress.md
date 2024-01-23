# Kong UDP Ingress

## references

<https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/custom-resources/#udpingress>

## UDPIngress

This resource requires the kubernetes.io/ingress.class annotation. Its value must match the value of the controller’s --ingress-class argument, which is kong by default.

This Custom Resource is used for exposing UDP services running inside Kubernetes to the outside world through Kong.

This is useful for services such as DNS servers, Game Servers, VPN software and a variety of other applications.
