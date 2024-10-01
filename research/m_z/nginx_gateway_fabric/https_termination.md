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

Save the ports of NGINX Gateway Fabric:

 Copy
GW_HTTP_PORT=<http port number>
GW_HTTPS_PORT=<https port number>

```

**Note:**\

In a production environment, you should have a DNS record for the external IP address that is exposed, and it should refer to the hostname that the gateway will forward for.

## Set up

Create the coffee application in Kubernetes by copying and pasting the following block into your terminal:
