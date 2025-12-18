# **[Outbound rules Azure Load Balancer](https://learn.microsoft.com/en-us/azure/load-balancer/outbound-rules)**

**[Current Status](../../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../../research_list.md)**\
**[Back Main](../../../../../README.md)**

## references

- **[vm load balancer example](https://faultbucket.ca/2020/06/understanding-azure-outbound-internet-and-load-balancer/)**
- **[secure by default](https://learn.microsoft.com/en-us/azure/load-balancer/load-balancer-overview#securebydefault)**

Outbound rules allow you to explicitly define SNAT(source network address translation) for a public standard load balancer. This configuration allows you to use the public IP(s) of your load balancer to provide outbound internet connectivity for your backend instances.

This configuration uses source network address translation (SNAT) to translate virtual machine's private IP into the load balancer's public IP address.

This configuration enables:

- IP masquerading
- Simplifying your allowlists.
- Reduces the number of public IP resources for deployment.

With outbound rules, you have full declarative control over outbound internet connectivity. Outbound rules allow you to scale and tune this ability to your specific needs.

Outbound rules will only be followed if the backend VM doesn't have an instance-level public IP address (ILPIP).

![snat](https://learn.microsoft.com/en-us/azure/load-balancer/media/load-balancer-outbound-rules-overview/load-balancer-outbound-rules.png)

With outbound rules, you can explicitly define outbound SNAT behavior.

Outbound rules allow you to control:

- Which virtual machines are translated to which public IP addresses.
  - Two rules where backend pool 1 uses both blue IP addresses, and backend pool 2 uses the yellow IP prefix.
- How outbound SNAT ports are allocated.
  - If backend pool 2 is the only pool making outbound connections, give all SNAT ports to backend pool 2 and none to backend pool 1.
- Which protocols to provide outbound translation for.
  - If backend pool 2 needs UDP ports for outbound, and backend pool 1 needs TCP, give TCP ports to 1 and UDP ports to 2.
- What duration to use for outbound connection idle timeout (4-120 minutes).
  - If there are long running connections with keepalives, reserve idle ports for long running connections for up to 120 minutes. Assume stale connections are abandoned and release ports in 4 minutes for fresh connections
- Whether to send a TCP Reset on idle timeout.
  - When timing out idle connections, do we send a TCP RST to the client and server so they know the flow is abandoned?

  **Important**\
  When a backend pool is configured by IP address, it will behave as a Basic Load Balancer with default outbound enabled. For secure by default configuration and applications with demanding outbound needs, configure the backend pool by NIC.

## Outbound rule definition

Outbound rules follow the same familiar syntax as load balancing and inbound NAT rules: frontend + parameters + backend pool.

An outbound rule configures outbound NAT for all virtual machines identified by the backend pool to be translated to the frontend.

The parameters provide fine grained control over the outbound NAT algorithm.
