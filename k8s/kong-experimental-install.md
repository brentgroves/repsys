# Tech preview experimental install of Kong Ingress Controller and Gateway

## references

<https://docs.konghq.com/gateway-operator/latest/get-started/kic/install/>

## Install Kong Ingress Controller

Install the Gateway API CRDs before installing Kong Ingress Controller.

```bash
kubectl apply -f <https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml>
```

To remove standard resources:

```bash
kubectl get crd
kubectl delete crd gatewayclasses.gateway.networking.k8s.io
kubectl delete crd gateways.gateway.networking.k8s.io
kubectl delete crd httproutes.gateway.networking.k8s.io
kubectl delete crd referencegrants.gateway.networking.k8s.io
```

If you want to use experimental resources and fields such as TCPRoutes and UDPRoutes, please run this command.

```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/experimental-install.yaml

```

To remove experimental resources:

```bash
kubectl delete crd backendtlspolicies.gateway.networking.k8s.io
kubectl delete crd gatewayclasses.gateway.networking.k8s.io
kubectl delete crd gateways.gateway.networking.k8s.io
kubectl delete crd grpcroutes.gateway.networking.k8s.io
kubectl delete crd httproutes.gateway.networking.k8s.io
kubectl delete crd referencegrants.gateway.networking.k8s.io
kubectl delete crd tcproutes.gateway.networking.k8s.io
kubectl delete crd tlsroutes.gateway.networking.k8s.io
kubectl delete crd udproutes.gateway.networking.k8s.io
```

To install Kong specific CRDs, run the following command.

```bash
kubectl apply -k https://github.com/Kong/kubernetes-ingress-controller/config/crd

```

To install Kong Gateway Operator use kubectl apply:

```bash
kubectl apply -f https://docs.konghq.com/assets/gateway-operator/v1.1.0/crds.yaml --server-side
kubectl apply -f https://docs.konghq.com/assets/gateway-operator/v1.1.0/all_controllers.yaml

```

You can wait for the operator to be ready using kubectl wait:

```bash
kubectl -n kong-system wait --for=condition=Available=true --timeout=120s deployment/gateway-operator-controller-manager

```

## Create a GatewayClass

To use the Gateway API resources to configure your routes, you need to create a GatewayClass instance and create a Gateway resource that listens on the ports that you need.

Note: Gateway and ControlPlane controllers are still alpha so be sure to use the installation **[steps from this guide](https://docs.konghq.com/gateway-operator/1.1.x/get-started/kic/install/)** in order to get your Gateway up and running.

```yaml
echo '
kind: GatewayConfiguration
apiVersion: gateway-operator.konghq.com/v1alpha1
metadata:
  name: kong
  namespace: default
spec:
  dataPlaneOptions:
    deployment:
      podTemplateSpec:
        spec:
          containers:
          - name: proxy
            image: kong:3.5.0
            readinessProbe:
              initialDelaySeconds: 1
              periodSeconds: 1
  controlPlaneOptions:
    deployment:
      podTemplateSpec:
        spec:
          containers:
          - name: controller
            image: kong/kubernetes-ingress-controller:3.0.0
            env:
            - name: CONTROLLER_LOG_LEVEL
              value: debug
---
kind: GatewayClass
apiVersion: gateway.networking.k8s.io/v1beta1
metadata:
  name: kong
spec:
  controllerName: konghq.com/gateway-operator
  parametersRef:
    group: gateway-operator.konghq.com
    kind: GatewayConfiguration
    name: kong
    namespace: default
---
kind: Gateway
apiVersion: gateway.networking.k8s.io/v1beta1
metadata:
  name: kong
  namespace: default
spec:
  gatewayClassName: kong
  listeners:
  - name: http
    protocol: HTTP
    port: 80

' | kubectl apply -f -
```

To remove Gateway and GatewayClass:

```bash
kubectl get gateway
NAME   CLASS   ADDRESS        PROGRAMMED   AGE
kong   kong    172.20.88.60   True         18h
kubectl delete gateway kong

kubectl get gatewayclass
NAME   CONTROLLER                          ACCEPTED   AGE
kong   konghq.com/kic-gateway-controller   True       18h
kubectl delete gatewayclass kong
```

Run kubectl get gateway kong -n default to get the IP address for the gateway and set that as the value for the variable PROXY_IP.

```bash
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
echo $PROXY_IP
```

The results should look like this:

```bash
 HTTP/1.1 404 Not Found
 Content-Type: application/json; charset=utf-8
 Connection: keep-alive
 Content-Length: 48
 X-Kong-Response-Latency: 0
 Server: kong/3.0.0
  
 {"message":"no Route matched with those values"}
```

## Configure the echo service

In order to route a request using Kong Gateway we need a service running in our cluster. Install an echo service using the following command:

 kubectl apply -f <https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml>

Create a HTTPRoute to send any requests that start with /echo to the echo service.

```bash
echo '
kind: HTTPRoute
apiVersion: gateway.networking.k8s.io/v1beta1
metadata:
  name: echo
spec:
  parentRefs:
    - group: gateway.networking.k8s.io
      kind: Gateway
      name: kong
  rules:
    - matches:
        - path:
            type: PathPrefix
            value: /echo
      backendRefs:
        - name: echo
          port: 1027
' | kubectl apply -f -

```

<https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/get-started/rate-limiting/>

```bash
echo "
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: rate-limit-5-min
  annotations:
    kubernetes.io/ingress.class: kong
config:
  minute: 5
  policy: local
plugin: rate-limiting
" | kubectl apply -f -
```

Associate the plugin with a service or route
Plugins can be linked to a service or a route. Adding a rate limit plugin to a service shares the limit across all routes contained within that service.

```bash
kubectl annotate service echo konghq.com/plugins=rate-limit-5-min
```

Test the rate-limiting plugin
To test the rate-limiting plugin, rapidly send six requests to $PROXY_IP/echo:

```bash
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
echo $PROXY_IP
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep "< HTTP"; done

```

## Create a proxy-cache KongClusterPlugin

In the previous section you created a KongPlugin that was applied to a specific service or route. You can also use a KongClusterPlugin which is a global plugin that applies to all services.

This configuration caches all HTTP 200 responses to GET and HEAD requests for 300 seconds:

```bash
echo '
apiVersion: configuration.konghq.com/v1
kind: KongClusterPlugin
metadata:
 name: proxy-cache-all-endpoints
 annotations:
   kubernetes.io/ingress.class: kong
 labels:
   global: "true"
plugin: proxy-cache
config:
 response_code:
 - 200
 request_method:
 - GET
 - HEAD
 content_type:
 - text/plain; charset=utf-8
 cache_ttl: 300
 strategy: memory
' | kubectl apply -f -

```

Test the proxy-cache plugin
To test the proxy-cache plugin, send another six requests to $PROXY_IP/echo:

```bash
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep -E "(Status|< HTTP)"; done
```
