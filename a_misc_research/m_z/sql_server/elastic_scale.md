# **[elastic scale](https://learn.microsoft.com/en-us/azure/azure-sql/database/elastic-pool-scale?view=azuresql)**

In SQL Server, **elastic scale** refers to the ability to automatically and dynamically increase or decrease computing resources (like CPU, memory, and storage) in response to changing workload demands, typically without manual intervention. This is a core concept in cloud computing, especially for services like Azure SQL Database.

## Key Concepts

**Automatic Adjustment:** The primary characteristic of elasticity is that the scaling process (adding or removing resources) happens automatically based on predefined rules or real-time workload needs.

**Matching Demand:** The goal is to match the allocated resources as closely as possible to the current demand, ensuring consistent performance during peak loads and minimizing costs during quiet periods.

**Vertical and Horizontal Scaling:** Elastic scale can involve both:

- **Vertical Scaling (Scaling Up/Down):** Increasing or decreasing the power of a single database instance (e.g., changing the service tier or vCores).
- **Horizontal Scaling (Scaling Out/In):** Distributing data across multiple databases (known as sharding) and adding or removing databases to the collection.

## Elastic Features in Azure SQL Database

The term "Elastic Scale" is prominently used in the context of Azure SQL Database to describe specific features:

- **Elastic Pools:** These allow software-as-a-service (SaaS) developers to manage and scale a group of databases with varying and unpredictable usage demands within a set budget. Databases in the pool share a pool of resources (eDTUs or vCores), and Azure automatically manages the resource allocation among them based on individual needs.

The shared resources in an elastic pool are measured by elastic database transaction units (eDTUs).

**vCore** stands for virtual core and is a unit of measure for processing power in virtualized environments, like cloud computing. It represents a logical CPU that allows users to select and scale the performance of virtual machines and databases, with more vCores leading to greater processing power.

## Key aspects of vCores

**Logical CPU:** A vCore is a virtual representation of a physical CPU core, providing processing power for workloads.
