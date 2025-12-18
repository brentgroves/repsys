# loadbalancer service

```bash
kubectl describe httproute/coffee
Name:         coffee
Namespace:    default
Labels:       <none>
Annotations:  <none>
API Version:  gateway.networking.k8s.io/v1
Kind:         HTTPRoute
Metadata:
  Creation Timestamp:  2024-09-28T20:12:44Z
  Generation:          1
  Resource Version:    15644531
  UID:                 6927df20-8b84-4ad7-ab69-b266960bce9d
Spec:
  Hostnames:
    repsys.linamar.com
  Parent Refs:
    Group:  gateway.networking.k8s.io
    Kind:   Gateway
    Name:   cafe
  Rules:
    Backend Refs:
      Group:   
      Kind:    Service
      Name:    coffee
      Port:    80
      Weight:  1
    Matches:
      Path:
        Type:   PathPrefix
        Value:  /
Status:
  Parents:
    Conditions:
      Last Transition Time:  2024-09-28T20:12:45Z
      Message:               The route is accepted
      Observed Generation:   1
      Reason:                Accepted
      Status:                True
      Type:                  Accepted
      Last Transition Time:  2024-09-28T20:12:45Z
      Message:               All references are resolved
      Observed Generation:   1
      Reason:                ResolvedRefs
      Status:                True
      Type:                  ResolvedRefs
    Controller Name:         gateway.nginx.org/nginx-gateway-controller
    Parent Ref:
      Group:      gateway.networking.k8s.io
      Kind:       Gateway
      Name:       cafe
      Namespace:  default
Events:           <none>

```
