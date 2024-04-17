# Azure Services

This is a markdown file if it looks a little strange you can use visual studio code or an online viewer such as <https://dillinger.io/> to pretty it up.

## **[Azure SQL MI](https://azure.microsoft.com/en-us/pricing/details/azure-sql-managed-instance/single/)**

Currently, this Azure SQL MI hosts an Azure SQL database which is being used as our data warehouse.

```yaml
SQL managed instance: mgsqlmi
databases: mgdw,ssisdb
resource group: rg-useast-dataservices
cost: $748/month
plan: Migrate schema and import data into our Azure SQL db then delete this instance.
status: This is being used to generate our Southfield's Plex Trial Balance report. In the future, our report system's Microsoft Teams accessible request/viewer/archive apps would use this.
```

## **[Azure SQL db](https://azure.microsoft.com/en-us/pricing/details/azure-sql-database/single/)**

```yaml
server: repsys
database: rsdw
resource group: repsys
type: Standard S1: 20 DTUs
cost: $30/month
plan: Use this instead of Azure SQL MI.
status: This service is running but the database schema and data have not been transferred from the database stored on the mgsqlmi MI.
```

## Azure AKS (Kubernetes)

The plan is to run the minimal components of the report system from this 1-node K8s Cluster.  It is needed because Power BI reports and supporting apps running in Microsoft Teams tabs need to be accessible through an SSL-secured public IP.

```yaml
resource: reports-aks
resource group: reports-aks
Node pools: 1 node pool
cost: $290/month
status: This service is running but the request/viewer/archive apps are not ready yet.
```
