# Feature List

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## https and rate limiting features

How can I get both https termination and rate limiting for the report system web app using NGINX, istio, or kong?

Default Rate limiting is usually provided by cloud provider's load balancer such as is the case for Azure AKS.

To get **[DOS feature](https://docs.nginx.com/nginx-ingress-controller/installation/integrations/app-protect-dos/installation/)**, such as rate-limiting, in NGINX we need to pay for NGINX Plus. In the docs you will always see some note like: "To use NGINX App Protect WAF with NGINX Ingress Controller, you must have NGINX Plus."

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
