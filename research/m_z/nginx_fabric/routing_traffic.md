# **[Routing traffic to applications](https://docs.nginx.com/nginx-gateway-fabric/how-to/traffic-management/routing-traffic-to-your-app/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## Routing traffic to applications

Learn how to route external traffic to your Kubernetes applications using NGINX Gateway Fabric.

## Overview

You can route traffic to your Kubernetes applications using the Gateway API and NGINX Gateway Fabric. Whether you’re managing a web application or a REST backend API, you can use NGINX Gateway Fabric to expose your application outside the cluster.

## Before you begin

Install NGINX Gateway Fabric.

Save the public IP address and port of NGINX Gateway Fabric into shell variables:

```bash
scc.sh repsys11c2n1.yaml microk8s 
kubectl get svc nginx-gateway -n nginx-gateway
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
nginx-gateway   LoadBalancer   10.152.183.50   10.1.0.143    80:30833/TCP,443:31343/TCP   82s

GW_IP=10.1.0.143
GW_PORT=80
```

## Example application

The application we are going to use in this guide is a simple coffee application comprised of one service and two pods:

![coffee](https://docs.nginx.com/nginx-gateway-fabric/img/route-all-traffic-app.png)**

Using this architecture, the coffee application is not accessible outside the cluster. We want to expose this application on the hostname “cafe.example.com” so that clients outside the cluster can access it.

Install NGINX Gateway Fabric and create two Gateway API resources: a **[gateway](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.Gateway)** and an **[HTTPRoute](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRoute)**.

Using these resources we will configure a simple routing rule to match all HTTP traffic with the hostname “cafe.example.com” and route it to the coffee service.

## Set up

Create the coffee application in Kubernetes by copying and pasting the following block into your terminal:

```bash
kubectl apply -f - <<EOF
apiVersion: apps/v1
kind: Deployment
metadata:
  name: coffee
spec:
  replicas: 2
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
```

This will create the coffee service and a deployment with two pods. Run the following command to verify the resources were created:

```bash
kubectl get pods,svc
NAME                          READY   STATUS    RESTARTS      AGE
pod/coffee-56b44d4c55-gvcsh   1/1     Running   0             56s
pod/coffee-56b44d4c55-jrpdl   1/1     Running   0             56s
pod/mysql-0                   1/1     Running   2 (32d ago)   73d
pod/test-nginx                1/1     Running   2 (32d ago)   38d

NAME                 TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)          AGE
service/coffee       ClusterIP   10.152.183.25    <none>        80/TCP           57s
service/kubernetes   ClusterIP   10.152.183.1     <none>        443/TCP          78d
service/mysql-svc    NodePort    10.152.183.210   <none>        3306:30031/TCP   73d
```

Your output should include two coffee pods and the coffee service:

## Application architecture with NGINX Gateway Fabric

To route traffic to the coffee application, we will create a gateway and HTTPRoute. The following diagram shows the configuration we are creating in the next step:

![coffee](https://docs.nginx.com/nginx-gateway-fabric/img/route-all-traffic-config.png)

We need a gateway to create an entry point for HTTP traffic coming into the cluster. The cafe gateway we are going to create will open an entry point to the cluster on port 80 for HTTP traffic.

To route HTTP traffic from the gateway to the coffee service, we need to create an HTTPRoute named coffee and attach it to the gateway. This HTTPRoute will have a single routing rule that routes all traffic to the hostname “cafe.example.com” from the gateway to the coffee service.

Once NGINX Gateway Fabric processes the cafe gateway and coffee HTTPRoute, it will configure its data plane (NGINX) to route all HTTP requests sent to “cafe.example.com” to the pods that the coffee service targets:

![more coffee](https://docs.nginx.com/nginx-gateway-fabric/img/route-all-traffic-flow.png)

The coffee service is omitted from the diagram above because the NGINX Gateway Fabric routes directly to the pods that the coffee service targets.

**Note:**\
In the diagrams above, all resources that are the responsibility of the cluster operator are shown in blue. The orange resources are the responsibility of the application developers.

See the **[roles and personas](https://gateway-api.sigs.k8s.io/concepts/roles-and-personas/#roles-and-personas_1)** Gateway API document for more information on these roles.

## Create the Gateway API resources

To create the cafe gateway, copy and paste the following into your terminal:

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
EOF
```

This gateway is associated with the NGINX Gateway Fabric through the gatewayClassName field. The default installation of NGINX Gateway Fabric creates a GatewayClass with the name nginx. NGINX Gateway Fabric will only configure gateways with a gatewayClassName of nginx unless you change the name via the --gatewayclass command-line flag.

We specify a listener on the gateway to open an entry point on the cluster. In this case, since the coffee application accepts HTTP requests, we create an HTTP listener, named http, that listens on port 80.

By default, gateways only allow routes (such as HTTPRoutes) to attach if they are in the same namespace as the gateway. If you want to change this behavior, you can set the allowedRoutes field.

Next you will create the HTTPRoute by copying and pasting the following into your terminal:

```bash
kubectl apply -f - <<EOF
apiVersion: gateway.networking.k8s.io/v1
kind: HTTPRoute
metadata:
  name: coffee
spec:
  parentRefs:
  - name: cafe
  hostnames:
  - "repsys.linamar.com"
  rules:
  - matches:
    - path:
        type: PathPrefix
        value: /
    backendRefs:
    - name: coffee
      port: 80
EOF
```

To attach the coffee HTTPRoute to the cafe gateway, we specify the gateway name in the **[parentRefs](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.CommonRouteSpec)** field. The attachment will succeed if the hostnames and protocol in the HTTPRoute are allowed by at least one of the gateway’s listeners.

The **[hostnames](https://gateway-api.sigs.k8s.io/references/spec/#gateway.networking.k8s.io/v1.HTTPRouteSpec)** field allows you to list the hostnames that the HTTPRoute matches. In this case, incoming requests handled by the http listener with the HTTP host header “cafe.example.com” will match this HTTPRoute and will be routed according to the rules in the spec.

The rules field defines routing rules for the HTTPRoute. A rule is selected if the request satisfies one of the rule’s matches. To forward traffic for all paths to the coffee service we specify a match with the PathPrefix “/” and target the coffee service using the backendRef field.

## Test the configuration

To test the configuration, we will send a request to the public IP and port of NGINX Gateway Fabric that you saved in the Before you begin section and verify that the response comes from one of the coffee pods.

**Note:**\
Your clients should be able to resolve the domain name “cafe.example.com” to the public IP of the NGINX Gateway Fabric. In this guide we will simulate that using curl’s --resolve option.
First, let’s send a request to the path “/”:

```bash
scc.sh repsys11c2n1.yaml microk8s 
kubectl get svc nginx-gateway -n nginx-gateway
NAME            TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
nginx-gateway   LoadBalancer   10.152.183.50   10.1.0.143    80:30833/TCP,443:31343/TCP   82s

GW_IP=10.1.0.143
GW_PORT=80

curl --resolve repsys.linamar.com:$GW_PORT:$GW_IP http://repsys.linamar.com:$GW_PORT/
Server address: 10.1.187.137:8080
Server name: coffee-56b44d4c55-gvcsh
Date: 28/Sep/2024:20:35:40 +0000
URI: /
Request ID: 13c7ac8dafe48f01abec6f0c16ab4891

scc.sh reports-aks-user.yaml reports-aks
kubectl get svc nginx-gateway -n nginx-gateway

NAME            TYPE           CLUSTER-IP    EXTERNAL-IP     PORT(S)                      AGE
nginx-gateway   LoadBalancer   10.0.160.21   52.228.166.50   80:30244/TCP,443:31999/TCP   21h

GW_IP=52.228.166.50
GW_PORT=80

curl --resolve repsys.linamar.com:$GW_PORT:$GW_IP http://repsys.linamar.com:$GW_PORT/

Server address: 10.244.2.24:8080
Server name: coffee-9bf875848-fsg2g
Date: 28/Sep/2024:20:38:49 +0000
URI: /
Request ID: 2e0b4e4c39e052bede55ec9f402a5db2


```

## **[curl --resolve](https://everything.curl.dev/usingcurl/connections/name.html#provide-a-custom-ip-address-for-a-name)**

Do you know better than the name resolver where curl should go? Then you can give an IP address to curl yourself. If you want to redirect port 80 access for example.com to instead reach your localhost:

curl --resolve example.com:80:127.0.0.1 <http://example.com/>
You can even specify multiple --resolve switches to provide multiple redirects of this sort, which can be handy if the URL you work with uses HTTP redirects or if you just want to have your command line work with multiple URLs.

--resolve inserts the address into curl's DNS cache, so it effectively makes curl believe that is the address it got when it resolved the name.

When talking HTTPS, this sends SNI for the name in the URL and curl verifies the server's response to make sure it serves for the name in the URL.

The pattern you specify in the option needs to be a hostname and its corresponding port number and only if that exact pair is used in the URL is the address substituted. For example, if you want to replace a hostname in an HTTPS URL on its default port number, you need to tell curl it is for port 443, like:

```bash
curl --resolve example.com:443:192.168.0.1 https://example.com/
```

Since the cafe HTTPRoute routes all traffic on any path to the coffee application, the following requests should also be handled by the coffee pods:

```bash
curl --resolve repsys.linamar.com:$GW_PORT:$GW_IP http://repsys.linamar.com:$GW_PORT/some-path

Server address: 10.244.2.24:8080
Server name: coffee-9bf875848-fsg2g
Date: 28/Sep/2024:20:41:44 +0000
URI: /some-path
Request ID: f6e749e24e42f25a662a955538c21eba

curl --resolve repsys.linamar.com:$GW_PORT:$GW_IP http://repsys.linamar.com:$GW_PORT/some/path

Server address: 10.244.2.24:8080
Server name: coffee-9bf875848-fsg2g
Date: 28/Sep/2024:20:43:02 +0000
URI: /some/path
Request ID: efdf6d84d67a6838dbb87116f68681fa

```

Requests to hostnames other than “repsys.linamar.com” should not be routed to the coffee application, since the cafe HTTPRoute only matches requests with the “cafe.example.com"need hostname. To verify this, send a request to the hostname “notrepsys.linamar.com”:

```bash
curl --resolve notrepsys.linamar.com:$GW_PORT:$GW_IP http://notrepsys.linamar.com:$GW_PORT/

<html>
<head><title>404 Not Found</title></head>
<body>
<center><h1>404 Not Found</h1></center>
<hr><center>nginx</center>
</body>
</html>

```

## Troubleshooting

If you have any issues while testing the configuration, try the following to debug your configuration and setup:

- Make sure you set the shell variables $GW_IP and $GW_PORT to the public IP and port of the NGINX Gateway Fabric Service. Refer to the Installation guides for more information.
- Check the status of the gateway:

```bash
kubectl describe gateway cafe
```

The gateway status should look similar to this:

```bash
Status:
Addresses:
  Type:   IPAddress
  Value:  10.244.0.85
Conditions:
  Last Transition Time:  2023-08-15T20:57:21Z
  Message:               Gateway is accepted
  Observed Generation:   1
  Reason:                Accepted
  Status:                True
  Type:                  Accepted
  Last Transition Time:  2023-08-15T20:57:21Z
  Message:               Gateway is programmed
  Observed Generation:   1
  Reason:                Programmed
  Status:                True
  Type:                  Programmed
Listeners:
  Attached Routes:  1
  Conditions:
    Last Transition Time:  2023-08-15T20:57:21Z
    Message:               Listener is accepted
    Observed Generation:   1
    Reason:                Accepted
    Status:                True
    Type:                  Accepted
    Last Transition Time:  2023-08-15T20:57:21Z
    Message:               Listener is programmed
    Observed Generation:   1
    Reason:                Programmed
    Status:                True
    Type:                  Programmed
    Last Transition Time:  2023-08-15T20:57:21Z
    Message:               All references are resolved
    Observed Generation:   1
    Reason:                ResolvedRefs
    Status:                True
    Type:                  ResolvedRefs
    Last Transition Time:  2023-08-15T20:57:21Z
    Message:               No conflicts
    Observed Generation:   1
    Reason:                NoConflicts
    Status:                False
    Type:                  Conflicted
  Name:                    http
  ```

  Check that the conditions match and that the attached routes for the http listener equals 1. If it is 0, there may be an issue with the HTTPRoute.

- Check the status of the HTTPRoute:

```bash
kubectl describe httproute coffee
Status:
  Parents:
    Conditions:
      Last Transition Time:  2023-08-15T20:57:21Z
      Message:               The route is accepted
      Observed Generation:   1
      Reason:                Accepted
      Status:                True
      Type:                  Accepted
      Last Transition Time:  2023-08-15T20:57:21Z
      Message:               All references are resolved
      Observed Generation:   1
      Reason:                ResolvedRefs
      Status:                True
      Type:                  ResolvedRefs
    Controller Name:         gateway.nginx.org/nginx-gateway-controller
    Parent Ref:
      Group:      gateway.networking.k8s.io
      Kind:       Gateway
      Name:       cafe
      Namespace:  default
```

Check for any error messages in the conditions.

Check the generated nginx config:

```bash
kubectl exec -it -n nginx-gateway nginx-gateway-7f89b76fd4-lp47m -c nginx -- nginx -T
```

The config should contain a server block with the server name “cafe.example.com” that listens on port 80. This server block should have a single location / that proxy passes to the coffee upstream:

```bash
server {
  listen 80;

  server_name cafe.example.com;

  location / {
      ...
      proxy_pass http://default_coffee_80$request_uri; # the upstream is named default_coffee_80
      ...
  }
}

# repsys.linamar.com
kubectl exec -it -n nginx-gateway nginx-gateway-7f89b76fd4-lp47m -c nginx -- nginx -T
...
server {
    listen 80;
    listen [::]:80;

    server_name repsys.linamar.com;

        
    location / {
        

        

        proxy_http_version 1.1;
        proxy_set_header Host "$gw_api_compliant_host";
        proxy_set_header X-Forwarded-For "$proxy_add_x_forwarded_for";
        proxy_set_header Upgrade "$http_upgrade";
        proxy_set_header Connection "$connection_upgrade";
        proxy_pass http://default_coffee_80$request_uri;
            
            
            
    }
}

```

There should also be an upstream block with a name that matches the upstream in the proxy_pass directive. This upstream block should contain the pod IPs of the coffee pods:

```bash

upstream default_coffee_80 {
  ...
  server 10.12.0.18:8080; # these should be the pod IPs of the coffee pods
  server 10.12.0.19:8080;
  ...
}

```
