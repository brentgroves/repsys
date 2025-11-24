# **[Adjust communication settings for the on-premises data gateway](<https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication>)**

The gateway communicates on the following outbound ports: TCP 443, 433, 5671, 5672, and from 9350 through 9354. The gateway doesn't require inbound ports.

For guidance on how to set up your on-premises firewall and/or proxy using fully qualified domain names (FQDNs) instead of using IP addresses that are subject to change, follow the steps in Azure WCF Relay DNS Support.

This article describes several communication settings associated with the on-premises data gateway. These settings need to be adjusted to support data source connections and output destination access.

## Enable outbound Azure connections

The gateway relies on Azure Relay for cloud connectivity. The gateway correspondingly establishes outbound connections to its associated Azure region.

If you registered for either a Power BI tenant or an Office 365 tenant, your Azure region defaults to the region of that service. Otherwise, your Azure region might be the one closest to you.

If a firewall blocks outbound connections, configure the firewall to allow outbound connections from the gateway to its associated Azure region. The firewall rules on the gateway server and/or customer's proxy servers need to be updated to allow outbound traffic from the gateway server to the below endpoints. If your firewall does not support wildcards, then use the IP addresses from Azure IP Ranges and Service Tags. Note that they will need to be kept in sync each month.

## **[](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#required-ports-for-the-gateway-to-function)**

## **[FQDNs used by the gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#required-ports-for-executing-fabric-workloads)**

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
