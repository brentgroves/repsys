# Task List

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Task List
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section Tickets
    Plex Ticketing                     :t1,2024-04-22,1d
    Training                           :t2,after t1,2d

    section Tool Tracker
    Moxa                               :tt1,2024-04-22,1d
    UDP Client                         :tt2,after tt1,2d
    Schema                             :tt3,after tt2,2d
    GCode                              :tt4,after tt3,2d
    Redis                              :tt5,after tt4,2d
    Observe CNC                        :tt6,after tt5,2d

```

## Task Notes

- **[Research Redis mutex](https://dev.to/jdvert/handling-mutexes-in-distributed-systems-with-redis-and-go-5g0d)**
- **[Research Redis Pub/Sub](https://redis.io/docs/latest/develop/interact/pubsub/)**
- Create K8s API tutorial in **[go/tutorials/k8s](~/src/repsys/volumes/go/tutorials/k8s)**
  - **[In-Cluster K8s API access](https://github.com/kubernetes/client-go/tree/master/examples/in-cluster-client-configuration)**
  - **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**
