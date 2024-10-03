# **[Rate Limiting](https://docs.nginx.com/nginx-service-mesh/tutorials/ratelimit-walkthrough/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## refenence

https://docs.nginx.com/nginx-gateway-fabric/overview/custom-policies/

The following table compares the key high‑level features of the standard Ingress API, NGINX Ingress Controller with CRDs, and Gateway API to illustrate their capabilities.

| Feature                              | Standard Ingress API | NGINX Ingress Controller with CRDs | Gateway API   |
|--------------------------------------|----------------------|------------------------------------|---------------|
| API specification                    | Ingress API          | Ingress API + CRDs                 | Gateway API   |
| Multi-user management                | ❌                    | ✅                                  | ✅             |
| Layer 7 protocols (HTTP/HTTPS, gRPC) | ✅                    | ✅                                  | ✅             |
| Layer 7 load balancing               | ✅                    | ✅                                  | Custom policy |
| Request routing                      | ✅                    | ✅                                  | ✅             |
| Request header manipulation          | Limited              | ✅                                  | ✅             |
| Response header manipulation         | Limited              | ✅                                  | ✅             |
| Layer 4 protocols (TLS, TCP, UDP)    | ❌                    | ✅                                  | ✅             |
| Layer 4 load balancing               | ❌                    | ✅                                  | Custom policy |
| Allow/deny lists                     | ❌                    | ✅                                  | Custom policy |
| Certificate validation               | ❌                    | ✅                                  | Custom policy |
| Authentication (OIDC)                | ❌                    | ✅                                  | Custom policy |
| Rate limiting                        | ❌                    | ✅                                  | Custom policy |
