# **[Guidance for deploying a data gateway for the Power BI service](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-deployment-guidance)**

Guidance for deploying a data gateway for the Power BI service
05/23/2024
 Note

We've split the on-premises data gateway docs into content that's specific to Power BI and general content that applies to all services that the gateway supports. You're currently in the Power BI content. To provide feedback on this article, or the overall gateway docs experience, scroll to the bottom of the article.

This article provides guidance and considerations for deploying a data gateway for the Power BI service in your network environment.

For information about how to download, install, configure, and manage the on-premises data gateway, see What is an on-premises data gateway?. You can also find out more about the on-premises data gateway and Power BI by visiting the Microsoft Power BI blog and the Microsoft Power BI Community site.

## Installation considerations for the on-premises data gateway

Before you install the on-premises data gateway for your Power BI cloud service, there are some considerations to keep in mind. The following sections describe these considerations.

## Number of users

- The number of users who consume a report that uses the gateway is an important metric in your decision about where to install the gateway. Here are some questions to consider:
- Do users use these reports at different times of the day?
- What types of connections do they use: DirectQuery or Import?
- Do all users use the same report?

If all the users access a given report at the same time each day, make sure that you install the gateway on a machine that's capable of handling all those requests. See the following sections for performance counters and minimum requirements that can help you determine whether a machine is adequate.

A constraint in the Power BI service allows only one gateway per report. Even if a report is based on multiple data sources, all such data sources must go through a single gateway. If a dashboard is based on multiple reports, you can use a dedicated gateway for each contributing report. In this way, you distribute the gateway load among the multiple reports that contribute to the single dashboard.

## Connection type

The Power BI service offers two types of connections: DirectQuery and Import. Not all data sources support both connection types. Many factors might contribute to your choice of one over the other, such as security requirements, performance, data limits, and data model sizes. To learn more about connection types and supported data sources, see the **[list of available data source types](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-data-sources#list-of-available-data-source-types)**.
