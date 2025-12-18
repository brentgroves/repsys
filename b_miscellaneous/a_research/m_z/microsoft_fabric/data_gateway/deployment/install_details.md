# **[Install an on-premises data gateway](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-install)**

An on-premises data gateway is software that you install in an on-premises network. The gateway facilitates access to data in that network.

As we explain in the **[overview](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-onprem#types-of-gateways)**, you can install a gateway either in personal mode, which applies to Power BI only, or in standard mode. We recommend standard mode. In that mode, you can install a standalone gateway or add a gateway to a cluster, which we recommend for high availability.

In this article, we show you how to install a standard gateway, how to add another gateway to create a cluster, and how to install a personal mode gateway.

 Note

To update an existing gateway to a later version, refer to Update an on-premises data gateway.

## Requirements

Minimum requirements

- .NET Framework 4.8
- A 64-bit version of Windows 10 or a 64-bit version of Windows Server 2019
- 4-GB disk space for **[performance monitoring logs](https://learn.microsoft.com/en-us/data-integration/gateway/service-gateway-performance#gateway-performance-monitoring-public-preview)** (in default configuration)

## Recommended

- An 8-core CPU
- 8 GB of memory
- A 64-bit version of Windows Server 2019 or later
Solid-state drive (SSD) storage for spooling

## Related considerations

Workloads might have specific requirements around compatible gateway versions. For dataflows, go to **[using dataflows with on-premises data](https://learn.microsoft.com/en-us/power-query/dataflows/using-dataflows-with-on-premises-data)**.

- Gateways aren't supported on Server Core installations.

- Gateways aren't supported on Windows containers.
- The user installing the gateway must be the admin of the gateway.
- The gateway can't be installed on a domain controller.
- If you're planning to use Windows authentication, make sure you install the gateway on a computer that's a member of the same Microsoft Entra environment as the data sources.
- Don't install a gateway on a computer, like a laptop, that might be turned off, asleep, or disconnected from the internet. The gateway can't run under any of those circumstances.
- If a gateway uses a wireless network, its performance might suffer. We recommend that you set the gateway on a wired device for best network performance.
- If you use a virtualization layer for your virtual machine, performance might suffer or perform inconsistently.
- You could install other applications on the gateway machine, but these applications might degrade gateway performance. If you do install other applications on the gateway machine, be sure to monitor the gateway closely to check if there's any resource contention.
- You can install up to two gateways on a single computer: one running in personal mode and the other running in standard mode. An on-premises data gateway (personal mode) can be used only with Power BI. You can't have more than one gateway running in the same mode on the same computer.
- When using an on-premises data gateway (standard mode) to access a data source on a remote domain, the gateway has to be installed on a domain joined machine having a trust relationship with the target domain.

Using an on-premises data gateway with private link enabled isn't supported. We recommend using the VNet data gateway, which does support private link scenarios. If private link is enabled, you get the following error when trying to register a new gateway or migrate/restore/takeover an existing gateway:

System.NullReferenceException: Object reference not set to an instance of an object

at Microsoft.PowerBI.DataMovement.GatewayCommon.DmtsGatewayCreation.UpdateGatewayConfiguration.

To disable private link, go to the powerbi.com page, and select Settings > Admin portal. Look for the Advanced networking section at the bottom of the page, and disable the Azure Private Link property. After the gateway is configured, you can enable the Azure Private Link property.

## Download and install a standard gateway

Because the gateway runs on the computer that you install it on, be sure to install it on a computer that's always turned on. For better performance and reliability, we recommend that the computer is on a wired network rather than a wireless one.

Download the standard gateway.

 Note

If the on-premises data gateway (standard mode) requires access to a remote data source in a different domain, it must be installed on a domain joined machine having a trust relationship with the target domain.
