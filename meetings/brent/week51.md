# Azure services

This is a markdown file if it looks a little strange. You could use visual studio code or an online viewer such as <https://dillinger.io/>

## Is IntelliPlex/Web Focus designed for data science tasks?

When you study data science the following software is mentioned alot:

Minitab, SPSS, PowerBI, R, Python

In traditional reporting managers look at dashboards to get an overview of the business.

In data science time series data is collected to make forcasts and answer questions.

We all have seen traditional dashboards so let's instead look at an example of how to use data science software.

## Continue R tutorial

launch R Studio using compose

```bash
pushd .
cd ~/src/repsys/docker/r
docker compose up

```

**[R Tutorial](../../docker/r/tutorial.md)**

- Azure SQL Server **[managed instance](https://intercept.cloud/en/news/azure-sql-sql-managed-instance-or-sql-server/)**
- Azure **[Managed Kubernetes service](https://azure.microsoft.com/en-us/products/kubernetes-service)**
- Azure App registration

## Software Stack

This list of software is mostly running on a Kubernetes Cluster.

Third party software:

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

In-house software:

- Report requestor web app
- Report requestor RESTful API
- Report runner
- SMTP Server
