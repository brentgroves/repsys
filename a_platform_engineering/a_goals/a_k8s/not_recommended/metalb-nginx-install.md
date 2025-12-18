# MetalB and Nginx Ingress Controll Install

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## Not Recommended

Recommend **[NGinx Gateway Fabric](../nginx_gateway_fabric_install.md)**

Ingress is a Kubernetes API object that defines DNS routing rules for external traffic coming into a Kubernetes cluster. Using Ingress, cluster administrators set up granular load balancing, SSL/TLS termination, and name-based virtual hosting for their cluster services.

**![External Load Balancer/Gateway](https://fabianlee.org/wp-content/uploads/2021/07/microk8s-3node.png)**
**![Service Load Balancer](https://www.densify.com/wp-content/uploads/article-k8s-capacity-kubernetes-service-overview.svg)**

## Issues

When the Load Balancer is enabled external kubectl connections become slower and timeout.  You can update the ~/.kube/config file to use an IP address of a node that is not occupied by the load balancer but it's still slow. I believe this was happening because I did not use separate IP addresses for the load balancer.  Once I picked new unused IP addresses for the load balancer kubectl connections were fine.

## References

<https://www.densify.com/kubernetes-autoscaling/kubernetes-service-load-balancer/>
<https://microk8s.io/docs/addon-metallb>
<https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/>
<https://marcolenzo.eu/configure-microk8s-nginx-ingress/>
<https://marcolenzo.eu/expose-tcp-and-udp-services-with-the-kubernetes-nginx-ingress-controller/>
<https://github.com/canonical/microk8s/issues/1500>
<https://benbrougher.tech/posts/microk8s-ingress/>
<https://kubernetes.github.io/ingress-nginx/user-guide/exposing-tcp-udp-services/>
<https://www.percona.com/blog/expose-databases-on-kubernetes-with-ingress>
<https://phoenixnap.com/kb/microk8s-ingress>
<https://mswis.com/configure-microk8s-kubernetes-load-balancer-with-tls/>
<https://www.percona.com/blog/expose-databases-on-kubernetes-with-ingress>

## Remove Ingress

```bash
pushd .
cd ~/src/repsys/k8s
# Delete test deployment

kubectl delete deployment.apps/golang-hello-world-web
kubectl delete service/golang-hello-world-web-service
kubectl delete ingress golang-hello-world-web-service
kubectl delete -n default secret tls-credential 

kubectl delete -f nginx/microk8s/ingress-service.yaml

microk8s disable ingress

## Remove MetalB

microk8s disable metallb

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

microk8s enable metallb:172.20.88.57-172.20.88.58
# microk8s enable metallb:172.20.88.59-172.20.88.60
microk8s enable metallb:10.1.0.8-10.1.0.9

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

## Enable Nginx Ingress Controller

For load balancing in a MicroK8s cluster, MetalLB can make use of Ingress to properly balance across the cluster. To do this, it requires a load balancer service.

```bash
microk8s enable ingress
Infer repository core for addon ingress
Enabling Ingress
ingressclass.networking.k8s.io/public created
ingressclass.networking.k8s.io/nginx created
namespace/ingress created
serviceaccount/nginx-ingress-microk8s-serviceaccount created
clusterrole.rbac.authorization.k8s.io/nginx-ingress-microk8s-clusterrole created
role.rbac.authorization.k8s.io/nginx-ingress-microk8s-role created
clusterrolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
rolebinding.rbac.authorization.k8s.io/nginx-ingress-microk8s created
configmap/nginx-load-balancer-microk8s-conf created
configmap/nginx-ingress-tcp-microk8s-conf created
configmap/nginx-ingress-udp-microk8s-conf created
daemonset.apps/nginx-ingress-microk8s-controller created
Ingress is enabled

kubectl get all --namespace ingress -o wide 

NAME                                          READY   STATUS    RESTARTS   AGE   IP             NODE             NOMINATED NODE   READINESS GATES
pod/nginx-ingress-microk8s-controller-4dtt2   1/1     Running   0          17m   10.1.41.132    repsys11-c2-n2   <none>           <none>
pod/nginx-ingress-microk8s-controller-kq8qf   1/1     Running   0          17m   10.1.226.37    repsys11-c2-n1   <none>           <none>
pod/nginx-ingress-microk8s-controller-x9gp7   1/1     Running   0          17m   10.1.187.134   repsys11-c2-n3   <none>           <none>

NAME                                               DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR   AGE   CONTAINERS               IMAGES                                            SELECTOR
daemonset.apps/nginx-ingress-microk8s-controller   3         3         3       3            3           <none>          17m   nginx-ingress-microk8s   registry.k8s.io/ingress-nginx/controller:v1.8.0   name=nginx-ingress-microk8s

# Update Nginx Ingress Controller to route InnoDB port to MySQL router
# Update the config map to forward port to service
microk8s kubectl get cm nginx-ingress-tcp-microk8s-conf -n ingress -o yaml

# append TCP ports to route to existing yaml for full yaml see ~/src/reports/k8s/ingress/nginx-ingress-tcp-microk8s-conf.yaml
microk8s kubectl edit cm nginx-ingress-tcp-microk8s-conf -n ingress 
data:
  3306: "default/mycluster:3306"

# Update DaemonSet that you want the Ingress Controller to expose
# Copy full yaml to ~/src/k8s/manifests/ingress/nginx-ingres-microk8s-controller.yaml
microk8s kubectl get ds nginx-ingress-microk8s-controller -n ingress -o yaml


# Then edit the DaemonSet by adding the port you want the ingress to expose at the spec.template.spec.containers.ports section

kubectl edit ds nginx-ingress-microk8s-controller -n ingress

        - containerPort: 3306
          hostPort: 3306
          name: tcp3306
          protocol: TCP

kubectl get all -n ingress -o wide

# Create an ingress service for the load balancer to use.
# ssh to dev system
pushd .
cd ~/src/repsys/k8s
kubectl apply -f nginx/ingress-service.yaml
service/ingress created
# verify arp request for a load balancer succeeded in finding an external IP and database pass-through ports are shown.
kubectl get svc -n ingress                             
NAME      TYPE           CLUSTER-IP      EXTERNAL-IP   PORT(S)                      AGE
ingress   LoadBalancer   10.152.183.18   10.1.0.143    80:30449/TCP,443:31993/TCP   11s

# watch the pods restart with the updated configuration
kubectl get pods -n ingress -o wide

# test ingress with small micro-service
# Reference: https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/

pushd ~/src/repsys/k8s
kubectl apply -f ./nginx/golang-hello-world/deployment/golang-hello-world-web.yaml
service/golang-hello-world-web-service created
deployment.apps/golang-hello-world-web created
kubectl get pods -l app=golang-hello-world-web
golang-hello-world-web-5db58fd456-47jwt   1/1     Running   0               81s
kubectl get services -l app=golang-hello-world-web
NAME                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
golang-hello-world-web-service   ClusterIP   10.152.183.232   <none>        8080/TCP   3m43s

# ssh to k8s cluster
# internal ip of primary pod
primaryPodIP=$(kubectl get pods -l app=golang-hello-world-web -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# check pod using internal IP
curl "http://${primaryPodIP}:8080/myhello/"
Hello, World
request 0 GET /myhello/
Host: 10.1.75.133:8080

# With internal pod IP proven out, move up to the IP at the  Service level.
# IP of primary service
primaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service -o=jsonpath="{.spec.clusterIP}")

# check primary service
curl "http://${primaryServiceIP}:8080/myhello/"
Hello, World
request 1 GET /myhello/
Host: 10.152.183.171:8080

# ssh to dev system
# generate real certificate using our pki
```

**[generate and install certs](../../../pki/gen-and-install-certs.md)**

```bash
# make sure kubectl is pointing to the correct K8s cluster
kubectl create -n default secret tls tls-credential --key=/home/brent/src/pki/intermediateCA/private/repsys.linamar.com.san.key.pem --cert=/home/brent/src/pki/intermediateCA/certs/server-chain/repsys.linamar.com-ca-chain-bundle.cert.pem
secret/tls-credential created

kubectl create -n ingress-test secret tls tls-credential --key=/home/brent/src/pki/intermediateCA/private/repsys.linamar.com.san.key.pem --cert=/home/brent/src/pki/intermediateCA/certs/server-chain/repsys.linamar.com-ca-chain-bundle.cert.pem

# shows both tls secrets
kubectl get secrets --namespace default
NAME             TYPE                DATA   AGE
tls-credential   kubernetes.io/tls   2      54s

# show cert chain
kubectl get secret -n default tls-credential -o json | jq -r '.data."tls.crt"' | base64 -d

kubectl get secret -n ingress-test tls-credential -o json | jq -r '.data."tls.crt"' | base64 -d

# show server cert key
kubectl get secret -n default tls-credential -o json | jq -r '.data."tls.key"' | base64 -d

kubectl get secret -n ingress-test tls-credential -o json | jq -r '.data."tls.key"' | base64 -d


# Update host property in the ingres yaml. 
pushd .

cd ~/src/repsys/k8s
code ./nginx/golang-hello-world/ingress/golang-hello-world-web-on-nginx-fqdn.yaml
# Now that the host property has the same value as that of one of the alt names in SAN certificate previously deployed to the cluster, create the ingress object.
kubectl apply -f ./nginx/golang-hello-world/ingress/golang-hello-world-web-on-nginx-fqdn.yaml
Warning: annotation "kubernetes.io/ingress.class" is deprecated, please use 'spec.ingressClassName' instead
ingress.networking.k8s.io/golang-hello-world-web-service created

# show Ingress objects
kubectl get ingress --namespace default
NAME                             CLASS    HOSTS       ADDRESS     PORTS     AGE
golang-hello-world-web-service   <none>   reports11.busche-cnc.com   127.0.0.1   80, 443   96s

# ping load balancer ip
# golang hello-world service pod should reply 

ping repsys.linamar.com                                                                                     
PING repsys.linamar.com (10.1.0.143) 56(84) bytes of data.
From repsys11-c2-n3 (10.1.0.141) icmp_seq=2 Redirect Host(New nexthop: repsys.linamar.com (10.1.0.143))
From repsys11-c2-n3 (10.1.0.141) icmp_seq=3 Redirect Host(New nexthop: repsys.linamar.com (10.1.0.143))
From repsys11-c2-n3 (10.1.0.141) icmp_seq=5 Redirect Host(New nexthop: repsys.linamar.com (10.1.0.143))

# verify certs our in openssl trust store dir
ls /etc/ssl/certs/
ca.cert.pem
intermediate.pem


# verify certificates
# https://curl.se/docs/sslcerts.html
# https://www.baeldung.com/linux/curl-https-connection 
# Make sure cert chain was added to linux cert store.  
# verify the cert chain from our PKI is returned using this command:
openssl s_client -showcerts -connect repsys.linamar.com:443 -servername repsys.linamar.com -CApath /etc/ssl/certs 

openssl s_client -showcerts -connect reports11.busche-cnc.com:443 -servername reports11.busche-cnc.com -CApath /etc/ssl/certs 

# https://unix.stackexchange.com/questions/421969/openssl-fetches-different-ssl-certificate-than-the-one-obtained-via-a-browser
# s_client by default does not send SNI (Server Name Indication) data but a browser does. The server may choose to respond with a different certificate based on the contents of that SNI - or if no SNI is present then it will serve a default certificate. Solution is to add -servername param.

# Verify TLS connection returns hello world
# https://phoenixnap.com/kb/microk8s-ingress
# https://mswis.com/configure-microk8s-kubernetes-load-balancer-with-tls/

curl -v --cacert /home/brent/src/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem https://repsys.linamar.com/myhello/

curl -v https://repsys.linamar.com/myhello/

# Delete test deployment

kubectl delete deployment.apps/golang-hello-world-web
kubectl delete service/golang-hello-world-web-service
kubectl delete ingress golang-hello-world-web-service

```
