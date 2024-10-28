# **[Ingress Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The **[Control Ingress Traffic](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)** task describes how to configure an ingress gateway to expose an HTTP service to external traffic. This task shows how to expose a secure HTTPS service using either simple or mutual TLS.

Along with support for Kubernetes Ingress resources, Istio also allows you to configure ingress traffic using either an Istio Gateway or Kubernetes Gateway resource. A Gateway provides more extensive customization and flexibility than Ingress, and allows Istio features such as monitoring and route rules to be applied to traffic entering the cluster.

This task describes how to configure Istio to expose a service outside of the service mesh using a Gateway.

Istio supports the Kubernetes **[Gateway API](https://istio.io/latest/blog/2024/gateway-mesh-ga/)** and intends to make it the default API for traffic management in the future. The following instructions allow you to choose to use either the Gateway API or the Istio configuration API when configuring traffic management in the mesh. Follow instructions under either the Gateway API or Istio APIs tab, according to your preference.

Note that the Kubernetes Gateway API CRDs do not come installed by default on most Kubernetes clusters, so make sure they are installed before using the Gateway API:

```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml; }

```

## Cleanup

```bash
pushd .
cd ~/Downloads/istio-1.23.0
kubectl delete -f samples/httpbin/httpbin.yaml
Cleanup
Istio APIsGateway API
Delete the Gateway and HTTPRoute configuration, and shutdown the httpbin service:

$ kubectl delete httproute httpbin
$ kubectl delete gtw httpbin-gateway
$ kubectl delete --ignore-not-found=true -f samples/httpbin/httpbin.yaml
```

## Before you begin

Setup Istio by following the instructions in the **[Installation guide](https://istio.io/latest/docs/setup/)**.

If you are going to use the Gateway API instructions, you can install Istio using the minimal profile because you will not need the istio-ingressgateway which is otherwise installed by default:

```bash
istioctl install --set profile=minimal
```

Start the httpbin sample, which will serve as the target service for ingress traffic:

```bash
pushd .
cd ~/src/repsys/k8s/istio
# https://github.com/istio/istio/blob/master/samples/httpbin/httpbin.yaml
kubectl apply -f httpbinnew.yaml

###### ERROR httpbin does not work always crashes
cd ~/Downloads/istio-1.23.0
kubectl apply -f samples/httpbin/httpbin.yaml

kubectl apply -f samples/httpbin/httpbin.yaml
serviceaccount/httpbin created
service/httpbin created
deployment.apps/httpbin created
```

Note that for the purpose of this document, which shows how to use a gateway to control ingress traffic into your “Kubernetes cluster”, you can start the httpbin service with or without sidecar injection enabled (i.e., the target service can be either inside or outside of the Istio mesh).

## Configuring ingress using a gateway

An ingress Gateway describes a load balancer operating at the edge of the mesh that receives incoming HTTP/TCP connections. It configures exposed ports, protocols, etc. but, unlike **[Kubernetes Ingress Resources](https://kubernetes.io/docs/concepts/services-networking/ingress/)**, does not include any traffic routing configuration. Traffic routing for ingress traffic is instead configured using routing rules, exactly in the same way as for internal service requests.

Let’s see how you can configure a Gateway on port 80 for HTTP traffic.

```bash
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  gatewayClassName: istio
  listeners:
  - name: http
    hostname: "httpbin.example.com"
    port: 80
    protocol: HTTP
    allowedRoutes:
      namespaces:
        from: Same
EOF
```

In a production environment, a Gateway and its corresponding routes are often created in separate namespaces by users performing different roles. In that case, the allowedRoutes field in the Gateway would be configured to specify the namespaces where routes should be created, instead of, as in this example, expecting them to be in the same namespace as the Gateway.

Because creating a Kubernetes Gateway resource will also deploy an associated proxy service, run the following command to wait for the gateway to be ready:

```bash
kubectl wait --for=condition=programmed gtw httpbin-gateway
gateway.gateway.networking.k8s.io/httpbin-gateway condition met
```
