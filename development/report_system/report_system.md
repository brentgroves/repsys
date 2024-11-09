# Report System

**[Development Menu](./menu.md)**\
**[Current Status](../status/weekly/current_status.md)**\
**[Back to Main](../../README.md)**

An On-Premise and Cloud-based observable K8s data warehouse reporting system.

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
