# **[HTTPS termination](https://docs.nginx.com/nginx-gateway-fabric/how-to/traffic-management/https-termination/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Clean-up

```bash
pushd .
cd ~/src/repsysk8s/nginx_gateway_fabric
kubectl delete httproute coffee
kubectl delete gateway cafe
kubectl delete deployment coffee
kubectl delete svc coffee
# aks
scc.sh reports-aks-user.yaml reports-aks

# microk8s
scc.sh repsys11c2n1.yaml microk8s 

```

![types](https://gateway-api.sigs.k8s.io/images/tls-termination-types.png)

## HTTPS termination

Learn how to terminate HTTPS traffic using NGINX Gateway Fabric.

## Overview

In this guide, we will show how to configure HTTPS termination for your application, using an HTTPRoute redirect filter, secret, and ReferenceGrant.

## Before you begin

**[Install](../../../k8s/nginx_gateway_fabric_install.md)** NGINX Gateway Fabric.

Save the **public IP address and port** of NGINX Gateway Fabric into shell variables:

```bash
pushd .
cd ~/src/repsys/k8s/nginx_gate_fabric

# microk8s
scc.sh repsys11c2n1.yaml microk8s 

kubectl get svc nginx-gateway -n nginx-gateway
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
nginx-gateway   LoadBalancer   10.152.183.50   10.1.0.143    80:30833/TCP,443:31343/TCP   82s

GW_IP=10.1.0.143
GW_PORT=80

# Save the ports of NGINX Gateway Fabric:
# I don't know what this is refering to but
# maybe it is the ports being used by the cluster ip


GW_HTTP_PORT=80
GW_HTTPS_PORT=443

# Azure aks
scc.sh reports-aks-user.yaml reports-aks
kubectl get svc nginx-gateway -n nginx-gateway
NAME            TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE
nginx-gateway   LoadBalancer   10.0.160.21   52.228.166.50   80:30244/TCP,443:31999/TCP   3d22h

GW_IP=52.228.166.50
GW_PORT=80

# Save the ports of NGINX Gateway Fabric:
# Don't know what this is for so be careful with these variables.
GW_HTTP_PORT=80
GW_HTTPS_PORT=443

```

**Note:**\

In a production environment, you should have a DNS record for the external IP address that is exposed, and it should refer to the hostname that the gateway will forward for.

## Set up

Create the coffee application in Kubernetes by copying and pasting the following block into your terminal:

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: coffee
spec:
  replicas: 1
  selector:
    matchLabels:
      app: coffee
  template:
    metadata:
      labels:
        app: coffee
    spec:
      containers:
      - name: coffee
        image: nginxdemos/nginx-hello:plain-text
        ports:
        - containerPort: 8080
---
apiVersion: v1
kind: Service
metadata:
  name: coffee
spec:
  ports:
  - port: 80
    targetPort: 8080
    protocol: TCP
    name: http
  selector:
    app: coffee
EOF
deployment.apps/coffee created
service/coffee created

kubectl get deployments                       
NAME     READY   UP-TO-DATE   AVAILABLE   AGE
coffee   1/1     1            1           27s

kubectl get svc                               
NAME         TYPE        CLUSTER-IP    EXTERNAL-IP   PORT(S)   AGE
coffee       ClusterIP   10.0.141.37   <none>        80/TCP    43s
kubernetes   ClusterIP   10.0.0.1      <none>        443/TCP   569d

kubectl get pods    
NAME                     READY   STATUS    RESTARTS   AGE
coffee-9bf875848-vgjx6   1/1     Running   0          7m56s
```

## Configure HTTPS termination and routing

For the HTTPS, we need a certificate and key that are stored in a secret. This secret will live in a separate namespace, so we will need a **[ReferenceGrant](../../a_l/k8s/gateway_api/reference_grant.md)** in order to access it.

To **[create the certificate](../../a_l/k8s/secrets/secrets.md#tls-secrets)** namespace and secret, copy and paste the following into your terminal:

```bash
kubectl apply -f - <<EOF
apiVersion: v1
kind: Namespace
metadata:
  name: certificate
---
apiVersion: v1
kind: Secret
metadata:
  name: cafe-secret
  namespace: certificate
type: kubernetes.io/tls
data:
  tls.crt: LS0tLS1CRUdJTiBDRVJUSUZJQ0FURS0tLS0tCk1JSUNzakNDQVpvQ0NRQzdCdVdXdWRtRkNEQU5CZ2txaGtpRzl3MEJBUXNGQURBYk1Sa3dGd1lEVlFRRERCQmoKWVdabExtVjRZVzF3YkdVdVkyOXRNQjRYRFRJeU1EY3hOREl4TlRJek9Wb1hEVEl6TURjeE5ESXhOVEl6T1ZvdwpHekVaTUJjR0ExVUVBd3dRWTJGbVpTNWxlR0Z0Y0d4bExtTnZiVENDQVNJd0RRWUpLb1pJaHZjTkFRRUJCUUFECmdnRVBBRENDQVFvQ2dnRUJBTHFZMnRHNFc5aStFYzJhdnV4Q2prb2tnUUx1ek10U1Rnc1RNaEhuK3ZRUmxIam8KVzFLRnMvQVdlS25UUStyTWVKVWNseis4M3QwRGtyRThwUisxR2NKSE50WlNMb0NEYUlRN0Nhck5nY1daS0o4Qgo1WDNnVS9YeVJHZjI2c1REd2xzU3NkSEQ1U2U3K2Vab3NPcTdHTVF3K25HR2NVZ0VtL1Q1UEMvY05PWE0zZWxGClRPL051MStoMzROVG9BbDNQdTF2QlpMcDNQVERtQ0thaEROV0NWbUJQUWpNNFI4VERsbFhhMHQ5Z1o1MTRSRzUKWHlZWTNtdzZpUzIrR1dYVXllMjFuWVV4UEhZbDV4RHY0c0FXaGRXbElweHlZQlNCRURjczN6QlI2bFF1OWkxZAp0R1k4dGJ3blVmcUVUR3NZdWxzc05qcU95V1VEcFdJelhibHhJZVVDQXdFQUFUQU5CZ2txaGtpRzl3MEJBUXNGCkFBT0NBUUVBcjkrZWJ0U1dzSnhLTGtLZlRkek1ISFhOd2Y5ZXFVbHNtTXZmMGdBdWVKTUpUR215dG1iWjlpbXQKL2RnWlpYVE9hTElHUG9oZ3BpS0l5eVVRZVdGQ2F0NHRxWkNPVWRhbUloOGk0Q1h6QVJYVHNvcUNOenNNLzZMRQphM25XbFZyS2lmZHYrWkxyRi8vblc0VVNvOEoxaCtQeDljY0tpRDZZU0RVUERDRGh1RUtFWXcvbHpoUDJVOXNmCnl6cEJKVGQ4enFyM3paTjNGWWlITmgzYlRhQS82di9jU2lyamNTK1EwQXg4RWpzQzYxRjRVMTc4QzdWNWRCKzQKcmtPTy9QNlA0UFlWNTRZZHMvRjE2WkZJTHFBNENCYnExRExuYWRxamxyN3NPbzl2ZzNnWFNMYXBVVkdtZ2todAp6VlZPWG1mU0Z4OS90MDBHUi95bUdPbERJbWlXMGc9PQotLS0tLUVORCBDRVJUSUZJQ0FURS0tLS0tCg==
  tls.key: LS0tLS1CRUdJTiBQUklWQVRFIEtFWS0tLS0tCk1JSUV2UUlCQURBTkJna3Foa2lHOXcwQkFRRUZBQVNDQktjd2dnU2pBZ0VBQW9JQkFRQzZtTnJSdUZ2WXZoSE4KbXI3c1FvNUtKSUVDN3N6TFVrNExFeklSNS9yMEVaUjQ2RnRTaGJQd0ZuaXAwMFBxekhpVkhKYy92TjdkQTVLeApQS1VmdFJuQ1J6YldVaTZBZzJpRU93bXF6WUhGbVNpZkFlVjk0RlAxOGtSbjl1ckV3OEpiRXJIUncrVW51L25tCmFMRHF1eGpFTVBweGhuRklCSnYwK1R3djNEVGx6TjNwUlV6dnpidGZvZCtEVTZBSmR6N3Rid1dTNmR6MHc1Z2kKbW9RelZnbFpnVDBJek9FZkV3NVpWMnRMZllHZWRlRVJ1VjhtR041c09va3R2aGxsMU1udHRaMkZNVHgySmVjUQo3K0xBRm9YVnBTS2NjbUFVZ1JBM0xOOHdVZXBVTHZZdFhiUm1QTFc4SjFINmhFeHJHTHBiTERZNmpzbGxBNlZpCk0xMjVjU0hsQWdNQkFBRUNnZ0VBQnpaRE50bmVTdWxGdk9HZlFYaHRFWGFKdWZoSzJBenRVVVpEcUNlRUxvekQKWlV6dHdxbkNRNlJLczUyandWNTN4cU9kUU94bTNMbjNvSHdNa2NZcEliWW82MjJ2dUczYnkwaVEzaFlsVHVMVgpqQmZCcS9UUXFlL2NMdngvSkczQWhFNmJxdFRjZFlXeGFmTmY2eUtpR1dzZk11WVVXTWs4MGVJVUxuRmZaZ1pOCklYNTlSOHlqdE9CVm9Sa3hjYTVoMW1ZTDFsSlJNM3ZqVHNHTHFybmpOTjNBdWZ3ZGRpK1VDbGZVL2l0K1EvZkUKV216aFFoTlRpNVFkRWJLVStOTnYvNnYvb2JvandNb25HVVBCdEFTUE05cmxFemIralQ1WHdWQjgvLzRGY3VoSwoyVzNpcjhtNHVlQ1JHSVlrbGxlLzhuQmZ0eVhiVkNocVRyZFBlaGlPM1FLQmdRRGlrR3JTOTc3cjg3Y1JPOCtQClpoeXltNXo4NVIzTHVVbFNTazJiOTI1QlhvakpZL2RRZDVTdFVsSWE4OUZKZnNWc1JRcEhHaTFCYzBMaTY1YjIKazR0cE5xcVFoUmZ1UVh0UG9GYXRuQzlPRnJVTXJXbDVJN0ZFejZnNkNQMVBXMEg5d2hPemFKZUdpZVpNYjlYTQoybDdSSFZOcC9jTDlYbmhNMnN0Q1lua2Iwd0tCZ1FEUzF4K0crakEyUVNtRVFWNXA1RnRONGcyamsyZEFjMEhNClRIQ2tTazFDRjhkR0Z2UWtsWm5ZbUt0dXFYeXNtekJGcnZKdmt2eUhqbUNYYTducXlpajBEdDZtODViN3BGcVAKQWxtajdtbXI3Z1pUeG1ZMXBhRWFLMXY4SDNINGtRNVl3MWdrTWRybVJHcVAvaTBGaDVpaGtSZS9DOUtGTFVkSQpDcnJjTzhkUVp3S0JnSHA1MzRXVWNCMVZibzFlYStIMUxXWlFRUmxsTWlwRFM2TzBqeWZWSmtFb1BZSEJESnp2ClIrdzZLREJ4eFoyWmJsZ05LblV0YlhHSVFZd3lGelhNcFB5SGxNVHpiZkJhYmJLcDFyR2JVT2RCMXpXM09PRkgKcmppb21TUm1YNmxhaDk0SjRHU0lFZ0drNGw1SHhxZ3JGRDZ2UDd4NGRjUktJWFpLZ0w2dVJSSUpBb0dCQU1CVApaL2p5WStRNTBLdEtEZHUrYU9ORW4zaGxUN3hrNXRKN3NBek5rbWdGMU10RXlQUk9Xd1pQVGFJbWpRbk9qbHdpCldCZ2JGcXg0M2ZlQ1Z4ZXJ6V3ZEM0txaWJVbWpCTkNMTGtYeGh3ZEVteFQwVit2NzZGYzgwaTNNYVdSNnZZR08KditwVVovL0F6UXdJcWZ6dlVmV2ZxdStrMHlhVXhQOGNlcFBIRyt0bEFvR0FmQUtVVWhqeFU0Ym5vVzVwVUhKegpwWWZXZXZ5TW54NWZyT2VsSmRmNzlvNGMvMHhVSjh1eFBFWDFkRmNrZW96dHNpaVFTNkN6MENRY09XVWxtSkRwCnVrdERvVzM3VmNSQU1BVjY3NlgxQVZlM0UwNm5aL2g2Tkd4Z28rT042Q3pwL0lkMkJPUm9IMFAxa2RjY1NLT3kKMUtFZlNnb1B0c1N1eEpBZXdUZmxDMXc9Ci0tLS0tRU5EIFBSSVZBVEUgS0VZLS0tLS0K
EOF

namespace/certificate created
secret/cafe-secret created

# view certificate
kubectl get secret -n certificate cafe-secret -o json | jq -r '.data."tls.crt"' | base64 -d

kubectl get secret -n certificate cafe-secret -o json | jq -r '.data."tls.key"' | base64 -d

```

To create the access-to-cafe-secret referencegrant, copy and paste the following into your terminal:

```bash
pushd .
cd ~/src/repsys/k8s/nginx_gateway_fabric


# Azure aks
scc.sh reports-aks-user.yaml reports-aks
kubectl get svc nginx-gateway -n nginx-gateway
NAME            TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE
nginx-gateway   LoadBalancer   10.0.160.21   52.228.166.50   80:30244/TCP,443:31999/TCP   3d22h

GW_IP=52.228.166.50
GW_PORT=80

# Save the ports of NGINX Gateway Fabric:
# Don't know what this is for so be careful with these variables.
# After peeking ahead I see that these variables are used in a curl command:
# curl --resolve cafe.example.com:$GW_HTTP_PORT:$GW_IP http://cafe.example.com:$GW_HTTP_PORT/coffee --include
GW_HTTP_PORT=80
GW_HTTPS_PORT=443

kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1beta1
kind: ReferenceGrant
metadata:
  name: access-to-cafe-secret
  namespace: certificate
spec:
  to:
  - group: ""
    kind: Secret
    name: cafe-secret # if you omit this name, then Gateways in default namespace can access all Secrets in the certificate namespace
  from:
  - group: gateway.networking.k8s.io
    kind: Gateway
    namespace: default
EOF

referencegrant.gateway.networking.k8s.io/access-to-cafe-secret created

kubectl get referencegrant -n certificate                                                  
NAME                    AGE
access-to-cafe-secret   2d22h
```

To create the cafe **[gateway](../../a_l/k8s/gateway_api/gateway_tls.md)**, copy and paste the following into your terminal:

```bash
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: Gateway
metadata:
  name: cafe
spec:
  gatewayClassName: nginx
  listeners:
  - name: http
    port: 80
    protocol: HTTP
  - name: https
    port: 443
    protocol: HTTPS
    tls:
      mode: Terminate
      certificateRefs:
      - kind: Secret
        name: cafe-secret
        namespace: certificate
EOF

kubectl get gateway                           
NAME   CLASS   ADDRESS         PROGRAMMED   AGE
cafe   nginx   52.228.166.50   True         22h
(base)  brent@reports-alb  ~/src/repsys/k8s/nginx_gate
```

This gateway configures:

- http listener for HTTP traffic
- https listener for HTTPS traffic. It terminates TLS connections using the cafe-secret we created.
To create the httproute resources, copy and paste the following into your terminal:

```bash
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: cafe-tls-redirect
spec:
  parentRefs:
  - name: cafe
    sectionName: http
  hostnames:
  - "cafe.example.com"
  rules:
  - filters:
    - type: RequestRedirect
      requestRedirect:
        scheme: https
        port: 443
---
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: coffee
spec:
  parentRefs:
  - name: cafe
    sectionName: https
  hostnames:
  - "cafe.example.com"
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /coffee
    backendRefs:
    - name: coffee
      port: 80
EOF
httproute.gateway.networking.k8s.io/cafe-tls-redirect created
httproute.gateway.networking.k8s.io/coffee created

kubectl get httproute                    
NAME                HOSTNAMES              AGE
cafe-tls-redirect   ["cafe.example.com"]   47h
coffee              ["cafe.example.com"]   47h
```

The first route issues a requestRedirect from the http listener on port 80 to https on port 443. The second route binds the coffee route to the https listener.

## Send Traffic

Using the external IP address and port for NGINX Gateway Fabric, we can send traffic to our coffee application.

**Note:**\
If you have a DNS record allocated for cafe.example.com, you can send the request directly to that hostname, without needing to resolve.
To test that NGINX sends an HTTPS redirect, we will send requests to the coffee service on the HTTP port. We will use curl’s --include option to print the response headers (we are interested in the Location header).

```bash
curl --resolve cafe.example.com:$GW_HTTP_PORT:$GW_IP http://cafe.example.com:$GW_HTTP_PORT/coffee --include

HTTP/1.1 302 Moved Temporarily
Server: nginx
Date: Mon, 07 Oct 2024 21:40:45 GMT
Content-Type: text/html
Content-Length: 138
Connection: keep-alive
Location: https://cafe.example.com/coffee

<html>
<head><title>302 Found</title></head>
<body>
<center><h1>302 Found</h1></center>
<hr><center>nginx</center>
</body>
</html>
```

Now we will access the application over HTTPS. Since our certificate is self-signed, we will use curl’s --insecure option to turn off certificate verification.

```bash
curl --resolve cafe.example.com:$GW_HTTPS_PORT:$GW_IP https://cafe.example.com:$GW_HTTPS_PORT/coffee --insecure 
Server address: 10.244.2.25:8080
Server name: coffee-9bf875848-vgjx6
Date: 07/Oct/2024:21:45:26 +0000
URI: /coffee
Request ID: b20605dcc2a20fa6d95d3c85d707ecb2

# Add cafe.example.com to /etc/hosts file
curl https://cafe.example.com:$GW_HTTPS_PORT/coffee --insecure 

```

## View the certificate

```bash
openssl s_client -connect cafe.example.com:443 -showcerts > cafe_example_com.pem
# or
openssl s_client -connect cafe.example.com:443
...
-----BEGIN CERTIFICATE-----
MIICsjCCAZoCCQC7BuWWudmFCDANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBj
YWZlLmV4YW1wbGUuY29tMB4XDTIyMDcxNDIxNTIzOVoXDTIzMDcxNDIxNTIzOVow
GzEZMBcGA1UEAwwQY2FmZS5leGFtcGxlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBALqY2tG4W9i+Ec2avuxCjkokgQLuzMtSTgsTMhHn+vQRlHjo
W1KFs/AWeKnTQ+rMeJUclz+83t0DkrE8pR+1GcJHNtZSLoCDaIQ7CarNgcWZKJ8B
5X3gU/XyRGf26sTDwlsSsdHD5Se7+eZosOq7GMQw+nGGcUgEm/T5PC/cNOXM3elF
TO/Nu1+h34NToAl3Pu1vBZLp3PTDmCKahDNWCVmBPQjM4R8TDllXa0t9gZ514RG5
XyYY3mw6iS2+GWXUye21nYUxPHYl5xDv4sAWhdWlIpxyYBSBEDcs3zBR6lQu9i1d
tGY8tbwnUfqETGsYulssNjqOyWUDpWIzXblxIeUCAwEAATANBgkqhkiG9w0BAQsF
AAOCAQEAr9+ebtSWsJxKLkKfTdzMHHXNwf9eqUlsmMvf0gAueJMJTGmytmbZ9imt
/dgZZXTOaLIGPohgpiKIyyUQeWFCat4tqZCOUdamIh8i4CXzARXTsoqCNzsM/6LE
a3nWlVrKifdv+ZLrF//nW4USo8J1h+Px9ccKiD6YSDUPDCDhuEKEYw/lzhP2U9sf
yzpBJTd8zqr3zZN3FYiHNh3bTaA/6v/cSirjcS+Q0Ax8EjsC61F4U178C7V5dB+4
rkOO/P6P4PYV54Yds/F16ZFILqA4CBbq1DLnadqjlr7sOo9vg3gXSLapUVGmgkht
zVVOXmfSFx9/t00GR/ymGOlDImiW0g==
-----END CERTIFICATE-----
...

# compare to k8s secret we just added

kubectl get secret -n certificate cafe-secret -o json | jq -r '.data."tls.crt"' | base64 -d

-----BEGIN CERTIFICATE-----
MIICsjCCAZoCCQC7BuWWudmFCDANBgkqhkiG9w0BAQsFADAbMRkwFwYDVQQDDBBj
YWZlLmV4YW1wbGUuY29tMB4XDTIyMDcxNDIxNTIzOVoXDTIzMDcxNDIxNTIzOVow
GzEZMBcGA1UEAwwQY2FmZS5leGFtcGxlLmNvbTCCASIwDQYJKoZIhvcNAQEBBQAD
ggEPADCCAQoCggEBALqY2tG4W9i+Ec2avuxCjkokgQLuzMtSTgsTMhHn+vQRlHjo
W1KFs/AWeKnTQ+rMeJUclz+83t0DkrE8pR+1GcJHNtZSLoCDaIQ7CarNgcWZKJ8B
5X3gU/XyRGf26sTDwlsSsdHD5Se7+eZosOq7GMQw+nGGcUgEm/T5PC/cNOXM3elF
TO/Nu1+h34NToAl3Pu1vBZLp3PTDmCKahDNWCVmBPQjM4R8TDllXa0t9gZ514RG5
XyYY3mw6iS2+GWXUye21nYUxPHYl5xDv4sAWhdWlIpxyYBSBEDcs3zBR6lQu9i1d
tGY8tbwnUfqETGsYulssNjqOyWUDpWIzXblxIeUCAwEAATANBgkqhkiG9w0BAQsF
AAOCAQEAr9+ebtSWsJxKLkKfTdzMHHXNwf9eqUlsmMvf0gAueJMJTGmytmbZ9imt
/dgZZXTOaLIGPohgpiKIyyUQeWFCat4tqZCOUdamIh8i4CXzARXTsoqCNzsM/6LE
a3nWlVrKifdv+ZLrF//nW4USo8J1h+Px9ccKiD6YSDUPDCDhuEKEYw/lzhP2U9sf
yzpBJTd8zqr3zZN3FYiHNh3bTaA/6v/cSirjcS+Q0Ax8EjsC61F4U178C7V5dB+4
rkOO/P6P4PYV54Yds/F16ZFILqA4CBbq1DLnadqjlr7sOo9vg3gXSLapUVGmgkht
zVVOXmfSFx9/t00GR/ymGOlDImiW0g==
-----END CERTIFICATE-----

openssl s_client -connect cafe.example.com:443 -showcerts > cafe_example_com.pem

## Further reading

To learn more about redirects using the Gateway API, see the following resource:

**[Gateway API Redirects](https://gateway-api.sigs.k8s.io/guides/http-redirect-rewrite/)**
