# Report System

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

## What is it

It is an On-Prem and/or Cloud-Based Observable Kubernetes, K8s, Data Warehouse Report System meant to allow users to request on-demand the generation of Excel files and reporting tables used by Power BI dashboards and reports containing live data or requiring long-running SQL queries from the Plex ERP.

**Observability** is the ability to understand a system's internal state by analyzing its external outputs, such as logs, metrics, and traces. It's a proactive process that helps teams monitor systems, identify issues, and prevent downtime.

## Why Kubernetes

Businesses may want to move to Kubernetes (K8s) for a variety of reasons, including

- **Automation:** K8s automates many DevOps processes, such as deployment, management, and scaling of containerized applications. This can simplify the work of software developers.
- **Scalability:** K8s makes it easy to scale applications up and down as needed, which can help businesses respond to changes in demand quickly.
- **Reliability:** K8s helps businesses deploy and manage applications consistently and reliably.
- **Portability:** K8s can help make applications more portable between platforms.
- **Faster time to market:** K8s can help businesses get to market faster.
- **IT cost optimization:** K8s can help businesses optimize IT costs.
- **Multi-cloud flexibility:** K8s can help businesses be more flexible across multiple clouds.
- **Effective migration to the cloud:** K8s can help businesses effectively migrate to the cloud.
- **Observability:** K8s can help monitor application performance and system health proactively.

K8s is an open-source platform that was developed by Google in 2014. It's an orchestration tool that manages the deployment of containers, which are standardized units of software that contain all the code and other dependencies required for an app to run.

Kubernetes is the fastest-growing project in the history of open-source software, after Linux.

## What it does

Allows users to start an ETL process flow on-demand via an mTLS Secured and OIDC authenticated web app to generate and email Excel as well as create report tables used by PowerBI reports and dashboards.

## What is ETL

ETL stands for "extract, transform, and load". It's a process that organizations use to combine data from multiple sources into a single database or data warehouse. ETL is a fundamental task in data engineering and is used for a variety of purposes, including:

- **Business intelligence:** ETL can help businesses generate reports and dashboards, predict business outcomes, and reduce operational inefficiency.
- **Data analytics:** ETL can help businesses prepare data for analysis and business intelligence processes.
- **Data science:** ETL can help businesses integrate data for use in data science.

## ETL Process Flow Microservices

- Accept parameterized report requests.
- Insert requests into a Redis work queue.
- Individual report runners pull report requests from work queues and initiate the appropriate ETL process flow which does the following:
  - Run stored procedures and Plex web services to retrieve live data from the Plex ERP.
  - Use SQL stored procedures to create desired report table(s) from retrieved data.
  - Use ETL scripts to move report table records into a uniquely identified object in the data warehouse.
  - Generate and email Excel from report table records.
  - Uniquely identify and archive result sets for later use.

## **[Azure resources](./azure_resource.md)**

## Diagrams

- **[Components](../../development/report_system/components.md)**
- **[K8s Clusters](../../development/report_system/k8s_clusters.md)**

## Linmar Network Transition

1. Move one R620 to Avilla and assign Avilla network address to it, i.e. 10.187.x.x
2. Configure it from Albion development system since the R620 has Ubuntu server not Ubuntu desktop.
