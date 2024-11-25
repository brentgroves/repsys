# **[End-user Authentication](https://istio.io/latest/docs/tasks/security/authentication/authn-policy/#end-user-authentication)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

![j](https://cdn.sanity.io/images/141x4uzu/production/c4ac5fa7137769d84630fd3d1fac135b1ee94c39-6336x4292.png)

## references

- **[External Authorization via OIDC](https://www.digihunch.com/2022/02/istio-external-authorization/)**
- **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**

To experiment with this feature, you need a valid JWT. The JWT must correspond to the JWKS endpoint you want to use for the demo. This tutorial uses the test token **[JWT test](https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/demo.jwt)** and **[JWKS endpoint](https://raw.githubusercontent.com/istio/istio/release-1.24/security/tools/jwt/samples/jwks.json)** from the Istio code base.

Also, for convenience, expose httpbin.foo via an ingress gateway (for more details, see the **[ingress task](https://istio.io/latest/docs/tasks/traffic-management/ingress/)**).

Istio supports the Kubernetes Gateway API and intends to make it the default API for traffic management in the future. The following instructions allow you to choose to use either the Gateway API or the Istio configuration API when configuring traffic management in the mesh. Follow instructions under either the Gateway API or Istio APIs tab, according to your preference.

Note that the Kubernetes Gateway API CRDs do not come installed by default on most Kubernetes clusters, so make sure they are installed before using the Gateway API:

```bash
$ kubectl get crd gateways.gateway.networking.k8s.io &> /dev/null || \
  { kubectl apply -f https://github.com/kubernetes-sigs/gateway-api/releases/download/v1.2.0/standard-install.yaml; }
```

Run a test query through the gateway:

```bash
curl "$INGRESS_HOST:$INGRESS_PORT/headers" -s -o /dev/null -w "%{http_code}\n"
```

200
