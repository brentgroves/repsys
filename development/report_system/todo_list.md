# ToDo List

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

- **[istio getting started](https://istio.io/latest/docs/setup/getting-started/)**
- **[Mastering Istio Rate Limiting for Efficient Traffic Management](../../research/a_l/istio/threat_protection/rate_limiting.md)**

- **[istio gateway](https://istio.io/latest/docs/reference/config/networking/gateway/)**

- **[example app](https://medium.com/@SabujJanaCodes/running-a-full-stack-app-in-istio-service-mesh-part-1-87b828f4d1cc)**
- **[istio tls termination web app](https://www.danielstechblog.io/run-the-istio-ingress-gateway-with-tls-termination-and-tls-passthrough/)**

- **[K8S Gateway API and TLS](https://imesh.ai/blog/secure-tls-kubernetes-gateway-api/)**
- **[F5 Nginx rate-limit](https://docs.nginx.com/nginx/admin-guide/security-controls/controlling-access-proxied-http/)**
- **[NGINX rate limiting](https://www.f5.com/company/blog/nginx/microservices-march-protect-kubernetes-apis-with-rate-limiting)**
- **[5 things to know about nginx gateway fabric](https://blog.nginx.org/blog/5-things-to-know-about-nginx-gateway-fabric)**
- **[How do I choose between Gateway,Ingress Controller, and Service Mesh](../../research/m_z/nginx_gateway_fabric/choose_gateway_ingress_or_mesh.md)**
- **[Create secret for repsys.linamar.com secret](../../research/a_l/k8s/secrets/secrets.md)**
A Secret is an object that contains a small amount of sensitive data such as a password, a token, or a key. Such information might otherwise be put in a Pod specification or in a container image. Using a Secret means that you don't need to include confidential data in your application code.

Because Secrets can be created independently of the Pods that use them, there is less risk of the Secret (and its data) being exposed during the workflow of creating, viewing, and editing Pods. Kubernetes, and applications that run in your cluster, can also take additional precautions with Secrets, such as avoiding writing sensitive data to nonvolatile storage.

- **[https termination](../../research/m_z/nginx_gateway_fabric/https_termination.md#send-traffic)**

- **[NEXT - tls passthrough](../../research/m_z/nginx_gateway_fabric/tls_passthrough.md)**

- **[Service Mesh 101](../../research/a_l/application_architecture/service_mesh_101.md)**
- **[TLS termination using NGINX Gateway Fabric](../../research/m_z/nginx_gateway_fabric/https_termination.md)**

## Debugging Pods/Containers

- **[Docker Container Debug](https://code.visualstudio.com/docs/containers/debug-common)**
- **[Debug Pods](https://kubernetes.io/docs/tasks/debug/debug-application/debug-running-pod/)**

## NetworkP programming

- **[Packet Filter](https://github.com/ghedo/go.pkt)**
- **[Golang http handler](https://medium.com/geekculture/demystifying-http-handlers-in-golang-a363e4222756)**

## Keycloak with TLS termination using nginx ingress

Get Keycloak on K8s with TLS termination using nginx ingress.
<https://docs.nginx.com/nginx-gateway-fabric/overview/gateway-architecture/>

## TLS termination using istio gateway

Get TLS termination with istio and k8s gateway api.
<https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/>
<https://gateway-api.sigs.k8s.io/guides/tls/>

- **[Keycloak getting started](../../research/a_l/iam/keycloak/keycloak_getting_started.md)**
- **[Cofiguring Keycloak](../../research/a_l/iam/keycloak/configuring_keycloak.md)**
- **[Configuring Keycloak for production](../../research/a_l/iam/keycloak/configuration_production.md)**

- **[istio tls termination web app](https://www.danielstechblog.io/run-the-istio-ingress-gateway-with-tls-termination-and-tls-passthrough/)**

- **[Request Level Authentication and Authorization with Istio and Keycloak](../../research/a_l/istio/authentication_and_authorization.md)**

- **[istio secure gateway](../../research/a_l/istio/secure_gateway.md)**

- **[istio with your PKI](../../research/a_l/istio/pki/cert_managment.md)**
- **[End-User-Authentication with Istio & Keycloak](../../research/a_l/istio/istio_keycloak_authentication.md)**
- **[reverse proxy config](https://www.keycloak.org/server/reverseproxy)**
- **[Keycloak Operator Install](../../k8s/keycloak_install.md)**
- **[Keycloak IAM AD integration](../../research/a_l/iam/keycloak/keycloak_ad.md)**
- **[How to Implement Keycloak Authentication in React](https://www.geeksforgeeks.org/how-to-implement-keycloak-authentication-in-react/)**
- **[Full Stack App in istio Service Mesh](../../../research/a_l/istio/full_stack_app_in_istio.md)**
