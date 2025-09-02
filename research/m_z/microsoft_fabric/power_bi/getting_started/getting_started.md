# **[getting startd](https://learn.microsoft.com/en-us/power-bi/fundamentals/fabric-get-started)**

Tutorial: Microsoft Fabric for Power BI users
06/17/2025
In this tutorial, you'll learn how to use Microsoft Fabric to prepare, load, and model data for Power BI reporting. You'll use Dataflows Gen2 to ingest and transform data into a Lakehouse, orchestrate data refreshes with Pipelines, and build a dimensional model using Direct Lake mode. Finally, you'll automatically generate a report to visualize the latest sales data.

By the end of this tutorial, you'll be able to:

Prepare and load data into a lakehouse
Orchestrate a data pipeline to refresh data and send an email on failure
Create a semantic model in the Lakehouse
Automatically create a report with quick create
Prerequisites
Before you begin, ensure you have the following:

Enable Fabric for your organization if you haven't already.
Sign up for a free trial if you don't have access.
Create a new workspace and assign a Fabric capacity. You can use an existing workspace, but a nonproduction workspace is recommended for this tutorial.
Download the Power Query template file containing **[sample queries](https://github.com/microsoft/pbiworkshops/raw/main/_Asset%20Library/Source_Files/ContosoSales.pqt)** for Contoso data.

## Create a lakehouse to store data

Start by creating a lakehouse to store your data. You'll use Dataflows Gen2 to prepare and transform it, and a pipeline to orchestrate scheduled refreshes and email notifications.

In your workspace, select New item at the top of the page.

![i1](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/new-item.png)

On the New item creation screen, search for or select Lakehouse.

Name the dataflow OnlineSalesDataflow (use only letters, numbers, and underscores), then select Create.

Prepare and load data into your lakehouse using Dataflows Gen2

In the Power Query Online editor for Dataflows Gen2, select Import from a Power Query template and choose the ContosoSales.pqt template file you downloaded in the prerequisites.

![i3](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/import-power-query-template.png)

Select the DimDate query under the Data load group. If prompted, select Configure connection, set authentication to Anonymous, and select Connect.

With DimDate selected, in the data preview, find the DateKey column. Select the data type icon in the column header and choose Date/Time from the dropdown.

![i3](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/transform-column-date-time.png)

In the Change column type window, select Replace current.

## Configure data destinations

With DimDate selected, review the data destination settings in the bottom right. Hover over the configured Lakehouse to view its properties.

The Lakehouse you created is the destination for all tables. The default update method is Replace, which overwrites previous data during each refresh.

![i4](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/default-destination.png)

Select the FactOnlineSales table and review its data destination settings.

Because the FactOnlineSales source changes frequently, optimize refreshes by appending new data. Remove its current data destination by selecting the X icon. Do not remove destinations for other tables.

![i5](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/modify-data-destination.png)

With FactOnlineSales still selected, select the + icon to add a data destination, then choose Lakehouse.

If prompted, set authentication to Organizational account and select Next.

![i6](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/add-lakehouse-destination.png)

In the navigator, select your workspace and expand to view all Lakehouse items. Select SalesLakehouse and ensure New table is selected, then select Next.

In the data destination settings panel, clear Use automatic settings, set Update method to Append, and select Save settings.

 Note

The Append method adds new rows to the table during each refresh, preserving existing data.

![i7](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/append-method.png)

From the Home tab, select Save & run.

![i8](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/save-and-run.png)

To exit the Power Query Online editor, select the X on the OnlineSalesDataflow item in the left side-rail.

![i9](https://learn.microsoft.com/en-us/power-bi/fundamentals/media/fabric-get-started/close-dataflow.png)
