# Report System Status

This is a work in progress.  When finished we will have an On-Premise and Microsoft Teams tab accessible way to request, view, and archive both parameterized reports requiring long running SQL scripts and those requiring live Plex data. It will also be able to use the **[Azure Graph API](https://learn.microsoft.com/en-us/graph/overview)** to email excel files or about anything else having to do with any Microsoft apps.

## Viewing Options

The github viewer has timeout issues rendering mermaid diagrams. For "unable to render" error please press the "<-->" button above that mermaid diagram to view it. Experiment with theming to get the best view. I think high contrast dark themes work best!

Note: Press ctrl-shift-v to render markdown after installing the "Markdown Preview Mermaid Support" extension in Visual Studio Code or GitHub.Dev.

- **[GitHub Link](https://github.com/brentgroves/repsys/blob/main/development/status/weekly/2024/week18.md)**
- **[Visual Studio Code Web](https://github.dev/brentgroves/repsys/blob/main/development/status/weekly/2024/week18.md)**
- **[Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)**
- **[JebBrains IDE](https://www.jetbrains.com/guide/go/tips/mermaid-js-support-in-markdown/)**

## **[Mermaid Live Editor](https://mermaid.live/edit)** (Also supports copy from Github gists and saving to .svg .png)**

Mermaid is a JavaScript-based diagramming and charting tool that uses Markdown-inspired text definitions and a renderer to create and modify complex diagrams. The main purpose of Mermaid is to help documentation catch up with development.

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Projects
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section Projects
    Report System             :p1,2024-04-22,5d
    Observability System      :p2,2024-04-22,5d

```

## Report System

An On-Premise and Cloud-based observable K8s data warehouse reporting system.

## **[Observability System](https://www.ibm.com/blog/kubernetes-observability/)**

Identify and escalate CNC maintenance and engineering issues which lead to rejections and low efficiencies.

- CNC operators' enter tickets in Plex concerning issues that could cause a rejection.
- Program automatically enters tickets in Plex by monitoring CNC tool, pallet, and cycle times.
- Use our report system to communicate and escalate issues.

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Task List
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section K8s
    Redis Operator                                :d1,2024-04-22,5d
    section Development
    K8s API access                                :d1,2024-04-22,1d
    Redis Pub/Sub TB queue                        :d2,after d1,2d
    Redis TB mutex                                :d3,after d2,2d

```

## Task Notes

- **[Redis Distributed Locks (mutex)](https://redis.io/docs/latest/develop/use/patterns/distributed-locks/)**

  **[Full Research Summary](../../../research/m_z/redis/mutex/distributed_locks.md)** \
  We are going to model our design with just three properties that, from our point of view, are the minimum guarantees needed to use distributed locks in an effective way.

  - Safety property: Mutual exclusion. At any given moment, only one client can hold a lock.
  - Liveness property A: Deadlock free. Eventually it is always possible to acquire a lock, even if the client that locked a resource crashes or gets partitioned.
  - Liveness property B: Fault tolerance. As long as the majority of Redis nodes are up, clients are able to acquire and release locks. \

  To acquire the lock, the way to go is the following:

  `SET resource_name my_random_value NX PX 30000` \
  The command will set the key only if it does not already exist (NX option), with an expire of 30000 milliseconds (PX option). The key is set to a value “my_random_value”. This value must be unique across all clients and all lock requests.

- **[Research Redis Pub/Sub](https://redis.io/docs/latest/develop/interact/pubsub/)**
- Create K8s API tutorial in **[go/tutorials/k8s](~/src/repsys/volumes/go/tutorials/k8s)**
  - **[In-Cluster K8s API access](https://github.com/kubernetes/client-go/tree/master/examples/in-cluster-client-configuration)**
  - **[Out-of-Cluster K8s API access](https://github.com/kubernetes/client-go/blob/master/examples/out-of-cluster-client-configuration/README.md)**

```mermaid
mindmap
  root((Report System))
    Azure Tenent
      IAM
      Azure SQL DB
      ::icon(fa fa-book)
      Blob Storage
      AKS
        redis
        RepSys web for Teams
    Plex ERP
      ::icon(fa fa-book)
      Soap Web Services
      ODBC data source

    On Premise
      MicroK8s
        RepSys on-prem web
        Kong API Server
        MySQL
        Postgres
        MongoDB
        Redis
        Report Runner

```

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Report System IT & Development
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section Platforms
    Dell R620s                :p1,2024-03-01,30d
    OpenStack                 :p2,2024-03-01,30d
    MicroK8s                  :p3,2024-03-01,30d

    section Storage
    Micro Ceph                :s1,2024-03-01,5d
    Minio S3 Object Storage   :s2,after s1, 5d

    section Databases
    Azure SQL DB              :db1,after s2,5d
    MySQL InnoDB              :db2,after db1,5d
    Postgres                  :db3, after db2, 5d
    MongoDB                   :db4, after db3, 5d
    Redis Operator            :active,db5, after db4, 5d

    section Ingres
    NGinx IC                  :i1,after db5, 5d
    Kong API Gateway          :i2, after i1, 5d  

    section Observability
    Metric Server             :o1,after i2,5d
    Prometheus                :o2,after o1,5d
    Grafana                   :o3,after o2,5d

    section Maintenance
    Kured Operator            :m1,after o3, 5d
    Transfer from MI to Azure SQL db :m2, after m1,5d

    section Development
    Runner                  :active,d1,2024-04-22,5d
    Requester               :d2,after d1,5d

```

## Run TB Report

```mermaid
sequenceDiagram
    participant dan as Dan
    participant req as Requester
    participant red as Redis
    participant run as Runner
    dan->>req: request report
    req->>red: insert TB request
    run->>red: subscribe to TB queue
    loop 
        run->>run: Start TB ETL pipeline
    end

```

## Trial Balance Runner

![](https://images.techhive.com/images/article/2017/02/pressure-water-line-100707995-large.jpg?auto=webp&quality=85,70)

```mermaid
flowchart TB
    start[Start Runner] --> subscribe_queue[Subscribe to Redis TB queue]
    subscribe_queue --> wait_tb_request[Wait for next TB request] 
    wait_tb_request --> down_mutex[Down Redis TB mutex]
    down_mutex -- Wait for Lock --> start_first_script[Start first ETL script]
    start_first_script --> more_scripts{More ETL scripts?}
    more_scripts -- Yes --> start_next_script[Start next ETL script]
    start_next_script --> more_scripts
    more_scripts -- No --> up_mutex[Up TB mutex]
    up_mutex --> wait_tb_request[Wait for next TB request]
```