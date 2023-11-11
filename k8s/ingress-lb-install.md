# Ingress and load balancer install

## References

<https://microk8s.io/docs/addon-metallb>
<https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/>

## install nginx ingress controller

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

```

## Setting up a MetalLB/Ingress service

For load balancing in a MicroK8s cluster, MetalLB can make use of Ingress to properly balance across the cluster ( make sure you have also enabled ingress in MicroK8s first, with microk8s enable ingress). To do this, it requires a service.

The MetalB is lv 4 and the ingress is lv 7 of the osi model
so the traffic is first seen by the metalb loadbalancer which then sends it to one of the ingress controllers through the service you define to decide which pod to send it to using an ingress object.

```bash
kubectl get all --namespace ingress

# Enable the load balancer
# for 1 external IP
microk8s enable metallb:10.1.0.110-10.1.0.110

# for 2 external IP
microk8s enable metallb:10.1.0.110-10.1.0.111

kubectl get all -n metallb-system

# Create an ingress service for the load balancer to use.
# ssh to dev system
pushd ~/src/reports/k8s
kubectl apply -f manifests/ingress/ingress-service.yaml
service/ingress created
reset adapter unexpectedly

kubectl get services --namespace ingress
NAME      TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                      AGE
ingress   LoadBalancer   10.152.183.234   10.1.0.110    80:30998/TCP,443:31939/TCP   4m52s

# apply a test deployment
kubectl apply -f golang-hello-world-web.yaml
service/golang-hello-world-web-service created
deployment.apps/golang-hello-world-web created
kubectl get pods
NAME                                      READY   STATUS    RESTARTS   AGE
golang-hello-world-web-5db58fd456-p2dps   1/1     Running   0          3m39s

# check ClusterIP and port of first service
kubectl get services
NAME                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)    AGE
kubernetes                       ClusterIP   10.152.183.1     <none>        443/TCP    5d2h
golang-hello-world-web-service   ClusterIP   10.152.183.171   <none>        8080/TCP   4m45s

# ssh to k8s cluster
# internal ip of primary pod
primaryPodIP=$(kubectl get pods -l app=golang-hello-world-web -o=jsonpath="{.items[0].status.podIPs[0].ip}")

# check pod using internal IP
curl http://${primaryPodIP}:8080/myhello/
Hello, World
request 0 GET /myhello/
Host: 10.1.75.133:8080

# With internal pod IP proven out, move up to the IP at the  Service level.

# IP of primary service
primaryServiceIP=$(microk8s kubectl get service/golang-hello-world-web-service -o=jsonpath="{.spec.clusterIP}")

# check primary service
curl http://${primaryServiceIP}:8080/myhello/
Hello, World
request 1 GET /myhello/
Host: 10.152.183.171:8080

# ssh to dev system
# generate real certificate using our pki
```

**[generate and install certs](../volume//pki/gen-and-install-certs.md)**

```bash
kubectl create -n default secret tls tls-credential --key=/home/brent/src/reports/volume/pki/intermediateCA/private/reports11.busche-cnc.com.san.key.pem --cert=/home/brent/src/reports/volume/pki/intermediateCA/certs/server-chain/reports11.busche-cnc.com-ca-chain-bundle.cert.pem
secret/tls-credential created

# shows both tls secrets
kubectl get secrets --namespace default
NAME             TYPE                DATA   AGE
tls-credential   kubernetes.io/tls   2      54s

# show cert chain
kubectl get secret -n default tls-credential -o json | jq -r '.data."tls.crt"' | base64 -d
# show server cert key
kubectl get secret -n default tls-credential -o json | jq -r '.data."tls.key"' | base64 -d

# create fqdn primary ingress
pushd ~/src/linux-utils/microk8s/golang-hello-world/ingress/reports1
kubectl apply -f golang-hello-world-web-on-nginx-fqdn.yaml

# show Ingress objects
kubectl get ingress --namespace default
NAME                             CLASS    HOSTS       ADDRESS     PORTS     AGE
golang-hello-world-web-service   <none>   reports11.busche-cnc.com   127.0.0.1   80, 443   96s


# verify certificates
# https://curl.se/docs/sslcerts.html
<!-- https://www.baeldung.com/linux/curl-https-connection -->
# verify fqdn version of ingress
openssl s_client -showcerts -connect reports11.busche-cnc.com:443 -servername reports11.busche-cnc.com -CApath /etc/ssl/certs 

# https://unix.stackexchange.com/questions/421969/openssl-fetches-different-ssl-certificate-than-the-one-obtained-via-a-browser
# s_client by default does not send SNI (Server Name Indication) data but a browser does. The server may choose to respond with a different certificate based on the contents of that SNI - or if no SNI is present then it will serve a default certificate. Solution is to add -servername param.

# https://phoenixnap.com/kb/microk8s-ingress
# https://mswis.com/configure-microk8s-kubernetes-load-balancer-with-tls/

curl -v --cacert /home/brent/src/reports/volume/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem https://reports11.busche-cnc.com/myhello/


# I believe this work since ca and intermediate certs were added to the linux trust store
curl -v https://reports11.busche-cnc.com/myhello/

# another tutorial https://mswis.com/configure-microk8s-kubernetes-load-balancer-with-tls/
```
