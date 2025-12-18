# **[Linked services in Azure Data Factory and Azure Synapse Analytics](https://learn.microsoft.com/en-us/azure/data-factory/concepts-linked-services?tabs=data-factory)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Try out Data Factory in Microsoft Fabric, an all-in-one analytics solution for enterprises. Microsoft Fabric covers everything from data movement to data science, real-time analytics, business intelligence, and reporting. Learn how to start a new trial for free!

This article describes what linked services are, how they're defined in JSON format, and how they're used in Azure Data Factory and Azure Synapse Analytics.

To learn more, read the introductory article for Azure Data Factory or **[Azure Synapse](https://learn.microsoft.com/en-us/azure/synapse-analytics/overview-what-is)**.

## Overview

Azure Data Factory and Azure Synapse Analytics can have one or more pipelines. A pipeline is a logical grouping of activities that together perform a task. The activities in a pipeline define actions to perform on your data. For example, you might use a copy activity to copy data from SQL Server to Azure Blob storage. Then, you might use a Hive activity that runs a Hive script on an Azure HDInsight cluster to process data from Blob storage to produce output data. Finally, you might use a second copy activity to copy the output data to Azure Synapse Analytics, on top of which business intelligence (BI) reporting solutions are built. For more information about pipelines and activities, see **[Pipelines and activities](https://learn.microsoft.com/en-us/azure/data-factory/concepts-pipelines-activities)**.

Now, a dataset is a named view of data that simply points to or references the data you want to use in your activities as inputs and outputs.

Before you create a dataset, you must create a linked service to link your data store to the Data Factory or Synapse Workspace. Linked services are much like connection strings, which define the connection information needed for the service to connect to external resources. Think of it this way: the dataset represents the structure of the data within the linked data stores, and the linked service defines the connection to the data source. For example, an Azure Storage linked service links a storage account to the service. An Azure Blob dataset represents the blob container and the folder within that Azure Storage account that contains the input blobs to be processed.

Here's a sample scenario. To copy data from Blob storage to a SQL Database, you create two linked services: Azure Storage and Azure SQL Database. Then, create two datasets: Azure Blob dataset (which refers to the Azure Storage linked service) and Azure SQL Table dataset (which refers to the Azure SQL Database linked service). The Azure Storage and Azure SQL Database linked services contain connection strings that the service uses at runtime to connect to your Azure Storage and Azure SQL Database, respectively. The Azure Blob dataset specifies the blob container and blob folder that contains the input blobs in your Blob storage. The Azure SQL Table dataset specifies the SQL table in your SQL Database to which the data is to be copied.

The following diagram shows the relationships among pipeline, activity, dataset, and linked service in the service:

![r](https://learn.microsoft.com/en-us/azure/data-factory/media/concepts-datasets-linked-services/relationship-between-data-factory-entities.png)

## Linked service with UI

## Azure Data Factory

To create a new linked service in Azure Data Factory Studio, select the Manage tab and then linked services, where you can see any existing linked services you defined. Select + New to create a new linked service.

![ls](https://learn.microsoft.com/en-us/azure/data-factory/media/concepts-linked-services/create-linked-service.png)

After selecting + New to create a new linked service you can choose any of the supported connectors and configure its details accordingly. Thereafter you can use the linked service in any pipelines you create.

![nls](https://learn.microsoft.com/en-us/azure/data-factory/media/concepts-linked-services/new-linked-service-window.png)
