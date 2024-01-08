# MetalB and Kong Ingress Controll Install

Ingress is a Kubernetes API object that defines DNS routing rules for external traffic coming into a Kubernetes cluster. Using Ingress, cluster administrators set up granular load balancing, SSL/TLS termination, and name-based virtual hosting for their cluster services.

## References

<https://callistaenterprise.se/blogg/teknik/2023/04/20/kong-api-gateway-part1/>
<https://microk8s.io/docs/addon-metallb>

## Remove Kong Ingress Controller

## Remove MetalB

microk8s disable metallb

## Enable MetalB

The MetalB is lv 4 and the ingress is lv 7 of the osi model
so the traffic is first seen by the metalb loadbalancer which then sends it to one of the ingress controllers through the service you define to decide which pod to send it to using an ingress object.

<https://microk8s.io/docs/addon-metallb>

## why use multiple node in Metallb's resource pool

If one node goes down network connections will still be possible. I don't know if this **[layer2](../research/metallb/metalb_layer2.md)** or BPG fail-over works without additional configuration.

```bash
# Scan sub-network for IPs to be used as load balancer.
nmap -sP 172.20.88.0/22
nmap -sP 10.1.0.0/22
# enable metallb
ssh brent@reports11
microk8s enable metallb:10.1.0.8-10.1.0.9

pushd .
cd ~/src/repsys/k8s
scc.sh reports1.yaml microk8s
# Check load balancer
kubectl get all -n metallb-system -o wide

```

## Install Kong using gateway operator

<https://docs.konghq.com/gateway-operator/latest/get-started/kic/install/>

```bash
# Below command installs all Gateway API resources that have graduated to GA or beta, including GatewayClass, Gateway, HTTPRoute, and ReferenceGrant.
kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/standard-install.yaml

# If you want to use experimental resources and fields such as TCPRoutes and UDPRoutes, please run this command.

kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.0.0/experimental-install.yaml

# To install Kong specific CRDs, run the following command.
kubectl apply -k https://github.com/Kong/kubernetes-ingress-controller/config/crd

# To install Kong Gateway Operator use kubectl apply:
kubectl apply -f https://docs.konghq.com/assets/gateway-operator/v1.1.0/crds.yaml --server-side
kubectl apply -f https://docs.konghq.com/assets/gateway-operator/v1.1.0/all_controllers.yaml

# You can wait for the operator to be ready using kubectl wait:
kubectl -n kong-system wait --for=condition=Available=true --timeout=120s deployment/gateway-operator-controller-manager

kubectl  get deployments                                
NAME                            READY   UP-TO-DATE   AVAILABLE   AGE
dataplane-kong-nntfm-q5cx5      1/1     1            1           64m
controlplane-kong-sx7pj-fmpjc   1/1     1            1           64m

kubectl  get deployments -n kong-system
NAME                                  READY   UP-TO-DATE   AVAILABLE   AGE
gateway-operator-controller-manager   1/1     1            1           83m

```

## Create a GatewayClass

<https://docs.konghq.com/gateway-operator/latest/get-started/kic/create-gateway/>

To use the Gateway API resources to configure your routes, you need to create a GatewayClass instance and create a Gateway resource that listens on the ports that you need.

```bash
kubectl apply -f ./manifests/kong/gatewayclass.yaml

# Run kubectl get gateway kong -n default to get the IP address for the gateway and set that as the value for the variable PROXY_IP.

export PROXY_IP=$(kubectl get gateway kong -n default -o jsonpath='{.status.addresses[0].value}')
```

## Create a Route

<https://docs.konghq.com/gateway-operator/latest/get-started/kic/create-route/>

After you’ve installed all of the required components and configured a GatewayClass you can route some traffic to a service in your Kubernetes cluster.

## Configure the echo service

In order to route a request using Kong Gateway we need a service running in our cluster. Install an echo service using the following command:

```bash
kubectl apply -f https://docs.konghq.com/assets/kubernetes-ingress-controller/examples/echo-service.yaml
```

Create a HTTPRoute to send any requests that start with /echo to the echo service.

```bash
kubectl apply -f ./manifests/kong/echo_route.yaml
kubectl delete httproute echo
```

## Test the configuration

```bash
# To test the configuration, make a call to the $PROXY_IP that you configured.
curl $PROXY_IP/echo
```

IT EQUIPMENT BUY/SELL SERVERS/SWITCHES FACEBOOK

``````
<https://github.com/Kong/charts/tree/main/charts/kong>

## Enable Nginx Ingress Controller

For load balancing in a MicroK8s cluster, MetalLB can make use of Ingress to properly balance across the cluster. To do this, it requires a load balancer service.

```bash
microk8s enable ingress

microk8s kubectl get all --namespace ingress -o wide

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
pushd ~/src/reports/k8s
kubectl apply -f manifests/ingress/ingress-service.yaml
service/ingress created
# verify arp request for a load balancer succeeded in finding an external IP and database pass-through ports are shown.
kubectl get svc -n ingress                             
NAME      TYPE           CLUSTER-IP       EXTERNAL-IP   PORT(S)                                     AGE
ingress   LoadBalancer   10.152.183.151   10.1.0.110    80:32206/TCP,443:30188/TCP,3306:32692/TCP   28s

# watch the pods restart with the updated configuration
kubectl get pods -n ingress -o wide

# test ingress with small micro-service
# Reference: https://fabianlee.org/2021/07/29/kubernetes-microk8s-with-multiple-metallb-endpoints-and-nginx-ingress-controllers/

pushd ~/src/repsys/k8s
kubectl apply -f ./manifests/ingress/golang-hello-world/deployment/golang-hello-world-web.yaml
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

**[generate and install certs](../volume/pki/gen-and-install-certs.md)**

```bash
# make sure kubectl is pointing to the correct K8s cluster
kubectl create -n default secret tls tls-credential --key=/home/brent/src/repsys/volumes/pki/intermediateCA/private/reports51.busche-cnc.com.san.key.pem --cert=/home/brent/src/repsys/volumes/pki/intermediateCA/certs/server-chain/reports51.busche-cnc.com-ca-chain-bundle.cert.pem
secret/tls-credential created

# shows both tls secrets
kubectl get secrets --namespace default
NAME             TYPE                DATA   AGE
tls-credential   kubernetes.io/tls   2      54s

# show cert chain
kubectl get secret -n default tls-credential -o json | jq -r '.data."tls.crt"' | base64 -d
# show server cert key
kubectl get secret -n default tls-credential -o json | jq -r '.data."tls.key"' | base64 -d

# Update host property in the ingres yaml. 
pushd ~/src/reports/k8s
code ./manifests/ingress/golang-hello-world/ingress/golang-hello-world-web-on-nginx-fqdn.yaml
# Now that the host property has the same value as that of one of the alt names in SAN certificate previously deployed to the cluster, create the ingress object.
kubectl apply -f ./manifests/ingress/golang-hello-world/ingress/golang-hello-world-web-on-nginx-fqdn.yaml
Warning: annotation "kubernetes.io/ingress.class" is deprecated, please use 'spec.ingressClassName' instead
ingress.networking.k8s.io/golang-hello-world-web-service created

# show Ingress objects
kubectl get ingress --namespace default
NAME                             CLASS    HOSTS       ADDRESS     PORTS     AGE
golang-hello-world-web-service   <none>   reports11.busche-cnc.com   127.0.0.1   80, 443   96s

# verify certificates
# https://curl.se/docs/sslcerts.html
# https://www.baeldung.com/linux/curl-https-connection 
# Make sure cert chain was added to linux cert store.  
- See **[gen-and-install-certs.md](../volumes/pki/gen-and-install-certs.md)**
# verify the cert chain from our PKI is returned using this command:
openssl s_client -showcerts -connect reports51.busche-cnc.com:443 -servername reports51.busche-cnc.com -CApath /etc/ssl/certs 

openssl s_client -showcerts -connect reports11.busche-cnc.com:443 -servername reports11.busche-cnc.com -CApath /etc/ssl/certs 

# https://unix.stackexchange.com/questions/421969/openssl-fetches-different-ssl-certificate-than-the-one-obtained-via-a-browser
# s_client by default does not send SNI (Server Name Indication) data but a browser does. The server may choose to respond with a different certificate based on the contents of that SNI - or if no SNI is present then it will serve a default certificate. Solution is to add -servername param.

# Verify TLS connection returns hello world
# https://phoenixnap.com/kb/microk8s-ingress
# https://mswis.com/configure-microk8s-kubernetes-load-balancer-with-tls/

curl -v --cacert /home/brent/src/repsys/volumes/pki/intermediateCA/certs/ca-chain/ca-chain-bundle.cert.pem https://reports51.busche-cnc.com/myhello/

curl -v https://reports51.busche-cnc.com/myhello/
curl -v https://reports11.busche-cnc.com/myhello/

# Delete test deployment

kubectl delete deployment.apps/golang-hello-world-web
kubectl delete service/golang-hello-world-web-service
kubectl delete ingress golang-hello-world-web-service

```
