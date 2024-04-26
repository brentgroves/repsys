# About Mermaid

Mermaid lets you create diagrams and visualizations using text and code.

It is a JavaScript based diagramming and charting tool that renders Markdown-inspired text definitions to create and modify diagrams dynamically.

If you are familiar with Markdown you should have no problem learning Mermaid's Syntax.

## references

<https://markmap.js.org/>
<https://mermaid.js.org/intro/syntax-reference.html>
<https://mermaid.js.org/syntax/gantt.html>
<https://chromewebstore.google.com/detail/mermaid-previewer/oidjnlhbegipkcklbdfnbkikplpghfdl>

## mindmap

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
