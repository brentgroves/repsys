# **[What is a Proxy Server? How does it work?](https://www.fortinet.com/resources/cyberglossary/proxy-server)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## What is a Proxy Server? How does it work?

A proxy server is a system or router that provides a gateway between users and the internet. Therefore, it helps prevent cyber attackers from entering a private network. It is a server, referred to as an “intermediary” because it goes between end-users and the web pages they visit online.

When a computer connects to the internet, it uses an IP address. This is similar to your home’s street address, telling incoming data where to go and marking outgoing data with a return address for other devices to authenticate. A proxy server is essentially a computer on the internet that has an IP address of its own.

## Proxy Servers and Network Security

Proxies provide a valuable layer of security for your computer. They can be set up as web filters or firewalls, protecting your computer from internet threats like malware.

This extra security is also valuable when coupled with a secure web gateway or other email security products. This way, you can filter traffic according to its level of safety or how much traffic your network—or individual computers—can handle.

How to use a proxy? Some people use proxies for personal purposes, such as hiding their location while watching movies online, for example. For a company, however, they can be used to accomplish several key tasks such as:

1, Improve security
2. Secure employees’ internet activity from people trying to snoop on them
3. Balance internet traffic to prevent crashes
4. Control the websites employees and staff access in the office
5. Save bandwidth by caching files or compressing incoming traffic

![proxy](https://www.fortinet.com/content/dam/fortinet/images/cyberglossary/proxy-server-1.jpeg)

## How a Proxy Works

Because a proxy server has its own IP address, it acts as a go-between for a computer and the internet. Your computer knows this address, and when you send a request on the internet, it is routed to the proxy, which then gets the response from the web server and forwards the data from the page to your computer’s browser, like Chrome, Safari, Firefox, or Microsoft Edge

## How to Get a Proxy

There are hardware and software versions. Hardware connections sit between your network and the internet, where they get, send, and forward data from the web. Software proxies are typically hosted by a provider or reside in the cloud. You download and install an application on your computer that facilitates interaction with the proxy.

Often, a software proxy can be obtained for a monthly fee. Sometimes, they are free. The free versions tend to offer users fewer addresses and may only cover a few devices, while the paid proxies can meet the demands of a business with many devices.

## How Is the Server Set Up?

To get started with a proxy server, you have to configure it in your computer, device, or network. Each operating system has its own setup procedures, so check the steps required for your computer or network.

In most cases, however, setup means using an automatic configuration script. If you want to do it manually, there will be options to enter the IP address and the appropriate port.

## How Does the Proxy Protect Computer Privacy and Data?

A proxy server performs the function of a firewall and filter. The end-user or a network administrator can choose a proxy designed to protect data and privacy. This examines the data going in and out of your computer or network. It then applies rules to prevent you from having to expose your digital address to the world. Only the proxy’s IP address is seen by hackers or other **bad actors**. Without your personal IP address, people on the internet do not have direct access to your personal data, schedules, apps, or files.

With it in place, web requests go to the proxy, which then reaches out and gets what you want from the internet. If the server has encryption capabilities, passwords and other personal data get an extra tier of protection.

## Benefits of a Proxy Server

Proxies come with several benefits that can give your business an advantage:

- **Enhanced security:** Can act like a firewall between your systems and the internet. Without them, hackers have easy access to your IP address, which they can use to infiltrate your computer or network.
- **Private browsing, watching, listening, and shopping:** Use different proxies to help you avoid getting inundated with unwanted ads or the collection of IP-specific data. With a proxy, site browsing is well-protected and impossible to track.
- **Access to location-specific content:** You can designate a proxy server with an address associated with another country. You can, in effect, make it look like you are in that country and gain full access to all the content computers in that country are allowed to interact with. For example, the technology can allow you to open location-restricted websites by using local IP addresses of the location you want to appear to be in.
- **Prevent employees from browsing inappropriate or distracting sites:** You can use it to block access to websites that run contrary to your organization’s principles. Also, you can block sites that typically end up distracting employees from important tasks. Some organizations block social media sites like Facebook and others to remove time-wasting temptations.

## Types of Proxy Servers

While all proxy servers give users an alternate address with which to use the internet, there are several different kinds—each with its own features. Understanding the details behind the list of proxy types will help you make a choice based on your use case and specific needs.

## Forward Proxy

A forward proxy **sits in front of clients** and is used to get data to groups of users within an internal network. When a request is sent, the proxy server examines it to decide whether it should proceed with making a connection.

A forward proxy is best suited for **internal networks** that need a single point of entry. It provides IP address security for those in the network and allows for straightforward administrative control. However, a forward proxy may limit an organization’s ability to cater to the needs of individual end-users.

## Transparent Proxy

A transparent proxy can give users an experience identical to what they would have if they were using their home computer. In that way, it is “transparent.” They can also be “forced” on users, meaning they are connected without knowing it.

Transparent proxies are well-suited for companies that want to make use of a proxy without making employees aware they are using one. It carries the advantage of providing a seamless user experience. On the other hand, transparent proxies are more susceptible to certain security threats, such as SYN-flood denial-of-service attacks.

## What is a SYN flood attack?

A SYN flood (half-open attack) is a type of denial-of-service (DDoS) attack which aims to make a server unavailable to legitimate traffic by consuming all available server resources. By repeatedly sending initial connection request (SYN) packets, the attacker is able to overwhelm all available ports on a targeted server machine, causing the targeted device to respond to legitimate traffic sluggishly or not at all.

A proxy server performs the function of a firewall and filter. The end-user or a network administrator can choose a proxy designed to protect data and privacy.

## **[What are inbound and outbound proxies?](https://www.quora.com/What-are-inbound-and-outbound-proxies)**

Inbound and outbound proxies are types of proxy servers that handle network traffic in different directions. Here’s a breakdown of each:

Inbound Proxy

Definition: An inbound proxy is a server that receives requests from external clients and forwards them to internal servers. It acts as an intermediary for incoming traffic.
Use Cases:
Load Balancing: Distributing incoming traffic across multiple servers to ensure no single server is overwhelmed.
Security: Protecting internal servers by hiding their IP addresses and filtering malicious traffic.
Caching: Storing frequently requested content to reduce load times and server resource usage.
Outbound Proxy

Definition: An outbound proxy is a server that forwards requests from internal clients to external servers. It acts as an intermediary for outgoing traffic.
Use Cases:
Access Control: Regulating which websites or services can be accessed from an internal network.
Anonymity: Hiding the IP addresses of internal clients from external servers, providing a layer of privacy.
Content Filtering: Blocking access to specific content or websites based on organizational policies.
Key Differences

Direction of Traffic: Inbound proxies deal with incoming requests, while outbound proxies handle outgoing requests.
Primary Functions: Inbound proxies are often used for security and load balancing, whereas outbound proxies focus on access control and anonymity.
Both types of proxies play crucial roles in network management, security, and performance optimization.
