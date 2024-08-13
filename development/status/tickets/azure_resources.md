# Mobex Azure AKS and Azure SQL database resources future

Mobex was planning on using an AKS single-node cluster and an Azure SQL database to host a report request web application and I would like to know what has been decided concerning the future of these resources. I thought it was previously decided to keep them in the Mobex Azure tenant but I would like to confirm this.

## Costs

- $285/month Azure AKS single-node cluster
- $50/month Azure SQL database.

## Report System Architecture

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

## Details

The cloud-based portion of the reporting system would have been responsible for inserting internal-customer report requests into an Azure SQL database.  It's **purpose** was meant to accept long-running or live data report requests for the Plex ERP as well as other databases as needed. There are other software components that are needed to complete this reporting system but they do not need to be hosted in the cloud such as the report runner and report status app.  The report runner would have been responsible for pulling the internal customer report requests from the Azure SQL database and then running ETL scripts to transfer and transform data from Plex and/or other databases to produce a final result set in the Azure SQL database ie. data warehouse.

## Reasons to use an Azure AKS single-node cluster and Azure SQL database

Most of the report system can run perfectly well at any location, but specifically we were going to run the other components in our on-prem Kubernetes cluster which would have been hosted at Avilla and/or Albion. But there are several reasons we chose to run at least the report requestor component in an Azure AKS single-node cluster and have our data warehouse implemented in an Azure SQL database.  

- **Performance:** If the internal customer report request web application is cloud-based it is not dependant on VPN networking performance between locations such as Fruitport, Southfield, Albion, Avilla, etc.
- **Microsoft Managed TLS Certificates:** Other advantages to hosting this report request web application in an Azure AKS cluster include TLS certificates managed by Microsoft.
- **Microsoft Teams and Azure identity management:** Another advantage is the ability to embed the report request web application into Microsoft Teams tabs gaining Active directory user identity management to decide who has access to what reports.
- **Microsoft Teams hosted PowerBI paginated reports:** Another advantage is the ability to embed paginated Power BI reports which accept report parameters for our live reporting requirements.
