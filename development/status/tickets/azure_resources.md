# Azure Resources

Mobex was planning on using an AKS single-node cluster and an Azure SQL database to host a report request web application that would be responsible for inserting report requests into an Azure SQL database.  It's **purpose** was to accept long-running or live data report requests for the Plex ERP as well as other databases as needed. There are other software components that are needed to complete this reporting system that do not need to be hosted in the cloud such as the report runner and report status app.  The report runner would be responsible for pulling the internal customer report requests from the Azure SQL database and then running ETL scripts to transfer and transform data from Plex and/or other databases to produce a final result set in the Azure SQL database ie. data warehouse.

## Reasons to use an Azure AKS single-node cluster and Azure SQL database

Most of the report system can run perfectly well at any location but specifically in our on-prem Kubernetes cluster which would be hosted at Avilla and/or Albion. But there are several reasons we chose to run the report requestor in an Azure AKS single-node cluster.  

- If the internal customer report request web application is cloud-based it is not dependant on VPN networking performance between locations such as Fruitport, Southfield, Albion, Avilla, etc.
- Other advantages to hosting this report request web application in an Azure AKS cluster include TLS certificates managed by Microsoft
- as well as the ability to embed the report request web application into Microsoft Teams tabs gaining Active directory user identity management.
- as well as the ability to embed paginated Power BI reports which accept report parameters for our live reporting requirements.

into Microsoft Teams tabs which would help manage who has access to each departmental or individual user report.
