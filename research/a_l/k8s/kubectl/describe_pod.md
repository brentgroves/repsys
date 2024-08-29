# **[Describe Kubernetes Pods With kubectl](https://www.warp.dev/terminus/kubectl-describe-pod)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## Describe Kubernetes Pods With kubectl

## kubectl describe node

```bash
kubectl describe pod/rabbitmqcluster-sample-server-0
Name:             rabbitmqcluster-sample-server-0
Namespace:        default
Priority:         0
Service Account:  rabbitmqcluster-sample-server
Node:             repsys11-c2-n3/10.1.0.141
Start Time:       Thu, 29 Aug 2024 17:29:17 -0400
Labels:           app.kubernetes.io/component=rabbitmq
                  app.kubernetes.io/name=rabbitmqcluster-sample
                  app.kubernetes.io/part-of=rabbitmq
                  apps.kubernetes.io/pod-index=0
                  controller-revision-hash=rabbitmqcluster-sample-server-7dbfb77fd5
                  statefulset.kubernetes.io/pod-name=rabbitmqcluster-sample-server-0
Annotations:      cni.projectcalico.org/containerID: 46e480d766cb747a1ec51ebb79e17381b4f64cc47d5721d6b6701a3c318afde3
                  cni.projectcalico.org/podIP: 10.1.187.130/32
                  cni.projectcalico.org/podIPs: 10.1.187.130/32
Status:           Running
IP:               10.1.187.130
IPs:
  IP:           10.1.187.130
Controlled By:  StatefulSet/rabbitmqcluster-sample-server
Init Containers:
  setup-container:
    Container ID:  containerd://9823158705fc83cfd247e9da9ed1445cd3bf1676232cb9d63c44fa96216ecb73
    Image:         rabbitmq:3.13.2-management
    Image ID:      docker.io/library/rabbitmq@sha256:eee9afbc17c32424ba6309dfd2d9efc9b9b1863ffe231b3d2be2815758b0d649
    Port:          <none>
    Host Port:     <none>
    Command:
      sh
      -c
      cp /tmp/erlang-cookie-secret/.erlang.cookie /var/lib/rabbitmq/.erlang.cookie && chmod 600 /var/lib/rabbitmq/.erlang.cookie ; cp /tmp/rabbitmq-plugins/enabled_plugins /operator/enabled_plugins ; echo '[default]' > /var/lib/rabbitmq/.rabbitmqadmin.conf && sed -e 's/default_user/username/' -e 's/default_pass/password/' /tmp/default_user.conf >> /var/lib/rabbitmq/.rabbitmqadmin.conf && chmod 600 /var/lib/rabbitmq/.rabbitmqadmin.conf ; sleep 30
    State:          Terminated
      Reason:       Completed
      Exit Code:    0
      Started:      Thu, 29 Aug 2024 17:29:29 -0400
      Finished:     Thu, 29 Aug 2024 17:29:59 -0400
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     100m
      memory:  500Mi
    Requests:
      cpu:        100m
      memory:     500Mi
    Environment:  <none>
    Mounts:
      /operator from rabbitmq-plugins (rw)
      /tmp/default_user.conf from rabbitmq-confd (rw,path="default_user.conf")
      /tmp/erlang-cookie-secret/ from erlang-cookie-secret (rw)
      /tmp/rabbitmq-plugins/ from plugins-conf (rw)
      /var/lib/rabbitmq/ from rabbitmq-erlang-cookie (rw)
      /var/lib/rabbitmq/mnesia/ from persistence (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrllx (ro)
Containers:
  rabbitmq:
    Container ID:   containerd://3296f8ec74e4a1c606dfc0de0abc36bbb4a15e2ef2905e65dc0c6ece75267bbe
    Image:          rabbitmq:3.13.2-management
    Image ID:       docker.io/library/rabbitmq@sha256:eee9afbc17c32424ba6309dfd2d9efc9b9b1863ffe231b3d2be2815758b0d649
    Ports:          4369/TCP, 5672/TCP, 15672/TCP, 15692/TCP
    Host Ports:     0/TCP, 0/TCP, 0/TCP, 0/TCP
    State:          Running
      Started:      Thu, 29 Aug 2024 17:30:00 -0400
    Ready:          True
    Restart Count:  0
    Limits:
      cpu:     2
      memory:  2Gi
    Requests:
      cpu:      1
      memory:   2Gi
    Readiness:  tcp-socket :amqp delay=10s timeout=5s period=10s #success=1 #failure=3
    Environment:
      MY_POD_NAME:                    rabbitmqcluster-sample-server-0 (v1:metadata.name)
      MY_POD_NAMESPACE:               default (v1:metadata.namespace)
      K8S_SERVICE_NAME:               rabbitmqcluster-sample-nodes
      RABBITMQ_ENABLED_PLUGINS_FILE:  /operator/enabled_plugins
      RABBITMQ_USE_LONGNAME:          true
      RABBITMQ_NODENAME:              rabbit@$(MY_POD_NAME).$(K8S_SERVICE_NAME).$(MY_POD_NAMESPACE)
      K8S_HOSTNAME_SUFFIX:            .$(K8S_SERVICE_NAME).$(MY_POD_NAMESPACE)
    Mounts:
      /etc/pod-info/ from pod-info (rw)
      /etc/rabbitmq/conf.d/10-operatorDefaults.conf from rabbitmq-confd (rw,path="operatorDefaults.conf")
      /etc/rabbitmq/conf.d/11-default_user.conf from rabbitmq-confd (rw,path="default_user.conf")
      /etc/rabbitmq/conf.d/90-userDefinedConfiguration.conf from rabbitmq-confd (rw,path="userDefinedConfiguration.conf")
      /operator from rabbitmq-plugins (rw)
      /var/lib/rabbitmq/ from rabbitmq-erlang-cookie (rw)
      /var/lib/rabbitmq/mnesia/ from persistence (rw)
      /var/run/secrets/kubernetes.io/serviceaccount from kube-api-access-vrllx (ro)
Conditions:
  Type                        Status
  PodReadyToStartContainers   True 
  Initialized                 True 
  Ready                       True 
  ContainersReady             True 
  PodScheduled                True 
Volumes:
  persistence:
    Type:       PersistentVolumeClaim (a reference to a PersistentVolumeClaim in the same namespace)
    ClaimName:  persistence-rabbitmqcluster-sample-server-0
    ReadOnly:   false
  plugins-conf:
    Type:      ConfigMap (a volume populated by a ConfigMap)
    Name:      rabbitmqcluster-sample-plugins-conf
    Optional:  false
  rabbitmq-confd:
    Type:                Projected (a volume that contains injected data from multiple sources)
    ConfigMapName:       rabbitmqcluster-sample-server-conf
    ConfigMapOptional:   <nil>
    SecretName:          rabbitmqcluster-sample-default-user
    SecretOptionalName:  <nil>
  rabbitmq-erlang-cookie:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  erlang-cookie-secret:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  rabbitmqcluster-sample-erlang-cookie
    Optional:    false
  rabbitmq-plugins:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
  pod-info:
    Type:  DownwardAPI (a volume populated by information about the pod)
    Items:
      metadata.labels['skipPreStopChecks'] -> skipPreStopChecks
  kube-api-access-vrllx:
    Type:                     Projected (a volume that contains injected data from multiple sources)
    TokenExpirationSeconds:   3607
    ConfigMapName:            kube-root-ca.crt
    ConfigMapOptional:        <nil>
    DownwardAPI:              true
QoS Class:                    Burstable
Node-Selectors:               <none>
Tolerations:                  node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                              node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Topology Spread Constraints:  topology.kubernetes.io/zone:ScheduleAnyway when max skew 1 is exceeded for selector app.kubernetes.io/name=rabbitmqcluster-sample
```

## kubectl top node

```bash
kubectl top node repsys11-c2-n1

NAME             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
repsys11-c2-n1   271m         27%    2495Mi          15%       

kubectl top nodes              

NAME             CPU(cores)   CPU%   MEMORY(bytes)   MEMORY%   
repsys11-c2-n1   306m         30%    2495Mi          15%       
repsys11-c2-n2   252m         12%    2349Mi          14%       
repsys11-c2-n3   258m         12%    2488Mi          15% 
```
