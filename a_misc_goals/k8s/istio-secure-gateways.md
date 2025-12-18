# **[Secure Gateways](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Specific K8s Instructions

- **[Azure AKS](../../azure/mobexglobal.com/aks/istio_secure_gateway_linamar.md)**
- **[Kind](../../k8s/kind/istio_secure_gateway_linamar.md)**

## Generic Instructions

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
# cd ~/Downloads/istio-1.23.0
# kubectl apply -f samples/httpbin/httpbin.yaml

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

# convert to pkcs12 format
openssl pkcs12 -export -out example_certs1/client.example.com.p12.crt -inkey example_certs1/client.example.com.key -in example_certs1/client.example.com.crt

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

kubectl get secret -n istio-system httpbin-credential -o json | jq -r '.data."tls.crt"' | base64 -d
kubectl get secret -n istio-system httpbin-credential -o json | jq -r '.data."tls.key"' | base64 -d

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

Because creating a Kubernetes Gateway resource will also deploy an associated proxy service, run the following command to wait for the gateway to be ready:

```bash
kubectl wait --for=condition=programmed gtw httpbin-gateway
gateway.gateway.networking.k8s.io/httpbin-gateway condition met

kubectl describe gtw mygateway -n istio-system
...
    Last Transition Time:  2024-10-29T22:22:11Z
    Message:               Resource programmed, assigned to service(s) mygateway-istio.istio-system.svc.cluster.local:443
    Observed Generation:   2
    Reason:                Programmed
    Status:                True
    Type:                  Programmed
...    
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

Because creating a Kubernetes Gateway resource will also deploy an associated proxy service, run the following command to wait for the gateway to be ready:

```bash
kubectl wait --for=condition=programmed gtw httpbin-gateway
gateway.gateway.networking.k8s.io/httpbin-gateway condition met

kubectl get gtw mygateway -n istio-system -o jsonpath='{.status.conditions}'
kubectl get gtw mygateway -n istio-system -o json | jq -r '.status."conditions"'

kubectl describe gtw mygateway -n istio-system
...
    Last Transition Time:  2024-10-29T22:22:11Z
    Message:               Resource programmed, assigned to service(s) mygateway-istio.istio-system.svc.cluster.local:443
    Observed Generation:   2
    Reason:                Programmed
    Status:                True
    Type:                  Programmed
...    

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

## Set env variables

```bash
export INGRESS_HOST=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.status.addresses[0].value}')
echo $INGRESS_HOST
10.1.0.144
export SECURE_INGRESS_PORT=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.spec.listeners[?(@.name=="https-helloworld")].port}')
echo $SECURE_INGRESS_PORT
443
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

## Configure a mutual TLS ingress gateway

You can extend your gateway’s definition to support **[mutual TLS](https://en.wikipedia.org/wiki/Mutual_authentication)**.

### 1. Change the credentials of the ingress gateway by deleting its secret and creating a new one. The server uses the CA certificate to verify its clients, and we must use the key ca.crt to hold the CA certificate

```bash
pushd .
cd ~/src/repsys/k8s/istio

kubectl -n istio-system delete secret httpbin-credential
kubectl create -n istio-system secret generic httpbin-credential \
  --from-file=tls.key=example_certs1/httpbin.example.com.key \
  --from-file=tls.crt=example_certs1/httpbin.example.com.crt \
  --from-file=ca.crt=example_certs1/example.com.crt
secret/httpbin-credential created 

```

Optionally, the credential may include a certificate revocation list (CRL) using the key ca.crl. If so, add another argument to the above example to provide the CRL: –from-file=ca.crl=/some/path/to/your-crl.pem.

The credential may also include an OCSP Staple using the key tls.ocsp-staple which can be specified by an additional argument: --from-file=tls.ocsp-staple=/some/path/to/your-ocsp-staple.pem.

### 2. Configure the ingress gateway

Because the Kubernetes Gateway API does not currently support mutual TLS termination in a Gateway, we use an Istio-specific option, gateway.istio.io/tls-terminate-mode: MUTUAL, to configure it:

```yaml
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
      options:
        gateway.istio.io/tls-terminate-mode: MUTUAL
    allowedRoutes:
      namespaces:
        from: Selector
        selector:
          matchLabels:
            kubernetes.io/metadata.name: default
EOF
gateway.gateway.networking.k8s.io/mygateway configured
```

## Set mTLS env variables

```bash
export INGRESS_HOST=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.status.addresses[0].value}')
echo $INGRESS_HOST
10.1.0.144
export SECURE_INGRESS_PORT=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.spec.listeners[?(@.name=="https-helloworld")].port}')
export SECURE_INGRESS_PORT=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.spec.listeners[?(@.name=="https")].port}')

echo $SECURE_INGRESS_PORT
443
```

### 3. Attempt to send an HTTPS request using the prior approach and see how it fails

```bash
pushd .
cd ~/src/repsys/k8s/istio

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
--cacert example_certs1/example.com.crt "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
...
* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS alert, unknown (628):
* OpenSSL SSL_read: error:0A00045C:SSL routines::tlsv13 alert certificate required, errno 0
* Failed receiving HTTP2 data
* OpenSSL SSL_write: SSL_ERROR_ZERO_RETURN, errno 0
* Failed sending HTTP2 data
* Connection #0 to host httpbin.example.com left intact
curl: (56) OpenSSL SSL_read: error:0A00045C:SSL routines::tlsv13 alert certificate required, errno 0
```

### 4.Pass a client certificate and private key to curl and resend the request

Pass your client’s certificate with the --cert flag and your private key with the --key flag to curl:

```bash
pushd .
cd ~/src/repsys/k8s/istio

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/client.example.com.crt --key example_certs1/client.example.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
...
  * Connection #0 to host httpbin.example.com left intact
I'm a teapot!%  

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/httpbin.example.com.crt --key example_certs1/httpbin.example.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
...
  * Connection #0 to host httpbin.example.com left intact
I'm a teapot!%  

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/helloworld.example.com.crt --key example_certs1/helloworld.example.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"
* Connection #0 to host httpbin.example.com left intact
I'm a teapot!%   
```

```bash

curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/client.bookinfo.com.crt --key example_certs1/client.bookinfo.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

* TLSv1.2 (IN), TLS header, Supplemental data (23):
* TLSv1.3 (IN), TLS alert, unknown CA (560):
* OpenSSL SSL_read: error:0A000418:SSL routines::tlsv1 alert unknown ca, errno 0
* Failed receiving HTTP2 data
* OpenSSL SSL_write: SSL_ERROR_ZERO_RETURN, errno 0
* Failed sending HTTP2 data
* Connection #0 to host httpbin.example.com left intact
curl: (56) OpenSSL SSL_read: error:0A000418:SSL routines::tlsv1 alert unknown ca, errno 0  


```

Note: The client certificate has to be signed by the ca.crt.

```bash
kubectl create -n istio-system secret generic httpbin-credential \
  --from-file=tls.key=example_certs1/httpbin.example.com.key \
  --from-file=tls.crt=example_certs1/httpbin.example.com.crt \
  --from-file=ca.crt=example_certs1/example.com.crt
secret/httpbin-credential created 

# This works because helloworld.example.com.crt was signed by example_certs1/example.com.crt
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/helloworld.example.com.crt --key example_certs1/helloworld.example.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

openssl x509 -req -sha256 -days 365 -CA example_certs1/example.com.crt -CAkey example_certs1/example.com.key -set_serial 1 -in example_certs1/helloworld.example.com.csr -out example_certs1/helloworld.example.com.crt

# This works because helloworld.example.com.crt was signed by example_certs1/example.com.crt
curl -v -HHost:httpbin.example.com --resolve "httpbin.example.com:$SECURE_INGRESS_PORT:$INGRESS_HOST" \
  --cacert example_certs1/example.com.crt --cert example_certs1/client.bookinfo.com.crt --key example_certs1/client.bookinfo.com.key \
  "https://httpbin.example.com:$SECURE_INGRESS_PORT/status/418"

* OpenSSL SSL_read: error:0A000418:SSL routines::tlsv1 alert unknown ca, errno 0
* Failed receiving HTTP2 data
* OpenSSL SSL_write: SSL_ERROR_ZERO_RETURN, errno 0
* Failed sending HTTP2 data
* Connection #0 to host httpbin.example.com left intact
curl: (56) OpenSSL SSL_read: error:0A000418:SSL routines::tlsv1 alert unknown ca, errno 0
```

## Try in browser <https://httpbin.example.com/status/418>

```bash
Access to httpbin.example.com was denied
httpbin.example.com didn’t accept your login certificate, or one may not have been provided.
Try contacting the system admin.
ERR_BAD_SSL_CLIENT_AUTH_CERT
```

### Import Client certificate

Since we generated this certificate we have the private key which is used on the client as the server uses the server private key.  To import into chrome type "chrome://settings/certificates" and select the import button from the your certificates tab.

```bash
openssl pkcs12 -export -out example_certs1/client.example.com.p12.crt -inkey example_certs1/client.example.com.key -in example_certs1/client.example.com.crt
```

## Set all env variables

```bash
export INGRESS_HOST=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.status.addresses[0].value}')
echo $INGRESS_HOST
10.1.0.144
export SECURE_INGRESS_PORT=$(kubectl get gtw mygateway -n istio-system -o jsonpath='{.spec.listeners[?(@.name=="https")].port}')
echo $SECURE_INGRESS_PORT
443
```
