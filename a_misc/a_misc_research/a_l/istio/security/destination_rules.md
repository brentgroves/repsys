# **[Destination Rules](https://istio.io/latest/docs/concepts/traffic-management/#destination-rules)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

Along with virtual services, destination rules are a key part of Istio’s traffic routing functionality. You can think of virtual services as how you route your traffic to a given destination, and then you use destination rules to configure what happens to traffic for that destination. Destination rules are applied after virtual service routing rules are evaluated, so they apply to the traffic’s “real” destination.

In particular, you use destination rules to specify named service subsets, such as grouping all a given service’s instances by version. You can then use these service subsets in the routing rules of virtual services to control the traffic to different instances of your services.

Destination rules also let you customize Envoy’s traffic policies when calling the entire destination service or a particular service subset, such as your preferred load balancing model, TLS security mode, or circuit breaker settings. You can see a complete list of destination rule options in the **[Destination Rule reference](https://istio.io/latest/docs/reference/config/networking/destination-rule/)**.

## Destination rule example

The following example destination rule configures three different subsets for the my-svc destination service, with different load balancing policies:

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: my-destination-rule
spec:
  host: my-svc
  trafficPolicy:
    loadBalancer:
      simple: RANDOM
  subsets:
  - name: v1
    labels:
      version: v1
  - name: v2
    labels:
      version: v2
    trafficPolicy:
      loadBalancer:
        simple: ROUND_ROBIN
  - name: v3
    labels:
      version: v3
```

Each subset is defined based on one or more labels, which in Kubernetes are key/value pairs that are attached to objects such as Pods. These labels are applied in the Kubernetes service’s deployment as metadata to identify different versions.

As well as defining subsets, this destination rule has both a default traffic policy for all subsets in this destination and a subset-specific policy that overrides it for just that subset. The default policy, defined above the subsets field, sets a simple random load balancer for the v1 and v3 subsets. In the v2 policy, a round-robin load balancer is specified in the corresponding subset’s field.

## **[Destination Rules](https://istio.io/latest/docs/reference/config/networking/destination-rule/)**

**DestinationRule** defines policies that apply to traffic intended for a service after routing has occurred. These rules specify configuration for load balancing, connection pool size from the sidecar, and outlier detection settings to detect and evict unhealthy hosts from the load balancing pool. For example, a simple load balancing policy for the ratings service would look as follows:

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: bookinfo-ratings
spec:
  host: ratings.prod.svc.cluster.local
  trafficPolicy:
    loadBalancer:
      simple: LEAST_REQUEST
```

Version specific policies can be specified by defining a named subset and overriding the settings specified at the service level. The following rule uses a round robin load balancing policy for all traffic going to a subset named testversion that is composed of endpoints (e.g., pods) with labels (version:v3).

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: bookinfo-ratings
spec:
  host: ratings.prod.svc.cluster.local
  trafficPolicy:
    loadBalancer:
      simple: LEAST_REQUEST
  subsets:
  - name: testversion
    labels:
      version: v3
    trafficPolicy:
      loadBalancer:
        simple: ROUND_ROBIN
```

Note: Policies specified for subsets will not take effect until a route rule explicitly sends traffic to this subset.

Traffic policies can be customized to specific ports as well. The following rule uses the least connection load balancing policy for all traffic to port 80, while uses a round robin load balancing setting for traffic to the port 9080.

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: bookinfo-ratings-port
spec:
  host: ratings.prod.svc.cluster.local
  trafficPolicy: # Apply to all ports
    portLevelSettings:
    - port:
        number: 80
      loadBalancer:
        simple: LEAST_REQUEST
    - port:
        number: 9080
      loadBalancer:
        simple: ROUND_ROBIN
```

Destination Rules can be customized to specific workloads as well. The following example shows how a destination rule can be applied to a specific workload using the workloadSelector configuration.

```yaml
apiVersion: networking.istio.io/v1
kind: DestinationRule
metadata:
  name: configure-client-mtls-dr-with-workloadselector
spec:
  host: example.com
  workloadSelector:
    matchLabels:
      app: ratings
  trafficPolicy:
    loadBalancer:
      simple: ROUND_ROBIN
    portLevelSettings:
    - port:
        number: 31443
      tls:
        credentialName: client-credential
        mode: MUTUAL
```
