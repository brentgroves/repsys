## **[Power BI Premium](https://learn.microsoft.com/en-us/fabric/enterprise/powerbi/service-premium-what-is#capacities-and-skus)**

Power BI Premium is geared toward enterprises who want a complete BI solution that provides a single view of its organization, partners, customers, and suppliers.

Power BI Premium is a SaaS product that allows users to consume content through mobile apps, internally developed apps, or at the Power BI portal (Power BI service). This service enables Power BI Premium to provide a solution for both internal and external customer facing applications.

Power BI premium offers two SKUs, P and EM.

- **[Understand the differences between the P and EM SKUs](https://learn.microsoft.com/en-us/power-bi/enterprise/service-premium-what-is#subscriptions-and-licensing)**
Buy a Premium SKU

## Note

For Power BI Premium, Power BI Report Server is only included with P SKUs. It is not included with EM SKUs. Power BI Report Server is also not included with any F SKUs below F64 reserved instance.

Web portal
The entry point for Power BI Report Server is a secure web portal you can view in any modern browser. Here, you access all your reports and KPIs. The content on the web portal is organized in a traditional folder hierarchy. In your folders, content is grouped by type: Power BI reports, mobile reports, paginated reports, KPIs, and Excel workbooks. Shared datasets and shared data sources are in their own folders, to use as building blocks for your reports. You tag favorites to view them in a single folder. And you create KPIs right in the web portal.

In Power BI, a Key Performance Indicator (KPI) is a visual element that displays the performance of a metric against a defined target, showing its current value, progress towards the goal, and historical trends in a clear, easy-to-understand format. To create a KPI visual, you must provide three key components: a Base Value (the metric you are tracking), a Target Value (the goal), and a Trend Axis (a sequential field like a date to show progress over time).

## Semantic model SKU limitation

With Power BI Premium and Power BI Embedded, there are memory limits and other constraints for each SKU listed in the table below.

1 The Microsoft Fabric Capacity Metrics app doesn't currently expose these metrics.

2 The Max memory (GB) column represents an upper bound for the semantic model size. However, an amount of memory must be reserved for operations such as refreshes and queries on the semantic model. The maximum semantic model size permitted on a capacity might be smaller than the numbers in this column.

3 DirectQuery parallelism can improve your query response times. The lower number indicates the default maximum number of queries that can be processed at the same time. The higher number indicates the maximum number of queries that can be processed at the same time. To change the default use the Model.MaxParallelismPerQuery property.

4 These limits apply to Direct Lake tables and models, and are guardrails that affect fallback to DirectQuery. Direct Lake semantic models have additional constraints that are based on SKUs, as listed in fallback.

 Note

While SKU limitations define the maximum memory available for semantic models, administrators can manage memory allocation through capacity settings in the Power BI admin portal. For details on adjusting memory settings, see Configure workloads in Power BI Premium.

Semantic model memory usage
Semantic model operations such as queries are subject to individual memory limits. To illustrate the restriction, consider a semantic model with an in-memory footprint of 1 GB, and a user initiating an on-demand refresh while interacting with a report based on the same semantic model. Three separate actions determine the amount of memory attributed to the original semantic model, which may be larger than two times the semantic model size. The total amount of memory used by one Power BI item can't exceed the SKU's Max memory per semantic model allocation.

Loading the semantic model - The first action is loading the semantic model into the memory.

Refreshing the semantic model - The second action is refreshing the semantic model after it's loaded into the memory. The refresh operation will cause the memory used by the semantic model to more than double, because in addition to the memory used by the refresh operation, the original copy of data remains available for active queries while another copy is being processed by the refresh. Once the refresh transaction commits, the memory footprint is reduced.

Interacting with the report - The third action is caused by the user's interaction with the report. During the semantic model refresh, report interactions will execute DAX queries. Each DAX query consumes a certain amount of temporary memory required to produce the results. Each query may consume a different amount of memory. The memory used to query the semantic model is added to the memory needed to load the semantic model, and refresh it.

Refreshes
Power BI Premium and Power BI Embedded don't require cumulative memory limits, and therefore concurrent semantic model refreshes don't contribute to resource constraints. However, refreshing individual semantic models is governed by existing capacity memory and CPU limits, and the model refresh parallelism limit for the SKU, as described in Capacities and SKUs.

You can schedule and run as many refreshes as required at any given time, and the Power BI service will run those refreshes at the time scheduled as a best effort.
