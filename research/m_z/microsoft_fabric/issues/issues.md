Hi Team,

I wanted to share an update on the recent issue we encountered in Fabric related to latency during Lakehouse-to-SQL Endpoint synchronization, along with the steps we’ve taken so far.

Issue Summary

We observed unexpected delays when accessing data in OneLake through SQL endpoints. This impacted our workflow, which relies on immediate data availability:
Lakehouse → Stored procedure in Warehouse (reads Lakehouse data and creates golden layer tables) → Power BI.

The problem occurred because the stored procedure was triggered immediately after raw data was loaded into the Lakehouse, resulting in incomplete data being used to populate golden layer tables.

Root Cause

After consulting with Microsoft support, we confirmed that this synchronization delay is expected behavior, not a bug. The sync process duration depends on several factors.

Proposed Solutions

Microsoft suggested two approaches to mitigate the delay:

Notebook Refresh – Run a notebook refresh after each Lakehouse data load. This involves linking the notebook to the Lakehouse and using Fabric scripts to refresh SQL Endpoint tables.
REST API – Use the REST API (Items → Refresh SQL Endpoint Metadata) to programmatically trigger synchronization when needed.
Current Status

We have not implemented these solutions yet, as we are testing their implications. In the meantime, we’ve added a wait event in the pipeline or incorporated record count checks in the stored procedure to ensure data preparation occurs only after the Lakehouse SQL Endpoint is updated.

We will share the results of our testing and Microsoft’s proposed solutions once completed.

Additional Resources:
Below are links with more details about the issue and recommended solutions:
SQL Analytics Endpoint Performance Considerations - Microsoft Fabric | Microsoft Learn

Code to refresh the tables in the SQL Endpoint, after they have been updated in the lakehouse. Cut …

Thanks.

Regards
