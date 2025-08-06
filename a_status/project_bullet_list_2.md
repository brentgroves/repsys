# IS Project Bullet List

Hi Christian, Kevin, and Jared

This is a revised bullet list for the Structures information systems projects. It is suitable for our Bi-Weekly meeting.

Thank you.

The following is in markdown format and can be viewed by copying and pasting the contents below into an online markdown viewer, such as at <https://markdownlivepreview.com/>.

- Set up and administer the Structures Microsoft Fabric workspace.

The Structures Information Systems group is setting up and administering the Structures Microsoft Fabric workspace. This workspace will help us achieve the goal of centralizing our business data to give us previously impossible insights.  

Time: ongoing

- Set up a data gateway.

This **[data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)** will enable the Microsoft Fabric **[Data Factory](https://azure.microsoft.com/en-us/products/data-factory)** to access on-premise data and data sources available through ODBC connections, such as the Plex ERP. A high-availability gateway cluster can be set up on our Structures MicroCloud.  This gateway will help us achieve the goal of centralizing our business data in Linamar's Microsoft Fabric OneLake.

Time: 1 to 3 months

- Set up an automated and on-demand ETL pipeline in K8s

We manually run scripts to update the data warehouse and data lake that Power BI reports use as their raw and golden data sources.  The Automated and on-demand [ETL pipeline](https://www.informatica.com/resources/articles/what-is-etl-pipeline.html)** runs these scripts automatically or on demand.

time: 6 months to 1 year
