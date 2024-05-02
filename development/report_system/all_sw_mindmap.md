# Report System Mind Map

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

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
