# **[What is Squid Proxy](https://wiki.squid-cache.org/)**

## references

- **[config examples](https://wiki.squid-cache.org/ConfigExamples/)**

Squid is a free, open-source caching proxy server that acts as an intermediary between clients and servers on a network, primarily used to improve web performance and reduce bandwidth usage by caching frequently accessed web content.

Caching:
Squid stores copies of frequently accessed web pages, images, and other resources in its cache memory.
Forwarding:
When a client requests a web page, Squid checks its cache first. If the page is already cached, Squid delivers it to the client directly, rather than fetching it from the original web server.
Performance:
This process significantly reduces latency and improves response times for users, as they receive content from the local cache instead of waiting for it to be downloaded from a remote server.
Bandwidth Reduction:
By serving content from the cache, Squid reduces the amount of data that needs to be transferred over the network, thereby saving bandwidth.
Security:
Squid can also be used for security purposes, such as filtering traffic from specific websites or implementing access controls.
Protocols Supported:
Squid supports various protocols, including HTTP, HTTPS, FTP, and others.
Usages:
Squid is used in enterprise networks, educational institutions, and by ISPs to improve web performance and reduce bandwidth costs.
Open Source:
Squid is open-source software, meaning it is free to use and modify, and the source code is available to the public.
