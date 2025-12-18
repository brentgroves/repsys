# **[F5 Load Balancer](https://www.f5.com/glossary/load-balancer)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

From talking with Kiran, I believe Linamar has an **[F5 Load Balancer](https://www.f5.com/glossary/load-balancer)** hosted in a **[DMZ](https://en.wikipedia.org/wiki/DMZ_(computing))** and this would probably be the ideal place to host the report system, although, I think the **[platform engineers](https://platformengineering.org/blog/what-is-platform-engineering)** responsible for it would have to do some Kubernetes, k8s, specific configuration in order to use it.

If we created our own vlan for the report system I think that would be safe also. The **[K8s](https://microk8s.io/)** we use comes with the **[MetalLB load balancer](https://metallb.universe.tf/)** which does not have nearly the features as the F5 Load Balancer but it still safely controls access to the **[K8s network](https://spacelift.io/blog/kubernetes-networking)**.

In conjuction with this simple load balancer we also use the **[Istio service mesh](https://istio.io/latest/about/service-mesh/)** gateway. A service mesh is an infrastructure layer that gives applications capabilities like **zero-trust security**, observability, and advanced traffic management, without code changes. It comes with advanced Istio is the most popular, powerful, and trusted service mesh. Founded by Google, IBM and Lyft in 2016, Istio is a graduated project in the Cloud Native Computing Foundation alongside projects like Kubernetes and Prometheus.

## Summary

With Istio and MetalLB our report system would have **[advanced load balancer or Application Delivery Controller](https://www.appviewx.com/education-center/application-delivery-controller/#:~:text=A%20load%20balancer%20simply%20distributes,across%20OSI%20layer%204%2D7.)** features like found in the F5 Load Balancer.

A **load balancer** is a solution that acts as a traffic proxy and distributes network or application traffic across endpoints on a number of servers. Load balancers are used to distribute capacity during peak traffic times, and to increase reliability of applications. They improve the overall performance of applications by decreasing the burden on individual services or clouds, and distribute the demand across different compute surfaces to help maintain application and network sessions.

A load balancer is a computer network device or software, placed in the DMZ, a zone between the outer firewall and a web farm. It optimizes and manages the connection of application servers with client machines.

In computer security, a **[DMZ](https://en.wikipedia.org/wiki/DMZ_(computing))** or demilitarized zone (sometimes referred to as a perimeter network or screened subnet) is a physical or logical subnetwork that contains and exposes an organization's external-facing services to an untrusted, usually larger, network such as the Internet. The purpose of a DMZ is to add an additional layer of security to an organization's local area network (LAN): an external network node can access only what is exposed in the DMZ, while the rest of the organization's network is protected behind a firewall.[1] The DMZ functions as a small, isolated network positioned between the Internet and the private network.[2]

This is not to be confused with a DMZ host, a feature present in some home routers which frequently differs greatly from an ordinary

Conventionally the ADCs have been a physical hardware but now software defined ADCs are also becoming common.
In addition to the conventional load balancing capabilities, ADCs can perform application access management, server health checks, SSL offload, TCP reuse, and RAM caching. Also, it possesses proxy and reverse proxy capabilities, web application firewalls (WAF), DNS application firewalls (DAF), and many others to count.

With all these features, ADCs ensure the most optimized application performance, eliminating the downtime, and making the applications highly available and secure.
