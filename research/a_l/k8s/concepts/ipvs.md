# **[ipvs](https://medium.com/google-cloud/load-balancing-with-ipvs-1c0a48476c4d)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

## IP Virtual Server

IP Virtual Server (IPVS) implements L4 Load Balancing directly inside the Linux kernel. I needed to make it work in GCP, thinking this can't be that difficult. And I got some headaches, together with a lot of fun :)

When life is easy
A Cloud environment like GCP is great. Initially it is a bit confusing because networking has other rules, but then you start to love all the abstractions it provides. For instance, implementing L4 Load Balancing is done through one of those services you can configure and mostly forget, it just works™.

Well, true, it may not always be that easy. But there are few occasions when you need to debug by going deeper than just reviewing your configuration. Sometimes I need to resort to tcpdump (that I really enjoy), and this is how this story started. But I didn't imagine how it would end up.

The task at hand, running a L4 Load Balancer. In a cloud environment there are times when you don’t get exactly the service you need. In this case the why is not that important, I will explain it later, but the thing is that I (my customer) decided to use IPVS. It is part of the **[Linux Virtual Server project](http://www.linuxvirtualserver.org/)**, where it runs in a server host as a transport-layer load balancer offering a single VIP to access services of real servers. If you don't know, IPVS is used by the kube-proxy component of Kubernetes.

## What is the Linux Virtual Server?

The Linux Virtual Server is a highly scalable and highly available server built on a cluster of real servers, with the load balancer running on the Linux operating system. The architecture of the server cluster is fully transparent to end users, and the users interact as if it were a single high-performance virtual server. For more information, click here.

## Applications of the Linux Virtual Server

The Linux Virtual Server as an advanced load balancing solution can be used to build highly scalable and highly available network services, such as scalable web, cache, mail, ftp, media and VoIP services.
