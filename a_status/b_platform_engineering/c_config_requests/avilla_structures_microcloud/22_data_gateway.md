# Structures Microsoft Data Gateway

Submitted : 2025-11-25 18:30:13
Request Number : REQ0229820

## outcome

It took about 10 minutes to login to our Microsoft tenant as <bgroves@linamar.com>.

- download python UV.

The following is in markdown format. You can view it better at <https://markdownlivepreview.com/> by copying and pasting the contents below.

**Project:** Structures **[Microsoft on-premise Data Gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem-indepth)**

**Issue:** The Structures Microsoft Fabric data gateway does not have access to the required domains and ports it needs to function.

**Request:** Please give the the Structures Microsoft Fabric data gateway access to the required domains and ports it needs to function.

**Affected Application:** Future Structures Power BI dashboards, reports, and notebooks that will be managed in the Structures Microsoft Fabric Power BI enabled workspace. The Structures Information Systems team is currently creating a process workflow that all Structure employees will be able to use to securely publish Power BI dashboards, reports, and notebooks.

**[notebook](https://jupyter.org/)**
"A notebook is a web-based interactive computing platform. The notebook combines live code, equations, narrative text, visualizations, ..."

**Business Justification:** The Structures Microsoft Fabric Power BI enabled workspace will help Linamar Structures centralize business data enabling insights never before possible:

Key benefits of Microsoft Fabric:

- **Unified platform:** Combines data integration, data engineering, data warehousing, data science, and business intelligence into a single service, eliminating the need for multiple tools and creating a more streamlined workflow.
- **Reduced complexity and cost:** A unified pricing model, a single data lake (OneLake), and reduced infrastructure management can lead to significant cost savings and increased efficiency.
- **Improved collaboration:** Allows different teams to work together on a single source of data within one environment, breaking down silos and fostering better collaboration.
- **AI and automation:** Integrates artificial intelligence and machine learning capabilities across all workloads, while automating processes to help teams move from data to insights faster.
- **Enhanced security and governance:** Features robust security, centralized administration, and governance powered by Purview, which automatically applies permissions and sensitivity labels across all assets.
- **Scalability:** Offers high availability and scalability to grow with a business, while also decoupling storage costs from compute costs.
- **Faster time to value:** Reduces the time it takes to get from raw data to actionable insights, improving development timelines and project delivery.
- **Seamless integration:** Integrates smoothly with the wider Microsoft ecosystem and business applications, allowing for more flexible and powerful solutions.

## Requested Policy Change

Please give the the Structures Microsoft Fabric data gateway access to the required domains and ports it needs to function.

Here is the egress IP of the data gateway:

`IP: 10.188.50.206`

The following is the public cloud domain names and outbound ports the above IP will need access to:

```yaml
*download.microsoft.com: 443
*powerbi.com: 443
*analysis.windows.net: 443
*login.windows.net: 443
login.live.com: 443
*login.live.com: 443
aadcdn.msauth.net: 443
*aadcdn.msauth.net: 443
login.microsoftonline.com: 443
*login.microsoftonline.com: 443
*microsoftonline-p.com: 443
*servicebus.windows.net: 5671-5672
*servicebus.windows.net: 443
*servicebus.windows.net: 9350-9354
*msftncsi.com: 80
*dc.services.visualstudio.com: 443
ecs.office.com: 443
*ecs.office.com: 443
gatewayadminportal.azure.com: 443
*gatewayadminportal.azure.com: 443
*core.windows.net: 443
*dfs.fabric.microsoft.com: 443
*datawarehouse.pbidedicated.windows.net: 1433
*datawarehouse.fabric.microsoft.com: 1433
*frontend.clouddatahub.net: 443
```

## public cloud domain port details

**[Required Ports for the gateway to function](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication#required-ports-for-the-gateway-to-function)**

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

## Verify

To test if the gateway has access to all required ports:

On the machine that is running the gateway, enter "gateway" in Windows search, and then select the On-premises data gateway app.

Select Diagnostics. Under Network ports test, select Start new test.

![i](https://learn.microsoft.com/en-us/data-integration/gateway/media/service-gateway-communication/gateway-start-new-test.png)

When your gateway runs the network ports test, it retrieves a list of ports and servers from Azure Relay and then attempts to connect to all of them. When the Start new test link reappears, the network ports test has finished.

The summary result of the test is either "Completed (Succeeded)" or "Completed (Failed, see last test results)". If the test succeeded, your gateway connected to all the required ports. If the test failed, your network environment might have blocked the required ports and servers.

**[What is Microsoft Fabric](https://www.microsoft.com/en-us/microsoft-fabric/resources/data-101/what-is-fabric#:~:text=Microsoft%20Fabric%20is%20a%20unified%2C%20cloud%2Dbased%20data,services%20to%20provide%20a%20unified%20user%20experience.)**

"Microsoft Fabric is a unified, cloud-based data analytics platform that combines data management and analytics into a single service. It provides an end-to-end experience for data professionals and users, covering everything from data ingestion and preparation to storage, analysis, and visualization, all within a unified experience that uses AI-powered tools. Key components include a unified oneLake for data storage and workloads for data engineering, data science, and data warehousing."

Key benefits of Microsoft Fabric:

- **Unified platform:** Combines data integration, data engineering, data warehousing, data science, and business intelligence into a single service, eliminating the need for multiple tools and creating a more streamlined workflow.
- **Reduced complexity and cost:** A unified pricing model, a single data lake (OneLake), and reduced infrastructure management can lead to significant cost savings and increased efficiency.
- **Improved collaboration:** Allows different teams to work together on a single source of data within one environment, breaking down silos and fostering better collaboration.
- **AI and automation:** Integrates artificial intelligence and machine learning capabilities across all workloads, while automating processes to help teams move from data to insights faster.
- **Enhanced security and governance:** Features robust security, centralized administration, and governance powered by Purview, which automatically applies permissions and sensitivity labels across all assets.
- **Scalability:** Offers high availability and scalability to grow with a business, while also decoupling storage costs from compute costs.
- **Faster time to value:** Reduces the time it takes to get from raw data to actionable insights, improving development timelines and project delivery.
- **Seamless integration:** Integrates smoothly with the wider Microsoft ecosystem and business applications, allowing for more flexible and powerful solutions.

**[What is an on-premises data gateway?](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem)**

The on-premises data gateway is a locally installed Windows client application that acts as a bridge between your local on-premises data sources and services in the Microsoft cloud. It provides quick and secure data transfer and requires no inbound ports to your network—only outbound ports to reach the Azure web service to which the gateway connects. The gateway functions with multiple services including Azure Analysis Services, Azure Data Factory, Azure Logic Apps, Microsoft Fabric, Power Apps, Power Automate, and Power BI.

Using a gateway allows organizations to keep databases and other data sources on their on-premises networks while securely using that on-premises data in cloud services.

## How does the Microsoft on-premise data gateway work?

The Microsoft On-premises data gateway uses the **[Azure Relay?](https://learn.microsoft.com/en-us/azure/azure-relay/relay-what-is-it)** to securely connect on-premises data sources to cloud services like Power BI, Power Apps, and Power Automate. Azure Relay acts as a secure bridge, allowing the gateway to receive requests from the cloud and send data back without exposing the on-premises network directly to the internet.

### **[What is Azure Relay?](https://learn.microsoft.com/en-us/azure/azure-relay/relay-what-is-it)**

The Azure Relay service enables you to securely expose services that run in your corporate network to the public cloud. You can do so without opening a port on your firewall, or making intrusive changes to your corporate network infrastructure.

The relay service supports the following scenarios between on-premises services and applications running in the cloud or in another on-premises environment.

- Traditional one-way, request/response, and peer-to-peer communication
- Event distribution at internet-scope to enable publish/subscribe scenarios
- Bi-directional and unbuffered socket communication across network boundaries
- Azure Relay differs from network-level integration technologies such as VPN. An Azure relay can be scoped to a single application endpoint on a single machine. The VPN technology is far more intrusive, as it relies on altering the network environment.

The Azure Relay Hybrid Connections feature uses WebSockets to enable secure, bi-directional communication between clients and services on different networks. It acts as a secure bridge for applications to communicate without needing to open firewall ports or change network infrastructure. While the service provides the foundation for WebSocket communication, you still need to build your own WebSocket server application to listen for and handle messages.

### How it works

- **A secure bridge:** Azure Relay provides a secure and reliable way to expose services running in a private network to public cloud applications.
- **WebSocket technology:** The Hybrid Connections feature is built on the open standard WebSocket protocol, allowing for real-time, two-way communication.
- **You build the server:** You must write your own server application to listen for and receive messages from the Relay. Azure Relay handles the underlying connection, but the application logic resides on your server.
- **Cross-platform:** Because it uses the open WebSocket protocol, your client and server applications can be written in any language and run on any platform.
