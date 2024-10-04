# Status

**[All Status](../weekly/status_list.md)**\
**[Back to Main](../../../README.md)**

## references

- **[table generator](https://tableconvert.com/markdown-generator)**
- **[Another table generator](https://www.tablesgenerator.com/markdown_tables)**

## High Level Summary

- Setup redundant **[kubernetes](https://kubernetes.io/docs/concepts/overview/)** clusters on-prem at Avilla with **[MicroK8s](https://microk8s.io/docs)** and in the cloud on **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)**. 2 weeks
- Research how best get http routing, https termination, and **[rate limiting](https://www.getambassador.io/blog/configure-rate-limits-prevent-ddos-best-practices)** features for the report system web app using **[NGINX Gateway Fabric](https://docs.nginx.com/nginx-gateway-fabric/)**, **[istio service mesh](https://istio.io/latest/about/service-mesh/)**, or **[Kong API Gateway](https://konghq.com/products/kong-gateway)**? We are attempting to offload as much of the non-business logic to OSS. 2 weeks.
- Create TLS certificates for repsys.linamar.com and keycloak.linamar.com using our internal **[PKI](https://www.keyfactor.com/education-center/what-is-pki/)** built with **[OpenSSL](https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/)** that passes SAN certificate validation at **[Sectigo Certificate Linter](https://crt.sh/lintcert)**

```text
The following is in markdown format it can be viewed better from https://markdownlivepreview.com/. if you copy and paste the contents below.
```

| task                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          | estimate |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| Setup redundant **[kubernetes](https://kubernetes.io/docs/concepts/overview/)** clusters on-prem at Avilla with **[MicroK8s](https://microk8s.io/docs)** and in the cloud on **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)**.                                                                                                                                                                                                                                                        | 2 weeks  |
| Research how best get http routing, https termination, and **[rate limiting](https://www.getambassador.io/blog/configure-rate-limits-prevent-ddos-best-practices)** features for the report system web app using **[NGINX Gateway Fabric](https://docs.nginx.com/nginx-gateway-fabric/)**, **[istio service mesh](https://istio.io/latest/about/service-mesh/)**, or **[Kong API Gateway](https://konghq.com/products/kong-gateway)**? We are attempting to offload as much of the non-business logic to OSS. | 2 weeks  |
| Create TLS certificates for repsys.linamar.com and keycloak.linamar.com using our internal **[PKI](https://www.keyfactor.com/education-center/what-is-pki/)** built with **[OpenSSL](https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/)** that passes SAN certificate validation at **[Sectigo Certificate Linter](https://crt.sh/lintcert)**                                                                                                                                              | 1 week   |
