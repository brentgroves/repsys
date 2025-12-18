# About Mermaid

Mermaid lets you create diagrams and visualizations using text and code.

It is a JavaScript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically.

If you are familiar with Markdown you should have no problem learning Mermaid's Syntax.

## references

- <https://mermaid.live/>
- <https://github.com/mkdocs/mkdocs/>
- <https://markmap.js.org/>
- <https://mermaid.js.org/intro/syntax-reference.html>
- <https://mermaid.js.org/syntax/gantt.html>

## Docs & Tools

- **[Mermaid Docs](https://mermaid-js.github.io/mermaid/)**
- **[Mermaid Live Editor](https://mermaid.live/edit)** (Also supports copy from Github gists and saving to .svg .png)
- **[Mermaid Cheat Sheet](https://jojozhuang.github.io/tutorial/mermaid-cheat-sheet/)**

## Some Examples

- <https://gist.github.com/ChristopherA/bffddfdf7b1502215e44cec9fb766dfd>
- <https://gist.github.com/balanza/39bd68f3978ae7dd6a486321b2251ce7>
- <https://gist.github.com/vtsoup/f1f79d19d6f8e58396bde8847c09a62e>

## Feature Support: GitHub's Mermaid support has some limitations. For example

Not all Mermaid symbols are supported, like the B-->C[fa:fa-ban forbidden].
Hyperlinks and tooltips may not work within Mermaid labels.
Markdown Features: Some Markdown features are supported within Mermaid labels, but others may cause issues or break the diagram.

Character Limitations: Some characters, including certain emojis and extended ASCII characters, can cause errors in Mermaid diagrams.

Embedding Limitations: Embedding GitHub gists and pages into Mermaid diagrams might not work as expected.

## mindmap

To create a a link of this mindmap go to <https://mermaid.live/>

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
        report requester
    Plex ERP
      ::icon(fa fa-book)
      Soap Web Services
      ODBC data source

    On Premise
      MicroK8s
        Kong API Server
        MySQL
        Postgres
        MongoDB
        Redis
        Report Runner

```

## flow chart

```mermaid
graph TD;
    A-->B;
    A-->C;
    B-->D;
    C-->D;
```

```mermaid
graph LR
    A[Square Rect] -- Link text --> B((Circle))
    A --> C(Round Rect)
    B --> D{Rhombus}
    C --> D
```

## Trial Balance Runner

The ETL pipeline is a set of Go routines (threads) each of which is responsible for 1 ETL script. The TB runner's main thread begins the ETL pipeline by sending a message the first ETL script go routine.  Each ETL script go routine completes and then calls the next ETL script's go routine.  The final ETL script finishes and then sets the TB mutex up so that the runner's main thread can start the pipeline again.

```psuedo_code
create go routines (threads) and communitcation channels for each tb etl script in tb etl pipeline
subscribe to redis tb mutex and request queue 

infinite while loop
    if tb queue not empty
        remove request from queue
        when tb mutex up
            down tb mutex 
            send request to 1st ETL script's go routine
        end
    end
```

Note:

- **[Mutex's in Redis](https://dev.to/jdvert/handling-mutexes-in-distributed-systems-with-redis-and-go-5g0d)**
- **[Publish/Subscribe](https://redis.io/docs/latest/develop/interact/pubsub/)**

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

```mermaid
flowchart TD
    A[Start] --> B{Are items in queue and pipeline idle?}
    B -- Yes --> C[Start Pipeline]
    C --> D[Repeat]
    D --> B
    B -- No --> D[Wait for report requests]
```

## Sequence diagram

```mermaid
sequenceDiagram
    participant Alice
    participant Bob
    Alice->>John: Hello John, how are you?
    loop HealthCheck
        John->>John: Fight against hypochondria
    end
    Note right of John: Rational thoughts <br/>prevail!
    John-->>Alice: Great!
    John->>Bob: How about you?
    Bob-->>John: Jolly good!
```

```mermaid
sequenceDiagram
    Alice->>Bob: Hello Bob, how are you ?
    Bob->>Alice: Fine, thank you. And you?
    create participant Carl
    Alice->>Carl: Hi Carl!
    create actor D as Donald
    Carl->>D: Hi!
    destroy Carl
    Alice-xCarl: We are too many
    destroy Bob
    Bob->>Alice: I agree
```

## gnatt

```mermaid
gantt
    dateFormat  YYYY-MM-DD
    title       Report System IT & Development
    excludes    weekends
    %% (`excludes` accepts specific dates in YYYY-MM-DD format, days of the week ("sunday") or "weekends", but not the word "weekdays".)

    section K8s
    MySQL InnoDB Operator     :active,k1,2024-03-01,5d
    Postgres Operator         :active,k2, after k1, 5d
    Kong API Gateway          :active,k3, after k2, 5d
    Redis Operator            :active,k4, after k3, 5d
    Kured Operator            :active,k5, after k4, 5d
    section Development
    Runner                  :active,d1,2024-04-22,5d
    Requester               :       d2,after d1,5d

```

```mermaid
gantt
    title A Gantt Diagram
    dateFormat YYYY-MM-DD
    section Section
        A task          :a1, 2014-01-01, 30d
        Another task    :after a1, 20d
    section Another
        Task in Another :2014-01-12, 12d
        another task    :24d
```
