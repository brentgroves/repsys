# Help with K8s

Christian Smith: Global Directory IT
Adrian Wise: System Admin, Technical Services Manager.

Hi Adrian,

I enjoyed getting to talk to you on Friday and hope I have the opportunity to get to know you better. Feel free to call me if you want to talk more.

Sincerely,
Brent Groves
260-564-4868

Below is some research on K8s and K3s that you may be interested in.  Thanks again for meeting with me on Friday and have a good weekend!

The following is in markdown format it can be viewed better by copying and pasting the contents into this markdown viewer: <https://markdownlivepreview.com/>.

## **[Top 10 Managed K8s Platforms](https://technologymagazine.com/top10/top-10-managed-kubernetes-platforms)**

1: **[Google Kubernetes Engine](https://cloud.google.com/kubernetes-engine)**

Makes sense they made it. I'm sure it's great but I never had the opportunity to use it.

2: **[Azure Kubernetes](https://azure.microsoft.com/en-gb/products/kubernetes-service)**

I have been using this for a few years and what I notice most is that the applications running in it **never fail/restart!**. 

Combined with **[Istio Service Mesh](https://istio.io/latest/about/service-mesh/)** which sets up an **[mTLS](https://tetrate.io/learn/what-is-mtls/)** **[envoy proxy](https://www.envoyproxy.io/#:~:text=Envoy%20is%20a%20self%20contained,1.1%20to%20HTTP%2F2%20proxy.)** to control access to each service it's a great choice to run applications reliably and securely. 

For example, only clients from our public IP with our own privately signed **[client certificates](https://www.digicert.com/faq/public-trust-and-certificates/whats-the-difference-between-client-certificates-vs-server-certificates)** would be able to access any Linus applications. 

We can also use Istio together with an authentication and authorization service such as **[Auth0](https://auth0.com/identity-platform)** linked to any identity provider such as **[Microsoft Entra ID](https://learn.microsoft.com/en-us/entra/fundamentals/whatis)** to further secure access to our resources. Further study is needed for more fine-grained control as to exactly who in our organization can access each application.

## **[K3s Summary](https://www.cloudzero.com/blog/k3s-vs-k8s/)**

### Advantages

- Run Kubernetes on ARM architecture – Devices that use ARM architecture, such as mobile phones, can run Kubernetes with K3s.
- Run Kubernetes on Raspberry Pi – It’s so lightweight that it supports clusters made with Raspberry Pi.
- Supports low-resource environments – For example, IoT devices and edge computing.

## What Are The Disadvantages Of K3s?

Among its limitations is that K3s does not come with a distributed database by default. This limits the control plane’s high availability capabilities. You need to point K3s servers to an external database endpoint (etcd, PostgreSQL, and MySQL) to achieve high availability of its control plane.

## When To Use K8s

For everything else requiring heavy-duty clusters, K8s is the best choice. See, while K3s is purpose-built for running Kubernetes on bare metal servers, K8s is a general container orchestrator. Also, K8s offers many configuration options for various applications.

If you want more high-availability options, such as automatic failover and cluster-level redundancy, full-blown K8s may be the better choice. Likewise, K8s offers plenty more extensions, dependencies, and features, such as load balancing, auto-scaling, and service discovery.

Besides, K8s can handle more sophisticated applications, such as robust big data analytics and high-performance computing (HPC). K3s is better suited for resource-restrained environments, such as IoT devices and computing at the edge.

In the long run, both small and larger companies can use K8s to handle complex applications with multiple extensions, cloud provider add-ons, and external drivers to get things done.

Good luck with your decision Adrian and have a great day!





