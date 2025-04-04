# Load balancer

```bash
# Scan sub-network for IPs to be used as load balancer.
nmap -sP 172.20.88.0/22
nmap -sP 10.1.0.0/22

# Found 10.1.0.143 and 10.1.0.144 was not being used.

ssh ubuntu@repsys11-c2-n1
# microk8s enable metallb:172.20.88.57-172.20.88.58
microk8s enable metallb:10.1.0.143-10.1.0.144
Infer repository core for addon metallb
Enabling MetalLB
Applying Metallb manifest
customresourcedefinition.apiextensions.k8s.io/addresspools.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bfdprofiles.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bgpadvertisements.metallb.io created
customresourcedefinition.apiextensions.k8s.io/bgppeers.metallb.io created
customresourcedefinition.apiextensions.k8s.io/communities.metallb.io created
customresourcedefinition.apiextensions.k8s.io/ipaddresspools.metallb.io created
customresourcedefinition.apiextensions.k8s.io/l2advertisements.metallb.io created
namespace/metallb-system created
serviceaccount/controller created
serviceaccount/speaker created
clusterrole.rbac.authorization.k8s.io/metallb-system:controller created
clusterrole.rbac.authorization.k8s.io/metallb-system:speaker created
role.rbac.authorization.k8s.io/controller created
role.rbac.authorization.k8s.io/pod-lister created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:controller created
clusterrolebinding.rbac.authorization.k8s.io/metallb-system:speaker created
rolebinding.rbac.authorization.k8s.io/controller created
secret/webhook-server-cert created
service/webhook-service created
rolebinding.rbac.authorization.k8s.io/pod-lister created
daemonset.apps/speaker created
deployment.apps/controller created
validatingwebhookconfiguration.admissionregistration.k8s.io/validating-webhook-configuration created
Waiting for Metallb controller to be ready.
deployment.apps/controller condition met
ipaddresspool.metallb.io/default-addresspool created
l2advertisement.metallb.io/default-advertise-all-pools created
MetalLB is enabled

# check address pool

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
  Creation Timestamp:  2024-09-26T20:03:51Z
  Generation:          1
  Resource Version:    15090865
  UID:                 68b3ed1e-52ab-4fde-9097-1fc728e2d11d
Spec:
  Addresses:
    10.1.0.143-10.1.0.144
  Auto Assign:  true
Events:         <none>

# Check load balancer
kubectl get all -n metallb-system -o wide
NAME                              READY   STATUS    RESTARTS   AGE    IP             NODE             NOMINATED NODE   READINESS GATES
pod/controller-5484c5f99f-kt6xh   1/1     Running   0          105s   10.1.187.133   repsys11-c2-n3   <none>           <none>
pod/speaker-25tbd                 1/1     Running   0          105s   10.1.0.142     repsys11-c2-n2   <none>           <none>
pod/speaker-n627h                 1/1     Running   0          105s   10.1.0.141     repsys11-c2-n3   <none>           <none>
pod/speaker-pcssf                 1/1     Running   0          105s   10.1.0.129     repsys11-c2-n1   <none>           <none>

NAME                      TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)   AGE    SELECTOR
service/webhook-service   ClusterIP   10.152.183.240   <none>        443/TCP   106s   component=controller

NAME                     DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE    CONTAINERS   IMAGES                            SELECTOR
daemonset.apps/speaker   3         3         3       3            3           kubernetes.io/os=linux   105s   speaker      quay.io/metallb/speaker:v0.13.3   app=metallb,component=speaker

NAME                         READY   UP-TO-DATE   AVAILABLE   AGE    CONTAINERS   IMAGES                               SELECTOR
deployment.apps/controller   1/1     1            1           105s   controller   quay.io/metallb/controller:v0.13.3   app=metallb,component=controller

NAME                                    DESIRED   CURRENT   READY   AGE    CONTAINERS   IMAGES                               SELECTOR
replicaset.apps/controller-5484c5f99f   1         1         1       105s   controller   quay.io/metallb/controller:v0.13.3   app=metallb,component=controller,pod-template-hash=5484c5f99f

# Ping load balancer

ping 10.1.0.143
PING 10.1.0.143 (10.1.0.143) 56(84) bytes of data.
From 10.1.0.113 icmp_seq=1 Destination Host Unreachable
From 10.1.0.113 icmp_seq=2 Destination Host Unreachable
From 10.1.0.113 icmp_seq=3 Destination Host Unreachable
From 10.1.0.113 icmp_seq=5 Destination Host Unreachable

ping 10.1.0.144
PING 10.1.0.144 (10.1.0.144) 56(84) bytes of data.
From 10.1.0.113 icmp_seq=1 Destination Host Unreachable
From 10.1.0.113 icmp_seq=2 Destination Host Unreachable
From 10.1.0.113 icmp_seq=3 Destination Host Unreachable

# ping 10.1.0.8
# PING 10.1.0.8 (10.1.0.8) 56(84) bytes of data.
# From 10.1.0.112 icmp_seq=2 Redirect Host(New nexthop: 10.1.0.8)

```
