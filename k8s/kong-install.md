# Install Kong

## references

<https://docs.konghq.com/gateway/latest/kong-manager-oss/>
<https://dev.to/robincher/securing-your-site-via-oidc-powered-by-kong-and-keycloak-2ccc>
<https://www.hcl-software.com/blog/versionvault/how-to-configure-microsoft-azure-active-directory-as-keycloak-identity-provider-to-enable-single-sign-on-for-hcl-compass>

## Install Prerequisites

- Install the Gateway API CRDs before installing Kong Ingress Controller.

```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml
```

- Create a Gateway and GatewayClass instance to use.

```bash
echo "
---
apiVersion: gateway.networking.k8s.io/v1
kind: GatewayClass
metadata:
  name: kong
  annotations:
    konghq.com/gatewayclass-unmanaged: 'true'

spec:
  controllerName: konghq.com/kic-gateway-controller
---
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: kong
spec:
  gatewayClassName: kong
  listeners:
  - name: proxy
    port: 80
    protocol: HTTP
" | kubectl apply -f -
```

Add the Kong Helm charts:

```bash
helm repo add kong https://charts.konghq.com
helm repo update
```

Install Kong Ingress Controller and Kong Gateway with Helm:

```bash
helm install kong kong/ingress -n kong --create-namespace 
```

## Test connectivity to Kong

Kubernetes exposes the proxy through a Kubernetes service. Run the following commands to store the load balancer IP address in a variable named PROXY_IP:

Populate $PROXY_IP for future commands:

```bash
export PROXY_IP=$(kubectl get svc --namespace kong kong-gateway-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $PROXY_IP

```

Ensure that you can call the proxy IP:

```bash
curl -i $PROXY_IP
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

<https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/get-started/services-and-routes/>

Routes are configured using Gateway API or Ingress resources, such as HTTPRoute, TCPRoute, GRPCRoute, Ingress and more.

In this tutorial, you will deploy an echo service which returns information about the Kubernetes cluster and route traffic to the service.

## Deploy an echo service

To proxy requests, you need an upstream application to send a request to. Deploying this echo server provides a simple application that returns information about the Pod it’s running in:

```bash
kubectl apply -f https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml

```

Add routing configuration
Create routing configuration to proxy /echo requests to the echo server:

```yaml
echo "
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: echo
  annotations:
    konghq.com/strip-path: 'true'
spec:
  parentRefs:
  - name: kong
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /echo
    backendRefs:
    - name: echo
      kind: Service
      port: 1027
" | kubectl apply -f -
```

```yaml
echo "
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: echo
  annotations:
    konghq.com/strip-path: 'true'
spec:
  ingressClassName: kong
  rules:
  - http:
      paths:
      - path: /echo
        pathType: ImplementationSpecific
        backend:
          service:
            name: echo
            port:
              number: 1027
```

Test the configuration
To test the configuration, make a call to the $PROXY_IP that you configured.

```bash
export PROXY_IP=$(kubectl get svc --namespace kong kong-gateway-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $PROXY_IP
curl $PROXY_IP/echo

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
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep "< HTTP"; done

```
