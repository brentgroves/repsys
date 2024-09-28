# loadbalancer service

```bash
kubectl describe svc/nginx-gateway -n nginx-gateway
Name:                     nginx-gateway
Namespace:                nginx-gateway
Labels:                   app.kubernetes.io/instance=nginx-gateway
                          app.kubernetes.io/name=nginx-gateway
                          app.kubernetes.io/version=1.4.0
Annotations:              <none>
Selector:                 app.kubernetes.io/instance=nginx-gateway,app.kubernetes.io/name=nginx-gateway
Type:                     LoadBalancer
IP Family Policy:         SingleStack
IP Families:              IPv4
IP:                       10.152.183.50
IPs:                      10.152.183.50
LoadBalancer Ingress:     10.1.0.143 (VIP)
Port:                     http  80/TCP
TargetPort:               80/TCP
NodePort:                 http  30833/TCP
Endpoints:                10.1.187.136:80
Port:                     https  443/TCP
TargetPort:               443/TCP
NodePort:                 https  31343/TCP
Endpoints:                10.1.187.136:443
Session Affinity:         None
External Traffic Policy:  Local
Internal Traffic Policy:  Cluster
HealthCheck NodePort:     32434
Events:
  Type    Reason        Age                   From             Message
  ----    ------        ----                  ----             -------
  Normal  nodeAssigned  3m52s (x47 over 74m)  metallb-speaker  announcing from node "repsys11-c2-n3" with protocol "layer2"
```
