# Feature List

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## https and rate limiting features

How can I get both https termination and rate limiting for the report system web app using NGINX, istio, or kong?

Default Rate limiting is usually provided by cloud provider's load balancer such as is the case for Azure AKS.

Nginx Gateway Fabric would achieve rate limiting using custom policies but currently it has only about four custom policies and rate limiting is not one of them.

**[Nginx Ingress Controller](../../k8s/ingress-lb-install.md)** can do both **[rate limiting](../../research/m_z/nginx_ingress_controller/rate_limiting.md)** and tls termination but F5 seems to be pushing Nginx Gateway Fabric so I don't like the idea of using the Ingress controller.

Istio does not seem to be a good fit for a SPA like react.js, but I would like to use it for non-SPA microservices such as the email server.

**[Kong](../../k8s/kong-experimental-install.md)** supports **[tls termination](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/services/tls/)** and **[basic rate limiting](https://docs.konghq.com/gateway/latest/get-started/rate-limiting/)** via a free plugin.

**[TLS pass-through Fallback](https://gist.github.com/denji/12b3a568f092ab951456)**

| Software      | routing                                                              | https termination                                                        | tls passthrough                                                        | rate limiting | IAM | Identity Provider |
|---------------|----------------------------------------------------------------------|--------------------------------------------------------------------------|------------------------------------------------------------------------|---------------|-----|-------------------|
| Nginx Gateway | **[ngroute](../../research/m_z/nginx_gateway_fabric/routing_traffic.md)** | **[nghttps](../../research/m_z/nginx_gateway_fabric/https_termination.md)** | **[ngtls](../../research/m_z/nginx_gateway_fabric/tls_passthrough.md)** |               |     |                   |
| Nginx Ingress |                                                                      |                                                                          |                                                                        |               |     |                   |
| istio mesh    |                                                                      |                                                                          |                                                                        |               |     |                   |
| kong api      |                                                                      |                                                                          |                                                                        |               |     |                   |
| keycloak      |                                                                      |                                                                          |                                                                        |               |     |                   |
| Entra ID      |                                                                      |                                                                          |                                                                        |               |     |                   |

**[nght](../../research/m_z/nginx_gateway_fabric/https_termination.md)**
