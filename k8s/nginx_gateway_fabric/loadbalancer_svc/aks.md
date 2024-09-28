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
IP:                       10.0.160.21
IPs:                      10.0.160.21
LoadBalancer Ingress:     52.228.166.50
Port:                     http  80/TCP
TargetPort:               80/TCP
NodePort:                 http  30244/TCP
Endpoints:                10.244.2.22:80
Port:                     https  443/TCP
TargetPort:               443/TCP
NodePort:                 https  31999/TCP
Endpoints:                10.244.2.22:443
Session Affinity:         None
External Traffic Policy:  Local
Internal Traffic Policy:  Cluster
HealthCheck NodePort:     32220
Events:                   <none>
```
