# How does Istio's request level authorization work

**[Current Status](../../development/status/weekly/current_status.md)**\
**[Research Summary](./research_summary.md)**\
**[Back Main](../../README.md)**

## search

how to implement request level authorization with istio 
## reference
https://rinormaloku.com/authorization-in-istio/
https://community.auth0.com/t/securing-kubernetes-clusters-with-istio-and-auth0/20492
https://thenewstack.io/securing-istio-workloads-with-auth0/
https://niravshah2705.medium.com/auth0-integration-with-istio-d31c50d2d5a0
https://medium.com/google-cloud/back-to-microservices-with-istio-part-2-authentication-authorization-b079f77358ac
- **[Implementing request level authentication and authorization using Istio and Keycloak](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/#:~:text=Istio%20performs%20request%20level%20authentication,accept%20the%20end%20user%20request.)**
In Istio, request-level authorization works by using "Authorization Policies" which define rules based on the source of a request, the target service, and specific conditions, allowing Istio to decide whether to permit or deny a request based on the defined criteria, typically leveraging authentication information like JWT tokens validated through "RequestAuthentication" policies to identify the requesting user or workload; essentially acting as a fine-grained access control mechanism at the request level within a service mesh. 
