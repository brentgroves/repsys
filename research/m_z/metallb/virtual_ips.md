# Virtual IPs

What are virtual IP addresses? Virtual IP addresses are IP addresses that are not tethered to particular machines. Thus, they can rotate among nodes in a Content Gateway cluster. It is common for a single machine to represent multiple IP addresses on the same subnet.

## references

<https://metallb.universe.tf/concepts/layer2/>

<https://www.pubconcierge.com/blog/virtual-ip-what-is-it-and-how-it-works/>

<https://www.websense.com/content/support/library/web/v84/wcg_help/virtual_ip_overview.aspx#:~:text=What%20are%20virtual%20IP%20addresses%3F,-Help%20%7C%20Content%20Gateway&text=Virtual%20IP%20addresses%20are%20IP,addresses%20on%20the%20same%20subnet>.

<https://www.ibm.com/docs/en/i/7.4?topic=methods-load-balancing-using-virtual-ip>

![](https://support.huaweicloud.com/intl/en-us/productdesc-vpc/en-us_image_0209608154.png)

## What is a virtual IP address?

A virtual IP address (VIP, literally) is a type of IP address that does not correspond to a physical device.  Instead, it is used for network services such as load balancing, one of the main use cases for a VIP.

A virtual IP address is a way for multiple devices to share a single IP address, among other clever methods, such as the NAT protocol.

VIP addresses help in situations where multiple servers are operating for the same service, such as a website. And for that, you want to ensure that if one server fails, the others can take over and maintain the availability of the service. And that’s how the virtual IP address steps into the spotlight.

In this setup, a load balancer is used to distribute incoming traffic to the servers, and the virtual IP address is assigned to the load balancer. The load balancer then uses the virtual IP address as its own IP address, and the servers use their own unique IP addresses behind the scenes.

## How does a virtual IP address work?

A virtual IP address (VIP) works by using a load balancer to distribute incoming traffic to multiple servers. The load balancer will get the VIP, which acts as the balancer’s IP address.  

But for us to understand how these pieces fit into the grander scheme, let’s first understand what a load balancer is.

If you study the name itself, you’ll probably think it has something to do with the load of information or traffic and how it is distributed for more efficiency.

And in this case, you were right. A load balancer is a device or software that sits between clients and servers in a network. distributes incoming traffic across multiple servers to ensure that the load is balanced and network services remain available.

This synergy is a great help for services that have multiple servers. In this way, if one server fails, the other can take over and keep the service available, ensuring little to no downtime. Here’s how this dynamic works, in a few steps:

1. Traffic is sent to the virtual IP: When a client/user wants to access a network service, such as a website, it sends a request to the VIP.
2. The load balancer distributes the traffic: It receives the request and distributes it to one of the servers behind it.
3. Server handles the request: The selected server processes the request and sends a response back to the client, but first it has to pass through the load balancer.
4. Load balancer forwards the response: The load balancer receives the response from the server and forwards it back to the client.

Additionally, the load balancer can use various algorithms to determine which server to send each request to, ensuring that the load is distributed evenly among the servers.
