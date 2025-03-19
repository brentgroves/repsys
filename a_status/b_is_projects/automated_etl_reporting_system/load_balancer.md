# **[Load Balancers](https://www.f5.com/glossary/load-balancer)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

Hi Jared and Kevin,

Thank you Jared for working on the network for the report system.  I know it's not easy and is a pain in the butt, so I appreciate the effort you put into it!

- Thank you
Brent
260-564-4868

```text
The following is in markdown format it can be viewed better from https://markdownlivepreview.com/. Just copy and paste the content below this line.
```

From talking with Kiran, I believe Linamar has an **[F5 Load Balancer](https://www.f5.com/glossary/load-balancer)** hosted in a **[DMZ](https://en.wikipedia.org/wiki/DMZ_(computing))** and this would probably be the ideal place to host the report system, although, I think the **[platform engineers](https://platformengineering.org/blog/what-is-platform-engineering)** responsible for it would have to do some Kubernetes, k8s, specific configuration in order to use it.

If we created our own vlan for the report system I think that would be safe also. The **[K8s](https://microk8s.io/)** we use comes with the **[MetalLB load balancer](https://metallb.universe.tf/)** which does not have nearly the features as the F5 Load Balancer but it still safely controls access to the **[K8s network](https://spacelift.io/blog/kubernetes-networking)**.

In conjuction with this simple load balancer we also use the **[Istio service mesh](https://istio.io/latest/about/service-mesh/)** gateway. A service mesh is an infrastructure layer that gives applications capabilities like **zero-trust security**, observability, and advanced traffic management, without code changes. It comes with advanced Istio is the most popular, powerful, and trusted service mesh. Founded by Google, IBM and Lyft in 2016, Istio is a graduated project in the Cloud Native Computing Foundation alongside projects like Kubernetes and Prometheus.

## Summary

With Istio and MetalLB our report system would have **[advanced load balancer or Application Delivery Controller](https://www.appviewx.com/education-center/application-delivery-controller/#:~:text=A%20load%20balancer%20simply%20distributes,across%20OSI%20layer%204%2D7.)** features like found in the F5 Load Balancer.
