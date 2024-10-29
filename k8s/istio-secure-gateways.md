# **[Secure Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

The **[Control Ingress Traffic](https://istio.io/latest/docs/tasks/traffic-management/ingress/ingress-control/)** task describes how to configure an ingress gateway to expose an HTTP service to external traffic. This task shows how to expose a secure HTTPS service using either simple or mutual TLS.

Istio supports the Kubernetes Gateway API and intends to make it the default API for traffic management in the future. The following instructions allow you to choose to use either the Gateway API or the Istio configuration API when configuring traffic management in the mesh. Follow instructions under either the Gateway API or Istio APIs tab, according to your preference.

Note that the Kubernetes Gateway API CRDs do not come installed by default on most Kubernetes clusters, so make sure they are installed before using the Gateway API:

```bash
kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.1.0/standard-install.yaml; }
```

## Before you begin

Setup Istio by following the instructions in the Installation guide.

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

## Generate client and server certificates and keys

This task requires several sets of certificates and keys which are used in the following examples. You can use your favorite tool to create them or use the commands below to generate them using openssl.

Create a root certificate and private key to sign the certificates for your services:

```bash
pushd .
cd ~/src/repsys/k8s/istio
mkdir example_certs1
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example_certs1/example.com.key -out example_certs1/example.com.crt

# The req command primarily creates and processes certificate requests in PKCS#10 format. It can additionally create self-signed certificates, for use as root CAs, for example.
# -nodes param. Do not encrypt the private key.
# -sha256 param. The message digest to sign the request with. 
# -x509 param. Output a self-signed certificate instead of a certificate request. This is typically used to generate a test certificate or a self-signed root CA. The extensions added to the certificate (if any) are specified in the configuration file. Unless specified using the -set_serial option, 0 is used for the serial number.
# -CAfile file, -CApath directory. A file or path containing trusted CA certificates, used to verify the signature on the OCSP response.
# OCSP stands for Online Certificate Status Protocol and is used by Certificate Authorities to check the revocation status of an X.509 digital certificate.
# CAkey file. Set the CA private key to sign a certificate with. Otherwise it is assumed that the CA private key is present in the CA certificate file.
# newkey arg
# Create a new certificate request and a new private key. The argument takes one of several forms.
# rsa:nbits generates an RSA key nbits in size. If nbits is omitted, the default key size is used.

# dsa:file generates a DSA key using the parameters in file.

# param:file generates a key using the parameters or certificate in file.

# All other algorithms support the form algorithm:file, where file may be an algorithm parameter file, created by the genpkey -genparam command or an X.509 certificate for a key with appropriate algorithm. file can be omitted, in which case any parameters can be specified via the -pkeyopt option.
```

## Generate a certificate and a private key for httpbin.example.com

```bash
pushd .
cd ~/src/repsys/k8s/istio

openssl req -out example_certs1/httpbin.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs1/httpbin.example.com.key -subj "/CN=httpbin.example.com/O=httpbin organization"
openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 0 -in example_certs1/httpbin.example.com.csr -out example_certs1/httpbin.example.com.crt
Certificate request self-signature ok
subject=CN = httpbin.example.com, O = httpbin organization
```

## Create a second set of the same kind of certificates and keys

```bash
pushd .
cd ~/src/repsys/k8s/istio

mkdir example_certs2
openssl req -x509 -sha256 -nodes -days 365 -newkey rsa:2048 -subj '/O=example Inc./CN=example.com' -keyout example_certs2/example.com.key -out example_certs2/example.com.crt
openssl req -out example_certs2/httpbin.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs2/httpbin.example.com.key -subj "/CN=httpbin.example.com/O=httpbin organization"
openssl x509 -req -sha256 -days 365 -CA example_certs2/example.com.crt -CAkey example_certs2/example.com.key -set_serial 0 -in example_certs2/httpbin.example.com.csr -out example_certs2/httpbin.example.com.crt
Certificate request self-signature ok
subject=CN = httpbin.example.com, O = httpbin organization
```

## Generate a certificate and a private key for helloworld.example.com

```bash
pushd .
cd ~/src/repsys/k8s/istio

openssl req -out example_certs1/helloworld.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs1/helloworld.example.com.key -subj "/CN=helloworld.example.com/O=helloworld organization"
openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 1 -in example_certs1/helloworld.example.com.csr -out example_certs1/helloworld.example.com.crt
Certificate request self-signature ok
subject=CN = helloworld.example.com, O = helloworld organization
```

## Generate a client certificate and private key

```bash
pushd .
cd ~/src/repsys/k8s/istio

openssl req -out example_certs1/client.example.com.csr -newkey rsa:2048 -nodes -keyout example_certs1/client.example.com.key -subj "/CN=client.example.com/O=client organization"
openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 1 -in example_certs1/client.example.com.csr -out example_certs1/client.example.com.crt
Certificate request self-signature ok
subject=CN = client.example.com, O = client organization
```

You can confirm that you have all of the needed files by running the following command:

```bash
pushd .
cd ~/src/repsys/k8s/istio

ls example_cert*
example_certs1:
client.example.com.crt          example.com.key                 httpbin.example.com.crt
client.example.com.csr          helloworld.example.com.crt      httpbin.example.com.csr
client.example.com.key          helloworld.example.com.csr      httpbin.example.com.key
example.com.crt                 helloworld.example.com.key

example_certs2:
example.com.crt         httpbin.example.com.crt httpbin.example.com.key
example.com.key         httpbin.example.com.csr
```

## Configure a TLS ingress gateway for a single host

Create a secret for the ingress gateway:

```bash
pushd .
cd ~/src/repsys/k8s/istio

kubectl create -n istio-system secret tls httpbin-credential \
  --key=example_certs1/httpbin.example.com.key \
  --cert=example_certs1/httpbin.example.com.crt

secret/httpbin-credential created  
```

## Configure the ingress gateway

First, create a Kubernetes Gateway:

```bash
cat <<EOF | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: mygateway
  namespace: istio-system
spec:
  gatewayClassName: istio
  listeners:
  - name: https
    hostname: "httpbin.example.com"
    port: 443
    protocol: HTTPS
    tls:
      mode: Terminate
      certificateRefs:
      - name: httpbin-credential
    allowedRoutes:
      namespaces:
        from: Selector
        selector:
          matchLabels:
            kubernetes.io/metadata.name: default
EOF

gateway.gateway.networking.k8s.io/mygateway created
```

## Next, configure the gateway’s ingress traffic routes by defining a corresponding HTTPRoute

```bash
cat <<EOF | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: httpbin
spec:
  parentRefs:
  - name: mygateway
    namespace: istio-system
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

httproute.gateway.networking.k8s.io/httpbin created
```

## Finally, get the gateway address and port from the Gateway resource

```bash
kubectl wait --for=condition=programmed gtw mygateway -n istio-system
gateway.gateway.networking.k8s.io/mygateway condition met
export INGRESS_HOST=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.status.addresses[0].value}')
echo $INGRESS_HOST
10.1.0.144
export SECURE_INGRESS_PORT=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.spec.listeners[?(@.name=="https")].port}')
echo $SECURE_INGRESS_PORT
443
```

## Send an HTTPS request to access the httpbin service through HTTPS

```bash
pushd .
cd ~/src/repsys/k8s/istio

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
...
* Connection #0 to host httpbin.example.com left intact
I'm a teapot!%  
```

The httpbin service will return the 418 I’m a Teapot code.

Change the gateway’s credentials by deleting the gateway’s secret and then recreating it using different certificates and keys:

```bash
pushd .
cd ~/src/repsys/k8s/istio

kubectl -n istio-system delete secret httpbin-credential
kubectl create -n istio-system secret tls httpbin-credential \
  --key=example_certs2/httpbin.example.com.key \
  --cert=example_certs2/httpbin.example.com.crt
  secret/httpbin-credential created
```

## Access the httpbin service with curl using the new certificate chain

```bash
pushd .
cd ~/src/repsys/k8s/istio

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs2/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
  * Connection #0 to host httpbin.example.com left intact
I'm a teapot!% 
```

## If you try to access httpbin using the previous certificate chain, the attempt now fails

```bash
pushd .
cd ~/src/repsys/k8s/istio

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

...
* TLSv1.2 (OUT), TLS header, Unknown (21):
* TLSv1.3 (OUT), TLS alert, decrypt error (563):
* error:0200008A:rsa routines::invalid padding
* Closing connection 0
curl: (35) error:0200008A:rsa routines::invalid padding
```

## Configure a TLS ingress gateway for multiple hosts

You can configure an ingress gateway for multiple hosts, httpbin.example.com and helloworld.example.com, for example. The ingress gateway is configured with unique credentials corresponding to each host.

Restore the httpbin credentials from the previous example by deleting and recreating the secret with the original certificates and keys:

```bash
pushd .
cd ~/src/repsys/k8s/istio

kubectl -n istio-system delete secret httpbin-credential
kubectl create -n istio-system secret tls httpbin-credential \
  --key=example_certs1/httpbin.example.com.key \
  --cert=example_certs1/httpbin.example.com.crt
  secret/httpbin-credential created
```

## Start the helloworld-v1 sample

```bash
pushd .
cd ~/src/repsys/k8s/istio

cp ~/Downloads/istio-1.23.2/samples/helloworld/helloworld.yaml ./helloworld/
# -l deploys only objects with that label
kubectl apply -f ./helloworld/helloworld.yaml -l service=helloworld
service/helloworld created
kubectl apply -f ./helloworld/helloworld.yaml -l version=v1
deployment.apps/helloworld-v1 created

```

## Create a helloworld-credential secret

```bash
pushd .
cd ~/src/repsys/k8s/istio

kubectl create -n istio-system secret tls helloworld-credential \
  --key=example_certs1/helloworld.example.com.key \
  --cert=example_certs1/helloworld.example.com.crt
secret/helloworld-credential created
```

## Configure the ingress gateway with hosts httpbin.example.com and helloworld.example.com

Configure a Gateway with two listeners for port 443. Set the value of certificateRefs on each listener to httpbin-credential and helloworld-credential respectively.

```bash
pushd .
cd ~/src/repsys/k8s/istio
cat <<EOF | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: mygateway
  namespace: istio-system
spec:
  gatewayClassName: istio
  listeners:
  - name: https-httpbin
    hostname: "httpbin.example.com"
    port: 443
    protocol: HTTPS
    tls:
      mode: Terminate
      certificateRefs:
      - name: httpbin-credential
    allowedRoutes:
      namespaces:
        from: Selector
        selector:
          matchLabels:
            kubernetes.io/metadata.name: default
  - name: https-helloworld
    hostname: "helloworld.example.com"
    port: 443
    protocol: HTTPS
    tls:
      mode: Terminate
      certificateRefs:
      - name: helloworld-credential
    allowedRoutes:
      namespaces:
        from: Selector
        selector:
          matchLabels:
            kubernetes.io/metadata.name: default
EOF
gateway.gateway.networking.k8s.io/mygateway configured
```

Configure the gateway’s traffic routes for the helloworld service

```bash
cat <<EOF | kubectl apply -f -
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: helloworld
spec:
  parentRefs:
  - name: mygateway
    namespace: istio-system
  hostnames: ["helloworld.example.com"]
  rules:
  - matches:
    - path:
        type: Exact
        value: /hello
    backendRefs:
    - name: helloworld
      port: 5000
EOF
```

## Send an HTTPS request to helloworld.example.com

```bash
curl -v -HHost:helloworld.example.com --resolve "helloworld.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://helloworld.example.com:$SECURE_INGRESS_PORT/hello"
...
* Connection #0 to host helloworld.example.com left intact
```

## Send an HTTPS request to httpbin.example.com and still get a teapot in return

```bash
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
...
* Connection #0 to host httpbin.example.com left intact
I'm a teapot!%   
```
