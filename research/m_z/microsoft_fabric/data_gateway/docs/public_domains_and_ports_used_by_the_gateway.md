# **[Required Ports for the gateway to function](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication)**

The gateway communicates on the following outbound ports: TCP 443, 433, 5671, 5672, and from 9350 through 9354. The gateway doesn't require inbound ports.

The following list describes FQDNs used by the gateway. These endpoints are required for the gateway to function.

| Public Cloud Domain names                                                                                  | Outbound ports    | Description                                                                                                                                                                                           |
|------------------------------------------------------------------------------------------------------------|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| *.download.microsoft.com                                                                                   | 443               | Used to download the installer. The gateway app also uses this domain to check the version and gateway region.                                                                                        |
| *.powerbi.com                                                                                              | 443               | Used to identify the relevant Power BI cluster.                                                                                                                                                       |
| *.analysis.windows.net                                                                                     | 443               | Used to identify the relevant Power BI cluster.                                                                                                                                                       |
| *.login.windows.net, login.live.com, aadcdn.msauth.net, login.microsoftonline.com,*.microsoftonline-p.com | 443               | Used to authenticate the gateway app for Microsoft Entra ID and OAuth2. Note that additional URLs could be required as part of the Microsoft Entra ID sign in process that can be unique to a tenant. |
| *.servicebus.windows.net                                                                                   | 5671-5672         | Used for Advanced Message Queuing Protocol (AMQP).                                                                                                                                                    |
| *.servicebus.windows.net                                                                                   | 443 and 9350-9354 | Listens on Azure Relay over TCP. Port 443 is required to get Azure Access Control tokens.                                                                                                             |
| *.msftncsi.com                                                                                             | 80                | Used to test internet connectivity if the Power BI service can't reach the gateway.                                                                                                                   |
| *.dc.services.visualstudio.com                                                                             | 443               | Used by AppInsights to collect telemetry.                                                                                                                                                             |
| ecs.office.com                                                                                             | 443               | Used for ECS configuration to enable Mashup features.                                                                                                                                                 |
| gatewayadminportal.azure.com                                                                               | 443               | Used for gateway management in the portal.                                                                                                                                                            |

 Note

After the gateway is installed and registered, the only required ports and IP addresses are those needed by Azure Relay, as described for servicebus.windows.net in the preceding table. You can get the list of required ports by performing the **[Network ports test](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#network-ports-test)** periodically in the gateway app. You can also force the gateway to communicate using HTTPS.

## **[Required ports for executing Fabric workloads](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#required-ports-for-executing-fabric-workloads)**

When a Fabric workload (for example, Semantic models or Fabric Dataflows) includes a query that connects to both on-premises data sources (via an on-premises data gateway) and cloud data sources, the entire query is executed on the on-premises data gateway. Therefore, to run a Fabric workload item, the following endpoints must be open so the on-premises data gateway has line-of-sight access to the workload required data sources:

| Public cloud domain names                | Outbound ports | Description                                                                               |
|------------------------------------------|----------------|-------------------------------------------------------------------------------------------|
| *.core.windows.net                       | 443            | Used by Dataflow Gen1 to write data to Azure Data Lake.                                   |
| *.dfs.fabric.microsoft.com               | 443            | Endpoint used by Dataflow Gen1 and Gen2 to connect to OneLake. Learn more                 |
| *.datawarehouse.pbidedicated.windows.net | 1433           | Old endpoint used by Dataflow Gen2 to connect to the Fabric staging lakehouse. Learn more |
| *.datawarehouse.fabric.microsoft.com     | 1433           | New endpoint used by Dataflow Gen2 to connect to the Fabric staging lakehouse. Learn more |
| *.frontend.clouddatahub.net              | 443            | Required for Fabric Pipeline execution                                                    |

 Note

*.datawarehouse.pbidedicated.windows.net is being replaced by*.datawarehouse.fabric.microsoft.com. During this transition process, make sure to have both endpoints open to ensure Dataflow Gen2 refresh.

Additionally, when any other cloud data connections (both data sources and output destinations) are used with an on-premises data source connection in a workload query, you must also open the necessary endpoints to ensure that the on-premises data gateway has line-of-sight access to those cloud data sources.

## Network ports test

To test if the gateway has access to all required ports:

On the machine that is running the gateway, enter "gateway" in Windows search, and then select the On-premises data gateway app.

Select Diagnostics. Under Network ports test, select Start new test.

![i](https://learn.microsoft.com/en-us/data-integration/gateway/media/service-gateway-communication/gateway-start-new-test.png)

When your gateway runs the network ports test, it retrieves a list of ports and servers from Azure Relay and then attempts to connect to all of them. When the Start new test link reappears, the network ports test has finished.

The summary result of the test is either "Completed (Succeeded)" or "Completed (Failed, see last test results)". If the test succeeded, your gateway connected to all the required ports. If the test failed, your network environment might have blocked the required ports and servers.
