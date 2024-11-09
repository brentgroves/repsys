# Report System K8s Clusters Mindmap

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

The following is a mermaid mindmap and can be viewed from <<https://mermaid.live/>

## On-Prem Kubernetes Cluster

```mermaid
mindmap
  root((On-Prem))
    Development System with K8s Client Certificate
    Local IP
      repsysop.linamar.com
        Browser with RepSys Client Certificate
    Hypervisor
      Network Bridge
        mTLS Secured Gateway
          K8s Node-1 VM
            Microsoft SQL Data Warehouse Availability Group
          K8s Node-2 VM
            Microservices
              React.js - Web App
              gRPC - Request Acceptor
              Http2 - Web Push Notifications
              Minio - S3 Compatible Storage  
      K8s Network Only
        K8s Node-3 VM
          Redis - Work Queue
          GoLang - Report Runner
          gRPC - Excel Emailer

```

## Azure AKS Cluster

```mermaid
mindmap
  root((Azure Cloud))
    Azure Kubernetes Service Public IP
      Development System with K8s Client Certificate
    Azure Load Balancer Public IP
      repsys.linamar.com
        Browser with Repsys Client Certificate
    Azure Kubernetes Service Cluster   
      K8s Network Only
        Redis - Work Queue
        GoLang - Report Runner
        gRPC - Excel Emailer
      mTLS Secured Gateway
        Microservices
          React.js - Web App
          gRPC - Report Request Acceptor
          Http2 - Web Push Notifications
          Minio - S3 Compatible Storage  
    Azure SQL - Data Warehouse
    
```
