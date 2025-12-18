# **[NGINX gateway deployment](https://gateway-api.sigs.k8s.io/reference/spec/#gateway.networking.k8s.io%2fv1.Gateway)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

Look at NGINX gateway deployment.

```bash
kubectl describe deployment/nginx-gateway -n nginx-gateway

Name:                   nginx-gateway
Namespace:              nginx-gateway
CreationTimestamp:      Fri, 27 Sep 2024 19:27:56 -0400
Labels:                 app.kubernetes.io/instance=nginx-gateway
                        app.kubernetes.io/name=nginx-gateway
                        app.kubernetes.io/version=1.4.0
Annotations:            deployment.kubernetes.io/revision: 1
Selector:               app.kubernetes.io/instance=nginx-gateway,app.kubernetes.io/name=nginx-gateway
Replicas:               1 desired | 1 updated | 1 total | 1 available | 0 unavailable
StrategyType:           RollingUpdate
MinReadySeconds:        0
RollingUpdateStrategy:  25% max unavailable, 25% max surge
Pod Template:
  Labels:           app.kubernetes.io/instance=nginx-gateway
                    app.kubernetes.io/name=nginx-gateway
  Annotations:      prometheus.io/port: 9113
                    prometheus.io/scrape: true
  Service Account:  nginx-gateway
  Containers:
   nginx-gateway:
    Image:           ghcr.io/nginxinc/nginx-gateway-fabric:1.4.0
    Ports:           9113/TCP, 8081/TCP
    Host Ports:      0/TCP, 0/TCP
    SeccompProfile:  RuntimeDefault
    Args:
      static-mode
      --gateway-ctlr-name=gateway.nginx.org/nginx-gateway-controller
      --gatewayclass=nginx
      --config=nginx-gateway-config
      --service=nginx-gateway
      --metrics-port=9113
      --health-port=8081
      --leader-election-lock-name=nginx-gateway-leader-election
      --gateway-api-experimental-features
    Readiness:  http-get http://:health/readyz delay=3s timeout=1s period=1s #success=1 #failure=3
    Environment:
      POD_IP:          (v1:status.podIP)
      POD_NAMESPACE:   (v1:metadata.namespace)
      POD_NAME:        (v1:metadata.name)
    Mounts:
      /etc/nginx/conf.d from nginx-conf (rw)
      /etc/nginx/includes from nginx-includes (rw)
      /etc/nginx/module-includes from module-includes (rw)
      /etc/nginx/secrets from nginx-secrets (rw)
      /etc/nginx/stream-conf.d from nginx-stream-conf (rw)
      /var/run/nginx from nginx-run (rw)
   nginx:
    Image:           ghcr.io/nginxinc/nginx-gateway-fabric/nginx:1.4.0
    Ports:           80/TCP, 443/TCP
    Host Ports:      0/TCP, 0/TCP
    SeccompProfile:  RuntimeDefault
    Environment:     <none>
    Mounts:
      /etc/nginx/conf.d from nginx-conf (rw)
      /etc/nginx/includes from nginx-includes (rw)
      /etc/nginx/module-includes from module-includes (rw)
      /etc/nginx/secrets from nginx-secrets (rw)
      /etc/nginx/stream-conf.d from nginx-stream-conf (rw)
      /var/cache/nginx from nginx-cache (rw)
      /var/run/nginx from nginx-run (rw)
  Volumes:
   nginx-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   nginx-stream-conf:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   module-includes:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   nginx-secrets:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   nginx-run:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   nginx-cache:
    Type:       EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:     
    SizeLimit:  <unset>
   nginx-includes:
    Type:          EmptyDir (a temporary directory that shares a pod's lifetime)
    Medium:        
    SizeLimit:     <unset>
  Node-Selectors:  <none>
  Tolerations:     <none>
Conditions:
  Type           Status  Reason
  ----           ------  ------
  Available      True    MinimumReplicasAvailable
  Progressing    True    NewReplicaSetAvailable
OldReplicaSets:  <none>
NewReplicaSet:   nginx-gateway-7f89b76fd4 (1/1 replicas created)
Events:          <none>
```
