# issue

## try 2

```bash
kubectl apply -f https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-crds.yaml

kubectl apply -f https://raw.githubusercontent.com/mysql/mysql-operator/trunk/deploy/deploy-operator.yaml

kubectl get deployment mysql-operator --namespace mysql-operator

kubectl describe pod/mysql-operator-7cbc8bd94d-xrpl2  --namespace mysql-operator
Events:
  Type     Reason                  Age                From               Message
  ----     ------                  ----               ----               -------
  Normal   Scheduled               94s                default-scheduler  Successfully assigned mysql-operator/mysql-operator-7cbc8bd94d-xrpl2 to k8sn211
  Warning  FailedCreatePodSandBox  95s                kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "86a02a57d961b8fb958910921f15bf458773dba25df78671d788881578edc79f": plugin type="calico" failed (add): error getting ClusterInformation: Get "https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default": tls: failed to verify certificate: x509: certificate signed by unknown authority
  Normal   SandboxChanged          11s (x7 over 95s)  kubelet            Pod sandbox changed, it will be killed and re-created.
```

## try 1

### the error

"calico" failed (add): error getting ClusterInformation: Get "<https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default>": tls: failed to verify certificate: x509: certificate signed by unknown authority

### reproduce

```bash
curl https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default
curl: (60) SSL certificate problem: unable to get local issuer certificate
More details here: https://curl.se/docs/sslcerts.html

curl failed to verify the legitimacy of the server and therefore could not
establish a secure connection to it. To learn more about this situation and
how to fix it, please visit the web page mentioned above.
```

## Verify the server with our CA root certificate

```bash
curl --cacert /var/snap/microk8s/current/certs/ca.crt https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default
```

Our root certificate can verify this certificate.

## What trust store does calico use when it performs this get request?

```bash
ls /var/snap/microk8s/current/certs/ca.crt 
```

## AI Overview: what certificate store is the calico microk8s plugin using when it performs https requests

The Calico MicroK8s plugin utilizes the certificate store provided by MicroK8s for HTTPS requests. MicroK8s creates a Certificate Authority (CA), a signed server certificate, and a service account key file, which are stored in /var/snap/microk8s/current/certs/. This CA and the signed server certificate are then used by the Kubernetes components, including Calico, to establish secure communication.

## Try http request after adding our ca root certificate to the system store

```bash
# where is trust store
ls /usr/local/share/ca-certificates/
# nothing
cd /usr/local/share/ca-certificates/
sudo cp /var/snap/microk8s/current/certs/ca.crt .
ls
ca.crt
# check trust store directory for files similar to ca.crt
ls /etc/ssl/certs/ca*
/etc/ssl/certs/ca-certificates.crt  /etc/ssl/certs/ca6e4ad9.0

# install ca-certificates update package
sudo apt-get install -y ca-certificates
ca-certificates is already the newest version (20240203).
ca-certificates set to manually installed.
0 upgraded, 0 newly installed, 0 to remove and 9 not upgraded.

# search ca-certificates.crt for our root certificate
sudo nvim /etc/ssl/certs/ca-certificates.crt

# update system trust store with certificate just added to the local certificate directory /usr/local/share/ca-certificates/
sudo update-ca-certificates

Updating certificates in /etc/ssl/certs...
rehash: warning: skipping ca-certificates.crt,it does not contain exactly one certificate or CRL
1 added, 0 removed; done.
Running hooks in /etc/ca-certificates/update.d...
done.

# check trust store directory again for files similar to ca.crt
ls /etc/ssl/certs/ca*
/etc/ssl/certs/ca-certificates.crt  /etc/ssl/certs/ca.pem  /etc/ssl/certs/ca6e4ad9.0
# is /etc/ssl/certs/ca.pem our root certificate? yes XLWsgfg==
# is our root certificate in /etc/ssl/certs/ca-certificates.crt. YES

# does curl succeed now
curl https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default
YES.
```

## try killing pod and see if it will recreate successfully

```bash
kubectl delete pods mysql-operator-7cbc8bd94d-xrpl2 --grace-period=0 -n mysql-operator
Events:
  Type     Reason          Age                    From     Message
  ----     ------          ----                   ----     -------
  Normal   SandboxChanged  2m3s (x5871 over 21h)  kubelet  Pod sandbox changed, it will be killed and re-created.
  Warning  FailedKillPod   4s (x4 over 41s)       kubelet  error killing pod: failed to "KillPodSandbox" for "8b3ea781-bbc5-4208-a544-a25cf00427b4" with KillPodSandboxError: "rpc error: code = Unknown desc = failed to destroy network for sandbox \"86a02a57d961b8fb958910921f15bf458773dba25df78671d788881578edc79f\": plugin type=\"calico\" failed (delete): error getting ClusterInformation: Get \"https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default\": tls: failed to verify certificate: x509: certificate signed by unknown authority"
 
kubectl delete pods mysql-operator-7cbc8bd94d-xrpl2 --grace-period=0 --force -n mysql-operator

kubectl describe pod/mysql-operator-7cbc8bd94d-l5nrs --namespace mysql-operator 

Events:
  Type     Reason                  Age                  From               Message
  ----     ------                  ----                 ----               -------
  Normal   Scheduled               4m23s                default-scheduler  Successfully assigned mysql-operator/mysql-operator-7cbc8bd94d-l5nrs to k8sn211
  Warning  FailedCreatePodSandBox  4m23s                kubelet            Failed to create pod sandbox: rpc error: code = Unknown desc = failed to setup network for sandbox "d84eb6a93d6a743a9dbce5424755514e7abdc28614b9c19222c4e8de9a939714": plugin type="calico" failed (add): error getting ClusterInformation: Get "https://10.152.183.1:443/apis/crd.projectcalico.org/v1/clusterinformations/default": tls: failed to verify certificate: x509: certificate signed by unknown authority
  Normal   SandboxChanged          8s (x21 over 4m22s)  kubelet            Pod sandbox changed, it will be killed and re-created.

kubectl delete pods pod/mysql-operator-7cbc8bd94d-l5nrs --grace-period=0 --force -n mysql-operator
```

what ca certificates does python 3.13 trust

Python 3.13 trusts CA certificates by leveraging the system's default certificate store and the Mozilla CA Certificate initiative, according to documentation and PyPI. Specifically, the ssl.create_default_context() method, which is used for creating SSL/TLS contexts, now defaults to trusting the system's certificate store and also includes security features like VERIFY_X509_PARTIAL_CHAIN and VERIFY_X509_STRICT.

## can't stop microk8s

```bash
sudo microk8s stop
Stopped.
ctr: failed to dial "/var/snap/microk8s/common/run/containerd.sock": connection error: desc = "transport: error while dialing: dial unix /var/snap/microk8s/common/run/containerd.sock: connect: connection refused"
ctr: failed to dial "/var/snap/microk8s/common/run/containerd.sock": connection error: desc = "transport: error while dialing: dial unix /var/snap/microk8s/common/run/containerd.sock: connect: connection refused"
ctr: failed to dial "/var/snap/microk8s/common/run/containerd.sock": connection error: desc = "transport: error while dialing: dial unix /var/snap/microk8s/common/run/containerd.sock: connect: connection refused"
iptables: No chain/target/match by that name.
Stopped.
```

A ca to certificate trust store.

does node have openssl? yes.

```bash
kubectl logs pod/mysql-operator-7cbc8bd94d-skbnb -n mysql-operator
Error from server (BadRequest): container "mysql-operator" in pod "mysql-operator-7cbc8bd94d-skbnb" is waiting to start: ContainerCreating

kubectl describe pod/mysql-operator-7cbc8bd94d-skbnb -n mysql-operator
Name:             mysql-operator-7cbc8bd94d-skbnb
Namespace:        mysql-operator
Priority:         0
Service Account:  mysql-operator-sa
Node:             k8sn211/10.97.219.76
Start Time:       Fri, 11 Apr 2025 18:59:14 -0400
Labels:           name=mysql-operator
                  pod-template-hash=7cbc8bd94d
Annotations:      <none>
Status:           Pending
IP:               
IPs:              <none>
Controlled By:    ReplicaSet/mysql-operator-7cbc8bd94d
Containers:
  mysql-operator:
    Container ID:  
    Image:         container-registry.oracle.com/mysql/community-operator:9.2.0-2.2.3
    Image ID:      
    Port:          <none>
    Host Port:     <none>
    Args:
      mysqlsh
      --log-level=@INFO
      --pym
      mysqloperator
      operator
    State:          Waiting
      Reason:       ContainerCreating
    Ready:          False
    Restart Count:  0
    Readiness:      exec [cat /tmp/mysql-operator-ready] delay=1s timeout=1s period=3s #success=1 #failure=3
    Environment:
      MYSQLSH_USER_CONFIG_HOME:                 /mysqlsh
      MYSQLSH_CREDENTIAL_STORE_SAVE_PASSWORDS:  never
    Mounts:
      /mysqlsh from mysqlsh-home (rw)
      /tmp from tmpdir (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-thhf4 (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   False 
  Initialized                 True 
  Ready                       False 
  ContainersReady             False 
  PodScheduled                True 
Volumes:
  mysqlsh-home:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  tmpdir:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  kube-api-access-thhf4:
    Type:                    Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:  3607
    ConfigMapName:           kube-root-ca.crt
    ConfigMapOptional:       <nil>
    DownwardAPI:             true
QoS Class:                   BestEffort
Node-Selectors:              <none>
Tolerations:                 node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                             node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason          Age                  From     Message
  ----    ------          ----                 ----     -------
  Normal  SandboxChanged  9s (x25 over 5m27s)  kubelet  Pod sandbox changed, it will be killed and re-created.

 kubectl describe deployment.apps/mysql-operator -n mysql-operator
Name:                   mysql-operator
Namespace:              mysql-operator
CreationTimestamp:      Fri, 11 Apr 2025 18:59:14 -0400
Labels:                 app.kubernetes.io/component=controller
                        app.kubernetes.io/created-by=mysql-operator
                        app.kubernetes.io/instance=mysql-operator
                        app.kubernetes.io/managed-by=mysql-operator
                        app.kubernetes.io/name=mysql-operator
                        app.kubernetes.io/version=9.2.0-2.2.3
                        version=1.0
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               name=mysql-operator
Replicas:               1 desired | 1 updated | 1 total | 0 available | 1 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:           name=mysql-operator
  Service Account:  mysql-operator-sa
  Containers:
   mysql-operator:
    Image:      container-registry.oracle.com/mysql/community-operator:9.2.0-2.2.3
    Port:       <none>
    Host Port:  <none>
    Args:
      mysqlsh
      --log-level=@INFO
      --pym
      mysqloperator
      operator
    Readiness:  exec [cat /tmp/mysql-operator-ready] delay=1s timeout=1s period=3s #success=1 #failure=3
    Environment:
      MYSQLSH_USER_CONFIG_HOME:                 /mysqlsh
      MYSQLSH_CREDENTIAL_STORE_SAVE_PASSWORDS:  never
    Mounts:
      /mysqlsh from mysqlsh-home (rw)
      /tmp from tmpdir (rw)
  Volumes:
   mysqlsh-home:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   tmpdir:
    Type:          EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:        
    SizeLimit:     <unset>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      False   MinimumReplicasUnavailable
  Progressing    False   ProgressDeadlineExceeded
OldReplicaSets:  <none>
NewReplicaSet:   mysql-operator-7cbc8bd94d (1/1 replicas created)
Events:          <none>

```

<https://github.com/kubernetes/kubernetes/issues/111469>
