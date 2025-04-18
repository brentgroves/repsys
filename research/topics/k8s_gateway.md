# K8s Ingress

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

## Secure Gateway Meeting

TLS is a cross-cutting concern so if the platform can perform the encryption/decription it would offload the task from the microservices. Fortunately, any K8s gateway can perform TLS termination. Istio service mesh is the gateway the report system uses and is a control plane to envoy proxies which has the following feature support:

- TLS/mTLS termination
- automatic retries
- circuit breaking
- global rate limiting
- request shadowing
- outlier detection

**Issue:** K8s Cluster provides http listerners for multiple hosts providing services such as the request web app and keycloak IAM. These microservices can be reached using repsys.linamar.com and keycloack.linamar.com FQDN. Unfortunately, at the stage when the TLS protocol serves certificates the name of the host is not known.  To solve this issue an extention to TLS, SNI, was created to identify the hostname in a TLS handshake but requires a host key/value pair to be sent in the http request header.  This is viable when your client is cURL or some program but not a good solution when your client is a browser.  
**Solution:** To get around this limation we use a SAN certificate which is valid for every host name.

## Features of an API Gateway

Ok, so we have just seen how an API Gateway can route Southbound traffic to the required Service and microservice within our cluster but this is only one of the features of an API gateway. Others include:

- Routing based on host, path, headers and more
- Load balancing
- Security
- Enforcing authentication
- Service monitoring
- Request monitoring and tracing
- A/B testing
- API versioning
- Rating limiting / circuit breaking
- Request transformation

## Which K8s Gateway should we use

**Default Rate limiting** is usually provided by cloud provider's load balancer such as is the case for **Azure AKS**.

**Nginx Gateway Fabric** would achieve rate limiting using custom policies but currently it has only about four custom policies and rate limiting is not one of them.

**[Nginx Ingress Controller](../../k8s/ingress-lb-install.md)** can do both **[rate limiting](../../research/m_z/nginx_ingress_controller/rate_limiting.md)** and **tls termination** but F5 seems to be pushing Nginx Gateway Fabric so I don't like the idea of using the Ingress controller.

**Istio** seems to have about every feature because it leverages **[Envoy](https://tetrate.io/what-is-envoy-proxy/)** proxy server technology. In addition to the traditional load balancing between different instances, Envoy also allows you to implement retries, circuit breakers, rate limiting, and so on. Also, while doing all that, Envoy collects rich metrics about the traffic it passes through and exposes the metrics for consumption and use in tools such as Grafana, for example.

**[Kong](../../k8s/kong-install.md)** supports **[tls termination](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/services/tls/)** and **[basic rate limiting](https://docs.konghq.com/gateway/latest/get-started/rate-limiting/)** via a free plugin.

## Summary

Use **Istio** which leverages **[Envoy](https://tetrate.io/what-is-envoy-proxy/)** proxy server technology to support about every possible Application Delivery Controller, **[ADC](https://kemptechnologies.com/blog/what-is-an-application-delivery-controller-(adc)-and-why-should-you-use-one)**, feature such as retries, circuit breakers, rate limiting, tls termination, and metrics.

| Software      | routing                                                                      | https termination                                                                            | https passthrough                                                                            | rate limiting                                                                |
|---------------|------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|----------------------------------------------------------------------------------------------|------------------------------------------------------------------------------|
| Nginx Gateway | **[yes](../../research/m_z/nginx_gateway_fabric/routing_traffic.md)**        | **[nghttps](../../research/m_z/nginx_gateway_fabric/https_termination.md)**                  | **[yes](../../research/m_z/nginx_gateway_fabric/tls_passthrough.md)**                        | no                                                                           |
| Nginx Ingress | yes                                                                          | yes                                                                                          | **[yes](https://kubernetes.github.io/ingress-nginx/user-guide/tls/)**                        | **[yes](../../research/m_z/nginx_ingress_controller/rate_limiting.md)**      |
| Istio         | **[yes](../../research/a_l/istio/learn_microservices_with_istio_on_k8s.md)** | **[yes](../../research/a_l/istio/learn_microservices_with_istio_on_k8s.md)**                 | **[yes](../../research/a_l/istio/learn_microservices_with_istio_on_k8s.md)**                 | yes                                                                          |
| Kong          | **[yes](../../k8s/kong-install.md)**                                         | **[yes](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/services/tls/)** | **[yes](https://docs.konghq.com/kubernetes-ingress-controller/latest/guides/services/tls/)** | **[yes](https://docs.konghq.com/gateway/latest/get-started/rate-limiting/)** |
