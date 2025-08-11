# **[](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem#types-of-gateways)**

## What is an on-premises data gateway?

06/10/2025
 Note

Currently, Microsoft actively supports only the last six releases of the on-premises data gateway. We release a new update for data gateways every month.

The on-premises data gateway is a locally installed Windows client application that acts as a bridge between your local on-premises data sources and services in the Microsoft cloud. It provides quick and secure data transfer and requires no inbound ports to your network—only outbound ports to reach the Azure web service to which the gateway connects. The gateway functions with multiple services including Azure Analysis Services, Azure Data Factory, Azure Logic Apps, Microsoft Fabric, Power Apps, Power Automate, and Power BI.

Using a gateway allows organizations to keep databases and other data sources on their on-premises networks while securely using that on-premises data in cloud services.

How the gateway works

![i1](https://learn.microsoft.com/en-us/data-integration/gateway/media/service-gateway-getting-started/on-premises-data-gateway.png)

The on-premises data gateway initiates outbound connections to the cloud, but requires no inbound connections. All communication from the cloud is received in responses to polling over the outbound connections. For detailed information on how the gateway works, go to **[On-premises data gateway architecture](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem-indepth)** and **[Adjust communication settings for the on-premises data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-communication)**.

## Types of gateways

There are two different types of on-premises data gateways, each for a different scenario.

- On-premises data gateway: Allows multiple users to connect to multiple on-premises data sources. With a single gateway installation, you can use an on-premises data gateway with all supported services. This gateway is well suited to complex scenarios where multiple people access multiple data sources.
- On-premises data gateway (personal mode): Allows one user to connect to data sources and can't be shared with others. An on-premises data gateway (personal mode) can be used only with Power BI. This gateway is well suited to scenarios where you're the only one who creates reports and you don't need to share any data sources with others.

In addition, there's a virtual network (VNet) data gateway that lets multiple users connect to multiple data sources secured by virtual networks. No installation is required because it's a Microsoft managed service. This gateway is well suited to complex scenarios in which multiple people access multiple data sources. Virtual network data gateways are discussed in depth in What is a **[virtual network (VNet) data gateway](https://learn.microsoft.com/en-us/data-integration/vnet/overview)**.

## Using a gateway

There are four main steps for using a gateway.

- **[Download and install the gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-install)** on a local computer.
- **[Configure](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-app)** the gateway based on your firewall and other network requirements.
- Add gateway admins who can also manage and administer other network requirements.
- Troubleshoot the gateway if there are errors.
