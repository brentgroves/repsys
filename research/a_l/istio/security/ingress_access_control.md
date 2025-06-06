# **[Ingress Access Control](https://istio.io/latest/docs/tasks/security/authorization/authz-ingress/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## How can we offload IAM to identity providers with our Istio gateway

- **[Istio Ingress Access Control](../../research/a_l/istio/security/ingress_access_control.md)**

- Access to our Cloud based web app is very strict
  - Client must have a client certificate generated by our PKI
  - Access is restricted
    - by IP Addresses
    - by custome **[External Authorizer](https://istio.io/latest/docs/tasks/security/authorization/)**
    - and by **[External Authorization via OIDC](https://www.digihunch.com/2022/02/istio-external-authorization/)** IE EntraID

## More tutorials

- **[Keycloak with Istio 2 month old](https://chrishaessig.medium.com/keycloak-with-istio-and-oauth2-proxy-65227a383c15)**
- **[Using External Authentication with Istio](https://dzone.com/articles/origin-authentication-and-rbac-in-istio-with-custo)**
- **[How to use JWT authorization in Istio](JWThttps://stackoverflow.com/questions/59897998/how-to-use-authorization-and-jwt-with-istio)**
