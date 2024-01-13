# Connect on-premise server

## references

<https://techcommunity.microsoft.com/t5/itops-talk-blog/connect-to-your-on-prem-server-from-anywhere/ba-p/3565194>

<https://learn.microsoft.com/en-us/microsoft-365/enterprise/connect-an-on-premises-network-to-a-microsoft-azure-virtual-network?view=o365-worldwide>

<https://docs.oracle.com/en-us/iaas/Content/Bastion/Tasks/managingsessions.htm#managingsessions>

## managed sessions

<https://docs.oracle.com/en-us/iaas/Content/Bastion/Tasks/managingsessions.htm#managingsessions>

Oracle allows connection via Sock5 dynamic port forwarding session but Microsoft does not.

## Connect an on-premises network to a microsoft Azure virtual network

<https://stackoverflow.com/questions/73535520/can-i-use-azure-bastion-to-tunnel-into-my-cosmosdb>

The answer is no, you can't. It only works with VMs.

The solution I came up with is to essentially create a VM, run sockd on it, use bastion to establish the port forwarding, then configure your local client to use a socks5 proxy to localhost.

<https://learn.microsoft.com/en-us/azure/bastion/connect-ip-address>

IP-based connection lets you connect to your on-premises, non-Azure, and Azure virtual machines via Azure Bastion over ExpressRoute or a VPN site-to-site connection using a specified private IP address. The steps in this article show you how to configure your Bastion deployment, and then connect to an on-premises resource using IP-based connection. For more information about Azure Bastion, see the Overview.

![](https://learn.microsoft.com/en-us/azure/bastion/media/connect-ip-address/architecture.png)

## Limitations

- IP-based connection won’t work with force tunneling over VPN, or when a default route is advertised over an ExpressRoute circuit. Azure Bastion requires access to the Internet and force tunneling, or the default route advertisement will result in traffic blackholing.
- Microsoft Entra authentication isn't supported for RDP connections. Microsoft Entra authentication is supported for SSH connections via native client.
- Custom ports and protocols aren't currently supported when connecting to a VM via native client.
- UDR isn't supported on Bastion subnet, including with IP-based connection.

A few weeks ago, I wrote about upgrading my local network edge device with one capable of connecting to my Azure virtual network using a site-to-site VPN.  I also mentioned that I would cover many other services and capabilities that this site-to-site VPN configuration enables for hybrid work and management.

This week I’m covering the ability to connect to your on-premises, non-Azure, and Azure virtual machines via Azure Bastion over ExpressRoute or a VPN site-to-site connection using a specified private IP address over RDP and SSH.

![](https://learn.microsoft.com/en-us/azure/bastion/media/connect-ip-address/ip-address.png)

Over the years I have seen and heard many ITPros struggles to figure out a way to deploy and maintain a VPN infrastructure that would allow them to access the servers in their remote environments easily and cheaply without having to mess around with routing and remote access roles or port forwarding. And without having to manage VPN clients on their PC.

Furthermore, the option of exposing the RDP port to the internet is a really bad idea.  As mentioned in the Data science for cybersecurity: A probabilistic time series model for detecting RDP inbound brute fo...,

“Computers with Windows Remote Desktop Protocol (RDP) exposed to the internet are an attractive target for adversaries because they present a simple and effective way to gain access to a network. Brute forcing RDP, a secure network communications protocol that provides remote access over port 3389, does not require a high level of expertise or the use of exploits; attackers can utilize many off-the-shelf tools to scan the internet for potential victims and leverage similar such tools for conducting the brute force attack.”

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/385576i25161EC1D4F84074/image-size/large?v=v2&px=999)

Azure Bastion is a service you can deploy and use to securely connect to a virtual machine using your browser and the Azure portal. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly from the Azure portal over TLS. That way your virtual machines don't need a public IP address, agent, or special client software.

Before you can take advantage of this feature, verify that you have the following environment set up:

- A VNet with Bastion already deployed.
- Make sure that you have deployed Bastion to the virtual network. Once the Bastion service is provisioned and deployed in your virtual network, you can use it to connect to any VM deployed in any of the virtual networks that is reachable from Bastion.
- To deploy Bastion, see Quickstart: **[Deploy Bastion with default settings](https://docs.microsoft.com/azure/bastion/quickstart-host-portal?WT.mc_id=modinfra-69297-pierrer)**.
- A virtual machine in any reachable virtual network. This is the virtual machine to which you'll connect.

Now you need to configure the bastion host.

1. In the Azure portal, go to your Bastion deployment.
2. IP-based connection requires the Standard SKU tier. On the Configuration page, for Tier, verify the tier is set to the Standard SKU. If the tier is set to the Basic SKU, select Standard from the dropdown
3. To enable IP based connection, select IP based connection

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/385578i537E02204B59D746/image-size/large?v=v2&px=999)

Once you completed the changes, simply click apply.

That’s it.  You can now connect to any VM that is connected to your virtual network.  Like any VM running in a network connected by site-to-site VPN.

PLEASE NOTE:

On your edge device, you may have to add a route to your AzureBastionSubnet.  On my own edge device (a Ubiquiti Dream Machine Pro) I had to manually add the AzureBastionSubnet address space to my configuration.

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/385577i8087C45F0E30DAF8/image-size/large?v=v2&px=999)

If you do not add the route, you may end up with an error stating “the network connection to the Bastion Host appears unstable.” when trying to establish the RDP connection.

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/385579i6B7A667347EEDBFF/image-size/large?v=v2&px=999)

When connecting to the vm, you need to provide an IP address, fully qualified domain names are not supported.

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/385580i84D7D346B5E04F56/image-size/large?v=v2&px=999)

![](https://techcommunity.microsoft.com/t5/image/serverpage/image-id/385581i9E4473AF3DFD8653/image-size/large?v=v2&px=999)
