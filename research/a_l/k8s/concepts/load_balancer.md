# **[What is Kubernetes Load Balancer? Configuration Example](https://spacelift.io/blog/kubernetes-load-balancer)**

**[Current Status](../../../../development/status/weekly/current_status.md)**\
**[Research List](../../../research_list.md)**\
**[Back Main](../../../../README.md)**

In this article, we will delve into load balancing in Kubernetes and explain the various available types, before showing how to configure them with example configuration files. We will then discuss the different available load balancing strategies, when best to use them, and some general best practices for handling load balancing in K8S!

## What is Kubernetes Load Balancer?

A Kubernetes load balancer is a component that distributes network traffic across multiple instances of an application running in a K8S cluster. It acts as a traffic manager, ensuring that incoming requests are evenly distributed among the available instances to optimize performance and prevent overload on any single instance, providing high availability and scalability.

Load balancers in K8S can be implemented by using a cloud provider-specific load balancer such as Azure Load Balancer, AWS Network Load Balancer (NLB), or Elastic Load Balancer (ELB) that operates at the Network Layer 4 of the OSI model.

Cloud-specific Ingress controllers that can operate at the Application Layer 7, include Application Gateway on Azure, or ELB or Application Load Balancer (ALB) on AWS. To use ingress, an Ingress controller must be installed on the cluster, as they are not included out of the box with K8S.

## network layer 4 OSI

Layer 4 of the Open Systems Interconnection (OSI) model is the transport layer, which is responsible for managing network traffic between hosts and end systems. It's also known as the "heart of OSI" because it's where the actual transmission between systems occurs.

The transport layer uses protocols like TCP, UDP, DCCP, and SCTP to control the volume of data, where it's sent, and how fast it's sent.

## **[OSI Model](https://www.geeksforgeeks.org/open-systems-interconnection-model-osi/)**

![osi](https://media.geeksforgeeks.org/wp-content/uploads/20240615010645/OSI-Model.png)

## Data Flow In OSI Model

When we transfer information from one device to another, it travels through 7 layers of OSI model. First data travels down through 7 layers from the sender’s end and then climbs back 7 layers on the receiver’s end.

Data flows through the OSI model in a step-by-step process:

- Application Layer: Applications create the data.
- Presentation Layer: Data is formatted and encrypted.
- Session Layer: Connections are established and managed.
- Transport Layer: Data is broken into segments for reliable delivery.
- Network Layer : Segments are packaged into packets and routed.
- Data Link Layer: Packets are framed and sent to the next device.
- Physical Layer: Frames are converted into bits and transmitted physically.

Each layer adds specific information to ensure the data reaches its destination correctly, and these steps are reversed upon arrival.
