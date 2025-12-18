# **[Add or remove a gateway data source](https://learn.microsoft.com/en-us/power-platform/admin/onpremises-data-gateway-management)**

Add or remove a gateway data source
08/28/2024
 Note

We've split the on-premises data gateway docs into **[content that's specific to Power BI](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-onprem)** and **[general content that applies to all services](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)** that the gateway supports. You're currently in the Power BI content. To provide feedback on this article, or the overall gateway docs experience, scroll to the bottom of the article.

Power BI supports many **[on-premises data sources](https://learn.microsoft.com/en-us/power-bi/connect-data/power-bi-data-sources)**, and each source has its own requirements. You can use a gateway for a single data source or multiple data sources. For this example, you learn how to add SQL Server as a data source. The steps are similar for other data sources. This article also tells you how to remove a data source, use it with scheduled refresh or DirectQuery, and manage user access.

You can also do most data source management operations by using APIs. For more information, see **[REST APIs (Gateways)](https://learn.microsoft.com/en-us/rest/api/power-bi/gateways)**.

If you don't have a gateway installed, install an on-premises data gateway to get started.

## Add a data source

From the page header in the Power BI service, select the Settings Settings gear icon icon, and then select Manage connections and gateways.

![i1](https://learn.microsoft.com/en-us/power-bi/connect-data/media/service-gateway-data-sources/manage-gateways.png)

- Select New at the top of the screen to add a new data source.

- On the New connection screen, select On-premises, provide the Gateway cluster name you want to create the connection on, provide a Connection name, and select the Data Source Type. For this example, choose SQL Server.
- Enter information about the data source. For SQL Server, provide the Server and Database.

![i2](https://learn.microsoft.com/en-us/power-bi/connect-data/media/service-gateway-data-sources/server-database.png)

 Note

To use the data source for Power BI reports and dashboards, the server and database names must match between Power BI Desktop and the data source you add to the gateway.

Select an Authentication method to use when connecting to the data source: Basic, Windows, or OAuth2. For SQL Server, choose Windows or Basic (SQL Authentication). Enter the credentials for your data source.

![i3](https://learn.microsoft.com/en-us/power-bi/connect-data/media/service-gateway-data-sources/authentification.png)

If you selected OAuth2 authentication method:

Any query that runs longer than the OAuth token expiration policy might fail.
Cross-tenant Microsoft Entra accounts aren't supported.
If you selected Windows authentication method, make sure that account has access on the machine. If you're not sure, add NT-AUTHORITY\Authenticated Users (S-1-5-11) to the local machine Users group.

- Optionally, under Single sign-on, you can configure single sign-on (SSO) for your data source. Depending on your organization settings, for DirectQuery-based reports, you can configure Use SSO via Kerberos for DirectQuery queries, Use SSO via Kerberos for DirectQuery And Import queries or Use SSO via Microsoft Entra ID for DirectQuery queries. You can configure Use SSO via Kerberos for DirectQuery And Import queries for refresh-based reports.

If you use Use SSO via Kerberos for DirectQuery queries and use this data source for a DirectQuery-based report, the report uses the credentials of the user that signs in to the Power BI service. A refresh-based report uses the credentials that you enter in the Username and Password fields and the Authentication method you choose.

When you use Use SSO via Kerberos for DirectQuery And Import queries, you don't need to provide any credentials. If this data source is used for DirectQuery-based reports, the report uses the user mapped to the Microsoft Entra user that signs in to the Power BI service. A refresh-based report uses the dataset owner's security context.

For more information about Use SSO via Kerberos for DirectQuery queries and Use SSO via Kerberos for DirectQuery And Import queries, see **[Overview of single sign-on (SSO) for on-premises data gateways in Power BI](https://learn.microsoft.com/en-us/power-bi/connect-data/service-gateway-sso-overview)**.

If you use Use SSO via Microsoft Entra ID for DirectQuery queries and use this data source for a DirectQuery-based report, the report uses the Microsoft Entra token of the user who signs into the Power BI service. A refresh-based report uses the credentials that you enter in the Username and Password fields and the Authentication method you choose. The Use SSO via Microsoft Entra ID for DirectQuery queries option is available only if the tenant admin allows Microsoft Entra SSO via the on-premises data gateway, and for the following data sources:

- SQL Server
- Azure Data Explorer
- Snowflake

For more information about Use SSO via Microsoft Entra ID for DirectQuery queries, see **[Microsoft Entra single sign-on (SSO) for data gateway](https://learn.microsoft.com/en-us/fabric/admin/service-admin-portal-integration#azure-ad-single-sign-on-sso-for-gateway)**.

 Note

SSO for Import queries is available only for the SSO data sources that use Kerberos constrained delegation.

- Under General > Privacy level, optionally configure a privacy level for your data source. This setting doesn't apply to DirectQuery.

![i4](https://learn.microsoft.com/en-us/power-bi/connect-data/media/service-gateway-data-sources/privacy-level.png)

- Select Create. Under Settings, you see Created new connection if the process succeeds.

![i5](https://learn.microsoft.com/en-us/power-bi/connect-data/media/service-gateway-data-sources/data-source-succesful.png)

You can now use this data source to include data from SQL Server in your Power BI dashboards and reports.

## Manage users

After you add a data source to a gateway, you give users and security groups access to the specific data source, not the entire gateway. The access list for the data source controls only who is allowed to publish reports that include data from the data source. Report owners can create dashboards and apps, and then share those items with other users.

You can also give users and security groups administrative access to the gateway.

 Note

Users with access to the data source can associate datasets to the data source, and connect, based on either the stored credentials or SSO you selected while creating a data source. Before you share a data source connection, always ensure the user or group account you’re sharing are trusted and has only the privileges it needs (ideally a service account with narrowly scoped rights).
