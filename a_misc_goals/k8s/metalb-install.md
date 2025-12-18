# MetalB and Nginx Ingress Controll Install

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

Ingress is a Kubernetes API object that defines DNS routing rules for external traffic coming into a Kubernetes cluster. Using Ingress, cluster administrators set up granular load balancing, SSL/TLS termination, and name-based virtual hosting for their cluster services.

**![External Load Balancer/Gateway](https://fabianlee.org/wp-content/uploads/2021/07/microk8s-3node.png)**
**![Service Load Balancer](https://www.densify.com/wp-content/uploads/article-k8s-capacity-kubernetes-service-overview.svg)**

## Issues

When the Load Balancer is enabled external kubectl connections become slower and timeout.  You can update the ~/.kube/config file to use an IP address of a node that is not occupied by the load balancer but it's still slow. I believe this was happening because I did not use separate IP addresses for the load balancer.  Once I picked new unused IP addresses for the load balancer kubectl connections were fine.

## Remove MetalB

```bash
pushd .
cd ~/src/repsys/k8s

## Remove MetalB

# Make sure there are no Ingress or Gateway Controllers active 
# which are using external IP from MetalB's address pool

kubectl get IPAddressPool -A 
kubectl get svc -n ingress                             
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
ingress   LoadBalancer   10.152.183.18   10.1.0.143    80:30449/TCP,443:31993/TCP   11s


microk8s disable metallb

```

## Enable MetalB

The MetalB is lv 4 and the ingress is lv 7 of the osi model
so the traffic is first seen by the metalb loadbalancer which then sends it to one of the ingress controllers through the service you define to decide which pod to send it to using an ingress object.

## why use multiple node in Metallb's resource pool

If one node goes down network connections will still be possible. I don't know if this **[layer2](../research/metallb/metalb_layer2.md)** or BPG fail-over works without additional configuration.

Reference cluster specific load balancer files in the cluster's netplan dir, i.e. **[repsys11-c2-n1](./netplan/repsys11/loadbalancer.md)**.

```bash
# Scan sub-network for IPs to be used as load balancer.
nmap -sP 172.20.88.0/22
nmap -sP 10.1.0.0/22
nmap -sP 192.168.1.0/24

# home
microk8s enable metallb:192.168.1.70-192.168.90
Infer repository core for addon metallb
Enabling MetalLB
Your input value (192.168.1.70-192.168.90) is not a valid IP Range

kubectl get IPAddressPool -A                           
NAMESPACE        NAME                  AGE
metallb-system   default-addresspool   9d

kubectl describe IPAddressPool default-addresspool -n metallb-system
Name:         default-addresspool
Namespace:    metallb-system
Labels:       <none>
Annotations:  <none>
API Version:  metallb.io/v1beta1
Kind:         IPAddressPool
Metadata:
  Creation Timestamp:  2023-12-26T19:17:39Z
  Generation:          1
  Resource Version:    9991658
  UID:                 5b96a489-699c-46f4-a029-fa4671dcaa98
Spec:
  Addresses:
    10.1.0.8-10.1.0.9
  Auto Assign:  true
Events:         <none>

# Check load balancer
kubectl get all -n metallb-system -o wide
# Ping load balancer
ping 10.1.0.8
PING 10.1.0.8 (10.1.0.8) 56(84) bytes of data.
From 10.1.0.112 icmp_seq=2 Redirect Host(New nexthop: 10.1.0.8)

```
