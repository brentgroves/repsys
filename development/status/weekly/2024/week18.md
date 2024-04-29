# Status

```text
Good morning dear ones,
I hope you and your loved ones are enjoying this beautiful spring weather and are doing OK!  As always please feel free to call me at home or work about anything you like!  

Sincerely yours,
Brent G.
260-564-4868
```

## Viewing Options

The github viewer has timeout issues rendering mermaid diagrams. For "unable to render" error please press the "<-->" button above that mermaid diagram to view it. Experiment with theming to get the best view. I think high contrast dark themes work best!

Note: Press ctrl-shift-v to render markdown after installing the "Markdown Preview Mermaid Support" extension in Visual Studio Code or GitHub.Dev.

- **[GitHub Link](https://github.com/brentgroves/repsys/blob/main/development/status/weekly/2024/week18.md)**
- **[Visual Studio Code Web](https://github.dev/brentgroves/repsys/blob/main/development/status/weekly/2024/week18.md)**
- **[Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=bierner.markdown-mermaid)**
- **[JebBrains IDE](https://www.jetbrains.com/guide/go/tips/mermaid-js-support-in-markdown/)**

## **[Mermaid Live Editor](https://mermaid.live/edit)** (Also supports copy from Github gists and saving to .svg .png)

Mermaid is a JavaScript-based diagramming and charting tool that uses Markdown-inspired text definitions and a renderer to create and modify complex diagrams. The main purpose of Mermaid is to help documentation catch up with development.

[![](https://mermaid.ink/img/pako:eNqFkcFOwzAMhl_FymmVtjvqbWMcplGtrEhcevFat0Q0ceUmiDHt3Uk2uiI4cLP9Ob__2CdVcU0qVUbb2mBfWgBhdrPZnnoWB8VxcGSSJAKA5acXgmeyZN21ArBZZmN4xcXTI6xXYy1NdcV21iA0uDgwvyUjWXV8gMKxYEs3hW0xhsEI1XqY0uAouIEXOkDDElyg-aZ5Rx_wsM__n1kw9heFguRdV3ST361X91CjQxjYSxUMXcnOQi5k9HCzmOlKeHv319jOLmJrlJ_Ylm0Ly3xzGUgygewY9jSlOQ-uFfqhmoWXPO0xjvm9jnigvbc26pZWzZUhMajrcM9TbCyVeyVDpUpDWFODvnOlKu05tKJ3XBxtpVInnubK9-H3tNbYChqVNtgNdP4C3lWhKQ?type=png)](https://mermaid.live/edit#pako:eNqFkcFOwzAMhl_FymmVtjvqbWMcplGtrEhcevFat0Q0ceUmiDHt3Uk2uiI4cLP9Ob__2CdVcU0qVUbb2mBfWgBhdrPZnnoWB8VxcGSSJAKA5acXgmeyZN21ArBZZmN4xcXTI6xXYy1NdcV21iA0uDgwvyUjWXV8gMKxYEs3hW0xhsEI1XqY0uAouIEXOkDDElyg-aZ5Rx_wsM__n1kw9heFguRdV3ST361X91CjQxjYSxUMXcnOQi5k9HCzmOlKeHv319jOLmJrlJ_Ylm0Ly3xzGUgygewY9jSlOQ-uFfqhmoWXPO0xjvm9jnigvbc26pZWzZUhMajrcM9TbCyVeyVDpUpDWFODvnOlKu05tKJ3XBxtpVInnubK9-H3tNbYChqVNtgNdP4C3lWhKQ)

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

## Observability System

An unmanned ticketing system which monitors CNC tool, pallet, and cycle times.

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
    MySQL InnoDB              :db1,after s2,5d
    Postgres                  :db2, after db1, 5d
    MongoDB                   :db3, after db2, 5d
    Redis Operator            :active,db4, after db3, 5d

    section Ingres
    NGinx IC                  :i1,after db4, 5d
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

![](https://mermaid.ink/img/pako:eNptkstuwyAQRX8FzdqN8EN-sMiiSnbtJsmq8oaYaYsUDwSD1DTKvxfbsZSqZQPMPfeONJordEYhCBjwHJA63Gj54WTfEovHSud1p60kz5QkJge2kfRXc3getd2YMXh0_xFqJpQe_lHDlL0LRIs5tntar2OwGNPH2Hhb4_wsx9okK8E0Deg8Ozwv4J0ItBBDOA6d00dk3oxcpALO1MkYy-bngymQYHsv59Tt4YVZbfGk6W5CUm2cAiTQo-ulVnF-11FqwX9ijy2I-FT4LsPJt9DSLaIyeLO_UAfCu4AJBKukX8b9u7hV2hu31OKE3ozpH74grvAFomxWeZ4VFa_yKkvzMoELiLTIVk1TVgXnRdnUJa9vCXxPfr6qeZ3lVdWkvEwLnhYJ4NTqdd6BaRVuP90VqvI?type=png)

## Trial Balance Runner

![](https://images.techhive.com/images/article/2017/02/pressure-water-line-100707995-large.jpg?auto=webp&quality=85,70)

![](https://mermaid.ink/img/pako:eNqVU01Pg0AQ_SubOWMDhUDhoIlpb-rBaoyWhmxhUGLZxf1Iq03_u8tCK_XjICRk3-ybN2-G3R3kvEBIoFzzTf5ChSJ3lykj5pHKoMW8_ZJbzRiKJTk7OydSr2QuqhVmbxo1LuYHTBQnt1hU0kgQu7fslU4zrMqGVipTq0ygiUm1eDCYlFwQhtvWA-k3lqTT-Ma3GgXfsKzWCreLqVl-FbexvvgXyeSQY5krnr927bQNZmUlpMpal82hZxsis7sr0oWXg7Gc8K1MzQX2WO6uDRhkyot9lzsktW4eUQ48tJ2fWrCz-MPBgP3DwO_Vbrgl6qaf2X3zfVaHrf_9oZS1LzhQo6hpVZjTtGv1UlAvWGMKiVkWWFK9VimkbG-oVCs-f2c5JEpodEA3BVU4reizoDUkJV3LY3RWVIqLA7Oh7InzegAh2cEWkjAe-f44iNzIj8aeHzrwDokXjEdxHEaB6wZhPAndyd6BD5vvjibuZOxHUey5oRe4XuAA2lLX3ZWwN2P_CbfZEOI?type=png)

## Ticketing System Help

Rejection occurred because bar code engraver not working for a long period of time and management was unaware of the issue.

Issue: CNC operators are expected to keep asking and calling management if important issues are not getting resolved.
Suggestion: Allow the CNC operators to enter priority issues that could lead to a rejection.
Question: What would be the best way for a CNC operator to inform management of critical issues.

- call Jake
- maintenance ticketing system
- plex suggestion system
- it ticketing system

## Repsys Operator

Make a k8s operator to install and monitor repsys.

## Plex ODBC

We did have to log into this ODBC account periodically do we still have to "mg.odbcalbion" if so how?
