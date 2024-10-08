# **[Rate Limiting](https://docs.nginx.com/nginx-service-mesh/tutorials/ratelimit-walkthrough/)**

**[Current Status](../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research/research_list.md)**\
**[Back Main](../../../README.md)**

## refenence

- **[This might work](https://www.f5.com/company/blog/nginx/microservices-march-protect-kubernetes-apis-with-rate-limiting)**
- **[Try to add tls termination](https://kubernetes.github.io/ingress-nginx/examples/tls-termination/)**
- **[NGINX ingress controller rate limiting](https://www.civo.com/learn/rate-limiting-applications-with-nginx-ingress)**
- **[Annotations](https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md)**
- **[Advanced Configurations](https://docs.nginx.com/nginx-ingress-controller/configuration/ingress-resources/advanced-configuration-with-annotations/)**
- **[ingress rate limiting](https://www.f5.com/company/blog/nginx/microservices-march-protect-kubernetes-apis-with-rate-limiting)**
- **[Setting up request rate limiting](<https://dzone.com/articles/setting-up-request-rate-limiting-with-nginx-ingres#:~:text=To%20apply%20rate%20limiting%20using,what%20rules%20should%20be%20applied.&text=In%20this%20example%2C%20we%20set,per%20second%20(%20limit%2Drps%20)>**

## Summary

To get DOS feature we need to pay for NGINX Plus. In the docs you will always see some note like: "To use NGINX App Protect WAF with NGINX Ingress Controller, you must have NGINX Plus."

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

## **[What Is Rate Limiting?](https://www.f5.com/company/blog/nginx/microservices-march-protect-kubernetes-apis-with-rate-limiting)**

Rate limiting restricts the number of requests a user can make in a given time period. To mitigate a DDoS attack, for example, you can use rate limiting to limit the incoming request rate to a value typical for real users. When rate limiting is implemented with NGINX, clients that submit too many requests are redirected to an error page so they cannot negatively impact the API. Learn how this works in the **[NGINX Ingress Controller documentation](https://docs.nginx.com/nginx-ingress-controller/configuration/policy-resource/#ratelimit)**.

## What Is an API Gateway?

An API gateway routes API requests from clients to the appropriate services. A big misinterpretation of this simple definition is that an API gateway is a unique piece of technology. It’s not. Rather, “API gateway” describes a set of use cases that can be implemented via different types of proxies – most commonly an ADC or load balancer and reverse proxy, and increasingly an Ingress controller or service mesh. Rate limiting is a common use case for deploying an API gateway. Learn more about API gateway use cases in Kubernetes in **[How Do I Choose? API Gateway vs. Ingress Controller vs. Service Mesh](https://www.f5.com/company/blog/nginx/how-do-i-choose-api-gateway-vs-ingress-controller-vs-service-mesh)** on our blog.
