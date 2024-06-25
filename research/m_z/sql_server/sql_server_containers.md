# **[SQL Server Containers](https://learn.microsoft.com/en-us/sql/linux/sql-server-linux-docker-container-deployment?view=sql-server-ver16&pivots=cs1-bash)**

**[Back to Research List](../../research_list.md)**\
**[Back to Current Status](../../../development/status/weekly/current_status.md)**\
**[Back to Main](../../../README.md)**

## Run production container images

The quickstart in the previous section runs the free Developer edition of SQL Server from the Microsoft Artifact Registry. Most of the information still applies if you want to run production container images, such as Enterprise, Standard, or Web editions. However, there are a few differences that are outlined here.

You can only use SQL Server in a production environment if you have a valid license. You can obtain a free SQL Server Express production license here. SQL Server Standard and Enterprise edition licenses are available through Microsoft Volume Licensing.

The Developer container image can be configured to run the production editions as well.

To run a production edition, review the requirements and run procedures in the quickstart. You must specify your production edition with the MSSQL_PID environment variable. The following example shows how to run the latest SQL Server 2022 (16.x) container image for the Enterprise Core edition.

Bash

Copy
docker run --name sqlenterprise \
-e 'ACCEPT_EULA=Y' -e 'MSSQL_SA_PASSWORD=<YourStrong!Passw0rd>' \
-e 'MSSQL_PID=EnterpriseCore' -p 1433:1433 \
-d mcr.microsoft.com/mssql/server:2022-latest
 Important

By passing the value Y to the environment variable ACCEPT_EULA and an edition value to MSSQL_PID, you are expressing that you have a valid and existing license for the edition and version of SQL Server that you intend to use. You also agree that your use of SQL Server software running in a container image will be governed by the terms of your SQL Server license.
