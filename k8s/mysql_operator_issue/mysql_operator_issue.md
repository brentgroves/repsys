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
