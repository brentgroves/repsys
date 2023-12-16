# Mobex report summary

This is a markdown file if it looks a little strange. You could use visual studio code or an online viewer such as <https://dillinger.io/>

We use IntelliPlex/Web Focus to create Plex dashboards and data warehouses for long-running, multiple data sources, or reports requiring live data.

## Goal

I am hoping we can use data science to give our decision-makers focused information that they can act on.

## Is IntelliPlex/Web Focus designed for data science tasks?

When you study data science the following software is mentioned a lot:

Minitab, SPSS, PowerBI, R, Python

In traditional reporting managers look at dashboards to get an overview of the business.

In data science time series data is collected to make forecasts and answer questions.

We all have seen traditional dashboards so let's instead look at an example of how to use data science software.

## Continue R tutorial

launch R Studio using compose

```bash
pushd .
cd ~/src/repsys/docker/r
docker compose up

```

**[R Tutorial](../../docker/r/tutorial.md)**

## Report system

The reporting system is meant to give customers the ability to run reports using data residing in our data warehouses.  Rather than running reports from individual databases, we use ETL scripts to pull data into our data warehouses so that we can have all the data in one place. Non-ERP data sources include tooling inventory and usage data collected by our MSC vending machines and tool life data collected from UDP servers attached to our CNC.  The tool life data collection process was successfully created and tested but has not been put into production as of yet.  It will require a possible vlan for our Okuma CNC, Moxa UDP servers, and small network switches or multiplexors at each cell.

## Microsoft Teams hosted

- PowerBI reports
- In-house apps

## Azure services and options

Only use this for PowerBI to be able to access our data.  A more cost-effective alternative is to put our Postgres, MySQL, MongoDB, and Prometheus databases, R Server, and S3-compatible storage in our DMZ.

- Azure SQL Server **[managed instance](https://intercept.cloud/en/news/azure-sql-sql-managed-instance-or-sql-server/)**
- Azure **[Managed Kubernetes service](https://azure.microsoft.com/en-us/products/kubernetes-service)**
- Azure App registration to enable our Apps to access the Azure API.
- PowerBI tabulated report license in addition to regular license
- S3-compatible storage
- PKI for secure browser connections to Mach2 and Report requestor web apps and API. AD GPO for root and intermediate certificates alt-names currently set to busche-cnc.com

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
- R Server

In-house software:

- Report requestor web app
- Report requestor RESTful API
- Report runner
- SMTP Server
- Jupyter Notebooks