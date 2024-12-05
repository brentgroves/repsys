# **[Kind LoadBalancer](https://kind.sigs.k8s.io/docs/user/loadbalancer/)**

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research List](../../research/research_list.md)**\
**[Back Main](../../README.md)**

## Gateways

There is a gateway or loadbalancer plugin but I have not tested it.

```bash
scc.sh kind.yaml kind-kind
kubectl port-forward -n istio-system svc/istio-ingressgateway 8000:80 
```
