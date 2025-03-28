# Task List

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## references

- **[gantt](https://mermaid.js.org/syntax/gantt.html)**

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Report System Time Line
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section K8s Gateway 
    Create TLS Certificates for repsys.linamar.com  :done,t10,2024-10-15,1d
    Deploy Istio service mesh and Sample App                     :crit,done,t20,after t10,1d
    Create HTTP route to Sample App                 :done,t30,after t20,1d
    Secure ingress gateway for AKS Istio service mesh               :active,done,t40,after t30,12h
    Secure ingress gateway for MicroK8s Istio service mesh          :active,done,t45,after t40,12h
    Ingress Sidecar TLS Termination                                 :active,done,t47,after t45,12h
    section Metrics and Observability 
    Deploy Prometheus and Grafana                   :active,done,t50,after t47,12h

```

## Report System Task List

| Setup **[kubernetes](https://kubernetes.io/docs/concepts/overview/)** clusters on-prem at Avilla with **[MicroK8s](https://microk8s.io/docs)** and in the cloud on **[Azure AKS](https://learn.microsoft.com/en-us/azure/aks/what-is-aks)**                                                                                                          | 2 weeks |
|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|---------|
| Create TLS Clint/Server certificate for repsys.linamar.com  using our internal **[PKI](https://www.keyfactor.com/education-center/what-is-pki/)** built with **[OpenSSL](https://www.golinuxcloud.com/openssl-create-certificate-chain-linux/)** that passes SAN certificate validation at **[Sectigo Certificate Linter](https://crt.sh/lintcert)** | 1 day   |
| **[Deploy Istio and Sample App on MicroK8s](https://istio.io/latest/docs/setup/getting-started/)**                                                                                                                                                                                                                                                   | 1 day   |
| **[Deploy Istio and Sample App on Azure AKS](https://learn.microsoft.com/en-us/azure/aks/istio-deploy-addon)**                                                                                                                                                                                                                                       | 3 day   |
| **[Setup secure ingress gateway for Istio service mesh add-on for Azure Kubernetes Service](https://learn.microsoft.com/en-us/azure/aks/istio-secure-gateway)**                                                                                                                                                                                      | 1 day   |
| **[Setup Secure ingress gateway for Istio service mesh on MicroK8s](https://istio.io/latest/docs/tasks/traffic-management/ingress/secure-ingress/)**                                                                                                                                                                                                 | 1 day   |
| **[Deploy Kiali Prometheus and Grafana for observability](https://istio.io/latest/docs/tasks/observability/kiali/)**                                                                                                                                                                                                                                 | 1 day   |
| **[Configure Istio service mesh for Auth0 authentication](https://istio.io/latest/docs/concepts/security/)**"                                                                                                                                                                                                                                        | 3 days  |
| **[Request Level Authentication and Authorization with Istio and Keycloak](https://www.infracloud.io/blogs/request-level-authentication-authorization-istio-keycloak/)**                                                                                                                                                                             | 3 day   |
| **[Deploy Prometheus and Grafana to Azure AKS](https://www.youtube.com/watch?v=nWKdpcqtMSs)**                                                                                                                                                                                                                                                        | 1 day   |
## example gantt

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Adding GANTT diagram functionality to mermaid
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section A section
    Completed task            :done,    des1, 2014-01-06,2014-01-08
    Active task               :active,  des2, 2014-01-09, 3d
    Future task               :         des3, after des2, 5d
    Future task2              :         des4, after des3, 5d

    section Critical tasks
    Completed task in the critical line :crit, done, 2014-01-06,24h
    Implement parser and jison          :crit, done, after des1, 2d
    Create tests for parser             :crit, active, 3d
    Future task in critical line        :crit, 5d
    Create tests for renderer           :2d
    Add to mermaid                      :until isadded
    Functionality added                 :milestone, isadded, 2014-01-25, 0d

    section Documentation
    Describe gantt syntax               :active, a1, after des1, 3d
    Add gantt diagram to demo page      :after a1  , 20h
    Add another diagram to demo page    :doc1, after a1  , 48h

    section Last section
    Describe gantt syntax               :after doc1, 3d
    Add gantt diagram to demo page      :20h
    Add another diagram to demo page    :48h
```
