The Structures K8S Clusters are used to run our ETL pipeline microservices. The ETL pipeline collects data from the Plex ERP is highly available.

```mermaid
flowchart TD
        A(["Virtual IP - 10.188.50.204"])
        A --> B["Server 1 - 10.188.50.201"]
        B --> E["K8S Cluster 1"]
        A --> C["Server 2 - 10.188.50.202"]
        C --> F["K8S Cluster 2"]
        A --> D["Server 3 - 10.188.50.203"]
        D --> G["K8S Cluster 3"]
```

Keepalived is a software that provides high availability and load balancing for Linux systems, using the Virtual Router Redundancy Protocol (VRRP). It's designed to ensure that services remain available even if some servers fail, by managing virtual IP addresses and health checks.

<https://www.youtube.com/watch?v=hPfk0qd4xEY&t=9s>

```mermaid
graph LR
A[Square Rect] -- Link text --> B((Circle))
A --> C(Round Rect)
B --> D{Rhombus}
C --> D
```

```mermaid
flowchart TD
    A[on-demand] -->|Get money| B(Go shopping)
    B --> C{Let me think}
    C -->|One| D[Laptop]
    C -->|Two| E[iPhone]
    C -->|Three| F[fa:fa-heart Car]
```
