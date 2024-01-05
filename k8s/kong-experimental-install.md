# Tech preview experimental install of Kong Ingress Controller and Gateway

This feature is released as a tech preview (alpha-quality) and should not be depended upon in a production environment.

## references

<https://docs.konghq.com/gateway-operator/latest/get-started/kic/install/>
<https://docs.konghq.com/gateway-operator/1.1.x/get-started/kic/install/>

## Install KIC with Kong Gateway Operator

Both Kong Gateway Operator and Kong Ingress Controller can be configured using the Kubernetes Gateway API.

You configure your GatewayClass and Gateway objects in a vendor independent way and Kong Gateway Operator translates those requirements in to Kong specific configuration.

This means that CRDs for both the Gateway API and Kong Ingress Controller have to be installed.

Below command installs all Gateway API resources that have graduated to GA or beta, including GatewayClass, Gateway, HTTPRoute, and ReferenceGrant.

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

To remove Kong specific CRD:

```bash
kubectl delete crd ingressclassparameterses.configuration.konghq.com
kubectl delete crd kongclusterplugins.configuration.konghq.com
kubectl delete crd kongconsumergroups.configuration.konghq.com
kubectl delete crd kongconsumers.configuration.konghq.com
kubectl delete crd kongingresses.configuration.konghq.com
kubectl delete crd kongplugins.configuration.konghq.com
kubectl delete crd kongupstreampolicies.configuration.konghq.com
kubectl delete crd tcpingresses.configuration.konghq.com
kubectl delete crd udpingresses.configuration.konghq.com
```

To install Kong Gateway Operator use kubectl apply:

```bash
kubectl apply -f https://docs.konghq.com/assets/gateway-operator/v1.1.0/crds.yaml --server-side
kubectl apply -f https://docs.konghq.com/assets/gateway-operator/v1.1.0/all_controllers.yaml

```

To remove Kong Gateway Operator:

```bash
kubectl delete crd controlplanes.gateway-operator.konghq.com
kubectl delete crd dataplanes.gateway-operator.konghq.com
kubectl delete crd gatewayconfigurations.gateway-operator.konghq.com

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
kubectl get GatewayConfiguration            
NAME   AGE
kong   9d
kubectl delete gatewayconfiguration kong

kubectl get gateway
NAME   CLASS   ADDRESS    PROGRAMMED   AGE
kong   kong    10.1.0.8   True         9d
kubectl delete gateway kong

kubectl get gatewayclass
NAME   CONTROLLER                    ACCEPTED   AGE
kong   konghq.com/gateway-operator   True       9d
kubectl delete gatewayclass kong
```

Run kubectl get gateway kong -n default to get the IP address for the gateway and set that as the value for the variable PROXY_IP.

```bash
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
echo $PROXY_IP
```

## Create a Route

This feature is released as a tech preview (alpha-quality) and should not be depended upon in a production environment.
After you’ve installed all of the required components and configured a GatewayClass you can route some traffic to a service in your Kubernetes cluster.

## Configure the echo service

In order to route a request using Kong Gateway we need a service running in our cluster. Install an echo service using the following command:

```bash
kubectl apply -f https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml
```

To remove echo service and deployment:

```bash
kubectl get svc
echo                  ClusterIP   10.152.183.249   <none>        1025/TCP,1026/TCP,1027/TCP  
kubectl delete svc echo

kubectl get deployments    
echo                            1/1     1            1           9d
kubectl delete deployment echo  
```

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

To remove echo route:

```bash
kubectl get httproute
NAME   HOSTNAMES   AGE
echo               18h
kubectl delete httproute echo
```

## Test the configuration

To test the configuration, make a call to the $PROXY_IP that you configured.

```bash
curl $PROXY_IP/echo
Welcome, you are connected to node reports12.
Running on Pod echo-74c66b778-k8pzn.
In namespace default.
With IP address 10.1.102.213.
```

## Next steps

Now that you have a running DataPlane configured using Gateway API resources, you can explore the power that Kong Gateway provides:

- **[Configuring Kong Gateway plugins using Kong Ingress Controller](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/using-kongplugin-resource/)**
- **[Upgrading Kong Gateway Operator managed data planes](https://docs.konghq.com/gateway-operator/1.1.x/production/upgrade/data-plane/rolling/)**

<https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/get-started/rate-limiting/>

## Create a rate-limiting KongPlugin

Configuring plugins with Kong Ingress Controller is different compared to how you’d do it with . Rather than attaching a configuration directly to a service or route, you create a KongPlugin definition and then annotate your Kubernetes resource with the konghq.com/plugins annotation.

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

To remove Kong plugin:

```bash
kubectl get kongplugin
NAME               PLUGIN-TYPE     AGE   PROGRAMMED
rate-limit-5-min   rate-limiting   18h
kubectl delete kongplugin rate-limit-5-min
```

## Associate the plugin with a service or route

Plugins can be linked to a service or a route. Adding a rate limit plugin to a service shares the limit across all routes contained within that service.

```bash
kubectl annotate service echo konghq.com/plugins=rate-limit-5-min
```

Alternatively you can add the rate limit plugin to a route. Adding a rate limit plugin to a route sets a rate limit per-route.

```bash
# Gateway API
kubectl annotate httproute echo konghq.com/plugins=rate-limit-5-min
kubectl describe httproute
## service
kubectl annotate ingress echo konghq.com/plugins=rate-limit-5-min
kubectl describe ingress echo 

```

## Test the rate-limiting plugin

To test the rate-limiting plugin, rapidly send six requests to $PROXY_IP/echo:

```bash
export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
echo $PROXY_IP
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep "< HTTP"; done
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 200 OK
< HTTP/1.1 429 Too Many Requests
```

This shows that the rate limiting plugin is preventing the request from reaching the upstream service.

Further reading
For more information about rate limiting, see **[scale to multiple pods](https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/plugins/rate-limiting/#scale-to-multiple-pods)** in the Rate Limiting plugin documentation.

## Proxy Caching

<https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/get-started/proxy-caching/>

One of the ways Kong delivers performance is through caching. The Proxy Cache plugin accelerates performance by caching responses based on configurable response codes, content types, and request methods. When caching is enabled, upstream services are not impacted by repetitive requests, because Kong Gateway responds on their behalf with cached results. Caching can be enabled on specific routes for all requests globally.

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

Remove KongClusterPlugin:

```bash
kubectl get kongclusterplugin proxy-cache-all-endpoints
NAME                        PLUGIN-TYPE   AGE   PROGRAMMED
proxy-cache-all-endpoints   proxy-cache   50s  
kubectl delete kongclusterplugin proxy-cache-all-endpoints
```

## Test the proxy-cache plugin

To test the proxy-cache plugin, send another six requests to $PROXY_IP/echo:

```bash
for i in `seq 6`; do curl -sv $PROXY_IP/echo 2>&1 | grep -E "(Status|< HTTP)"; done
< HTTP/1.1 200 OK
< X-Cache-Status: Miss
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 429 Too Many Requests

```

The first request results in X-Cache-Status: Miss. This means that the request is sent to the upstream service. The next four responses return X-Cache-Status: Hit which indicates that the request was served from a cache.

The X-Cache-Status header can return the following cache results:

| STATE   | DESCRIPTION                                                                                                                                        |
|---------|----------------------------------------------------------------------------------------------------------------------------------------------------|
| Miss    | The request could be satisfied in cache, but an entry for the resource was not found in cache, and the request was proxied upstream.               |
| Hit     | The request was satisfied and served from the cache.                                                                                               |
| Refresh | The resource was found in cache, but could not satisfy the request, due to Cache-Control behaviors or reaching its hard-coded cache_ttl threshold. |
| Bypass  | The request could not be satisfied from cache based on plugin configuration.                                                                       |

The final thing to note is that when a HTTP 429 request is returned by the rate-limit plugin, you do not see a X-Cache-Status header. This is because rate-limiting executes before proxy-cache. For more information, see **[plugin priority](https://docs.konghq.com/gateway/latest/plugin-development/custom-logic/#kong-plugins)**.

```bash
< HTTP/1.1 200 OK
< X-Cache-Status: Miss
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 200 OK
< X-Cache-Status: Hit
< HTTP/1.1 429 Too Many Requests

```

## Key Authentication

Authentication is the process of verifying that a requester has permissions to access a resource. API gateway authentication authenticates the flow of data to and from your upstream services.

Kong Gateway has a library of plugins that support the most widely used methods of API gateway **[authentication](https://docs.konghq.com/hub/#authentication)**.

Common authentication methods include:

- Key Authentication
- Basic Authentication
- OAuth 2.0 Authentication (Kong for free) <https://docs.konghq.com/hub/kong-inc/oauth2/>
- LDAP Authentication Advanced
- OpenID Connect

## Authentication benefits

With Kong Gateway controlling authentication, requests won’t reach upstream services unless the client has successfully authenticated. This means upstream services process pre-authorized requests, freeing them from the cost of authentication, which is a savings in compute time and development effort.

Kong Gateway has visibility into all authentication attempts and enables you to build monitoring and alerting capabilities which support service availability and compliance.

For more information, see What is **[API Gateway Authentication](https://konghq.com/learning-center/api-gateway/api-gateway-authentication)**?

## Add authentication to the echo service

Create a new key-auth plugin.

```bash
echo "
apiVersion: configuration.konghq.com/v1
kind: KongPlugin
metadata:
  name: key-auth
plugin: key-auth
config:
  key_names:
  - apikey
" | kubectl apply -f -

```

Remove key-auth plugin:

```bash
kubectl get kongplugin       
NAME               PLUGIN-TYPE     AGE   PROGRAMMED
rate-limit-5-min   rate-limiting   19h   
key-auth           key-auth        42s   
kubectl delete kongplugin key-auth
```

Apply the key-auth plugin to the echo service in addition to the previous rate-limit plugin.

```bash
kubectl annotate service echo konghq.com/plugins=rate-limit-5-min,key-auth --overwrite

```

Test that the API is secure by sending a request using curl -i $PROXY_IP/echo. Observe that a HTTP 401 is returned with this message:

```bash
curl -i $PROXY_IP/echo
HTTP/1.1 401 Unauthorized
Date: Fri, 05 Jan 2024 17:48:36 GMT
Content-Type: application/json; charset=utf-8
Connection: keep-alive
WWW-Authenticate: Key realm="kong"
Content-Length: 96
X-Kong-Response-Latency: 1
Server: kong/3.5.0
X-Kong-Request-Id: 2e0dbd1ac29f85282b68067dc25f032e

{
  "message":"No API key found in request",
  "request_id":"2e0dbd1ac29f85282b68067dc25f032e"
}% 
```

## Set up consumers and keys

Key authentication in Kong Gateway works by using the consumer object. Keys are assigned to consumers, and client applications present the key within the requests they make.

Keys are stored as Kubernetes Secrets and consumers are managed with the KongConsumer CRD.

## Create a new Secret where kongCredType=key-auth

```bash
kubectl create secret generic alex-key-auth \
  --from-literal=kongCredType=key-auth \
  --from-literal=key=hello_world

```

Remove new secret:

```bash
kubectl get secrets
alex-key-auth                         Opaque              2      34s
kubectl delete secret alex-key-auth
```

Create a new consumer and attach the credential.

```bash
echo "apiVersion: configuration.konghq.com/v1
kind: KongConsumer
metadata:
  name: alex
  annotations:
    kubernetes.io/ingress.class: kong
username: alex
credentials:
- alex-key-auth
" | kubectl apply -f -

```

Remove new consumer:

```bash
kubectl get kongconsumer                                 
NAME   USERNAME   AGE   PROGRAMMED
alex   alex       60s   True
kubectl delete kongconsumer alex
```

Make a request to the API and provide your apikey:

```bash
curl -H 'apikey: hello_world' $PROXY_IP/echo
Welcome, you are connected to node reports52.
Running on Pod echo-74c66b778-j2n45.
In namespace default.
With IP address 10.1.184.161.

```

## Next Steps

Congratulations! By making it this far you’ve deployed Kong Ingress Controller, configured a service and route, added rate limiting, proxy caching and API authentication all using your normal Kubernetes workflow.

You can learn more about the available plugins (including Kubernetes configuration instructions) on the **[Plugin Hub](https://docs.konghq.com/hub/)**. For more information about Kong Ingress Controller and how it works, see the **[architecture](https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/concepts/architecture/)** page.

<https://docs.konghq.com/kubernetes-ingress-controller/latest/plugins/custom/>
<https://insomnia.rest/>
