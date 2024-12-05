# **[End-user Authentication](https://istio.io/latest/docs/tasks/security/authentication/authn-policy/#end-user-authentication)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

![j](https://cdn.sanity.io/images/141x4uzu/production/c4ac5fa7137769d84630fd3d1fac135b1ee94c39-6336x4292.png)

## references

- **[jwt.ms](https://jwt.ms/)**
- **[External Authorization via OIDC](https://www.digihunch.com/2022/02/istio-external-authorization/)**
- **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**

To experiment with this feature, you need a valid JWT. The JWT must correspond to the JWKS endpoint you want to use for the demo. This tutorial uses the test token **[JWT test](https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt)** and **[JWKS endpoint](https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/jwks.json)** from the Istio code base.

Also, for convenience, expose httpbin.foo via an ingress gateway (for more details, see the **[ingress task](https://istio.io/latest/docs/tasks/traffic-management/ingress/)**).

Istio supports the Kubernetes Gateway API and intends to make it the default API for traffic management in the future. The following instructions allow you to choose to use either the Gateway API or the Istio configuration API when configuring traffic management in the mesh. Follow instructions under either the Gateway API or Istio APIs tab, according to your preference.

Note that the Kubernetes Gateway API CRDs do not come installed by default on most Kubernetes clusters, so make sure they are installed before using the Gateway API:

```bash
$ kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml; }
```

## Before you begin

Understand Istio authentication policy and related mutual TLS authentication concepts.

Install Istio on a Kubernetes cluster with the default configuration profile, as described in installation steps.

```bash
scc.sh kind.yaml kind-kind
kubectl port-forward -n istio-system svc/istio-ingressgateway 8000:80 
istioctl install --set profile=default
```

## Cleanup

```bash
kubectl delete ns foo
```

## Setup

```bash
pushd .
cd ~/Downloads/istio-1.24.1/
scc.sh aks_repsys1.yaml repsys1 
scc.sh kind.yaml kind-kind
kubectl create ns foo
kubectl label namespace foo istio-injection=enabled
# or for aks
kubectl label namespace foo istio.io/rev=asm-1-22

kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n foo
# above gives error on aks
# Error: could not read valid configmap "istio" from namespace "istio-system": configmaps "istio" not found - Use --meshConfigFile or re-run kube-inject with `-i <istioSystemNamespace> and ensure valid MeshConfig exists
# or for aks
kubectl apply -f samples/httpbin/httpbin.yaml -n foo
serviceaccount/httpbin created
service/httpbin created
deployment.apps/httpbin created
```

## **Configure the gateway:**

```bash
pushd .
cd ~/Downloads/istio-1.24.1/
kubectl apply -f samples/httpbin/httpbin-gateway.yaml -n foo
# or for aks
kubectl apply -n foo -f - <<EOFk
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: aks-istio-ingressgateway-external
  servers:
  - port:
      number: 80
      name: http
      protocol: HTTP
    hosts:
    - "*"
---
apiVersion: networking.istio.io/v1
kind: VirtualService
metadata:
  name: httpbin
spec:
  hosts:
  - "*"
  gateways:
  - httpbin-gateway
  http:
  - route:
    - destination:
        host: httpbin
        port:
          number: 8000
EOF
gateway.networking.istio.io/httpbin-gateway created
virtualservice.networking.istio.io/httpbin created
```

Follow the instructions in Determining the ingress IP and ports to define the INGRESS_PORT and INGRESS_HOST environment variables.

```bash
export INGRESS_NAME=istio-ingressgateway
export INGRESS_NS=istio-system
# Kind does not support loadbalancer without a plugin
kubectl get svc "$INGRESS_NAME" -n "$INGRESS_NS"
NAME                   TYPE           CLUSTER-IP     EXTERNAL-IP   PORT(S)                                                                      AGE
istio-ingressgateway   LoadBalancer   10.96.20.134   <pending>     15021:32564/TCP,80:31067/TCP,443:32190/TCP,31400:32692/TCP,15443:30233/TCP   24h
# use port-forward command instead
kubectl port-forward -n istio-system svc/istio-ingressgateway 8000:80
```

## **Run a test query through the gateway:**

Run a test query through the gateway:

```bash
curl "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
# or for kind cluster
curl "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"
200
curl -I "localhost:8000/headers"
HTTP/1.1 200 OK
access-control-allow-credentials: true
access-control-allow-origin: *
content-type: application/json; charset=utf-8
date: Tue, 26 Nov 2024 23:30:11 GMT
x-envoy-upstream-service-time: 2
server: istio-envoy
transfer-encoding: chunked
```

Now, add a request authentication policy that requires end-user JWT for the ingress gateway.

```bash
kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: RequestAuthentication
metadata:
  name: "jwt-example"
  namespace: istio-system
spec:
  selector:
    matchLabels:
      istio: ingressgateway
  jwtRules:
  - issuer: "testing@secure.istio.io"
    jwksUri: "https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/jwks.json"
EOF
```

Apply the policy in the namespace of the workload it selects, the ingress gateway in this case.

If you provide a token in the authorization header, its implicitly default location, Istio validates the token using the public key set, and rejects requests if the bearer token is invalid. However, requests without tokens are accepted. To observe this behavior, retry the request without a token, with a bad token, and with a valid token:

## no token

```bash
curl "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"
curl "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
# or for kind cluster
curl "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"
200
```

## bad token

```bash
curl --header "Authorization: Bearer deadbeef" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
# or for kind cluster
curl --header "Authorization: Bearer deadbeef" "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"
401
```

## good token

```bash
TOKEN=$(curl https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt -s)

curl --header "Authorization: Bearer $TOKEN" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
# or for kind cluster
curl --header "Authorization: Bearer $TOKEN" "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"
```

To observe other aspects of JWT validation, use the script gen-jwt.py to generate new tokens to test with different issuer, audiences, expiry date, etc. The script can be downloaded from the Istio repository:

```bash
pushd .
cd ~/Downloads/istio-1.24.1/

wget --no-verbose https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/gen-jwt.py
```

You also need the key.pem file:

```bash
wget --no-verbose https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/key.pem
```

Download the **[jwcrypto library](https://pypi.org/project/jwcrypto)**, if you haven’t installed it on your system.

```bash
pip install jwcrypto
```

The JWT authentication has 60 seconds clock skew, this means the JWT token will become valid 60 seconds earlier than its configured nbf and remain valid 60 seconds after its configured exp.

For example, the command below creates a token that expires in 5 seconds. As you see, Istio authenticates requests using that token successfully at first but rejects them after 65 seconds:

```bash
TOKEN=$(python3 ./gen-jwt.py ./key.pem --expire 5)
for i in $(seq 1 10); do curl --header "Authorization: Bearer $TOKEN" "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"; sleep 10; done
# or kind cluster
TOKEN=$(python3 ./gen-jwt.py ./key.pem --expire 5)
for i in $(seq 1 10); do curl --header "Authorization: Bearer $TOKEN" "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"; sleep 10; done

200
200
200
200
200
200
200
401
401
401
```

You can also add a JWT policy to an ingress gateway (e.g., service istio-ingressgateway.istio-system.svc.cluster.local). This is often used to define a JWT policy for all services bound to the gateway, instead of for individual services.
