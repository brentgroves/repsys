# Report System

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

An On-Premise and Cloud-based observable K8s data warehouse reporting service.

## Businesses may want to move to Kubernetes (K8s) for a variety of reasons, including:

- **Automation:** K8s automates many DevOps processes, such as deployment, management, and scaling of containerized applications. This can simplify the work of software developers. 
- **Scalability:** K8s makes it easy to scale applications up and down as needed, which can help businesses respond to changes in demand quickly. 
- **Reliability:** K8s helps businesses deploy and manage applications in a consistent and reliable way. 
- **Portability:** K8s can help make applications more portable between platforms. 
- **Faster time to market:** K8s can help businesses get to market faster. 
- **IT cost optimization:** K8s can help businesses optimize IT costs. 
- **Multi-cloud flexibility:** K8s can help businesses be more flexible across multiple clouds. 
- **Effective migration to the cloud:** K8s can help businesses effectively migrate to the cloud. 
- **Observability:** K8s can help monitor application performance and system health proactively.

K8s is an open-source platform that was developed by Google in 2014. It's an orchestration tool that manages the deployment of containers, which are standardized units of software that contain all the code and other dependencies required for an app to run. 

Kubernetes is the fastest growing project in the history of open-source software, after Linux.

## What it does

Allows users to start ETL scripts on-demand via a web app.

## What ETL scripts do

- Run SQL stored procedures and Plex web services to retrieve live data.
- Move result sets of Plex web services and stored procedures to a centralized data warehouse.
- Generate and email Excel from result sets.
- Identifies and archives result sets for later use.

## Azure resources

Only needed for Microsoft Teams tab accessibility.

- Azure Kubernetes Service 
  - mTLS secured service mesh gateway
  - gRPC micro-services
  - cost $350/month

- Azure SQL Server 
  - Secured by IP
  - cost $50/month

## Linmar Network Transition

1. Move one R620 to Avilla and assign Avilla network address to it, i.e. 10.188.x.x or 10.187.x.x i forget which is Avilla's network number.
2. Configure it from Albion development system since the R620 has Ubuntu server not Ubuntu desktop.
