# Bastion

A **Bastion Host** is a server whose purpose is providing access to the private network from an external network, such as the Internet. Because of its exposure to potential attacks, a bastion host must minimize the chances of penetration.

## references

<https://learn.microsoft.com/en-us/azure/bastion/bastion-overview>

<https://www.linkedin.com/pulse/how-setup-bastion-host-aws-ec2-access-private-api-from-malkhasyan/>

## What is a Bastion Host?

A bastion host is a server used to manage access to an internal or private network from an external network - sometimes called a jump box or jump server. Because bastion hosts often sit on the Internet, they typically run a minimum amount of services in order to reduce their attack surface. They are also commonly used to proxy and log communications, such as SSH sessions.

## What is Azure Bastion?

It might be a **[SOCKs5 proxy](https://securityintelligence.com/posts/socks-proxy-primer-what-is-socks5-and-why-should-you-use-it/)** is more secure because it establishes a full TCP connection with authentication and uses the Secure Shell (SSH) encrypted tunneling method to relay the traffic.

Is our Bastion host configured to provide SSH tunneling (Dynamic Port Forwarding) from an Azure Public IP to a VM or computer within our companies network, remote port forwarding, taking care of TLS termination?

If so I believe Bastion can be setup to route traffic to our K8s hosted API gateway which has it's own routing, throttling, TLS termination, and IAM authentication and authorization scheme.

If TLS termination is done by our Bastion host then we will probably need to pay for a Public IP and a TLS certificate. Once this is done I believe we will be able to access our data warehouse reporting UI and micro-services from a Microsoft Teams reporting app.

## SSH tunnelling

## references

<https://linuxize.com/post/how-to-setup-ssh-tunneling/>

## How to Set up SSH Tunneling (Port Forwarding)

![](https://linuxize.com/post/how-to-setup-ssh-tunneling/featured_hue1c954e34e19ec8ebc68aff9e2e67e75_25546_768x0_resize_q75_lanczos.jpg)

SSH tunneling or SSH port forwarding is a method of creating an encrypted SSH connection between a client and a server machine through which services ports can be relayed.

SSH forwarding is useful for transporting network data of services that use an unencrypted protocol, such as VNC or FTP , accessing geo-restricted content, or bypassing intermediate firewalls. Basically, you can forward any TCP port and tunnel the traffic over a secure SSH connection.

## There are three types of SSH port forwarding

- Local Port Forwarding. - Forwards a connection from the client host to the SSH server host and then to the destination host port.
- Remote Port Forwarding. - Forwards a port from the server host to the client host and then to the destination host port.
- Dynamic Port Forwarding. - Creates a SOCKS proxy server that allows communication across a range of ports.

Azure Bastion is a fully managed PaaS service that you provision to securely connect to virtual machines via private IP address. It provides secure and seamless RDP/SSH connectivity to your virtual machines directly over TLS from the Azure portal, or via the native SSH or RDP client already installed on your local computer. When you connect via Azure Bastion, your virtual machines don't need a public IP address, agent, or special client software.

Bastion provides secure RDP and SSH connectivity to all of the VMs in the virtual network for which it's provisioned. Using Azure Bastion protects your virtual machines from exposing RDP/SSH ports to the outside world, while still providing secure access using RDP/SSH.

The following diagram shows connections to virtual machines via a Bastion deployment that uses a Basic or Standard SKU.

![](https://learn.microsoft.com/en-us/azure/bastion/media/bastion-overview/architecture.png)

## Key benefits

| Benefit                                                    | Description                                                                                                                                                                                                                                                                                                                                                                          |
|------------------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| RDP and SSH through the Azure portal                       | You can get to the RDP and SSH session directly in the Azure portal using a single-click seamless experience.                                                                                                                                                                                                                                                                        |
| Remote Session over TLS and firewall traversal for RDP/SSH | Azure Bastion uses an HTML5 based web client that is automatically streamed to your local device. Your RDP/SSH session is over TLS on port 443. This enables the traffic to traverse firewalls more securely. Bastion supports TLS 1.2. Older TLS versions aren't supported.                                                                                                         |
| No Public IP address required on the Azure VM              | Azure Bastion opens the RDP/SSH connection to your Azure VM by using the private IP address on your VM. You don't need a public IP address on your virtual machine.                                                                                                                                                                                                                  |
| No hassle of managing Network Security Groups (NSGs)       | You don't need to apply any NSGs to the Azure Bastion subnet. Because Azure Bastion connects to your virtual machines over private IP, you can configure your NSGs to allow RDP/SSH from Azure Bastion only. This removes the hassle of managing NSGs each time you need to securely connect to your virtual machines. For more information about NSGs, see Network Security Groups. |
| No need to manage a separate bastion host on a VM          | Azure Bastion is a fully managed platform PaaS service from Azure that is hardened internally to provide you secure RDP/SSH connectivity.                                                                                                                                                                                                                                            |
| Protection against port scanning                           | Your VMs are protected against port scanning by rogue and malicious users because you don't need to expose the VMs to the internet.                                                                                                                                                                                                                                                  |
| Hardening in one place only                                | Azure Bastion sits at the perimeter of your virtual network, so you don’t need to worry about hardening each of the VMs in your virtual network.                                                                                                                                                                                                                                     |
| Protection against zero-day exploits                       | The Azure platform protects against zero-day exploits by keeping the Azure Bastion hardened and always up to date for you.                                                                                                                                                                                                                                                           |
