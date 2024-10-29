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
cd ~/src/repsys/k8s/istio

Delete the Gateway and HTTPRoute configuration, and shutdown the httpbin service:

kubectl delete httproute httpbin
kubectl delete gtw httpbin-gateway
# https://github.com/istio/istio/blob/master/samples/httpbin/httpbin.yaml
kubectl delete --ignore-not-found=true -f httpbin_from_master.yaml

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
kubectl apply -f httpbin_from_master.yaml
serviceaccount/httpbin created
service/httpbin created
deployment.apps/httpbin created

###### ERROR httpbin does not work always crashes
cd ~/Downloads/istio-1.23.0
kubectl apply -f samples/httpbin/httpbin.yaml

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

Configure routes for traffic entering via the Gateway:

```bash
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: httpbin
spec:
  parentRefs:
  - name: httpbin-gateway
  hostnames: ["httpbin.example.com"]
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /status
    - path:
        type: PathPrefix
        value: /delay
    backendRefs:
    - name: httpbin
      port: 8000
EOF
```

You have now created an HTTP Route configuration for the httpbin service containing two route rules that allow traffic for paths /status and /delay.

## Determining the ingress IP and ports

Every Gateway is backed by a service of type LoadBalancer. The external load balancer IP and ports for this service are used to access the gateway. Kubernetes services of type LoadBalancer are supported by default in clusters running on most cloud platforms but in some environments (e.g., test) you may need to do the following:

- minikube - start an external load balancer by running the following command in a different terminal:

```$ minikube tunnel```

- kind - follow the guide for setting up MetalLB to get LoadBalancer type services to work.

- other platforms - you may be able to use MetalLB to get an EXTERNAL-IP for LoadBalancer services.

For convenience, we will store the ingress IP and ports in environment variables which will be used in later instructions. Set the INGRESS_HOST and INGRESS_PORT environment variables according to the following instructions:

Get the gateway address and port from the httpbin gateway resource:

```bash
export INGRESS_HOST=$(kubectl get gtw httpbin-gateway -o jsonpath='{.status.addresses[0].value}')
echo $INGRESS_HOST
export INGRESS_PORT=$(kubectl get gtw httpbin-gateway -o jsonpath='{.spec.listeners[?(@.name=="http")].port}')
echo $INGRESS_PORT

```

You can use similar commands to find other ports on any gateway. For example to access a secure HTTP port named https on a gateway named my-gateway:

```bash
export INGRESS_HOST=$(kubectl get gtw my-gateway -o jsonpath='{.status.addresses[0].value}')
export SECURE_INGRESS_PORT=$(kubectl get gtw my-gateway -o jsonpath='{.spec.listeners[?(@.name=="https")].port}')
```

## Accessing ingress services

### 1. Access the httpbin service using curl

```bash
curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/status/200"
```

-I, --head

(HTTP FTP FILE) Fetch the headers only. HTTP-servers feature the command HEAD which this uses to get nothing but the header of a document. When used on an FTP or FILE URL, curl displays the file size and last modification time only.

Note that you use the -H flag to set the Host HTTP header to “httpbin.example.com”. This is needed because your ingress Gateway is configured to handle “httpbin.example.com”, but in your test environment you have no DNS binding for that host and are simply sending your request to the ingress IP.

### 2.  Access any other URL that has not been explicitly exposed. You should see an HTTP 404 error

```bash
curl -s -I -HHost:httpbin.example.com "http://$INGRESS_HOST:$INGRESS_PORT/headers"
HTTP/1.1 404 Not Found
...
```

## Accessing ingress services using a browser

Entering the httpbin service URL in a browser won’t work because you can’t pass the Host header to a browser like you did with curl. In a real world situation, this is not a problem because you configure the requested host properly and DNS resolvable. Thus, you use the host’s domain name in the URL, for example, ```http://httpbin.example.com/status/200```.

You can work around this problem for simple tests and demos as follows:

If you remove the host names from the Gateway and HTTPRoute configurations, they will apply to any request. For example, change your ingress configuration to the following:

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
    port: 80
    protocol: HTTP
    allowedRoutes:
      namespaces:
        from: Same
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: httpbin
spec:
  parentRefs:
  - name: httpbin-gateway
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /headers
    backendRefs:
    - name: httpbin
      port: 8000
EOF
```

You can then use $INGRESS_HOST:$INGRESS_PORT in the browser URL. For example, ```http://$INGRESS_HOST:$INGRESS_PORT/headers``` will display all the headers that your browser sends.

## Understanding what happened

The Gateway configuration resources allow external traffic to enter the Istio service mesh and make the traffic management and policy features of Istio available for edge services.

In the preceding steps, you created a service inside the service mesh and exposed an HTTP endpoint of the service to external traffic.

## Using node ports of the ingress gateway service

You should not use these instructions if your Kubernetes environment has an external load balancer supporting services of type LoadBalancer.

If your environment does not support external load balancers, you can still experiment with some of the Istio features by using the istio-ingressgateway service’s node ports.

Set the ingress ports:

```bash
export INGRESS_NS=default
export INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="http2")].nodePort}')
export SECURE_INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="https")].nodePort}')
export TCP_INGRESS_PORT=$(kubectl -n "${INGRESS_NS}" get service "${INGRESS_NAME}" -o jsonpath='{.spec.ports[?(@.name=="tcp")].nodePort}')
```

Setting the ingress IP depends on the cluster provider:

GKE:
```export INGRESS_HOST=worker-node-address```

You need to create firewall rules to allow the TCP traffic to the ingressgateway service’s ports. Run the following commands to allow the traffic for the HTTP port, the secure port (HTTPS) or both:

```bash
gcloud compute firewall-rules create allow-gateway-http --allow "tcp:$INGRESS_PORT"
gcloud compute firewall-rules create allow-gateway-https --allow "tcp:$SECURE_INGRESS_PORT"
```

Other Environments

```bash
export INGRESS_HOST=$(kubectl get po -l istio=ingressgateway -n "${INGRESS_NS}" -o jsonpath='{.items[0].status.hostIP}')
```

## Troubleshooting

Inspect the values of the INGRESS_HOST and INGRESS_PORT environment variables. Make sure they have valid values, according to the output of the following commands:

```bash
kubectl get svc -n istio-system
echo "INGRESS_HOST=$INGRESS_HOST, INGRESS_PORT=$INGRESS_PORT"
```

Check that you have no other Istio ingress gateways defined on the same port:

```bash
kubectl get gateway --all-namespaces
```

Check that you have no Kubernetes Ingress resources defined on the same IP and port:

```bash
kubectl get ingress --all-namespaces
```

If you have an external load balancer and it does not work for you, try to **[access the gateway using its node port](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/#using-node-ports-of-the-ingress-gateway-service)**.
