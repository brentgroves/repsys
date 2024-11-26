# **[Authentication Policy](https://istio.io/latest/docs/tasks/security/authentication/authn-policy)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

![j](https://cdn.sanity.io/images/141x4uzu/production/c4ac5fa7137769d84630fd3d1fac135b1ee94c39-6336x4292.png)

## references

- **[jwt.ms](https://jwt.ms/)**
- **[External Authorization via OIDC](https://www.digihunch.com/2022/02/istio-external-authorization/)**
- **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**

## Before you begin

Understand Istio authentication policy and related mutual TLS authentication concepts.

Install Istio on a Kubernetes cluster with the default configuration profile, as described in installation steps.

```bash
istioctl install --set profile=default
```

## Cleanup

```bash
kubectl delete ns foo
kubectl delete ns bar
kubectl delete ns legacy
```

By labeling the namespace with istio-injection=enabled, pods that are deployed into it will get Istio's sidecar automatically injected. Next, deploy the sample application by executing the following command from the istio-auth0-integration directory:

## Setup

Our examples use two namespaces foo and bar, with two services, httpbin and curl, both running with an Envoy proxy. We also use second instances of httpbin and curl running without the sidecar in the legacy namespace. If you’d like to use the same examples when trying the tasks, run the following:

```bash
pushd .
cd ~/Downloads/istio-1.24.1/
# kubectl config set-context $(kubectl config current-context) --namespace=demo
kubectl create ns foo
kubectl label namespace foo istio-injection=enabled
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n foo
kubectl apply -f <(istioctl kube-inject -f samples/curl/curl.yaml) -n foo
kubectl create ns bar
kubectl label namespace bar istio-injection=enabled
kubectl apply -f <(istioctl kube-inject -f samples/httpbin/httpbin.yaml) -n bar
kubectl apply -f <(istioctl kube-inject -f samples/curl/curl.yaml) -n bar
kubectl create ns legacy
kubectl apply -f samples/httpbin/httpbin.yaml -n legacy
kubectl apply -f samples/curl/curl.yaml -n legacy
```

You can verify setup by sending an HTTP request with curl from any curl pod in the namespace foo, bar or legacy to either httpbin.foo, httpbin.bar or httpbin.legacy. All requests should succeed with HTTP code 200.

For example, here is a command to check curl.bar to httpbin.foo reachability:

```bash
kubectl exec "$(kubectl get pod -l app=curl -n bar -o jsonpath={.items..metadata.name})" -c curl -n bar -- curl http://httpbin.foo:8000/ip -s -o /dev/null -w "%{http_code}\n"
200
```

This one-liner command conveniently iterates through all reachability combinations:

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl -s "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
curl.foo to httpbin.foo: 200
curl.foo to httpbin.bar: 200
curl.foo to httpbin.legacy: 200
curl.bar to httpbin.foo: 200
curl.bar to httpbin.bar: 200
curl.bar to httpbin.legacy: 200
curl.legacy to httpbin.foo: 200
curl.legacy to httpbin.bar: 200
curl.legacy to httpbin.legacy: 200
```

## **Verify there is no peer authentication policy in the system with the following command:**

```bash
kubectl get peerauthentication --all-namespaces
```

Last but not least, verify that there are no destination rules that apply on the example services. You can do this by checking the host: value of existing destination rules and make sure they do not match. For example:

```bash
kubectl get destinationrules.networking.istio.io --all-namespaces -o yaml | grep "host:"
```

Depending on the version of Istio, you may see destination rules for hosts other than those shown. However, there should be none with hosts in the foo, bar and legacy namespace, nor is the match-all wildcard *.

## Auto mutual TLS

By default, Istio tracks the server workloads migrated to Istio proxies, and configures client proxies to send mutual TLS traffic to those workloads automatically, and to send plain text traffic to workloads without sidecars.

Thus, all traffic between workloads with proxies uses mutual TLS, without you doing anything. For example, take the response from a request to httpbin/header. When using mutual TLS, the proxy injects the X-Forwarded-Client-Cert header to the upstream request to the backend. That header’s presence is evidence that mutual TLS is used. For example:

```bash
kubectl exec "$(kubectl get pod -l app=curl -n foo -o jsonpath={.items..metadata.name})" -c curl -n foo -- curl -s http://httpbin.foo:8000/headers -s | jq '.headers["X-Forwarded-Client-Cert"][0]' | sed 's/Hash=[a-z0-9]*;/Hash=<redacted>;/'
```

When the server doesn’t have sidecar, the X-Forwarded-Client-Cert header is not there, which implies requests are in plain text.

```bash
kubectl exec "$(kubectl get pod -l app=curl -n foo -o jsonpath={.items..metadata.name})" -c curl -n foo -- curl http://httpbin.legacy:8000/headers -s | grep X-Forwarded-Client-Cert
```

## Globally enabling Istio mutual TLS in STRICT mode

While Istio automatically upgrades all traffic between the proxies and the workloads to mutual TLS, workloads can still receive plain text traffic. To prevent non-mutual TLS traffic for the whole mesh, set a mesh-wide peer authentication policy with the mutual TLS mode set to STRICT. The mesh-wide peer authentication policy should not have a selector and must be applied in the root namespace, for example:

```yaml
kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "default"
  namespace: "istio-system"
spec:
  mtls:
    mode: STRICT
EOF
```

The example assumes istio-system is the root namespace. If you used a different value during installation, replace istio-system with the value you used.

This peer authentication policy configures workloads to only accept requests encrypted with TLS. Since it doesn’t specify a value for the selector field, the policy applies to all workloads in the mesh.

Run the test command again:

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
curl.foo to httpbin.foo: 200
curl.foo to httpbin.bar: 200
curl.foo to httpbin.legacy: 200
curl.bar to httpbin.foo: 200
curl.bar to httpbin.bar: 200
curl.bar to httpbin.legacy: 200
curl.legacy to httpbin.foo: 000
command terminated with exit code 56
curl.legacy to httpbin.bar: 000
command terminated with exit code 56
curl.legacy to httpbin.legacy: 200

```

You see requests still succeed, except for those from the client that doesn’t have proxy, curl.legacy, to the server with a proxy, httpbin.foo or httpbin.bar. This is expected because mutual TLS is now strictly required, but the workload without sidecar cannot comply.

## Cleanup part 1

Remove global authentication policy added in the session:

```bash
kubectl delete peerauthentication -n istio-system default
```

## Enable mutual TLS per namespace or workload

### Namespace-wide policy

To change mutual TLS for all workloads within a particular namespace, use a namespace-wide policy. The specification of the policy is the same as for a mesh-wide policy, but you specify the namespace it applies to under metadata. For example, the following peer authentication policy enables strict mutual TLS for the foo namespace:

```bash
kubectl apply -f - <<EOF
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "default"
  namespace: "foo"
spec:
  mtls:
    mode: STRICT
EOF
```

As this policy is applied on workloads in namespace foo only, you should see only request from client-without-sidecar (curl.legacy) to httpbin.foo start to fail.

Run the test command again:

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
curl.foo to httpbin.foo: 200
curl.foo to httpbin.bar: 200
curl.foo to httpbin.legacy: 200
curl.bar to httpbin.foo: 200
curl.bar to httpbin.bar: 200
curl.bar to httpbin.legacy: 200
curl.legacy to httpbin.foo: 000
command terminated with exit code 56
curl.legacy to httpbin.bar: 000
command terminated with exit code 56
curl.legacy to httpbin.legacy: 200

```

You see requests still succeed, except for those from the client that doesn’t have proxy, curl.legacy, to the server with a proxy, httpbin.foo or httpbin.bar. This is expected because mutual TLS is now strictly required, but the workload without sidecar cannot comply.

## Enable mutual TLS per workload

To set a peer authentication policy for a specific workload, you must configure the selector section and specify the labels that match the desired workload. For example, the following peer authentication policy enables strict mutual TLS for the httpbin.bar workload:

```bash
cat <<EOF | kubectl apply -n bar -f -
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "httpbin"
  namespace: "bar"
spec:
  selector:
    matchLabels:
      app: httpbin
  mtls:
    mode: STRICT
EOF
```

Run the test command again:

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done

curl.foo to httpbin.foo: 200
curl.foo to httpbin.bar: 200
curl.foo to httpbin.legacy: 200
curl.bar to httpbin.foo: 200
curl.bar to httpbin.bar: 200
curl.bar to httpbin.legacy: 200
curl.legacy to httpbin.foo: 000
command terminated with exit code 56
curl.legacy to httpbin.bar: 000
command terminated with exit code 56
curl.legacy to httpbin.legacy: 200

```

To refine the mutual TLS settings per port, you must configure the portLevelMtls section. For example, the following peer authentication policy requires mutual TLS on all ports, except port 8080:

```bash
cat <<EOF | kubectl apply -n bar -f -
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "httpbin"
  namespace: "bar"
spec:
  selector:
    matchLabels:
      app: httpbin
  mtls:
    mode: STRICT
  portLevelMtls:
    8080:
      mode: DISABLE
EOF
```

Run the test command again:

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
curl.foo to httpbin.foo: 200
curl.foo to httpbin.bar: 200
curl.foo to httpbin.legacy: 200
curl.bar to httpbin.foo: 200
curl.bar to httpbin.bar: 200
curl.bar to httpbin.legacy: 200
curl.legacy to httpbin.foo: 000
command terminated with exit code 56
curl.legacy to httpbin.bar: 200
curl.legacy to httpbin.legacy: 200

```

The port value in the peer authentication policy is the container’s port.
You can only use portLevelMtls if the port is bound to a service. Istio ignores it otherwise.

## Policy precedence

A workload-specific peer authentication policy takes precedence over a namespace-wide policy. You can test this behavior if you add a policy to disable mutual TLS for the httpbin.foo workload, for example. Note that you’ve already created a namespace-wide policy that enables mutual TLS for all services in namespace foo and observe that requests from curl.legacy to httpbin.foo are failing (see above).

```bash
$ cat <<EOF | kubectl apply -n foo -f -
apiVersion: security.istio.io/v1
kind: PeerAuthentication
metadata:
  name: "overwrite-example"
  namespace: "foo"
spec:
  selector:
    matchLabels:
      app: httpbin
  mtls:
    mode: DISABLE
EOF
```

Run the test command again:

```bash
for from in "foo" "bar" "legacy"; do for to in "foo" "bar" "legacy"; do kubectl exec "$(kubectl get pod -l app=curl -n ${from} -o jsonpath={.items..metadata.name})" -c curl -n ${from} -- curl "http://httpbin.${to}:8000/ip" -s -o /dev/null -w "curl.${from} to httpbin.${to}: %{http_code}\n"; done; done
curl.foo to httpbin.foo: 200
curl.foo to httpbin.bar: 200
curl.foo to httpbin.legacy: 200
curl.bar to httpbin.foo: 200
curl.bar to httpbin.bar: 200
curl.bar to httpbin.legacy: 200
curl.legacy to httpbin.foo: 200
curl.legacy to httpbin.bar: 200
curl.legacy to httpbin.legacy: 200
```

## Cleanup part 2

Remove policies created in the above steps:

```bash
kubectl get peerauthentication --all-namespaces                                         

NAMESPACE   NAME                MODE      AGE
bar         httpbin             STRICT    12m
foo         default             STRICT    20m
foo         overwrite-example   DISABLE   2m40s

kubectl delete peerauthentication default overwrite-example -n foo
kubectl delete peerauthentication httpbin -n bar
```

## **Configure the gateway:**

```bash
pushd .
cd ~/Downloads/istio-1.24.1/
kubectl apply -f samples/httpbin/httpbin-gateway.yaml -n foo
# or
kubectl apply -f - <<EOFk
apiVersion: networking.istio.io/v1
kind: Gateway
metadata:
  name: httpbin-gateway
spec:
  selector:
    istio: ingressgateway
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
# or
curl "localhost:8000/headers" -s -o /dev/null -w "%{http_code}\n"
503
curl -I "localhost:8000/headers"
```
