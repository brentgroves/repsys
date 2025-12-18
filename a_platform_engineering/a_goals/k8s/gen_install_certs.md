# Generate and Install Certificates

**[Report System Install](./report-system-install.md)**\
**[Current Status](../development/status/weekly/current_status.md)**\
**[Back to Main](../README.md)**

## **[generate and install certs](../../../pki/gen-and-install-certs.md)**

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
