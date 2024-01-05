# Standard install of Kong Ingress Controller and Gateway

## references

<https://docs.konghq.com/gateway/latest/install/kubernetes/kubectl/>
<https://docs.konghq.com/gateway/latest/kong-manager-oss/>
<https://dev.to/robincher/securing-your-site-via-oidc-powered-by-kong-and-keycloak-2ccc>
<https://www.hcl-software.com/blog/versionvault/how-to-configure-microsoft-azure-active-directory-as-keycloak-identity-provider-to-enable-single-sign-on-for-hcl-compass>

## Install Kong Ingress Controller

<https://docs.konghq.com/gateway/latest/install/kubernetes/kubectl/>

Install the Gateway API CRDs before installing Kong Ingress Controller.

```bash
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml
```

To remove standard resources:

```bash
kubectl get crd
kubectl delete crd gatewayclasses.gateway.networking.k8s.io
kubectl delete crd gateways.gateway.networking.k8s.io
kubectl delete crd httproutes.gateway.networking.k8s.io
kubectl delete crd referencegrants.gateway.networking.k8s.io
```

Create a Gateway and GatewayClass instance to use.

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

## Install Kong

You can install Kong in your Kubernetes cluster using Helm.

Add the Kong Helm charts:

```bash
helm repo add kong https://charts.konghq.com
helm repo update
```

Install Kong Ingress Controller and Kong Gateway with Helm:

```bash
helm install kong kong/ingress -n kong --create-namespace 
```

To remove Kong Ingress Controller and Kong Gateway:

```bash
helm list -A
NAME            NAMESPACE       REVISION        UPDATED                                 STATUS          CHART                           APP VERSION
kong            kong            1               2024-01-04 16:30:16.756749098 -0500 EST deployed        ingress-0.10.1                  3.4  

helm uninstall kong -n kong

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

## Services and Routes

A Service inside Kubernetes is a way to abstract an application that is running on a set of Pods. This maps to two objects in Kong: Service and Upstream.

The service object in Kong holds the information of the protocol to use to talk to the upstream service and various other protocol specific settings. The Upstream object defines load-balancing and health-checking behavior.

![](https://docs.konghq.com/assets/images/products/kubernetes-ingress-controller/k8s-to-kong.png)

Routes are configured using Gateway API or Ingress resources, such as HTTPRoute, TCPRoute, GRPCRoute, Ingress and more.

In this tutorial, you will deploy an echo service which returns information about the Kubernetes cluster and route traffic to the service.

## Deploy an echo service

To proxy requests, you need an upstream application to send a request to. Deploying this echo server provides a simple application that returns information about the Pod it’s running in:

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

To remove echo route:

```bash
kubectl get httproute
NAME   HOSTNAMES   AGE
echo               18h
kubectl delete httproute echo
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

To remove echo ingress:

```bash
kubectl get ingress
NAME   CLASS   HOSTS   ADDRESS        PORTS   AGE
echo   kong    *       172.20.88.60   80      18h

kubectl delete ingress echo
```

Test the configuration
To test the configuration, make a call to the $PROXY_IP that you configured.

```bash
export PROXY_IP=$(kubectl get svc --namespace kong kong-gateway-proxy -o jsonpath='{.status.loadBalancer.ingress[0].ip}')
echo $PROXY_IP
curl $PROXY_IP/echo

```

<https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/get-started/rate-limiting/>

## Rate Limiting

Rate limiting is used to control the rate of requests sent to an upstream service. It can be used to prevent **[DoS attacks](<https://www.paloaltonetworks.com/cyberpedia/what-is-a-denial-of-service-attack-dos#:~:text=A%20Denial%2Dof%2DService%20(,information%20that%20triggers%20a%20crash>.)**, limit web scraping, and other forms of overuse. Without rate limiting, clients have unlimited access to your upstream services, which may negatively impact availability.

Kong Gateway imposes rate limits on clients through the Rate Limiting plugin. When rate limiting is enabled, clients are restricted in the number of requests that can be made in a configurable period of time. The plugin supports identifying clients as consumers based on authentication or by the client IP address of the requests.

<https://docs.konghq.com/hub/kong-inc/rate-limiting/>

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

Create a new Secret where kongCredType=key-auth.

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
# test http connection
curl -H 'apikey: hello_world' $PROXY_IP/echo
Welcome, you are connected to node reports52.
Running on Pod echo-74c66b778-j2n45.
In namespace default.
With IP address 10.1.184.161.

# test https connection
curl -H 'apikey: hello_world' https://10.1.0.8/echo
curl: (60) SSL certificate problem: self-signed certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

## change default ssl certificate

```bash
# https://support.konghq.com/support/s/article/How-to-setup-Kong-to-serve-an-SSL-certificate-for-API-requests

curl -k -X POST \
  https://kong.lan:8444/certificates \
  -H 'Content-Type: multipart/form-data' \
  -F cert=@./kong.lan.pem \
  -F key=@./kong.lan.key \
  -F snis[]=kong.lan
  
# https://stackoverflow.com/questions/71998636/kong-api-gateway-ssl-tls-certificates

curl -X POST \
  http://example.com:8001/certificates \
  -H 'Content-Type: multipart/form-data' \
  -F cert=@./kong.ca-bundle \
  -F key=@./kong.key \
  -F snis[]=example.com
```

## Next Steps

Congratulations! By making it this far you’ve deployed Kong Ingress Controller, configured a service and route, added rate limiting, proxy caching and API authentication all using your normal Kubernetes workflow.

You can learn more about the available plugins (including Kubernetes configuration instructions) on the **[Plugin Hub](https://docs.konghq.com/hub/)**. For more information about Kong Ingress Controller and how it works, see the **[architecture](https://docs.konghq.com/kubernetes-ingress-controller/3.0.x/concepts/architecture/)** page.

<https://docs.konghq.com/kubernetes-ingress-controller/latest/plugins/custom/>
<https://insomnia.rest/>
