# Report sytem summary

This is a markdown file if it looks a little strange. You could use visual studio code or an online viewer such as <https://dillinger.io/>

## Report system

Why do we need a report system besides the one that comes standard with Plex?

- long running SPROCS time-out so complex queries on large data sets are not possible.
- Queries run against a snap shot of the database which can be several hours old so live reporting is not possible.
- Reports based on data from multiple datasources such as MSC tooling vending machine and Plex.

The reporting system is meant to give customers the ability to run reports using data residing in our data warehouses.  Rather than running reports from individual databases, we use ETL scripts to pull data into our data warehouses so that we can have all the data in one place. Non-ERP data sources include tooling inventory and usage data collected by our MSC vending machines and tool life data collected from UDP servers attached to our CNC.  The tool life data collection process was successfully created and tested but has not been put into production as of yet.  It will require a possible vlan for our Okuma CNC, Moxa UDP servers, and small network switches or multiplexors at each cell.

These are internal links.

- **[Architecture](../../requirements/architecture.md)**
- **[Flow](../../requirements/flow.md)**

## Azure services and options

Only need Azure services to enable customers to access our report gateway and PowerBI reports through Microsoft Teams.  A more cost-effective alternative is to put our databases and object storage in our DMZ.

- Azure SQL Server **[managed instance](https://intercept.cloud/en/news/azure-sql-sql-managed-instance-or-sql-server)**
- How to create **[Azure SQL Server managed instance](https://learn.microsoft.com/en-us/azure/azure-sql/managed-instance/instance-create-quickstart?view=azuresql)**
- Azure **[Managed Kubernetes service](https://azure.microsoft.com/en-us/products/kubernetes-service)**
- How to deploy an **[AKS cluster](https://learn.microsoft.com/en-us/azure/aks/tutorial-kubernetes-deploy-cluster?tabs=azure-cli)**
- Azure **[App registration](../../linux/azure/app_registration/app_registration.md)** to enable our Apps to access the Azure API.
- How to register and **[app](https://learn.microsoft.com/en-us/entra/identity-platform/quickstart-register-app)**
- Azure **[repos](https://azure.microsoft.com/en-us/products/devops/repos/)**
- How to create an Azure **[repo](https://learn.microsoft.com/en-us/azure/devops/repos/git/create-new-repo?view=azure-devops)**
- What are PowerBI paginated reports **[comparison](https://learn.microsoft.com/en-us/power-bi/paginated-reports/paginated-reports-report-builder-power-bi)**
- **[When to use paginated reports](https://learn.microsoft.com/en-us/power-bi/guidance/report-paginated-or-power-bi)**
- License **[requirements](https://learn.microsoft.com/en-us/power-bi/paginated-reports/paginated-reports-report-builder-power-bi#prerequisites)** to use PowerBI paginated reports

## Software Stack

This list of software is mostly running on a Kubernetes Cluster.

Third-party software:

- OpenStack
- Kubernetes
- Nginx Ingress Controller
- Ceph
- MinIO
- Prometheus
- Grafana
- Postgres Cluster
- MySQL InnoDB Cluster
- Azure SQL Server
- Redis
- R Server - Run outside of k8s.

In-house software:

- **[Report System](../../requirements/architecture.md)**
- SMTP Server

Reports:

- PowerBI both regular and tabular
- Grafana
- Jupyter Notebooks
