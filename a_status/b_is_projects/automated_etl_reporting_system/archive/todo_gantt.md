# All Software Gantt Chart

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Report System IT & Development

    section HW
    Dell R620s                  :p1,2024-09-01,1d

    section OS
    Ubuntu 24.04                :os1,after p1,1d

    section Kubernetes
    MicroK8s                    :k1,after os1,1d

    section Storage
    Hostpath                    :s1,after k1,1d  
    Minio S3                    :s2,after s1,1d

    section Service Mesh
    Istio                       :sm1,after s2,1d

    section IAM
    keycloak                    :i1,after sm1,1d  

    section Web App
    Requester                   :w1,after i1,1d  

    section MQTT WS 
    Mosquitto                   :m1,after w1,1d  

    section Msg Topics
    UserID                      :t1,after m1,1d

    section Cache
    Redis                       :mq1,after t1,1d

    section Queues
    TB                          :q1,after mq1,1d

```

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Report System IT & Development

    section Databases
    MySQL InnoDB                :db1,2024-09-01,1d
    MSSQL                       :db2,after db1,1d
    MongoDB                     :db3,after db2,1d

    section Schemas
    TB work area                :sc1,after db3,1d  
    TB current                  :sc2,after sc1,1d    
    TB BI                       :sc3,after sc2,1d  
    TB Object                   :sc4,after sc3,1d    

    section Development
    Requester                   :d1,after sc4,1d
    TB Runner                   :d2,after d1,1d
    Status Microservice         :d3,after d2,1d
    Mailer Microservice         :d4,after d3,1d
    Storage Microservice        :d5,after d4,1d

    section Observability
    Metric Server               :o1,after d5,1d
    Prometheus                  :o2,after o1,1d
    Grafana                     :o3,after o2,1d

    section Maintenance
    Kured Operator              :m1,after o3,1d
```
