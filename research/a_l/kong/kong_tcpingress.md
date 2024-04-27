# Kong TCP Ingress

## references

<https://docs.konghq.com/kubernetes-ingress-controller/latest/concepts/custom-resources/#tcpingress>

## TCPIngress

This resource requires the kubernetes.io/ingress.class annotation. Its value must match the value of the controller’s --ingress-class argument, which is kong by default.

This Custom Resource is used for exposing non-HTTP and non-GRPC services running inside Kubernetes to the outside world through Kong. This proves to be useful when you want to use a single cloud LoadBalancer for all kinds of traffic into your Kubernetes cluster.

It is very similar to the Ingress resource that ships with Kubernetes.
