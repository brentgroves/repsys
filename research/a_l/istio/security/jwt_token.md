# **[JWT Token](https://istio.io/latest/docs/tasks/security/authorization/authz-jwt/)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research/research_list.md)**\
**[Back Main](../../../../README.md)**

## references

- **[External Authorization via OIDC](https://www.digihunch.com/2022/02/istio-external-authorization/)**
- **[conditions page](https://istio.io/latest/docs/reference/config/security/conditions/)**

This task shows you how to set up an Istio authorization policy to enforce access based on a JSON Web Token (JWT). An Istio authorization policy supports both string typed and list-of-string typed JWT claims.

## Before you begin

Before you begin this task, do the following:

Complete the Istio **[end user authentication task](https://istio.io/latest/docs/tasks/security/authentication/authn-policy/#end-user-authentication)**.

Read the Istio authorization concepts.

Install Istio using Istio installation guide.

Deploy two workloads: httpbin and curl. Deploy these in one namespace, for example foo. Both workloads run with an Envoy proxy in front of each. Deploy the example namespace and workloads using these commands:
