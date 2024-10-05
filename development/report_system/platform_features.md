# Feature List

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## https and rate limiting features

How can I get both https termination and rate limiting for the report system web app using NGINX, istio, or kong?

Rate limiting is only needed on on-prem K8s because the load balancer provides this feature on most cloud based k8s such as Azure AKS.

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
