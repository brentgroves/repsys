# Task List

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Task List
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section K8s
    Redis Operator                                :d1,2024-04-22,5d
    section Development
    K8s API access                                :d1,2024-04-29,1d
    Redis Pub/Sub TB queue                        :d2,after d1,2d
    Redis TB mutex                                :d3,after d2,2d
    Azure SQL MI to Azure SQL DB                  :d4,after d3,5d   
    Requester HTML Mockup                         :d5,after d4,5d  
    Test k8s.io from within Cluster               :d6,after d5,5d  
 

```

## Task Notes

- **[Test k8s.io from within Cluster](https://github.com/kubernetes/client-go/blob/master/examples/in-cluster-client-configuration/main.go)**
  - read database passwords from k8s secret and write to k8s log.
- **[Research Redis mutex](https://dev.to/jdvert/handling-mutexes-in-distributed-systems-with-redis-and-go-5g0d)**
- **[Research Redis Pub/Sub](https://redis.io/docs/latest/develop/interact/pubsub/)**
- **[In-Cluster K8s API access](https://github.com/kubernetes/client-go/tree/master/examples/in-cluster-client-configuration)**
- **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**
- **[Sessions and Cookies](https://www.sohamkamani.com/web-security-basics/#sessions-and-cookies)**
